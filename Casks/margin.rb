# Homebrew cask for Margin, published to the wiggleji/homebrew-tap repository
# by the Release workflow (0.8.1 and ae2c57c49fd46b7c0577f8b88561abc74f35ccbdd3c92a38519b876a1c225034 filled in for each release).
#   brew install --cask wiggleji/tap/margin
cask "margin" do
  version "0.8.1"
  sha256 "ae2c57c49fd46b7c0577f8b88561abc74f35ccbdd3c92a38519b876a1c225034"

  url "https://github.com/wiggleji/margin/releases/download/v#{version}/Margin-#{version}.dmg"
  name "Margin"
  desc "Git client with notes on branches, commits and tasks"
  homepage "https://github.com/wiggleji/margin"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Margin updates itself (Margin → Check for Updates…)
  auto_updates true
  depends_on macos: ">= :big_sur"

  app "Margin.app"
  # `margin .` opens a repository; margin-mcp is the agent (MCP) server
  binary "#{appdir}/Margin.app/Contents/Resources/bin/margin"
  binary "#{appdir}/Margin.app/Contents/MacOS/margin-mcp"

  postflight do
    # Until the app is notarized by Apple, macOS would block the first open
    # of a downloaded copy; the tap installs it the way `xattr -dr` would.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Margin.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Margin",
    "~/Library/Saved Application State/io.github.wiggleji.margin.savedState",
  ]
end
