Received: from eggs.gnu.org ([209.51.188.92]:55286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH0-0006TJ-VN
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGy-0001z7-T4
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGy-0001Ht-DF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:32 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mZ0J028799
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r283s930b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:57 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:54 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:21 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-17-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/27] ppc/pnv: lpc: fix OPB address ranges
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
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
