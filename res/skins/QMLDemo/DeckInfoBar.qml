import "." as Skin
import Mixxx 0.1 as Mixxx
import Mixxx.Controls 0.1 as MixxxControls
import QtQuick 2.12
import "Theme"

Rectangle {
    id: root

    required property string group
    property color textColor: Theme.deckTextColor
    property color lineColor: Theme.deckLineColor

    radius: 5
    height: 56

    Rectangle {
        id: coverArt

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 5
        width: height
        color: Theme.deckLineColor
    }

    Item {
        id: spinny

        anchors.fill: coverArt

        // The Spinnies are automatically hidden if the track
        // is stopped. This is not really useful, but is nice for
        // demo'ing transitions.
        Mixxx.ControlProxy {
            group: root.group
            key: "play"
            onValueChanged: spinnyIndicator.indicatorVisible = (value > 0)
        }

        MixxxControls.Spinny {
            id: spinnyIndicator

            anchors.fill: parent
            group: root.group
            indicatorVisible: false

            indicatorDelegate: Image {
                mipmap: true
                width: spinnyIndicator.width
                height: spinnyIndicator.height
                source: "../LateNight/palemoon/style/spinny_indicator.svg"
            }

        }

    }

    Text {
        id: infoBarTitle

        text: "Title Placeholder"
        anchors.top: infoBarHSeparator.top
        anchors.left: infoBarVSeparator.left
        anchors.right: infoBarHSeparator.left
        anchors.bottom: infoBarVSeparator.bottom
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.family: Theme.fontFamily
        font.pixelSize: Theme.textFontPixelSize
        color: infoBar.textColor
    }

    Rectangle {
        id: infoBarVSeparator

        anchors.left: coverArt.right
        anchors.right: infoBar.right
        anchors.verticalCenter: infoBar.verticalCenter
        anchors.margins: 5
        height: 2
        color: infoBar.lineColor
    }

    Text {
        id: infoBarArtist

        text: "Artist Placeholder"
        anchors.top: infoBarVSeparator.bottom
        anchors.left: infoBarVSeparator.left
        anchors.right: infoBarHSeparator.left
        anchors.bottom: infoBarHSeparator.bottom
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.family: Theme.fontFamily
        font.pixelSize: Theme.textFontPixelSize
        color: infoBar.textColor
    }

    Text {
        id: infoBarRate

        anchors.top: infoBarHSeparator.top
        anchors.bottom: infoBarVSeparator.top
        anchors.left: infoBarRightSpace.left
        anchors.right: infoBarRightSpace.right
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: bpmControl.value.toFixed(2)
        font.family: Theme.fontFamily
        font.pixelSize: Theme.textFontPixelSize
        color: infoBar.textColor

        Mixxx.ControlProxy {
            id: bpmControl

            group: root.group
            key: "bpm"
        }

    }

    Text {
        id: infoBarRateRatio

        property real ratio: ((rateRatioControl.value - 1) * 100).toPrecision(2)

        anchors.top: infoBarVSeparator.bottom
        anchors.bottom: infoBarHSeparator.bottom
        anchors.left: infoBarRightSpace.left
        anchors.right: infoBarRightSpace.right
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: Theme.fontFamily
        font.pixelSize: Theme.textFontPixelSize
        color: infoBar.textColor
        text: (ratio > 0) ? "+" + ratio.toFixed(2) : ratio.toFixed(2)

        Mixxx.ControlProxy {
            id: rateRatioControl

            group: root.group
            key: "rate_ratio"
        }

    }

    Item {
        id: infoBarRightSpace

        anchors.top: infoBar.top
        anchors.bottom: infoBar.bottom
        anchors.right: infoBar.right
        width: rateSlider.width
    }

    Rectangle {
        id: infoBarHSeparator

        anchors.top: infoBar.top
        anchors.bottom: infoBar.bottom
        anchors.right: infoBarRightSpace.left
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        width: 2
        color: infoBar.lineColor
    }

}
