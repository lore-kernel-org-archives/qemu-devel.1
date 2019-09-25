Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4B5C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4DB21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4DB21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8pX-0001qF-3A
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD8NW-0004XA-Vl
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD8NU-0001OH-J4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:34:50 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:43982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD8NU-0001Nt-DA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:34:48 -0400
Received: from player786.ha.ovh.net (unknown [10.108.35.59])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 3FCF018DEC8
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:34:47 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id B22A5A4D40F2;
 Wed, 25 Sep 2019 14:34:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 15/23] aspeed/i2c: Introduce an object class per SoC
Date: Wed, 25 Sep 2019 16:32:40 +0200
Message-Id: <20190925143248.10000-16-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925143248.10000-1-clg@kaod.org>
References: <20190925143248.10000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8865054393088576273
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.45.168
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It prepares ground for register differences between SoCs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/i2c/aspeed_i2c.h | 15 ++++++++++
 hw/arm/aspeed_soc.c         |  3 +-
 hw/i2c/aspeed_i2c.c         | 60 ++++++++++++++++++++++++++++++++-----
 3 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index a2753f0bbbaa..6e2dae7db818 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -25,6 +25,8 @@
 #include "hw/sysbus.h"
=20
 #define TYPE_ASPEED_I2C "aspeed.i2c"
+#define TYPE_ASPEED_2400_I2C TYPE_ASPEED_I2C "-ast2400"
+#define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"
 #define ASPEED_I2C(obj) \
     OBJECT_CHECK(AspeedI2CState, (obj), TYPE_ASPEED_I2C)
=20
@@ -59,6 +61,19 @@ typedef struct AspeedI2CState {
     AspeedI2CBus busses[ASPEED_I2C_NR_BUSSES];
 } AspeedI2CState;
=20
+#define ASPEED_I2C_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedI2CClass, (klass), TYPE_ASPEED_I2C)
+#define ASPEED_I2C_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedI2CClass, (obj), TYPE_ASPEED_I2C)
+
+typedef struct AspeedI2CClass {
+    SysBusDeviceClass parent_class;
+
+    uint8_t num_busses;
+    uint8_t reg_size;
+    uint8_t gap;
+} AspeedI2CClass;
+
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
=20
 #endif /* ASPEED_I2C_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5c5fcb810944..e60f198d92c1 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -188,8 +188,9 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
                                    OBJECT(&s->scu), &error_abort);
=20
+    snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
     sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
-                          TYPE_ASPEED_I2C);
+                          typename);
=20
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
     sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a956eb384922..fabdb01e9747 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -408,10 +408,11 @@ static void aspeed_i2c_reset(DeviceState *dev)
 {
     int i;
     AspeedI2CState *s =3D ASPEED_I2C(dev);
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(s);
=20
     s->intr_status =3D 0;
=20
-    for (i =3D 0; i < ASPEED_I2C_NR_BUSSES; i++) {
+    for (i =3D 0; i < aic->num_busses; i++) {
         s->busses[i].intr_ctrl =3D 0;
         s->busses[i].intr_status =3D 0;
         s->busses[i].cmd =3D 0;
@@ -421,7 +422,7 @@ static void aspeed_i2c_reset(DeviceState *dev)
 }
=20
 /*
- * Address Definitions
+ * Address Definitions (AST2400 and AST2500)
  *
  *   0x000 ... 0x03F: Global Register
  *   0x040 ... 0x07F: Device 1
@@ -446,22 +447,24 @@ static void aspeed_i2c_realize(DeviceState *dev, Er=
ror **errp)
     int i;
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     AspeedI2CState *s =3D ASPEED_I2C(dev);
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(s);
=20
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_i2c_ctrl_ops, s,
                           "aspeed.i2c", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
=20
-    for (i =3D 0; i < ASPEED_I2C_NR_BUSSES; i++) {
-        char name[16];
-        int offset =3D i < 7 ? 1 : 5;
+    for (i =3D 0; i < aic->num_busses; i++) {
+        char name[32];
+        int offset =3D i < aic->gap ? 1 : 5;
         snprintf(name, sizeof(name), "aspeed.i2c.%d", i);
         s->busses[i].controller =3D s;
         s->busses[i].id =3D i;
         s->busses[i].bus =3D i2c_init_bus(dev, name);
         memory_region_init_io(&s->busses[i].mr, OBJECT(dev),
-                              &aspeed_i2c_bus_ops, &s->busses[i], name, =
0x40);
-        memory_region_add_subregion(&s->iomem, 0x40 * (i + offset),
+                              &aspeed_i2c_bus_ops, &s->busses[i], name,
+                              aic->reg_size);
+        memory_region_add_subregion(&s->iomem, aic->reg_size * (i + offs=
et),
                                     &s->busses[i].mr);
     }
 }
@@ -481,11 +484,51 @@ static const TypeInfo aspeed_i2c_info =3D {
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(AspeedI2CState),
     .class_init    =3D aspeed_i2c_class_init,
+    .class_size =3D sizeof(AspeedI2CClass),
+    .abstract   =3D true,
+};
+
+static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedI2CClass *aic =3D ASPEED_I2C_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2400 I2C Controller";
+
+    aic->num_busses =3D 14;
+    aic->reg_size =3D 0x40;
+    aic->gap =3D 7;
+}
+
+static const TypeInfo aspeed_2400_i2c_info =3D {
+    .name =3D TYPE_ASPEED_2400_I2C,
+    .parent =3D TYPE_ASPEED_I2C,
+    .class_init =3D aspeed_2400_i2c_class_init,
+};
+
+static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedI2CClass *aic =3D ASPEED_I2C_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2500 I2C Controller";
+
+    aic->num_busses =3D 14;
+    aic->reg_size =3D 0x40;
+    aic->gap =3D 7;
+}
+
+static const TypeInfo aspeed_2500_i2c_info =3D {
+    .name =3D TYPE_ASPEED_2500_I2C,
+    .parent =3D TYPE_ASPEED_I2C,
+    .class_init =3D aspeed_2500_i2c_class_init,
 };
=20
 static void aspeed_i2c_register_types(void)
 {
     type_register_static(&aspeed_i2c_info);
+    type_register_static(&aspeed_2400_i2c_info);
+    type_register_static(&aspeed_2500_i2c_info);
 }
=20
 type_init(aspeed_i2c_register_types)
@@ -494,9 +537,10 @@ type_init(aspeed_i2c_register_types)
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr)
 {
     AspeedI2CState *s =3D ASPEED_I2C(dev);
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(s);
     I2CBus *bus =3D NULL;
=20
-    if (busnr >=3D 0 && busnr < ASPEED_I2C_NR_BUSSES) {
+    if (busnr >=3D 0 && busnr < aic->num_busses) {
         bus =3D s->busses[busnr].bus;
     }
=20
--=20
2.21.0


