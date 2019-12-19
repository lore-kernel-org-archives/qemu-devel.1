Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636DFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B5D222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B5D222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0Vu-0001Y8-DB
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ii0IS-0001KY-Fi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ii0IQ-0006UV-6p
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:13:12 -0500
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:44537)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ii0IP-0006Ok-V6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:13:10 -0500
Received: from player734.ha.ovh.net (unknown [10.108.16.238])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id DC875263786
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 19:13:08 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 7FED1D6D640F;
 Thu, 19 Dec 2019 18:13:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 11/13] xive: Add a "presenter" link property to the TCTX
 object
Date: Thu, 19 Dec 2019 19:11:53 +0100
Message-Id: <20191219181155.32530-12-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219181155.32530-1-clg@kaod.org>
References: <20191219181155.32530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 13669550770366942182
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepge
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.182.191
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

This will be used in subsequent patches to access the XIVE associated to
a TCTX without reaching out to the machine through qdev_get_machine().

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
[ groug: - split patch
         - write subject and changelog ]
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 8 +++++---
 hw/intc/spapr_xive.c  | 2 +-
 hw/intc/xive.c        | 6 +++++-
 hw/ppc/pnv.c          | 3 ++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 1ded82b1cda8..705cf48176fc 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -311,6 +311,8 @@ void xive_source_set_irq(void *opaque, int srcno, int=
 val);
 #define XIVE_TM_RING_COUNT      4
 #define XIVE_TM_RING_SIZE       0x10
=20
+typedef struct XivePresenter XivePresenter;
+
 typedef struct XiveTCTX {
     DeviceState parent_obj;
=20
@@ -319,6 +321,8 @@ typedef struct XiveTCTX {
     qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
+
+    XivePresenter *xptr;
 } XiveTCTX;
=20
 /*
@@ -378,8 +382,6 @@ typedef struct XiveTCTXMatch {
     uint8_t ring;
 } XiveTCTXMatch;
=20
-typedef struct XivePresenter XivePresenter;
-
 #define TYPE_XIVE_PRESENTER "xive-presenter"
 #define XIVE_PRESENTER(obj)                                     \
     INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
@@ -467,7 +469,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveT=
CTX *tctx, hwaddr offset,
                            unsigned size);
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
-Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
+Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)=
;
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 32322470a8b8..76631238783e 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -601,7 +601,7 @@ static int spapr_xive_cpu_intc_create(SpaprInterruptC=
ontroller *intc,
     Object *obj;
     SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
-    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), errp);
+    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(xive), errp);
     if (!obj) {
         return -1;
     }
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 12a362b681a6..bc8019c4c973 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -654,6 +654,7 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
     Error *local_err =3D NULL;
=20
     assert(tctx->cs);
+    assert(tctx->xptr);
=20
     cpu =3D POWERPC_CPU(tctx->cs);
     env =3D &cpu->env;
@@ -727,6 +728,8 @@ static const VMStateDescription vmstate_xive_tctx =3D=
 {
=20
 static Property xive_tctx_properties[] =3D {
     DEFINE_PROP_LINK("cpu", XiveTCTX, cs, TYPE_CPU, CPUState *),
+    DEFINE_PROP_LINK("presenter", XiveTCTX, xptr, TYPE_XIVE_PRESENTER,
+                     XivePresenter *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -752,7 +755,7 @@ static const TypeInfo xive_tctx_info =3D {
     .class_init    =3D xive_tctx_class_init,
 };
=20
-Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
+Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)
 {
     Error *local_err =3D NULL;
     Object *obj;
@@ -761,6 +764,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
     object_property_set_link(obj, cpu, "cpu", &error_abort);
+    object_property_set_link(obj, OBJECT(xptr), "presenter", &error_abor=
t);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 34549aefa2fc..d100b6f559e2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -920,7 +920,8 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
      * controller object is initialized afterwards. Hopefully, it's
      * only used at runtime.
      */
-    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), &lo=
cal_err);
+    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(&chip9->xive),
+                           &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
--=20
2.21.0


