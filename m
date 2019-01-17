Received: from eggs.gnu.org ([209.51.188.92]:48494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gk5ZO-00031k-Tf
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gk5ZO-0004VT-1u
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:10:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:40350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gk5ZN-0004UU-St
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:10:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gk5ZM-0008Gp-Fn
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 11:10:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 669382E80C7
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 11:10:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Jan 2019 10:56:18 -0000
From: WHR <msl0000023508@gmail.com>
Reply-To: Bug 1811916 <1811916@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154760979078.8671.12129737571280605477.malonedeb@chaenomeles.canonical.com>
Message-Id: <154772257814.1741.7749373260227502524.malone@gac.canonical.com>
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

I'm currently reverted the commit f8d2c9369b8302f65f4f43f14ed3987c2268a02a =
to use only CTRL-ALT.
https://gist.github.com/Low-power/822eace3f37c893bc6aad3af647b4c7d

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
