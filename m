Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3984C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A61207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A61207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUIZ-0007Ev-Bv
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioToh-0000Nw-M8
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioTog-0000ct-F8
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:15 -0500
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:51634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioTog-0000bL-9L
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:14 -0500
Received: from player731.ha.ovh.net (unknown [10.109.143.109])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6090412B2AF
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:57:12 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 8B77EDB3A549;
 Mon,  6 Jan 2020 14:57:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 03/12] pnv/xive: Use device_class_set_parent_realize()
Date: Mon,  6 Jan 2020 15:56:36 +0100
Message-Id: <20200106145645.4539-4-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106145645.4539-1-clg@kaod.org>
References: <20200106145645.4539-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5388556956550532070
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.46.122
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/pnv_xive.h | 10 ++++++++++
 hw/intc/pnv_xive.c        | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index f4c7caad40ee..76cf16f64472 100644
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
@@ -85,6 +89,12 @@ typedef struct PnvXive {
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
index a0a69b98a713..6412cf222eae 100644
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
=20
     /*
@@ -1947,10 +1954,12 @@ static void pnv_xive_class_init(ObjectClass *klas=
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
@@ -1971,6 +1980,7 @@ static const TypeInfo pnv_xive_info =3D {
     .instance_init =3D pnv_xive_init,
     .instance_size =3D sizeof(PnvXive),
     .class_init    =3D pnv_xive_class_init,
+    .class_size    =3D sizeof(PnvXiveClass),
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
--=20
2.21.1


