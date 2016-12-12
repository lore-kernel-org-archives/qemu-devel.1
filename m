Received: from eggs.gnu.org ([2001:4830:134:3::10]:58022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cGNo5-00076J-AN
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cGNo4-0007hf-70
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:26:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:54748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cGNo4-0007hJ-1t
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:26:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cGNo1-0006hp-Uo
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:26:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E1A02E8283
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:25:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Dec 2016 10:16:29 -0000
From: Tom Yan <tom.ty89@gmail.com>
Reply-To: Bug 1649233 <1649233@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20161212101630.16736.48530.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1649233] [NEW] scrolling does not work once mouse
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

Public bug reported:

The title pretty much told it all. It occurs in Windows 10 RS1 on qemu
2.7.0. Interestingly, I can scroll in the guest if the mouse is not
grabbed. So using usb-tablet sort of works around it, but if I
explicitly grab the mouse with Ctrl+Alt+G, scrolling will also stop
working.

The host is Arch Linux so the qemu build uses gtk(3) for GUI by default.
I wanted to test with sdl but it seems sdl support in qemu is sort of
broken that I can't even start the virtual machine properly with that.

** Affects: qemu
     Importance: Undecided
         Status: New

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
