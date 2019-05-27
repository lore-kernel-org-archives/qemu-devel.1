Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0773DC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 07:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DCC2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 07:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DCC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hV9uL-0005iy-K8
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 03:18:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hV9t9-00059v-KA
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hV9t8-0002ak-Q5
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:17:43 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:54308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hV9t8-0002Zk-LS
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:17:42 -0400
Received: from player735.ha.ovh.net (unknown [10.109.146.173])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5F85112D5B1
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 09:17:38 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player735.ha.ovh.net (Postfix) with ESMTPSA id 621EB6336185;
	Mon, 27 May 2019 07:17:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 27 May 2019 09:17:22 +0200
Message-Id: <20190527071722.31424-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 10309302501163437030
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddvuddgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.230
Subject: [Qemu-devel] [PATCH] ppc/pnv: add dummy XSCOM registers for PRD
 initialization
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PRD (Processor recovery diagnostics) is a service available on
OpenPower systems. The opal-prd daemon initializes the PowerPC
Processor through the XSCOM bus and then waits for hardware diagnostic
events.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_xscom.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index c285ef514e88..f53a6d7a9457 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -29,6 +29,12 @@
=20
 #include <libfdt.h>
=20
+/* PRD registers */
+#define PRD_P8_IPOLL_REG_MASK           0x01020013
+#define PRD_P8_IPOLL_REG_STATUS         0x01020014
+#define PRD_P9_IPOLL_REG_MASK           0x000F0033
+#define PRD_P9_IPOLL_REG_STATUS         0x000F0034
+
 static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
 {
     /*
@@ -70,6 +76,12 @@ static uint64_t xscom_read_default(PnvChip *chip, uint=
32_t pcba)
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
=20
+        /* PRD registers */
+    case PRD_P8_IPOLL_REG_MASK:
+    case PRD_P8_IPOLL_REG_STATUS:
+    case PRD_P9_IPOLL_REG_MASK:
+    case PRD_P9_IPOLL_REG_STATUS:
+
         /* P9 xscom reset */
     case 0x0090018:     /* Receive status reg */
     case 0x0090012:     /* log register */
@@ -124,6 +136,12 @@ static bool xscom_write_default(PnvChip *chip, uint3=
2_t pcba, uint64_t val)
     case 0x201302a:     /* CAPP stuff */
     case 0x2013801:     /* CAPP stuff */
     case 0x2013802:     /* CAPP stuff */
+
+        /* P8 PRD registers */
+    case PRD_P8_IPOLL_REG_MASK:
+    case PRD_P8_IPOLL_REG_STATUS:
+    case PRD_P9_IPOLL_REG_MASK:
+    case PRD_P9_IPOLL_REG_STATUS:
         return true;
     default:
         return false;
--=20
2.21.0


