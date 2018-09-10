Received: from eggs.gnu.org ([2001:4830:134:3::10]:57345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzJy1-0001gh-Ko
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzJxw-00018w-F4
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:02:53 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:52006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzJxu-00010g-Ey
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:02:46 -0400
Received: from player691.ha.ovh.net (unknown [10.109.159.222])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id D1196C4EA7
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 13:02:37 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 10 Sep 2018 13:02:19 +0200
Message-Id: <20180910110222.8162-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] spapr: introduce a new sPAPRIrq backend
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

C=C3=A9dric Le Goater (3):
  spapr: introduce a spapr_irq class 'nr_msis' attribute
  spapr: increase the size of the IRQ number space
  spapr_pci: fix "ibm,pe-total-#msi" value

 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xics.h      |  2 --
 hw/ppc/spapr.c             |  1 +
 hw/ppc/spapr_irq.c         | 22 ++++++++++++++++++++--
 hw/ppc/spapr_pci.c         |  5 +++--
 5 files changed, 26 insertions(+), 6 deletions(-)

--=20
2.17.1
