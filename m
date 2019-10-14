Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E686ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFE320663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IawZ/1jH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFE320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3SO-0004T8-GA
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2ql-0005Id-WB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qj-00089a-Do
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:35 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qj-00088Z-6h
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p14so20382536wro.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vP5GcYuUE/pjFlJ1lHMM9Tj7/XDRmZl7iSdxbfoBULU=;
 b=IawZ/1jHhf+PIor81+rbQZyJRuxezJJesef1df1fpTP7BLt/iaIYC+BXJy3ya2enzj
 Qy8JrHQy5HnhcQJYos0ltNW76TT1xV7tdhMjw6UuYg3JooYfiL736fsH35xl3uyROUdc
 afT4bWOMqrhRh9ubNgHvZg/BC/SjbLpXTmmGUZcW2MWOxYFw0a1pkJW76J0rPqT4heoN
 lucnDFIIPDN0nuPK7KflJWEzyhvfzBVvvGAki7nbVjFQ/Ss+SxMApXJ8AiOS31A5+ncS
 WTxBe80yuOn7E1W1Ljm4N7ug8z/QOVF+4TM1s95l+TbEzS+asr2Q3r7rAMTxo1uAEazy
 y2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vP5GcYuUE/pjFlJ1lHMM9Tj7/XDRmZl7iSdxbfoBULU=;
 b=dtLg+cQpJ13lMJpSoVxXwQIilZfGtbA2Lu0K6ZO+EJN/2P/RQO8U8Das1wVVmfCcB+
 XV+al9yCHjUIU5jpB2G0puioFL4UxclzhiaCYPCnvCzVsmlEbQ8dPzvy5h4MWi2p157n
 RfUek0KATbzYdOgN0dzIERF/Dq2JsvnnCMxD3qHe8KMupAtx3WIzebX+7ut8WDr9hFZ7
 A1veYeus1SQ0MDuWplT8uMn8AfuoNiM4g2E1xQ5sXOWsFx7RrxnuujaMtcW7Tsw7RSpf
 eIVNvSupmDV4Lm5eF1/OxA5uaUDFBXG0N4ggAqe7Z5Q5YE8onW1yhymheKpTDRYdkORW
 wpPg==
X-Gm-Message-State: APjAAAVNZRGuwjkuUp37g/teibkMRilW9V1pI2aqhL+KXaAomUTOsUvm
 CptPQGLSK64lMfPc2xMtpJDkNqsgoyyxPA==
X-Google-Smtp-Source: APXvYqx2qtoS0H9K5lmCVcCnLYweqQpflsTuary7rKQ7g1S6+Br6/uEMC3hDbpKKy6nMt1MotLDCrg==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr12606072wrj.283.1571069130845; 
 Mon, 14 Oct 2019 09:05:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/68] aspeed/i2c: Introduce an object class per SoC
Date: Mon, 14 Oct 2019 17:03:50 +0100
Message-Id: <20191014160404.19553-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

It prepares ground for register differences between SoCs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-16-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/aspeed_i2c.h | 15 ++++++++++
 hw/arm/aspeed_soc.c         |  3 +-
 hw/i2c/aspeed_i2c.c         | 60 ++++++++++++++++++++++++++++++++-----
 3 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index a2753f0bbba..6e2dae7db81 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -25,6 +25,8 @@
 #include "hw/sysbus.h"
 
 #define TYPE_ASPEED_I2C "aspeed.i2c"
+#define TYPE_ASPEED_2400_I2C TYPE_ASPEED_I2C "-ast2400"
+#define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"
 #define ASPEED_I2C(obj) \
     OBJECT_CHECK(AspeedI2CState, (obj), TYPE_ASPEED_I2C)
 
@@ -59,6 +61,19 @@ typedef struct AspeedI2CState {
     AspeedI2CBus busses[ASPEED_I2C_NR_BUSSES];
 } AspeedI2CState;
 
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
 
 #endif /* ASPEED_I2C_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5c5fcb81094..e60f198d92c 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -188,8 +188,9 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
                                    OBJECT(&s->scu), &error_abort);
 
