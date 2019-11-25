Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46132C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2A62071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 07:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2A62071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ8aC-0001wy-SA
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 02:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZ8Ls-0003VW-T1
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZ8Lr-0001xK-JN
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:00:04 -0500
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:51007)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZ8Lr-0001v2-9j
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 02:00:03 -0500
Received: from player697.ha.ovh.net (unknown [10.109.159.152])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 20C7621369E
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 08:00:01 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 6B880C809683;
 Mon, 25 Nov 2019 06:59:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v6 15/20] ppc/xive: Remove the get_tctx() XiveRouter handler
Date: Mon, 25 Nov 2019 07:58:15 +0100
Message-Id: <20191125065820.927-16-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191125065820.927-1-clg@kaod.org>
References: <20191125065820.927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8930919539497798630
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeitddggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeeg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.29
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

It is now unused.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  2 --
 hw/intc/pnv_xive.c    | 13 -------------
 hw/intc/spapr_xive.c  |  8 --------
 hw/intc/xive.c        |  7 -------
 4 files changed, 30 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index dcf897451589..24315480e7c2 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -351,7 +351,6 @@ typedef struct XiveRouterClass {
                    XiveNVT *nvt);
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
                      XiveNVT *nvt, uint8_t word_number);
-    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
 } XiveRouterClass;
=20
 int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
@@ -364,7 +363,6 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
                         XiveNVT *nvt);
 int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
                           XiveNVT *nvt, uint8_t word_number);
-XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
=20
 /*
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index c14a2d186960..216ebc150a41 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -460,18 +460,6 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu=
)
     return xive;
 }
=20
-static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
-
-    if (!xive) {
-        return NULL;
-    }
-
-    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-}
-
 /*
  * The internal sources (IPIs) of the interrupt controller have no
  * knowledge of the XIVE chip on which they reside. Encode the block
@@ -1900,7 +1888,6 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D pnv_xive_write_end;
     xrc->get_nvt =3D pnv_xive_get_nvt;
     xrc->write_nvt =3D pnv_xive_write_nvt;
-    xrc->get_tctx =3D pnv_xive_get_tctx;
=20
     xnc->notify =3D pnv_xive_notify;
     xpc->match_nvt  =3D pnv_xive_match_nvt;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 6292da58f62c..1542cef91878 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -427,13 +427,6 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, ui=
nt8_t nvt_blk,
     g_assert_not_reached();
 }
=20
-static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-
-    return spapr_cpu_state(cpu)->tctx;
-}
-
 static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
                                 bool cam_ignore, uint8_t priority,
@@ -771,7 +764,6 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->write_end =3D spapr_xive_write_end;
     xrc->get_nvt =3D spapr_xive_get_nvt;
     xrc->write_nvt =3D spapr_xive_write_nvt;
-    xrc->get_tctx =3D spapr_xive_get_tctx;
=20
     sicc->activate =3D spapr_xive_activate;
     sicc->deactivate =3D spapr_xive_deactivate;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 0ca7099f4e55..4bff3abdc3eb 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1317,13 +1317,6 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_=
t nvt_blk, uint32_t nvt_idx,
    return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
 }
=20
-XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
-{
-    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
-
-    return xrc->get_tctx(xrtr, cs);
-}
-
 /*
  * Encode the HW CAM line in the block group mode format :
  *
--=20
2.21.0


