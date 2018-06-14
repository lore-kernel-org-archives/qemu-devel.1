Received: from eggs.gnu.org ([2001:4830:134:3::10]:54394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoC-0007fH-7h
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSo6-0008Or-DJ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:04 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:38490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTSo6-0008OY-5v
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:00:58 -0400
Received: from player738.ha.ovh.net (unknown [10.109.105.31])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 2B83810841D
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:00:56 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 14 Jun 2018 16:00:37 +0200
Message-Id: <20180614140043.9231-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] ppc/pnv: new Pnv8Chip and Pnv9Chip models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

First are some cleanups around the ISA bus of the machine. Then
additions of new chip models for the different processor the PowerNV
machine supports, which come with their respective "powernv8" and
"powernv9" machines.


For some obscure reasons, this patchset breaks 'make check' :

  TEST: tests/spapr-phb-test... (pid=3D8196)
  qemu-system-ppc64: -device spapr-pci-host-bridge,index=3D30: spapr-pci-=
host-bridge needs a pseries machine
  Broken pipe
 FAIL: tests/spapr-phb-test

Any idea ? I guess this is because of the new machines.=20

Thanks,

C.=20

C=C3=A9dric Le Goater (6):
  ppc/pnv: introduce a 'primary' field under the LPC model
  ppc/pnv: move the details of the ISA bus creation under the LPC model
  ppc/pnv: introduce an 'isa_bus_name' field under the LPC model
  ppc/pnv: introduce a pnv_chip_core_realize() routine
  ppc/pnv: introduce a new intc_create() operation to the chip model
  ppc/pnv: introduce Pnv8Chip and Pnv9Chip models

 include/hw/ppc/pnv.h     |  29 +++-
 include/hw/ppc/pnv_lpc.h |   6 +-
 hw/ppc/pnv.c             | 380 +++++++++++++++++++++++++++++------------=
------
 hw/ppc/pnv_core.c        |  18 +--
 hw/ppc/pnv_lpc.c         |  55 +++++--
 5 files changed, 322 insertions(+), 166 deletions(-)

--=20
2.13.6
