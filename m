Received: from eggs.gnu.org ([2001:4830:134:3::10]:50341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTqbl-0003oh-C8
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTqbi-0006VW-3j
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:25:49 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:53785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTqbh-0006U2-Sf
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:25:46 -0400
Received: from player794.ha.ovh.net (unknown [10.109.105.29])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4A354B68D6
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 17:25:44 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Jun 2018 17:25:32 +0200
Message-Id: <20180615152536.30093-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] ppc/pnv: new Pnv8Chip and Pnv9Chip
 models
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

Changes since v1:

 - reworked the ISABus creation interface with the chip, the machine
   is not aware anymore of the chip controllers.
 - removed the bizarre controllers under the PnvChip base class.
 - kept back some changes on the ISA device tree name. They will come
   in time with the LPC controller for P9

C=C3=A9dric Le Goater (4):
  ppc/pnv: introduce a new intc_create() operation to the chip model
  ppc/pnv: introduce a new isa_create() operation to the chip model
  ppc/pnv: introduce Pnv8Chip and Pnv9Chip models
  ppc/pnv: consolidate the creation of the ISA bus device tree

 include/hw/ppc/pnv.h     |  25 ++-
 include/hw/ppc/pnv_lpc.h |   3 +-
 hw/ppc/pnv.c             | 424 ++++++++++++++++++++++++++++++-----------=
------
 hw/ppc/pnv_core.c        |  18 +-
 hw/ppc/pnv_lpc.c         |  30 +++-
 5 files changed, 327 insertions(+), 173 deletions(-)

--=20
2.13.6
