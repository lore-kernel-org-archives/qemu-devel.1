Received: from eggs.gnu.org ([2001:4830:134:3::10]:46756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1er4wM-0002XE-8T
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1er4wJ-0008JY-6W
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:50:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:34570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1er4wJ-0008ID-0E
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:50:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1er4wH-0002xu-QB
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 16:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C4D472E80CC
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 16:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Feb 2018 16:35:56 -0000
From: Fabiano Rosas <1681404@bugs.launchpad.net>
Reply-To: Bug 1681404 <1681404@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170410105209.1613.42620.malonedeb@chaenomeles.canonical.com>
Message-Id: <151983575671.16395.823888285337264106.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1681404] Re: hw/ppc: Aborted (core dumped)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is addressed by commit:

"f7d6bfc spapr_pci: fail gracefully with non-pseries machine types"


$ ./v2.11.0-1421-g7d84845/bin/qemu-system-ppc64 -S -machine ppce500,accel=
=3Dtcg -device spapr-pci-host-bridge
qemu-system-ppc64: -device spapr-pci-host-bridge: spapr-pci-host-bridge nee=
ds a pseries machine

$ git tag --contains f7d6bfc
v2.11.0


1- https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Df7d6bfcdc0fe49040aac3a=
c131a319cb5427957e

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681404

Title:
  hw/ppc: Aborted (core dumped)

Status in QEMU:
  New

Bug description:
  Reproducable:
  $ ./ppc64-softmmu/qemu-system-ppc64 -S -machine ppce500,accel=3Dtcg -devi=
ce spapr-pci-host-bridge

  =

  qemu/hw/ppc/spapr_pci.c:1567:spapr_phb_realize: Object 0x55bda99744a0 is =
not an instance of type spapr-machine
  Aborted (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681404/+subscriptions
