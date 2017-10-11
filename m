Received: from eggs.gnu.org ([2001:4830:134:3::10]:57651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2JuU-0005Tk-Bn
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2JuQ-0007mk-Dy
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:31:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:42460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e2JuQ-0007mN-8D
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:31:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e2JuN-00050y-1n
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 16:30:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2FA112E817B
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 16:30:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2017 16:19:19 -0000
From: Googulator <1722857@bugs.launchpad.net>
Reply-To: Bug 1722857 <1722857@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150773875950.15858.6612772865194948716.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1722857] [NEW] Missing PCI "programming
 interface" ID emulation for USB host controllers
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

Qemu doesn't currently emulate the correct value of the "register level
programming interface" field in the PCI config space of USB host
controllers. As a result, some guest operating systems (most notably
Windows) fail to load e.g. generic xHCI drivers, and instead ask for a
vendor-specific driver, which may not be always available.

Example: "-device nec-usb-xhci" emulates a Renesas (formerly NEC)
uPD720202 xHCI controller. However, in the PCI config space, it shows us
as class 0C, subclass 03, prog-if 00 (UHCI) where as the real uPD720202
(and all real xHCI controllers) have prog-if 30 (xHCI). A Windows guest
booted with this option will not recognize devices attached to the XHCI
controller unless drivers from Renesas are manually installed first,
even though recent Windows versions include a generic xHCI driver that
works perfectly well with real uPD720202 hardware.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1722857

Title:
  Missing PCI "programming interface" ID emulation for USB host
  controllers

Status in QEMU:
  New

Bug description:
  Qemu doesn't currently emulate the correct value of the "register
  level programming interface" field in the PCI config space of USB host
  controllers. As a result, some guest operating systems (most notably
  Windows) fail to load e.g. generic xHCI drivers, and instead ask for a
  vendor-specific driver, which may not be always available.

  Example: "-device nec-usb-xhci" emulates a Renesas (formerly NEC)
  uPD720202 xHCI controller. However, in the PCI config space, it shows
  us as class 0C, subclass 03, prog-if 00 (UHCI) where as the real
  uPD720202 (and all real xHCI controllers) have prog-if 30 (xHCI). A
  Windows guest booted with this option will not recognize devices
  attached to the XHCI controller unless drivers from Renesas are
  manually installed first, even though recent Windows versions include
  a generic xHCI driver that works perfectly well with real uPD720202
  hardware.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1722857/+subscriptions
