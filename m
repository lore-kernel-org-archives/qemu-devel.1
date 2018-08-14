Received: from eggs.gnu.org ([2001:4830:134:3::10]:54494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpQyu-0006FK-3i
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 00:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpQyq-0006HR-Vs
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 00:30:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:55766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpQyq-0006Gg-Oz
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 00:30:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpQyp-0007mL-Cu
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 04:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5FC152E851B
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 04:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Aug 2018 04:17:29 -0000
From: Launchpad Bug Tracker <1463463@bugs.launchpad.net>
Reply-To: Bug 1463463 <1463463@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150609152912.22500.85807.malonedeb@chaenomeles.canonical.com>
Message-Id: <153422025005.598.587227392374831338.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1463463] Re: PCI devices on PCI to PCI bridges
 stopped being accessable from Xen with QEMU 2.3.0
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
https://bugs.launchpad.net/bugs/1463463

Title:
  PCI devices on PCI to PCI bridges stopped being accessable from Xen
  with QEMU 2.3.0

Status in QEMU:
  Expired

Bug description:
  The change set:

  commit 3996e85c1822e05c50250f8d2d1e57b6bea1229d
  Author: Paul Durrant <paul.durrant@citrix.com>
  Date:   Tue Jan 20 11:06:19 2015 +0000

      Xen: Use the ioreq-server API when available
  ...

  Added calls to xen_map_pcidev()  when available.  However these call
  are only done at startup, not when the guest configures the PCI to PCI
  bridge.  So Xen 4.5.0 (which has these) using a QEMU 2.3.0 or later
  can no longer access PCI devices that are not on a root bridge.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1463463/+subscriptions
