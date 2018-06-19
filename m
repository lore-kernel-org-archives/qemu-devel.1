Received: from eggs.gnu.org ([2001:4830:134:3::10]:36436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVHIT-0007SU-J7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVHIO-0002eX-Kw
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:07:49 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:45946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVHIO-0002dW-Cp
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:07:44 -0400
Received: from player786.ha.ovh.net (unknown [10.109.108.3])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id ADA27175851
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 16:07:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 19 Jun 2018 16:07:26 +0200
Message-Id: <20180619140729.21949-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/3] spapr: introduce a fixed IRQ number
 space and an IRQ controller backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Here is a proposal for a new IRQ number space layout using static
numbers and a bitmap allocator for the MSIs. The previous layout is
kept for compatibly in machines raising the 'legacy_irq_allocation' flag.

The patchset also introduces a sPAPR IRQ interface which offers the
possibility to provide different IRQ controller backend to the sPAPR
machine. This is preparing ground for the new XIVE controller.

Thanks,

C.

Changes since v2 :

 - renamed 'xics_legacy' to 'legacy_irq_allocation'
 - introduced the sPAPR IRQ backend interface
 - increase the size of the IRQ number space for newer machines

Changes since v1 :

 - removed block allocation
 - spaced the IRQ offsets=20
 - check for overlaps when allocating VIO irqs
 - removed 'Error *' arg from spapr_irq_msi_init()=20


C=C3=A9dric Le Goater (3):
  spapr: introduce a fixed IRQ number space
  spapr: introduce a IRQ controller backend to the machine
  spapr: increase the size of the IRQ number space

 include/hw/ppc/spapr.h     |  14 +--
 include/hw/ppc/spapr_irq.h |  55 +++++++++
 hw/ppc/spapr.c             | 201 +++++-------------------------
 hw/ppc/spapr_events.c      |  12 +-
 hw/ppc/spapr_irq.c         | 297 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_pci.c         |  29 ++++-
 hw/ppc/spapr_vio.c         |  19 ++-
 hw/ppc/Makefile.objs       |   2 +-
 8 files changed, 438 insertions(+), 191 deletions(-)
 create mode 100644 include/hw/ppc/spapr_irq.h
 create mode 100644 hw/ppc/spapr_irq.c

--=20
2.13.6
