Received: from eggs.gnu.org ([2001:4830:134:3::10]:39382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbG-00071c-Vi
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbE-0002yO-Nf
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:59644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3lbE-0002xy-IA
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3lbD-0008HV-JU
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 915042E80C4
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 15:31:08 -0000
From: Thomas Huth <1090602@bugs.launchpad.net>
Reply-To: Bug 1090602 <1090602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121215000355.23796.95243.malonedeb@soybean.canonical.com>
Message-Id: <20170427153108.23010.54932.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1090602] Re: RFE: Allow specifying usb-host
 device by serial number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1090602

Title:
  RFE: Allow specifying usb-host device by serial number

Status in QEMU:
  New

Bug description:
  Currently you can pass through a host USB device to the guest like

    -device usb-host,vendorid=3D0x1234,productid=3D0x5678

  Which is all well and good, but has problems if you are trying to
  assign to identical USB devices to the same guest.

  It would be useful if there was an additional option that allow
  matching against the device's serial number, which should allow
  differentiating between two devices with the same product+vendor.

  This was originally filed at
  https://bugzilla.redhat.com/show_bug.cgi?id=3D640332

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1090602/+subscriptions
