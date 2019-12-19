Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC7C2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022F5222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022F5222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0ST-00051P-Sj
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ii0I0-0000bN-FQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ii0Hz-0004HZ-5a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:44 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:54552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ii0Hy-0004CE-Rl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:43 -0500
Received: from player734.ha.ovh.net (unknown [10.108.54.97])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 60CCE129E37
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 19:12:41 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id E93AFD6D6398;
 Thu, 19 Dec 2019 18:12:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 06/13] pnv/xive: Use device_class_set_parent_realize()
Date: Thu, 19 Dec 2019 19:11:48 +0100
Message-Id: <20191219181155.32530-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219181155.32530-1-clg@kaod.org>
References: <20191219181155.32530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 13661950946887699430
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.219
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

From: Greg Kurz <groug@kaod.org>

The XIVE router base class currently inherits an empty realize hook
from the sysbus device base class, but it will soon implement one
of its own to perform some sanity checks. Do the preliminary plumbing
to have it called.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_xive.h | 10 ++++++++++
 hw/intc/pnv_xive.c        | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 4d641db691c8..ba9bbeab88c3 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -16,6 +16,10 @@ struct PnvChip;
=20
 #define TYPE_PNV_XIVE "pnv-xive"
 #define PNV_XIVE(obj) OBJECT_CHECK(PnvXive, (obj), TYPE_PNV_XIVE)
+#define PNV_XIVE_CLASS(klass)                                   \
+    OBJECT_CLASS_CHECK(PnvXiveClass, (klass), TYPE_PNV_XIVE)
+#define PNV_XIVE_GET_CLASS(obj)                                 \
+    OBJECT_GET_CLASS(PnvXiveClass, (obj), TYPE_PNV_XIVE)
=20
 #define XIVE_BLOCK_MAX      16
=20
@@ -87,6 +91,12 @@ typedef struct PnvXive {
     uint64_t      edt[XIVE_TABLE_EDT_MAX];
 } PnvXive;
=20
+typedef struct PnvXiveClass {
+    XiveRouterClass parent_class;
+
+    DeviceRealize parent_realize;
+} PnvXiveClass;
+
 void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
=20
 #endif /* PPC_PNV_XIVE_H */
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 66970a60733b..1962f884d6de 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1816,10 +1816,17 @@ static void pnv_xive_init(Object *obj)
 static void pnv_xive_realize(DeviceState *dev, Error **errp)
 {
     PnvXive *xive =3D PNV_XIVE(dev);
+    PnvXiveClass *pxc =3D PNV_XIVE_GET_CLASS(dev);
     XiveSource *xsrc =3D &xive->ipi_source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
     Error *local_err =3D NULL;
=20
+    pxc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     assert(xive->chip);
     assert(xive->system_memory);
=20
@@ -1950,10 +1957,12 @@ static void pnv_xive_class_init(ObjectClass *klas=
s, void *data)
     XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
     XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
     XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
+    PnvXiveClass *pxc =3D PNV_XIVE_CLASS(klass);
=20
     xdc->dt_xscom =3D pnv_xive_dt_xscom;
=20
     dc->desc =3D "PowerNV XIVE Interrupt Controller";
+    device_class_set_parent_realize(dc, pnv_xive_realize, &pxc->parent_r=
ealize);
     dc->realize =3D pnv_xive_realize;
     dc->props =3D pnv_xive_properties;
=20
@@ -1974,6 +1983,7 @@ static const TypeInfo pnv_xive_info =3D {
     .instance_init =3D pnv_xive_init,
     .instance_size =3D sizeof(PnvXive),
     .class_init    =3D pnv_xive_class_init,
+    .class_size    =3D sizeof(PnvXiveClass),
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
--=20
2.21.0


