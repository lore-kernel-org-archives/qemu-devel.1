Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBAFC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7CE21848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7CE21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iApeD-0004pX-PW
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iApMC-0002J2-NJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iApMB-00008E-AA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:51:56 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:38916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iApMB-00007b-4v
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:51:55 -0400
Received: from player788.ha.ovh.net (unknown [10.109.143.210])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1080C18F90F
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:51:54 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 81E609F175EA;
 Thu, 19 Sep 2019 05:51:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 07:49:56 +0200
Message-Id: <20190919055002.6729-16-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919055002.6729-1-clg@kaod.org>
References: <20190919055002.6729-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1691664610166803217
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.60.232
Subject: [Qemu-devel] [PATCH 15/21] aspeed/i2c: Add AST2600 support
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

The I2C controller of the AST2400 and AST2500 SoCs have one IRQ shared
by all I2C busses. The AST2600 SoC I2C controller has one IRQ per bus
and 16 busses.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/i2c/aspeed_i2c.h |  5 +++-
 hw/i2c/aspeed_i2c.c         | 46 +++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 6e2dae7db818..13e01059189f 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -27,10 +27,11 @@
 #define TYPE_ASPEED_I2C "aspeed.i2c"
 #define TYPE_ASPEED_2400_I2C TYPE_ASPEED_I2C "-ast2400"
 #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"
+#define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"
 #define ASPEED_I2C(obj) \
     OBJECT_CHECK(AspeedI2CState, (obj), TYPE_ASPEED_I2C)
=20
-#define ASPEED_I2C_NR_BUSSES 14
+#define ASPEED_I2C_NR_BUSSES 16
=20
 struct AspeedI2CState;
=20
@@ -41,6 +42,7 @@ typedef struct AspeedI2CBus {
=20
     I2CBus *bus;
     uint8_t id;
+    qemu_irq irq;
=20
     uint32_t ctrl;
     uint32_t timing[2];
@@ -72,6 +74,7 @@ typedef struct AspeedI2CClass {
     uint8_t num_busses;
     uint8_t reg_size;
     uint8_t gap;
+    qemu_irq (*bus_get_irq)(AspeedI2CBus *);
 } AspeedI2CClass;
=20
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index fabdb01e9747..06c119f385b8 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -145,10 +145,12 @@ static inline bool aspeed_i2c_bus_is_enabled(Aspeed=
I2CBus *bus)
=20
 static inline void aspeed_i2c_bus_raise_interrupt(AspeedI2CBus *bus)
 {
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
+
     bus->intr_status &=3D bus->intr_ctrl;
     if (bus->intr_status) {
         bus->controller->intr_status |=3D 1 << bus->id;
-        qemu_irq_raise(bus->controller->irq);
+        qemu_irq_raise(aic->bus_get_irq(bus));
     }
 }
=20
@@ -273,6 +275,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr=
 offset,
                                  uint64_t value, unsigned size)
 {
     AspeedI2CBus *bus =3D opaque;
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
     bool handle_rx;
=20
     switch (offset) {
@@ -299,7 +302,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr=
 offset,
         bus->intr_status &=3D ~(value & 0x7FFF);
         if (!bus->intr_status) {
             bus->controller->intr_status &=3D ~(1 << bus->id);
-            qemu_irq_lower(bus->controller->irq);
+            qemu_irq_lower(aic->bus_get_irq(bus));
         }
         if (handle_rx && (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LA=
ST))) {
             aspeed_i2c_handle_rx_cmd(bus);
@@ -457,6 +460,8 @@ static void aspeed_i2c_realize(DeviceState *dev, Erro=
r **errp)
     for (i =3D 0; i < aic->num_busses; i++) {
         char name[32];
         int offset =3D i < aic->gap ? 1 : 5;
+
+        sysbus_init_irq(sbd, &s->busses[i].irq);
         snprintf(name, sizeof(name), "aspeed.i2c.%d", i);
         s->busses[i].controller =3D s;
         s->busses[i].id =3D i;
@@ -488,6 +493,11 @@ static const TypeInfo aspeed_i2c_info =3D {
     .abstract   =3D true,
 };
=20
+static qemu_irq aspeed_2400_i2c_bus_get_irq(AspeedI2CBus *bus)
+{
+    return bus->controller->irq;
+}
+
 static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -498,6 +508,7 @@ static void aspeed_2400_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->num_busses =3D 14;
     aic->reg_size =3D 0x40;
     aic->gap =3D 7;
+    aic->bus_get_irq =3D aspeed_2400_i2c_bus_get_irq;
 }
=20
 static const TypeInfo aspeed_2400_i2c_info =3D {
@@ -506,6 +517,11 @@ static const TypeInfo aspeed_2400_i2c_info =3D {
     .class_init =3D aspeed_2400_i2c_class_init,
 };
=20
+static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2CBus *bus)
+{
+    return bus->controller->irq;
+}
+
 static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -516,6 +532,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->num_busses =3D 14;
     aic->reg_size =3D 0x40;
     aic->gap =3D 7;
+    aic->bus_get_irq =3D aspeed_2500_i2c_bus_get_irq;
 }
=20
 static const TypeInfo aspeed_2500_i2c_info =3D {
@@ -524,11 +541,36 @@ static const TypeInfo aspeed_2500_i2c_info =3D {
     .class_init =3D aspeed_2500_i2c_class_init,
 };
=20
+static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
+{
+    return bus->irq;
+}
+
+static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedI2CClass *aic =3D ASPEED_I2C_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2600 I2C Controller";
+
+    aic->num_busses =3D 16;
+    aic->reg_size =3D 0x80;
+    aic->gap =3D -1; /* no gap */
+    aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;
+}
+
+static const TypeInfo aspeed_2600_i2c_info =3D {
+    .name =3D TYPE_ASPEED_2600_I2C,
+    .parent =3D TYPE_ASPEED_I2C,
+    .class_init =3D aspeed_2600_i2c_class_init,
+};
+
 static void aspeed_i2c_register_types(void)
 {
     type_register_static(&aspeed_i2c_info);
     type_register_static(&aspeed_2400_i2c_info);
     type_register_static(&aspeed_2500_i2c_info);
+    type_register_static(&aspeed_2600_i2c_info);
 }
=20
 type_init(aspeed_i2c_register_types)
--=20
2.21.0


