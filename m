Received: from eggs.gnu.org ([209.51.188.92]:57264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gk4Tl-0005TB-Nh
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gk4Tg-0002Ts-6r
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:00:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:50308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gk4Tg-0002RB-0N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:00:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gk4Td-0006IF-Vh
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:00:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D9EFA2E80CB
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:00:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Jan 2019 09:52:33 -0000
From: WHR <msl0000023508@gmail.com>
Reply-To: Bug 1811916 <1811916@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154760979078.8671.12129737571280605477.malonedeb@chaenomeles.canonical.com>
Message-Id: <154771875346.1080.14385070689273989440.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811916] Re: SDL2 interface didn't follow the
 current X11 keyboard layout for hotkeys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Also affects SDL 1.2 UI in QEMU 2.12.1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811916

Title:
  SDL2 interface didn't follow the current X11 keyboard layout for
  hotkeys

Status in QEMU:
  New

Bug description:
  My X11 was configured to use Dvorak keyboard layout, with
  setxkbmap(1). Despite the window title said 'Press Ctrl-Alt-G to exit
  grab' after it grabbed the mouse, pressing this hotkey don't have any
  effects, and I has to switch to a virtual terminal to kill(1) that
  qemu process. By debugging the program I found it is using the raw key
  code to handle the key events, so I must use CTRL-ALT-I to exit the
  grab, in my keyboard.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811916/+subscriptions
