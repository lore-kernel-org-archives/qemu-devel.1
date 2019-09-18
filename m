Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAEEC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E4721848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E4721848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdOB-0008Jr-42
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcVZ-00052F-1a
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcVX-0003no-HM
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:44 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:39987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcVX-0003mu-BX
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:43 -0400
Received: from player799.ha.ovh.net (unknown [10.109.160.23])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id C8BE619029F
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:08:41 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 51A019F0EA12;
 Wed, 18 Sep 2019 16:08:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:39 +0200
Message-Id: <20190918160645.25126-20-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6235515161851562982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.162.229
Subject: [Qemu-devel] [PATCH v4 19/25] ppc/pnv: Introduce a
 pnv_xive_block_id() helper
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When PC_TCTXT_CHIPID_OVERRIDE is configured, the PC_TCTXT_CHIPID field
overrides the hardwired chip ID in the Powerbus operations and for CAM
compares. This is typically used in the one block-per-chip configuration
to associate a unique block id number to each IC of the system.

Simplify the model with a pnv_xive_block_id() helper and remove
'tctx_chipid' which becomes useless.

The model does support multiple blocks per chip.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_xive.h |  3 --
 hw/intc/pnv_xive.c        | 68 ++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 4fdaa9247d65..f4c7caad40ee 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -72,9 +72,6 @@ typedef struct PnvXive {
     /* Interrupt controller registers */
     uint64_t      regs[0x300];
=20
-    /* Can be configured by FW */
-    uint32_t      tctx_chipid;
-
     /*
      * Virtual Structure Descriptor tables : EAT, SBE, ENDT, NVTT, IRQ
      * These are in a SRAM protected by ECC.
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index a986d4ed9364..8c352315f6f5 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -85,13 +85,30 @@ static inline uint64_t SETFIELD(uint64_t mask, uint64=
_t word,
     return (word & ~mask) | ((value << ctz64(mask)) & mask);
 }
=20
+/*
+ * When PC_TCTXT_CHIPID_OVERRIDE is configured, the PC_TCTXT_CHIPID
+ * field overrides the hardwired chip ID in the Powerbus operations
+ * and for CAM compares
+ */
+static uint8_t pnv_xive_block_id(PnvXive *xive)
+{
+    uint8_t blk =3D xive->chip->chip_id;
+    uint64_t cfg_val =3D xive->regs[PC_TCTXT_CFG >> 3];
+
+    if (cfg_val & PC_TCTXT_CHIPID_OVERRIDE) {
+        blk =3D GETFIELD(PC_TCTXT_CHIPID, cfg_val);
+    }
+
+    return blk;
+}
+
 /*
  * Remote access to controllers. HW uses MMIOs. For now, a simple scan
  * of the chips is good enough.
  *
  * TODO: Block scope support
  */
-static PnvXive *pnv_xive_get_ic(uint8_t blk)
+static PnvXive *pnv_xive_get_remote(uint8_t blk)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
     int i;
@@ -100,7 +117,7 @@ static PnvXive *pnv_xive_get_ic(uint8_t blk)
         Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
         PnvXive *xive =3D &chip9->xive;
=20
-        if (xive->chip->chip_id =3D=3D blk) {
+        if (pnv_xive_block_id(xive) =3D=3D blk) {
             return xive;
         }
     }
@@ -212,7 +229,7 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint=
32_t type, uint8_t blk,
=20
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) =3D=3D VSD_MODE_FORWARD) {
-        xive =3D pnv_xive_get_ic(blk);
+        xive =3D pnv_xive_get_remote(blk);
=20
         return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
     }
