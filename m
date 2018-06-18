Received: from eggs.gnu.org ([2001:4830:134:3::10]:56603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUxbI-0003Rx-DG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUxbE-0002WA-CT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:05:56 -0400
Received: from 18.mo7.mail-out.ovh.net ([188.165.56.163]:44365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fUxbE-0002Vg-56
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:05:52 -0400
Received: from player729.ha.ovh.net (unknown [10.109.108.37])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 765ECB3EFA
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 19:05:50 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 18 Jun 2018 19:05:38 +0200
Message-Id: <20180618170540.12143-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] ppc/pnv: new Pnv8Chip and Pnv9Chip
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

Here comes new chip models for the different processor the PowerNV
machine supports and some more cleanups around the device tree of the
ISA bus of the machine.

Thanks,

C.=20

Changes since v2:

  - introduced a parent_realize
  - removed the machines
 =20
Changes since v1:

 - reworked the ISABus creation interface with the chip, the machine
   is not aware anymore of the chip controllers.
 - removed the bizarre controllers under the PnvChip base class.
 - kept back some changes on the ISA device tree name. They will come
   in time with the LPC controller for P9

C=C3=A9dric Le Goater (2):
  ppc/pnv: introduce Pnv8Chip and Pnv9Chip models
  ppc/pnv: consolidate the creation of the ISA bus device tree

 include/hw/ppc/pnv.h |  24 +++-
 hw/ppc/pnv.c         | 332 +++++++++++++++++++++++++++++++--------------=
------
 2 files changed, 225 insertions(+), 131 deletions(-)

--=20
2.13.6
