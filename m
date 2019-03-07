Received: from eggs.gnu.org ([209.51.188.92]:34189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dD-0007SN-F1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21d4-00035O-SF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21cy-0001zr-0e
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MIbbY119415
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r390h1ck2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:00 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:35:58 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:36 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-4-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/15] ppc/pnv: lpc: fix OPB address ranges
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

The PowerNV LPC Controller exposes different sets of registers for
each of the functional units it encompasses, among which the OPB
(On-Chip Peripheral Bus) Master and Arbitrer and the LPC HOST
Controller.

The mapping addresses of each register range are correct but the sizes
are too large. Fix the sizes and define the OPB Arbitrer range to fill
the gap between the OPB Master registers and the LPC HOST Controller
registers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes in v2 :

  - wrote a commit log

 hw/ppc/pnv_lpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 9b18ce55e391..547be609cafe 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -89,10 +89,11 @@ enum {
 #define LPC_FW_OPB_SIZE         0x10000000
=20
 #define LPC_OPB_REGS_OPB_ADDR   0xc0010000
-#define LPC_OPB_REGS_OPB_SIZE   0x00002000
+#define LPC_OPB_REGS_OPB_SIZE   0x00000060
+#define LPC_OPB_REGS_OPBA_ADDR  0xc0011000
+#define LPC_OPB_REGS_OPBA_SIZE  0x00000008
 #define LPC_HC_REGS_OPB_ADDR    0xc0012000
-#define LPC_HC_REGS_OPB_SIZE    0x00001000
-
+#define LPC_HC_REGS_OPB_SIZE    0x00000100
=20
 static int pnv_lpc_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
 {
--=20
2.20.1
