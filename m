Received: from eggs.gnu.org ([2001:4830:134:3::10]:60777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQsDE-0001Jv-97
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQsD9-0004gx-D3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:59:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:41372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQsD9-0004fp-6c
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:59:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQsD7-0002py-8y
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:59:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3827D2E8056
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:59:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 09:48:56 -0000
From: Thomas Huth <1587970@bugs.launchpad.net>
Reply-To: Bug 1587970 <1587970@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160601160200.996.35165.malonedeb@wampee.canonical.com>
Message-Id: <151359053645.19292.4493658854398027432.malone@chaenomeles.canonical.com>
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

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1587970

Title:
  QEMU Crashes when attaching USB 3.00 devices to xhci bus

Status in QEMU:
  Incomplete

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
