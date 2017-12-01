Received: from eggs.gnu.org ([2001:4830:134:3::10]:47747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKnpf-0001Ae-Id
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKnpZ-000261-Em
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:29 -0500
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:37022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKnpZ-0001rx-6G
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:25 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6AD97177DAE
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 17:06:16 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  1 Dec 2017 17:05:59 +0100
Message-Id: <20171201160604.15265-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] spapr: preliminary cleanups before
 introducing XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

These are initial patches of the XIVE patchset which prepare ground
for the integration of the XIVE model.

Thanks,

C.

C=C3=A9dric Le Goater (5):
  ppc/xics: introduce an icp_create() helper
  ppc/xics: assign of the CPU 'intc' pointer under the core
  spapr: move the IRQ allocation routines under the machine
  spapr: introduce a spapr_irq_set_lsi() helper
  spapr: introduce a spapr_qirq() helper

 hw/intc/trace-events        |   4 --
 hw/intc/xics.c              |  34 ++++++-----
 hw/intc/xics_spapr.c        | 114 -------------------------------------
 hw/ppc/pnv_core.c           |  10 +---
 hw/ppc/spapr.c              | 133 ++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_cpu_core.c     |  14 +----
 hw/ppc/spapr_events.c       |  16 +++---
 hw/ppc/spapr_pci.c          |  10 ++--
 hw/ppc/spapr_vio.c          |   2 +-
 hw/ppc/trace-events         |   4 ++
 include/hw/pci-host/spapr.h |   2 +-
 include/hw/ppc/spapr.h      |   7 +++
 include/hw/ppc/spapr_vio.h  |   2 +-
 include/hw/ppc/xics.h       |   8 +--
 14 files changed, 187 insertions(+), 173 deletions(-)

--=20
2.13.6
