Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0EBC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829642072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829642072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeXN-0008HZ-JC
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVePK-0007j8-H9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVePJ-0000eb-9c
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:14 -0500
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:39333)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVePI-0000df-WB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:13 -0500
Received: from player787.ha.ovh.net (unknown [10.108.54.94])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 847CE231DB9
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:25:11 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 14DA7C444802;
 Fri, 15 Nov 2019 16:25:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH for-5.0 v5 04/23] ppc/pnv: Dump the XIVE NVT table
Date: Fri, 15 Nov 2019 17:24:17 +0100
Message-Id: <20191115162436.30548-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15089029079264693222
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedv
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.249
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is useful to dump the saved contexts of the vCPUs : configuration
of the base END index of the vCPU and the Interrupt Pending Buffer
register, which is updated when an interrupt can not be presented.

When dumping the NVT table, we skip empty indirect pages which are not
necessarily allocated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h |  2 ++
 hw/intc/pnv_xive.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 1a5622f8ded8..94338b4b551e 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -252,6 +252,8 @@ typedef struct XiveNVT {
         uint32_t        w0;
 #define NVT_W0_VALID             PPC_BIT32(0)
         uint32_t        w1;
+#define NVT_W1_EQ_BLOCK          PPC_BITMASK32(0, 3)
+#define NVT_W1_EQ_INDEX          PPC_BITMASK32(4, 31)
         uint32_t        w2;
         uint32_t        w3;
         uint32_t        w4;
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index a4d80fd5e79c..02faf4135e48 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1554,6 +1554,27 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D {
     },
 };
=20
+/*
+ * skiboot uses an indirect NVT table with 64k subpages
+ */
+#define XIVE_NVT_COUNT          (1 << XIVE_NVT_SHIFT)
+#define XIVE_NVT_PER_PAGE       (0x10000 / sizeof(XiveNVT))
+
+static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
+                                    Monitor *mon)
+{
+    uint8_t  eq_blk =3D xive_get_field32(NVT_W1_EQ_BLOCK, nvt->w1);
+    uint32_t eq_idx =3D xive_get_field32(NVT_W1_EQ_INDEX, nvt->w1);
+
+    if (!xive_nvt_is_valid(nvt)) {
+        return;
+    }
+
+    monitor_printf(mon, "  %08x end:%02x/%04x IPB:%02x\n", nvt_idx,
+                   eq_blk, eq_idx,
+                   xive_get_field32(NVT_W4_IPB, nvt->w4));
+}
+
 void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
@@ -1562,6 +1583,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
     uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
     XiveEAS eas;
     XiveEND end;
+    XiveNVT nvt;
     int i;
=20
     monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
@@ -1590,6 +1612,14 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monito=
r *mon)
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_eas_pic_print_info(&end, i++, mon);
     }
+
+    monitor_printf(mon, "XIVE[%x] NVTT %08x .. %08x\n", blk, 0,
+                   XIVE_NVT_COUNT - 1);
+    for (i =3D 0; i < XIVE_NVT_COUNT; i +=3D XIVE_NVT_PER_PAGE) {
+        while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
+            xive_nvt_pic_print_info(&nvt, i++, mon);
+        }
+    }
 }
=20
 static void pnv_xive_reset(void *dev)
--=20
2.21.0


