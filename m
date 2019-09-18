Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87899C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5592F20665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5592F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdRx-0004T6-D9
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcVe-00059g-MI
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcVd-0003qt-AO
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:50 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:53435)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcVd-0003qD-5Y
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:49 -0400
Received: from player799.ha.ovh.net (unknown [10.109.160.11])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5242A6772E
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:08:47 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id C78A59F0EA60;
 Wed, 18 Sep 2019 16:08:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:40 +0200
Message-Id: <20190918160645.25126-21-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6237204013030607846
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.203
Subject: [Qemu-devel] [PATCH v4 20/25] ppc/pnv: Extend XiveRouter with a
 get_block_id() handler
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

When doing CAM line compares, fetch the block id from the interrupt
controller which can have set the PC_TCTXT_CHIPID field.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  2 +-
 hw/intc/pnv_xive.c    |  6 ++++++
 hw/intc/spapr_xive.c  |  6 ++++++
 hw/intc/xive.c        | 21 ++++++++++++++++-----
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 794dfcaae0f8..1f084b6e13a5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -351,6 +351,7 @@ typedef struct XiveRouterClass {
                    XiveNVT *nvt);
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
                      XiveNVT *nvt, uint8_t word_number);
+    uint8_t (*get_block_id)(XiveRouter *xrtr);
 } XiveRouterClass;
=20
 int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
@@ -431,7 +432,6 @@ typedef struct XiveENDSource {
     DeviceState parent;
=20
     uint32_t        nr_ends;
-    uint8_t         block_id;
=20
     /* ESB memory region */
     uint32_t        esb_shift;
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 8c352315f6f5..8fa78e1c6cd9 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -460,6 +460,11 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, u=
int8_t format,
     return count;
 }
=20
+static uint8_t pnv_xive_get_block_id(XiveRouter *xrtr)
+{
+    return pnv_xive_block_id(PNV_XIVE(xrtr));
+}
+
 /*
  * The TIMA MMIO space is shared among the chips and to identify the
  * chip from which the access is being done, we extract the chip id
@@ -1915,6 +1920,7 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D pnv_xive_write_end;
     xrc->get_nvt =3D pnv_xive_get_nvt;
     xrc->write_nvt =3D pnv_xive_write_nvt;
+    xrc->get_block_id =3D pnv_xive_get_block_id;
=20
     xnc->notify =3D pnv_xive_notify;
     xpc->match_nvt  =3D pnv_xive_match_nvt;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 864f50167c65..1a2475811257 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -482,6 +482,11 @@ static int spapr_xive_match_nvt(XivePresenter *xptr,=
 uint8_t format,
     return count;
 }
=20
+static uint8_t spapr_xive_get_block_id(XiveRouter *xrtr)
+{
+    return SPAPR_XIVE_BLOCK_ID;
+}
+
 static const VMStateDescription vmstate_spapr_xive_end =3D {
     .name =3D TYPE_SPAPR_XIVE "/end",
     .version_id =3D 1,
@@ -571,6 +576,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D spapr_xive_write_end;
     xrc->get_nvt =3D spapr_xive_get_nvt;
     xrc->write_nvt =3D spapr_xive_write_nvt;
+    xrc->get_block_id =3D spapr_xive_get_block_id;
=20
     xpc->match_nvt  =3D spapr_xive_match_nvt;
 }
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f47b0cf2b053..dfae584a319f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1322,17 +1322,25 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8=
_t nvt_blk, uint32_t nvt_idx,
    return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
 }
=20
+static int xive_router_get_block_id(XiveRouter *xrtr)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_block_id(xrtr);
+}
+
 /*
  * Encode the HW CAM line in the block group mode format :
  *
  *   chip << 19 | 0000000 0 0001 thread (7Bit)
  */
-static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx)
+static uint32_t xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tct=
x)
 {
     CPUPPCState *env =3D &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
+    uint8_t blk =3D xive_router_get_block_id(XIVE_ROUTER(xptr));
=20
-    return xive_nvt_cam_line((pir >> 8) & 0xf, 1 << 7 | (pir & 0x7f));
+    return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
 }
=20
 /*
@@ -1369,7 +1377,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, =
XiveTCTX *tctx,
=20
         /* PHYS ring */
         if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
-            cam =3D=3D xive_tctx_hw_cam_line(tctx)) {
+            cam =3D=3D xive_tctx_hw_cam_line(xptr, tctx)) {
             return TM_QW3_HV_PHYS;
         }
=20
@@ -1706,7 +1714,11 @@ static uint64_t xive_end_source_read(void *opaque,=
 hwaddr addr, unsigned size)
     uint8_t pq;
     uint64_t ret =3D -1;
=20
-    end_blk =3D xsrc->block_id;
+    /*
+     * The block id should be deduced from the load address on the END
+     * ESB MMIO but our model only supports a single block per XIVE chip=
.
+     */
+    end_blk =3D xive_router_get_block_id(xsrc->xrtr);
     end_idx =3D addr >> (xsrc->esb_shift + 1);
=20
     if (xive_router_get_end(xsrc->xrtr, end_blk, end_idx, &end)) {
@@ -1815,7 +1827,6 @@ static void xive_end_source_realize(DeviceState *de=
v, Error **errp)
 }
=20
 static Property xive_end_source_properties[] =3D {
-    DEFINE_PROP_UINT8("block-id", XiveENDSource, block_id, 0),
     DEFINE_PROP_UINT32("nr-ends", XiveENDSource, nr_ends, 0),
     DEFINE_PROP_UINT32("shift", XiveENDSource, esb_shift, XIVE_ESB_64K),
     DEFINE_PROP_END_OF_LIST(),
--=20
2.21.0