@@ -360,7 +377,10 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
 {
     PnvXive *xive =3D PNV_XIVE(xrtr);
=20
-    if (pnv_xive_get_ic(blk) !=3D xive) {
+    /*
+     * EAT lookups should be local to the IC
+     */
+    if (pnv_xive_block_id(xive) !=3D blk) {
         xive_error(xive, "VST: EAS %x is remote !?", XIVE_SRCNO(blk, idx=
));
         return -1;
     }
@@ -471,7 +491,7 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
 static void pnv_xive_notify(XiveNotifier *xn, uint32_t srcno)
 {
     PnvXive *xive =3D PNV_XIVE(xn);
-    uint8_t blk =3D xive->chip->chip_id;
+    uint8_t blk =3D pnv_xive_block_id(xive);
=20
     xive_router_notify(xn, XIVE_SRCNO(blk, srcno));
 }
@@ -835,20 +855,7 @@ static void pnv_xive_ic_reg_write(void *opaque, hwad=
dr offset,
     case PC_TCTXT_CFG:
         /*
          * TODO: block group support
-         *
-         * PC_TCTXT_CFG_BLKGRP_EN
-         * PC_TCTXT_CFG_HARD_CHIPID_BLK :
-         *   Moves the chipid into block field for hardwired CAM compare=
s.
-         *   Block offset value is adjusted to 0b0..01 & ThrdId
-         *
-         *   Will require changes in xive_presenter_tctx_match(). I am
-         *   not sure how to handle that yet.
          */
-
-        /* Overrides hardwired chip ID with the chip ID field */
-        if (val & PC_TCTXT_CHIPID_OVERRIDE) {
-            xive->tctx_chipid =3D GETFIELD(PC_TCTXT_CHIPID, val);
-        }
         break;
     case PC_TCTXT_TRACK:
         /*
@@ -1665,7 +1672,8 @@ static void xive_nvt_pic_print_info(XiveNVT *nvt, u=
int32_t nvt_idx,
 void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
-    uint8_t blk =3D xive->chip->chip_id;
+    uint8_t blk =3D pnv_xive_block_id(xive);
+    uint8_t chip_id =3D xive->chip->chip_id;
     uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
     uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
     XiveEAS eas;
@@ -1673,12 +1681,12 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monit=
or *mon)
     XiveNVT nvt;
     int i;
=20
-    monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
-                   srcno0 + nr_ipis - 1);
+    monitor_printf(mon, "XIVE[%x] #%d Source %08x .. %08x\n", chip_id, b=
lk,
+                   srcno0, srcno0 + nr_ipis - 1);
     xive_source_pic_print_info(&xive->ipi_source, srcno0, mon);
=20
-    monitor_printf(mon, "XIVE[%x] EAT %08x .. %08x\n", blk, srcno0,
-                   srcno0 + nr_ipis - 1);
+    monitor_printf(mon, "XIVE[%x] #%d EAT %08x .. %08x\n", chip_id, blk,
+                   srcno0, srcno0 + nr_ipis - 1);
     for (i =3D 0; i < nr_ipis; i++) {
         if (xive_router_get_eas(xrtr, blk, i, &eas)) {
             break;
@@ -1688,20 +1696,20 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monit=
or *mon)
         }
     }
=20
-    monitor_printf(mon, "XIVE[%x] ENDT\n", blk);
+    monitor_printf(mon, "XIVE[%x] #%d ENDT\n", chip_id, blk);
     i =3D 0;
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_pic_print_info(&end, i++, mon);
     }
=20
-    monitor_printf(mon, "XIVE[%x] END Escalation EAT\n", blk);
+    monitor_printf(mon, "XIVE[%x] #%d END Escalation EAT\n", chip_id, bl=
k);
     i =3D 0;
     while (!xive_router_get_end(xrtr, blk, i, &end)) {
         xive_end_eas_pic_print_info(&end, i++, mon);
     }
=20
-    monitor_printf(mon, "XIVE[%x] NVTT %08x .. %08x\n", blk, 0,
-                   XIVE_NVT_COUNT - 1);
+    monitor_printf(mon, "XIVE[%x] #%d NVTT %08x .. %08x\n", chip_id, blk=
,
+                   0, XIVE_NVT_COUNT - 1);
     for (i =3D 0; i < XIVE_NVT_COUNT; i +=3D XIVE_NVT_PER_PAGE) {
         while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
             xive_nvt_pic_print_info(&nvt, i++, mon);
@@ -1715,12 +1723,6 @@ static void pnv_xive_reset(void *dev)
     XiveSource *xsrc =3D &xive->ipi_source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
=20
-    /*
-     * Use the PnvChip id to identify the XIVE interrupt controller.
-     * It can be overriden by configuration at runtime.
-     */
-    xive->tctx_chipid =3D xive->chip->chip_id;
-
     /* Default page size (Should be changed at runtime to 64k) */
     xive->ic_shift =3D xive->vc_shift =3D xive->pc_shift =3D 12;
=20
--=20
2.21.0


