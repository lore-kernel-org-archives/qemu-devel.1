Received: from eggs.gnu.org ([2001:4830:134:3::10]:58018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzbe1-0006Wg-0u
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 01:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzbdv-0002We-VZ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 01:55:24 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:48672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzbdv-0002WB-NE
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 01:55:19 -0400
Received: from player750.ha.ovh.net (unknown [10.109.160.39])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5D32DD5448
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 07:55:18 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Sep 2018 07:55:01 +0200
Message-Id: <20180911055503.2303-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] spapr: introduce a new sPAPRIrq backend
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

Hello,

This series adds a new sPAPRIrq backend increasing the number of
available IRQ numbers in pseries-3.1 machines. This change is an
opportunity to also fix the "ibm,pe-total-#msi" and remove the old
XICS_IRQS_SPAPR definition.

Thanks,

C.

Changes since v1:

 - merge patch 1 and 3


C=C3=A9dric Le Goater (2):
  spapr: introduce a spapr_irq class 'nr_msis' attribute
  spapr: increase the size of the IRQ number space

 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xics.h      |  2 --
 hw/ppc/spapr.c             |  1 +
 hw/ppc/spapr_irq.c         | 22 ++++++++++++++++++++--
 hw/ppc/spapr_pci.c         |  5 +++--
 5 files changed, 26 insertions(+), 6 deletions(-)

--=20
2.17.1
