Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418DDC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB002067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7QVT5ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB002067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3ZN-0004dN-SV
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2ql-0005Gy-3U
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qj-00089o-MP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qj-000896-Ft
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id y21so17310951wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VnKuGKYmXvKiYUaWE62O1+t40crCAoje8TmSropWhmQ=;
 b=v7QVT5ty9nW9jpo/2jCxHBW/C9BfyzNjwHCXG5tQsfv4NS7HQ+VcgN27RQDWdVvfTK
 mOl3D467/2ac6DFGyC06Zva0eh2rLgB0/RZvnAxOszsbZIg8xJNJQLIYf04JQtt6Bh1/
 NRanOTqAMtueQWY3qogVm8nzgcFryM+rFTCLp548Y7p69PD5sTz5SXf0IXY4R370xH0y
 juOSOW196sXcFKytKDONl4ctgvS+wVMI1brFkpQYsPdH5hReBEA5vYVhTsBB/uoOJqSK
 2pFrdlsbPq17yo6Icc2AYtfrCUYUOs3i79ixZozDZpPP6s0GzbJ5actzaLxy1F49/r1T
 Oglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VnKuGKYmXvKiYUaWE62O1+t40crCAoje8TmSropWhmQ=;
 b=iVk57iTHelsPZu+uleNRzorlCYiOmQnLGCEk/Y+ciHq93vX6n5HBAXKN1hwIps4The
 lPi5ar4dHBkJEWdRvgsqa+pQyoWxpHiqM22Pc/IzKShn1sl9Qe4Kuy22ql4XDJtMxqlg
 68ZcArNMo+q6Tcg3zF6T7YchUartWu74C1O8m3mo41OwzILV0K76hjosfAOO4Alp/mKQ
 enHGSJzYhCp4ioXMyaRBubWTWvchX9nsJNvVogrf3ZiNqcBFMm7zS7fCLkNlbteb1QVo
 j57cDDw3am0JrMaaYWkN4Mrpoii+apFlfpaJKc9kH9vPg2hQVt+peDcghF685QpUI7df
 qUvQ==
X-Gm-Message-State: APjAAAWjmb6Oi1uwFpTdxDVDUEkCclUi1qB/R3Vwm7n+/2skbbYnNh0b
 K5d/40MLT1TNxX8kPl2Mk9mmPq1oxpMFIg==
X-Google-Smtp-Source: APXvYqzMhZzmaKSQ/jLnXIYnlGJEZJ8QkOHCRmcvcFb6oImvIuAscVW/8QU/r5nfSKVRQLn41pfAvg==
X-Received: by 2002:a1c:e10a:: with SMTP id y10mr15664194wmg.29.1571069132058; 
 Mon, 14 Oct 2019 09:05:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/68] aspeed/i2c: Add AST2600 support
Date: Mon, 14 Oct 2019 17:03:51 +0100
Message-Id: <20191014160404.19553-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

The I2C controller of the AST2400 and AST2500 SoCs have one IRQ shared
by all I2C busses. The AST2600 SoC I2C controller has one IRQ per bus
and 16 busses.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-17-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/aspeed_i2c.h |  5 +++-
 hw/i2c/aspeed_i2c.c         | 46 +++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 6e2dae7db81..13e01059189 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -27,10 +27,11 @@
 #define TYPE_ASPEED_I2C "aspeed.i2c"
 #define TYPE_ASPEED_2400_I2C TYPE_ASPEED_I2C "-ast2400"
 #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"
+#define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"
 #define ASPEED_I2C(obj) \
     OBJECT_CHECK(AspeedI2CState, (obj), TYPE_ASPEED_I2C)
 
-#define ASPEED_I2C_NR_BUSSES 14
+#define ASPEED_I2C_NR_BUSSES 16
 
 struct AspeedI2CState;
 
