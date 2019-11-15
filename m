Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F909C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DD120718
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DD120718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVedR-0007w9-Ul
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVePg-0008LH-Ro
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVePf-0000o1-Cn
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:36 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:39668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVePf-0000nf-6X
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:35 -0500
Received: from player787.ha.ovh.net (unknown [10.109.146.19])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 79ABD113EF0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:25:33 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 1EF60C44499C;
 Fri, 15 Nov 2019 16:25:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH for-5.0 v5 08/23] ppc/xive: Introduce a XivePresenter interface
Date: Fri, 15 Nov 2019 17:24:21 +0100
Message-Id: <20191115162436.30548-9-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15095221527823813606
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.149
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

When the XIVE IVRE sub-engine (XiveRouter) looks for a Notification
Virtual Target (NVT) to notify, it broadcasts a message on the
PowerBUS to find an XIVE IVPE sub-engine (Presenter) with the NVT
dispatched on one of its HW threads, and then forwards the
notification if any response was received.

The current XIVE presenter model is sufficient for the pseries machine
because it has a single interrupt controller device, but the PowerNV
machine can have multiple chips each having its own interrupt
controller. In this case, the XIVE presenter model is too simple and
the CAM line matching should scan all chips of the system.

To start fixing this issue, we first extend the XIVE Router model with
a new XivePresenter QOM interface representing the XIVE IVPE
sub-engine. This interface exposes a 'match_nvt' handler which the
sPAPR and PowerNV XIVE Router models will need to implement to perform
the CAM line matching.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 32 ++++++++++++++++++++++++++++++++
 hw/intc/xive.c        | 26 +++++++++++++++++---------
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index fa7adf87feb2..f9aa0fa0dac3 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -367,6 +367,38 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_t =
nvt_blk, uint32_t nvt_idx,
 XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
=20
+/*
+ * XIVE Presenter
+ */
+
+typedef struct XiveTCTXMatch {
+    XiveTCTX *tctx;
+    uint8_t ring;
+} XiveTCTXMatch;
+
+typedef struct XivePresenter XivePresenter;
+
+#define TYPE_XIVE_PRESENTER "xive-presenter"
+#define XIVE_PRESENTER(obj)                                     \
+    INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
+#define XIVE_PRESENTER_CLASS(klass)                                     =
\
+    OBJECT_CLASS_CHECK(XivePresenterClass, (klass), TYPE_XIVE_PRESENTER)
+#define XIVE_PRESENTER_GET_CLASS(obj)                                   =
\
+    OBJECT_GET_CLASS(XivePresenterClass, (obj), TYPE_XIVE_PRESENTER)
+
+typedef struct XivePresenterClass {
+    InterfaceClass parent;
+    int (*match_nvt)(XivePresenter *xptr, uint8_t format,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     bool cam_ignore, uint8_t priority,
+                     uint32_t logic_serv, XiveTCTXMatch *match);
+} XivePresenterClass;
+
+int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
+                              uint8_t format,
+                              uint8_t nvt_blk, uint32_t nvt_idx,
+                              bool cam_ignore, uint32_t logic_serv);
+
 /*
  * XIVE END ESBs
  */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 511e1a936347..344bb3f3bc4b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1363,9 +1363,10 @@ static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tc=
tx)
 /*
  * The thread context register words are in big-endian format.
  */
-static int xive_presenter_tctx_match(XiveTCTX *tctx, uint8_t format,
-                                     uint8_t nvt_blk, uint32_t nvt_idx,
-                                     bool cam_ignore, uint32_t logic_ser=
v)
+int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
+                              uint8_t format,
+                              uint8_t nvt_blk, uint32_t nvt_idx,
+                              bool cam_ignore, uint32_t logic_serv)
 {
     uint32_t cam =3D xive_nvt_cam_line(nvt_blk, nvt_idx);
     uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
@@ -1422,11 +1423,6 @@ static int xive_presenter_tctx_match(XiveTCTX *tct=
x, uint8_t format,
     return -1;
 }
=20
-typedef struct XiveTCTXMatch {
-    XiveTCTX *tctx;
-    uint8_t ring;
-} XiveTCTXMatch;
-
 static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
                                  uint8_t nvt_blk, uint32_t nvt_idx,
                                  bool cam_ignore, uint8_t priority,
@@ -1460,7 +1456,8 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
          * Check the thread context CAM lines and record matches. We
          * will handle CPU exception delivery later
          */
-        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_id=
x,
+        ring =3D xive_presenter_tctx_match(XIVE_PRESENTER(xrtr), tctx, f=
ormat,
+                                         nvt_blk, nvt_idx,
                                          cam_ignore, logic_serv);
         /*
          * Save the context and follow on to catch duplicates, that we
@@ -1754,6 +1751,7 @@ static const TypeInfo xive_router_info =3D {
     .class_init    =3D xive_router_class_init,
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_XIVE_NOTIFIER },
+        { TYPE_XIVE_PRESENTER },
         { }
     }
 };
@@ -1923,10 +1921,20 @@ static const TypeInfo xive_notifier_info =3D {
     .class_size =3D sizeof(XiveNotifierClass),
 };
=20
+/*
+ * XIVE Presenter
+ */
+static const TypeInfo xive_presenter_info =3D {
+    .name =3D TYPE_XIVE_PRESENTER,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XivePresenterClass),
+};
+
 static void xive_register_types(void)
 {
     type_register_static(&xive_source_info);
     type_register_static(&xive_notifier_info);
+    type_register_static(&xive_presenter_info);
     type_register_static(&xive_router_info);
     type_register_static(&xive_end_source_info);
     type_register_static(&xive_tctx_info);
--=20
2.21.0


