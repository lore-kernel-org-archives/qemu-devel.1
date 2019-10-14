Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF14FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B232067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/aSnlmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B232067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3aH-00063g-Cv
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qe-00055s-6X
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qc-00085f-Fg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qc-000857-8K
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id r19so17863723wmh.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BA0Hr4fMEwRvskAIrNFkdzykZF5LEWAtuXwTcCbqLfo=;
 b=g/aSnlmnaont5N0WjMGmBGVkQdCmEVr/GEjuF2ib9qwpnZnT2NSo1cRVeoZ1Oq0eFY
 XXem418o8W5vEH2BNt6qrpOw3MvOTz6yydir7YZkG9rKfzfwJf8b0DRuBp6lOhU4DqmM
 BKuNrBhGuEvT18qwYLdY9QxSnaZl8qoF1V1PYu5yxhhmQuGNlSYFhjl4f3KecvJlS5gt
 dWWDtbMoKOt6LCDcjaXkI1P5m92igrgPhS5dLIKOW3hSvnyLXP72K9BpW/nSVNLqm1EO
 Bs+3IT29mu/5p12WUEhqlAGxqVLt4/F2/Rrf6CJf26IC3LkI6eww+N16N5cpjUm5ki6a
 6W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BA0Hr4fMEwRvskAIrNFkdzykZF5LEWAtuXwTcCbqLfo=;
 b=p6vkSpCecW3pu73maJSpeWJ3TgBLXEMn13/FTsviUINLMsYBLaEc4tdlM8Ve8XEKIZ
 wgE4P95AQY/leYwvbD8YHsyYsY68V32WVcSoXsO6T9UvGCor4gyWGn/YlHH+dcMqqn2y
 1vA9qBtMy2yg2rfzvePlZ+z/c/b20IGvZk/J14XKpA8e4kEPOUVMhWY2wIdE1iqbAxH6
 pqhlyzcPJHJEEjw7/h1mGO18Ndv6I2HlwRCCYaInKrikXBlNaYOeiqVqpIuLYkgeBd+4
 9i9If+wvGgc3D7EmJUnP9aPsWbRdSzk4JbBraPizgX8h3Jal9eN3L/yBK4Ys8OPOqcWg
 jYSA==
X-Gm-Message-State: APjAAAXxKyjUEBX8lk1FwQGKfgFnnHeZAqlgsdzZfZbjE5CzbmLLI2vV
 VJEW/+B0DjLkAMP75a5qa1mpQBAixJYbHA==
X-Google-Smtp-Source: APXvYqzJu+VGLZPd7ifopp1aEyb0g5LHD6KrEqyjfGpJl5kwc6SSrr54wa4HSZOGZRwKtWYA7r0FNA==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr7973934wmj.119.1571069124902; 
 Mon, 14 Oct 2019 09:05:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/68] watchdog/aspeed: Introduce an object class per SoC
Date: Mon, 14 Oct 2019 17:03:45 +0100
Message-Id: <20191014160404.19553-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

It cleanups the current models for the Aspeed AST2400 and AST2500 SoCs
and prepares ground for future SoCs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-11-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/watchdog/wdt_aspeed.h |  18 ++++-
 hw/arm/aspeed_soc.c              |   9 ++-
 hw/watchdog/wdt_aspeed.c         | 122 ++++++++++++++++---------------
 3 files changed, 86 insertions(+), 63 deletions(-)

diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index 8c5691ce204..796342764e2 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -16,6 +16,8 @@
 #define TYPE_ASPEED_WDT "aspeed.wdt"
 #define ASPEED_WDT(obj) \
     OBJECT_CHECK(AspeedWDTState, (obj), TYPE_ASPEED_WDT)
+#define TYPE_ASPEED_2400_WDT TYPE_ASPEED_WDT "-ast2400"
+#define TYPE_ASPEED_2500_WDT TYPE_ASPEED_WDT "-ast2500"
 
 #define ASPEED_WDT_REGS_MAX        (0x20 / 4)
 
@@ -30,8 +32,20 @@ typedef struct AspeedWDTState {
 
     AspeedSCUState *scu;
     uint32_t pclk_freq;
-    uint32_t silicon_rev;
-    uint32_t ext_pulse_width_mask;
 } AspeedWDTState;
 
