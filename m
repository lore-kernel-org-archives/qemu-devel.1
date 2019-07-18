Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8160C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C51121019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C51121019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho51J-0000WT-EL
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho50r-0008HM-OR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho50o-0002TA-P2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:52 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:43740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho50m-0002Q7-S9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:50 -0400
Received: from player778.ha.ovh.net (unknown [10.108.57.72])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 507CD7223D
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:55:46 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 96B7C801F5D6;
 Thu, 18 Jul 2019 11:55:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:16 +0200
Message-Id: <20190718115420.19919-14-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6791991190805908454
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.45
Subject: [Qemu-devel] [PATCH v2 13/17] ppc/pnv: Dump the XIVE NVT table
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

This is to track the configuration of the base END index of the vCPU
and the Interrupt Pending Buffer. The NVT IPB is updated when an
interrupt can not be presented to a vCPU.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h |  2 ++
 hw/intc/pnv_xive.c         | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 92ff80d25456..b228ab0ba3ea 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -229,6 +229,8 @@ typedef struct XiveNVT {
         uint32_t        w0;
 #define NVT_W0_VALID             PPC_BIT32(0)
         uint32_t        w1;
+#define NVT_W1_EQ_BLOCK          PPC_BITMASK32(0, 3)
+#define NVT_W1_EQ_INDEX          PPC_BITMASK32(4, 31)
         uint32_t        w2;
         uint32_t        w3;
         uint32_t        w4;
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 63243253b736..a086598c5e77 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1540,6 +1540,21 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D {
     },
 };
=20
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
@@ -1548,6 +1563,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
     uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
     XiveEAS eas;
     XiveEND end;
+    XiveNVT nvt;
     int i;
=20
     monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
@@ -1576,6 +1592,12 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monito=
r *mon)
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_eas_pic_print_info(&end, i++, mon);
     }
+
+    monitor_printf(mon, "XIVE[%x] NVTT\n", blk);
+    i =3D 0;
+    while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
+        xive_nvt_pic_print_info(&nvt, i++, mon);
+    }
 }
=20
 static void pnv_xive_reset(void *dev)
--=20
2.21.0