@@ -41,6 +42,7 @@ typedef struct AspeedI2CBus {
 
     I2CBus *bus;
     uint8_t id;
+    qemu_irq irq;
 
     uint32_t ctrl;
     uint32_t timing[2];
@@ -72,6 +74,7 @@ typedef struct AspeedI2CClass {
     uint8_t num_busses;
     uint8_t reg_size;
     uint8_t gap;
+    qemu_irq (*bus_get_irq)(AspeedI2CBus *);
 } AspeedI2CClass;
 
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index fabdb01e974..06c119f385b 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -145,10 +145,12 @@ static inline bool aspeed_i2c_bus_is_enabled(AspeedI2CBus *bus)
 
 static inline void aspeed_i2c_bus_raise_interrupt(AspeedI2CBus *bus)
 {
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+
     bus->intr_status &= bus->intr_ctrl;
     if (bus->intr_status) {
         bus->controller->intr_status |= 1 << bus->id;
-        qemu_irq_raise(bus->controller->irq);
+        qemu_irq_raise(aic->bus_get_irq(bus));
     }
 }
 
@@ -273,6 +275,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
                                  uint64_t value, unsigned size)
 {
     AspeedI2CBus *bus = opaque;
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     bool handle_rx;
 
     switch (offset) {
@@ -299,7 +302,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
         bus->intr_status &= ~(value & 0x7FFF);
         if (!bus->intr_status) {
             bus->controller->intr_status &= ~(1 << bus->id);
-            qemu_irq_lower(bus->controller->irq);
+            qemu_irq_lower(aic->bus_get_irq(bus));
         }
         if (handle_rx && (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST))) {
             aspeed_i2c_handle_rx_cmd(bus);
@@ -457,6 +460,8 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < aic->num_busses; i++) {
         char name[32];
         int offset = i < aic->gap ? 1 : 5;
+
+        sysbus_init_irq(sbd, &s->busses[i].irq);
         snprintf(name, sizeof(name), "aspeed.i2c.%d", i);
         s->busses[i].controller = s;
         s->busses[i].id = i;
@@ -488,6 +493,11 @@ static const TypeInfo aspeed_i2c_info = {
     .abstract   = true,
 };
 
+static qemu_irq aspeed_2400_i2c_bus_get_irq(AspeedI2CBus *bus)
+{
+    return bus->controller->irq;
+}
+
 static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -498,6 +508,7 @@ static void aspeed_2400_i2c_class_init(ObjectClass *klass, void *data)
     aic->num_busses = 14;
     aic->reg_size = 0x40;
     aic->gap = 7;
+    aic->bus_get_irq = aspeed_2400_i2c_bus_get_irq;
 }
 
 static const TypeInfo aspeed_2400_i2c_info = {
@@ -506,6 +517,11 @@ static const TypeInfo aspeed_2400_i2c_info = {
     .class_init = aspeed_2400_i2c_class_init,
 };
 
+static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2CBus *bus)
+{
+    return bus->controller->irq;
+}
+
 static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -516,6 +532,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
     aic->num_busses = 14;
     aic->reg_size = 0x40;
     aic->gap = 7;
+    aic->bus_get_irq = aspeed_2500_i2c_bus_get_irq;
 }
 
 static const TypeInfo aspeed_2500_i2c_info = {
@@ -524,11 +541,36 @@ static const TypeInfo aspeed_2500_i2c_info = {
     .class_init = aspeed_2500_i2c_class_init,
 };
 
+static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
+{
+    return bus->irq;
+}
+
+static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
+
+    dc->desc = "ASPEED 2600 I2C Controller";
+
+    aic->num_busses = 16;
+    aic->reg_size = 0x80;
+    aic->gap = -1; /* no gap */
+    aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
+}
+
+static const TypeInfo aspeed_2600_i2c_info = {
+    .name = TYPE_ASPEED_2600_I2C,
+    .parent = TYPE_ASPEED_I2C,
+    .class_init = aspeed_2600_i2c_class_init,
+};
+
 static void aspeed_i2c_register_types(void)
 {
     type_register_static(&aspeed_i2c_info);
     type_register_static(&aspeed_2400_i2c_info);
     type_register_static(&aspeed_2500_i2c_info);
+    type_register_static(&aspeed_2600_i2c_info);
 }
 
 type_init(aspeed_i2c_register_types)
-- 
2.20.1