+#define ASPEED_WDT_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedWDTClass, (klass), TYPE_ASPEED_WDT)
+#define ASPEED_WDT_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedWDTClass, (obj), TYPE_ASPEED_WDT)
+
+typedef struct AspeedWDTClass {
+    SysBusDeviceClass parent_class;
+
+    uint32_t offset;
+    uint32_t ext_pulse_width_mask;
+    uint32_t reset_ctrl_reg;
+    void (*reset_pulse)(AspeedWDTState *s, uint32_t property);
+}  AspeedWDTClass;
+
 #endif /* WDT_ASPEED_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index aaf18d3e42f..5c5fcb81094 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -214,10 +214,9 @@ static void aspeed_soc_init(Object *obj)
                               "max-ram-size", &error_abort);
 
     for (i = 0; i < sc->info->wdts_num; i++) {
+        snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
         sysbus_init_child_obj(obj, "wdt[*]", OBJECT(&s->wdt[i]),
-                              sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
-        qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
-                                    sc->info->silicon_rev);
+                              sizeof(s->wdt[i]), typename);
         object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
                                        OBJECT(&s->scu), &error_abort);
     }
@@ -384,13 +383,15 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* Watch dog */
     for (i = 0; i < sc->info->wdts_num; i++) {
+        AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
+
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                        sc->info->memmap[ASPEED_WDT] + i * 0x20);
+                        sc->info->memmap[ASPEED_WDT] + i * awc->offset);
     }
 
     /* Net */
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index f710036535d..fc0e6c486a7 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -54,21 +54,6 @@ static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
     return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
 }
 
-static bool is_ast2500(const AspeedWDTState *s)
-{
-    switch (s->silicon_rev) {
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        return true;
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-    default:
-        break;
-    }
-
-    return false;
-}
-
 static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned size)
 {
     AspeedWDTState *s = ASPEED_WDT(opaque);
@@ -124,6 +109,7 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size)
 {
     AspeedWDTState *s = ASPEED_WDT(opaque);
+    AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(s);
     bool enable = data & WDT_CTRL_ENABLE;
 
     offset >>= 2;
@@ -153,24 +139,13 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
         }
         break;
     case WDT_RESET_WIDTH:
