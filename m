Received: from eggs.gnu.org ([2001:4830:134:3::10]:59969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fMkWD-0003dK-6m
	for qemu-devel@nongnu.org; Sat, 26 May 2018 21:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fMkWA-0007es-2X
	for qemu-devel@nongnu.org; Sat, 26 May 2018 21:30:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:51544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fMkW9-0007bJ-S6
	for qemu-devel@nongnu.org; Sat, 26 May 2018 21:30:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fMkW8-0004s3-NX
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 01:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ADA4F2E8029
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 01:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 May 2018 01:22:31 -0000
From: Krupp <1649233@bugs.launchpad.net>
Reply-To: Bug 1649233 <1649233@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161212101630.16736.48530.malonedeb@soybean.canonical.com>
Message-Id: <152738415133.26114.1713325559950503979.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1649233] Re: scrolling does not work once mouse
 is grabbed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am also having trouble with this bug. I have QEMU version 2.11.1 on
kubuntu. I have the same symptoms as above, and would be willing to
assist in troubleshooting. The mouse I am using has two side buttons for
forward and back on web-browsing and a scroll wheel with scroll button.
I am using QEMU/KVM through Virtual Machine Manager.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1649233

Title:
  scrolling does not work once mouse is grabbed

Status in QEMU:
  New

Bug description:
  The title pretty much told it all. It occurs in Windows 10 RS1 on qemu
  2.7.0. Interestingly, I can scroll in the guest if the mouse is not
  grabbed. So using usb-tablet sort of works around it, but if I
  explicitly grab the mouse with Ctrl+Alt+G, scrolling will also stop
  working.

  The host is Arch Linux so the qemu build uses gtk(3) for GUI by
  default. I wanted to test with sdl but it seems sdl support in qemu is
  sort of broken that I can't even start the virtual machine properly
  with that.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1649233/+subscriptions
