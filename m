Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0F7C43141
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B5F21850
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B5F21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWjlU-0005Jf-Lx
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 11:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWjii-0001EZ-Hz
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWjih-00069f-09
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:17:44 -0500
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:34591)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWjig-000698-QP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:17:42 -0500
Received: from player796.ha.ovh.net (unknown [10.109.146.240])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 0C92480FDB
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 17:17:40 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id 701CBC1CB3EA;
 Mon, 18 Nov 2019 16:17:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH for-5.0 2/2] aspeed: change the "nic" property definition
Date: Mon, 18 Nov 2019 17:17:12 +0100
Message-Id: <20191118161712.6712-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191118161712.6712-1-clg@kaod.org>
References: <20191118161712.6712-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 14133421532880866065
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegiedgieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.49.171
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Aspeed MII model has a link pointing to its associated FTGMAC100
NIC in the machine.

Change the "nic" property definition so that it explicitly sets the
pointer. The property isn't optional : not being able to set the link
is a bug and QEMU should rather abort than exit in this case.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed_ast2600.c |  5 ++---
 hw/net/ftgmac100.c      | 19 +++++++++----------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 810fd7de0c06..be88005dab8f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -183,9 +183,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
=20
         sysbus_init_child_obj(obj, "mii[*]", &s->mii[i], sizeof(s->mii[i=
]),
                               TYPE_ASPEED_MII);
-        object_property_add_const_link(OBJECT(&s->mii[i]), "nic",
-                                       OBJECT(&s->ftgmac100[i]),
-                                       &error_abort);
     }
=20
     sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma)=
,
@@ -441,6 +438,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
=20
+        object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac10=
0[i]),
+                                 "nic", &error_abort);
         object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
                                  &err);
         if (err) {
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index eb8b441461a1..86ac25894a89 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1204,17 +1204,8 @@ static void aspeed_mii_realize(DeviceState *dev, E=
rror **errp)
 {
     AspeedMiiState *s =3D ASPEED_MII(dev);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
-    Object *obj;
-    Error *local_err =3D NULL;
=20
-    obj =3D object_property_get_link(OBJECT(dev), "nic", &local_err);
-    if (!obj) {
-        error_propagate(errp, local_err);
-        error_prepend(errp, "required link 'nic' not found: ");
-        return;
-    }
-
-    s->nic =3D FTGMAC100(obj);
+    assert(s->nic);
=20
     memory_region_init_io(&s->iomem, OBJECT(dev), &aspeed_mii_ops, s,
                           TYPE_ASPEED_MII, 0x8);
@@ -1231,6 +1222,13 @@ static const VMStateDescription vmstate_aspeed_mii=
 =3D {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static Property aspeed_mii_properties[] =3D {
+    DEFINE_PROP_LINK("nic", AspeedMiiState, nic, TYPE_FTGMAC100,
+                     FTGMAC100State *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void aspeed_mii_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -1239,6 +1237,7 @@ static void aspeed_mii_class_init(ObjectClass *klas=
s, void *data)
     dc->reset =3D aspeed_mii_reset;
     dc->realize =3D aspeed_mii_realize;
     dc->desc =3D "Aspeed MII controller";
+    dc->props =3D aspeed_mii_properties;
 }
=20
 static const TypeInfo aspeed_mii_info =3D {
--=20
2.21.0