-    {
-        uint32_t property = data & WDT_POLARITY_MASK;
-
-        if (property && is_ast2500(s)) {
-            if (property == WDT_ACTIVE_HIGH_MAGIC) {
-                s->regs[WDT_RESET_WIDTH] |= WDT_RESET_WIDTH_ACTIVE_HIGH;
-            } else if (property == WDT_ACTIVE_LOW_MAGIC) {
-                s->regs[WDT_RESET_WIDTH] &= ~WDT_RESET_WIDTH_ACTIVE_HIGH;
-            } else if (property == WDT_PUSH_PULL_MAGIC) {
-                s->regs[WDT_RESET_WIDTH] |= WDT_RESET_WIDTH_PUSH_PULL;
-            } else if (property == WDT_OPEN_DRAIN_MAGIC) {
-                s->regs[WDT_RESET_WIDTH] &= ~WDT_RESET_WIDTH_PUSH_PULL;
-            }
+        if (awc->reset_pulse) {
+            awc->reset_pulse(s, data & WDT_POLARITY_MASK);
         }
-        s->regs[WDT_RESET_WIDTH] &= ~s->ext_pulse_width_mask;
-        s->regs[WDT_RESET_WIDTH] |= data & s->ext_pulse_width_mask;
+        s->regs[WDT_RESET_WIDTH] &= ~awc->ext_pulse_width_mask;
+        s->regs[WDT_RESET_WIDTH] |= data & awc->ext_pulse_width_mask;
         break;
-    }
+
     case WDT_TIMEOUT_STATUS:
     case WDT_TIMEOUT_CLEAR:
         qemu_log_mask(LOG_UNIMP,
@@ -226,9 +201,10 @@ static void aspeed_wdt_reset(DeviceState *dev)
 static void aspeed_wdt_timer_expired(void *dev)
 {
     AspeedWDTState *s = ASPEED_WDT(dev);
+    uint32_t reset_ctrl_reg = ASPEED_WDT_GET_CLASS(s)->reset_ctrl_reg;
 
     /* Do not reset on SDRAM controller reset */
-    if (s->scu->regs[SCU_RESET_CONTROL1] & SCU_RESET_SDRAM) {
+    if (s->scu->regs[reset_ctrl_reg] & SCU_RESET_SDRAM) {
         timer_del(s->timer);
         s->regs[WDT_CTRL] = 0;
         return;
@@ -256,25 +232,6 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
     }
     s->scu = ASPEED_SCU(obj);
 
-    if (!is_supported_silicon_rev(s->silicon_rev)) {
-        error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
-                s->silicon_rev);
-        return;
-    }
-
-    switch (s->silicon_rev) {
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-        s->ext_pulse_width_mask = 0xff;
-        break;
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        s->ext_pulse_width_mask = 0xfffff;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, aspeed_wdt_timer_expired, dev);
 
     /* FIXME: This setting should be derived from the SCU hw strapping
@@ -287,20 +244,15 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static Property aspeed_wdt_properties[] = {
-    DEFINE_PROP_UINT32("silicon-rev", AspeedWDTState, silicon_rev, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void aspeed_wdt_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->desc = "ASPEED Watchdog Controller";
     dc->realize = aspeed_wdt_realize;
     dc->reset = aspeed_wdt_reset;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->vmsd = &vmstate_aspeed_wdt;
-    dc->props = aspeed_wdt_properties;
 }
 
 static const TypeInfo aspeed_wdt_info = {
@@ -308,12 +260,68 @@ static const TypeInfo aspeed_wdt_info = {
     .name  = TYPE_ASPEED_WDT,
     .instance_size  = sizeof(AspeedWDTState),
     .class_init = aspeed_wdt_class_init,
+    .class_size    = sizeof(AspeedWDTClass),
+    .abstract      = true,
+};
+
+static void aspeed_2400_wdt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
+
+    dc->desc = "ASPEED 2400 Watchdog Controller";
+    awc->offset = 0x20;
+    awc->ext_pulse_width_mask = 0xff;
+    awc->reset_ctrl_reg = SCU_RESET_CONTROL1;
+}
+
+static const TypeInfo aspeed_2400_wdt_info = {
+    .name = TYPE_ASPEED_2400_WDT,
+    .parent = TYPE_ASPEED_WDT,
+    .instance_size = sizeof(AspeedWDTState),
+    .class_init = aspeed_2400_wdt_class_init,
+};
+
+static void aspeed_2500_wdt_reset_pulse(AspeedWDTState *s, uint32_t property)
+{
+    if (property) {
+        if (property == WDT_ACTIVE_HIGH_MAGIC) {
+            s->regs[WDT_RESET_WIDTH] |= WDT_RESET_WIDTH_ACTIVE_HIGH;
+        } else if (property == WDT_ACTIVE_LOW_MAGIC) {
+            s->regs[WDT_RESET_WIDTH] &= ~WDT_RESET_WIDTH_ACTIVE_HIGH;
+        } else if (property == WDT_PUSH_PULL_MAGIC) {
+            s->regs[WDT_RESET_WIDTH] |= WDT_RESET_WIDTH_PUSH_PULL;
+        } else if (property == WDT_OPEN_DRAIN_MAGIC) {
+            s->regs[WDT_RESET_WIDTH] &= ~WDT_RESET_WIDTH_PUSH_PULL;
+        }
+    }
+}
+
+static void aspeed_2500_wdt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
+
+    dc->desc = "ASPEED 2500 Watchdog Controller";
+    awc->offset = 0x20;
+    awc->ext_pulse_width_mask = 0xfffff;
+    awc->reset_ctrl_reg = SCU_RESET_CONTROL1;
+    awc->reset_pulse = aspeed_2500_wdt_reset_pulse;
+}
+
+static const TypeInfo aspeed_2500_wdt_info = {
+    .name = TYPE_ASPEED_2500_WDT,
+    .parent = TYPE_ASPEED_WDT,
+    .instance_size = sizeof(AspeedWDTState),
+    .class_init = aspeed_2500_wdt_class_init,
 };
 
 static void wdt_aspeed_register_types(void)
 {
     watchdog_add_model(&model);
     type_register_static(&aspeed_wdt_info);
+    type_register_static(&aspeed_2400_wdt_info);
+    type_register_static(&aspeed_2500_wdt_info);
 }
 
 type_init(wdt_aspeed_register_types)
-- 
2.20.1


