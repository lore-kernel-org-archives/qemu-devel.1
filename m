Received: from eggs.gnu.org ([209.51.188.92]:48008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2Us-0002FY-Fc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk2Ur-0005a7-F6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gk2Uo-0005PU-Sg
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:53:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0H7repV053200
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:53:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2n77145j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:53:41 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 17 Jan 2019 07:53:37 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 17 Jan 2019 08:53:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190117075327.22194-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] ppc: move the interrupt presenters under
 the CPU machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Currently the interrupt presenters of the sPAPR and PowerNV machines
are stored directly under PowerPCCPU which can be problematic as this
model is shared by all PPC machines.

The following patches move the interrupt presenters under the CPU
machine_data pointer which is a private field of the CPU that the
machine can use of its own needs.

To be applied on top of Thomas -std=3Dgnu99 patchset.

Thanks,

C.=20

C=C3=A9dric Le Goater (4):
  xive: add a get_tctx() method to the XiveRouter
  ppc/pnv: introduce a CPU machine_data
  spapr: move the interrupt presenters under machine_data
  ppc: remove the interrupt presenters from under PowerPCCPU

 include/hw/ppc/pnv_core.h       |  9 ++++++
 include/hw/ppc/spapr_cpu_core.h |  2 ++
 include/hw/ppc/xive.h           | 57 +++++++++++++++++----------------
 target/ppc/cpu.h                |  9 ------
 hw/intc/spapr_xive.c            |  9 ++++++
 hw/intc/xics_spapr.c            | 11 ++++---
 hw/intc/xive.c                  | 16 +++++----
 hw/ppc/pnv.c                    |  7 ++--
 hw/ppc/pnv_core.c               | 12 ++++++-
 hw/ppc/spapr.c                  |  2 +-
 hw/ppc/spapr_cpu_core.c         |  8 ++---
 hw/ppc/spapr_irq.c              | 17 ++++++----
 12 files changed, 95 insertions(+), 64 deletions(-)

--=20
2.20.1
