Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cGNsk-0002Fs-PY
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cGNsg-0001GU-6a
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:55375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cGNsg-0001GK-1K
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:30:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cGNse-0007Km-Te
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DEF6A2E80C8
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:30:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Dec 2016 10:23:14 -0000
From: Tom Yan <tom.ty89@gmail.com>
Reply-To: Bug 1649233 <1649233@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161212101630.16736.48530.malonedeb@soybean.canonical.com>
Message-Id: <20161212102314.16805.27011.malone@soybean.canonical.com>
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

Full commands I used:

qemu-system-x86_64 -enable-kvm -cpu host -smp cores=3D4 -m 4G -drive
file=3Dtest.img,format=3Draw

qemu-system-x86_64 -enable-kvm -cpu host -smp cores=3D4 -m 4G -drive
file=3Dtest.img,format=3Draw -device nec-usb-xhci -device usb-kbd -device
usb-mouse

qemu-system-x86_64 -enable-kvm -cpu host -smp cores=3D4 -m 4G -drive
file=3Dtest.img,format=3Draw -device nec-usb-xhci -device usb-kbd -device
usb-tablet

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
