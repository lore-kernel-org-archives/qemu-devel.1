Received: from eggs.gnu.org ([2001:4830:134:3::10]:58395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1Th-0007Sa-Bp
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1Tc-0007Lq-HK
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:09 -0500
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:58035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZ1TY-0007FU-KL
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:03 -0500
Received: from player718.ha.ovh.net (unknown [10.109.159.157])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 123F8430E2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:34:56 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 17 Dec 2018 23:34:38 +0100
Message-Id: <20181217223445.28594-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 0/7] ppc: support for the XIVE interrupt
 controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is the version 9 of the QEMU models adding support for the XIVE
interrupt controller to the sPAPR machine, under TCG only.=20

The 'dual' machine, supporting both interrupt modes, is nearly complete,
only remains the question on the qirq array, which will be addressed
in early 2019 with the support for KVM.

Thanks,

C.

Changes in v9 (sPAPR only) :

 - fixed compile breakage on windows
 - reworked XIVE capability in ibm,arch-vec-5-platform-support=20
 - fixed default CPU type on 3.1 machines
 - updated MAINTAINERS file
=20
* GitHub trees
=20
QEMU sPAPR:

  https://github.com/legoater/qemu/commits/xive-v9-4.0
 =20
QEMU PowerNV:

  https://github.com/legoater/qemu/commits/powernv-3.1

Linux/KVM:

  https://github.com/legoater/linux/commits/xive-4.20

OPAL:

  https://github.com/legoater/skiboot/commits/xive

C=C3=A9dric Le Goater (7):
  target/ppc: fix the PPC_BIT definitions
  target/ppc: replace __builtin_ffssl() by the equivalent ctz routines
  spapr/xive: fix compilation breakage on windows
  spapr: add an extra OV5 field to the sPAPR IRQ backend
  spapr: introduce an 'ic-mode' machine option
  spapr: change default CPU type to POWER9
  MAINTAINERS: PPC: add a XIVE section

 include/hw/ppc/spapr.h     |  7 ++++
 include/hw/ppc/spapr_irq.h |  1 +
 target/ppc/cpu.h           | 21 +++++-----
 hw/intc/spapr_xive.c       | 46 +++++++++++++---------
 hw/ppc/spapr.c             | 80 ++++++++++++++++++++++++++++++++------
 hw/ppc/spapr_cpu_core.c    |  3 +-
 hw/ppc/spapr_irq.c         | 37 +++++++-----------
 MAINTAINERS                |  8 ++++
 8 files changed, 138 insertions(+), 65 deletions(-)

--=20
2.17.2
