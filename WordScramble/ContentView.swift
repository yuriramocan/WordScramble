//
//  ContentView.swift
//  WordScramble
//
//  Created by Yuri Ramocan on 4/9/20.
//  Copyright © 2020 Yuri Ramocan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()

                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord.capitalized)
            .onAppear(perform: startGame)
        }
    }

    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard !answer.isEmpty else { return }

        // extra validation

        usedWords.insert(answer, at: 0)
        self.newWord = ""
    }

    private func startGame() {
        guard
            let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL)
            else {
                fatalError("Could not load start words.")
        }

        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
