Received: from eggs.gnu.org ([2001:4830:134:3::10]:53362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWTS-0003Oj-PY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTWTP-0006oL-4S
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:58340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTWTO-0006o0-Tv
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 13:55:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTWTO-0005bL-0E
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 17:55:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 006862E80C7
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 17:55:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Jun 2018 17:40:40 -0000
From: Thomas Huth <1463463@bugs.launchpad.net>
Reply-To: Bug 1463463 <1463463@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150609152912.22500.85807.malonedeb@chaenomeles.canonical.com>
Message-Id: <152899804038.25494.14682118866470658504.malone@soybean.canonical.com>
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

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1463463

Title:
  PCI devices on PCI to PCI bridges stopped being accessable from Xen
  with QEMU 2.3.0

Status in QEMU:
  Incomplete

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