+    snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
     sysbus_init_child_obj(obj, "i2c", OBJECT(&s->i2c), sizeof(s->i2c),
-                          TYPE_ASPEED_I2C);
+                          typename);
 
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
     sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a956eb38492..fabdb01e974 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -408,10 +408,11 @@ static void aspeed_i2c_reset(DeviceState *dev)
 {
     int i;
     AspeedI2CState *s = ASPEED_I2C(dev);
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
 
     s->intr_status = 0;
 
-    for (i = 0; i < ASPEED_I2C_NR_BUSSES; i++) {
+    for (i = 0; i < aic->num_busses; i++) {
         s->busses[i].intr_ctrl = 0;
         s->busses[i].intr_status = 0;
         s->busses[i].cmd = 0;
@@ -421,7 +422,7 @@ static void aspeed_i2c_reset(DeviceState *dev)
 }
 
 /*
- * Address Definitions
+ * Address Definitions (AST2400 and AST2500)
  *
  *   0x000 ... 0x03F: Global Register
  *   0x040 ... 0x07F: Device 1
@@ -446,22 +447,24 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     int i;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedI2CState *s = ASPEED_I2C(dev);
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_i2c_ctrl_ops, s,
                           "aspeed.i2c", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
 
-    for (i = 0; i < ASPEED_I2C_NR_BUSSES; i++) {
-        char name[16];
-        int offset = i < 7 ? 1 : 5;
+    for (i = 0; i < aic->num_busses; i++) {
+        char name[32];
+        int offset = i < aic->gap ? 1 : 5;
         snprintf(name, sizeof(name), "aspeed.i2c.%d", i);
         s->busses[i].controller = s;
         s->busses[i].id = i;
         s->busses[i].bus = i2c_init_bus(dev, name);
         memory_region_init_io(&s->busses[i].mr, OBJECT(dev),
-                              &aspeed_i2c_bus_ops, &s->busses[i], name, 0x40);
-        memory_region_add_subregion(&s->iomem, 0x40 * (i + offset),
+                              &aspeed_i2c_bus_ops, &s->busses[i], name,
+                              aic->reg_size);
+        memory_region_add_subregion(&s->iomem, aic->reg_size * (i + offset),
                                     &s->busses[i].mr);
     }
 }
@@ -481,11 +484,51 @@ static const TypeInfo aspeed_i2c_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AspeedI2CState),
     .class_init    = aspeed_i2c_class_init,
+    .class_size = sizeof(AspeedI2CClass),
+    .abstract   = true,
+};
+
+static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
+
+    dc->desc = "ASPEED 2400 I2C Controller";
+
+    aic->num_busses = 14;
+    aic->reg_size = 0x40;
+    aic->gap = 7;
+}
+
+static const TypeInfo aspeed_2400_i2c_info = {
+    .name = TYPE_ASPEED_2400_I2C,
+    .parent = TYPE_ASPEED_I2C,
+    .class_init = aspeed_2400_i2c_class_init,
+};
+
+static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
+
+    dc->desc = "ASPEED 2500 I2C Controller";
+
+    aic->num_busses = 14;
+    aic->reg_size = 0x40;
+    aic->gap = 7;
+}
+
+static const TypeInfo aspeed_2500_i2c_info = {
+    .name = TYPE_ASPEED_2500_I2C,
+    .parent = TYPE_ASPEED_I2C,
+    .class_init = aspeed_2500_i2c_class_init,
 };
 
 static void aspeed_i2c_register_types(void)
 {
     type_register_static(&aspeed_i2c_info);
+    type_register_static(&aspeed_2400_i2c_info);
+    type_register_static(&aspeed_2500_i2c_info);
 }
 
 type_init(aspeed_i2c_register_types)
@@ -494,9 +537,10 @@ type_init(aspeed_i2c_register_types)
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr)
 {
     AspeedI2CState *s = ASPEED_I2C(dev);
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
     I2CBus *bus = NULL;
 
-    if (busnr >= 0 && busnr < ASPEED_I2C_NR_BUSSES) {
+    if (busnr >= 0 && busnr < aic->num_busses) {
         bus = s->busses[busnr].bus;
     }
 
-- 
2.20.1


