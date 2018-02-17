Received: from eggs.gnu.org ([2001:4830:134:3::10]:42285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1emu9B-0005Lq-07
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 23:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1emu96-0007xm-3R
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 23:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:45168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1emu95-0007xX-Tt
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 23:30:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1emu95-0003Ay-2o
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 04:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1375C2E80CB
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 04:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Feb 2018 04:17:24 -0000
From: Launchpad Bug Tracker <1587970@bugs.launchpad.net>
Reply-To: Bug 1587970 <1587970@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160601160200.996.35165.malonedeb@wampee.canonical.com>
Message-Id: <151884104500.16257.14946780333345549314.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1587970] Re: QEMU Crashes when attaching USB 3.00
 devices to xhci bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1587970

Title:
  QEMU Crashes when attaching USB 3.00 devices to xhci bus

Status in QEMU:
  Expired

Bug description:
  Using qemu 2.6 with a windows7 32-bit VM, if I plug a USB 3.0 memory stic=
k in to a USB 3.0 port, then pass it through to the VM via the monitor (dev=
ice_add usb-host,bus=3Dxhci.0,hostbus=3Dxx,hostaddr=3Dxx,id=3Dstick1) then =
qemu asserts and dies - I have seen 2 different asserts one is from the xch=
i module - Assertion `intr->er_full, and one is in core.c (line 400 I IIRCC=
) with "Assertion dev->state =3D=3D 3 failed"
  Tried to work around by only passing in an ehci controller to the VM, but=
 then if I attach a usb 3.0 memory stick to that it doesn't work in windows.
  I have made sure the xhci drivers in the windows VM are up to date, lates=
t version of SeaBios etc, but at the moment, I have had to disable xhci in =
my system bios and just use ehci for everything.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1587970/+subscriptions
