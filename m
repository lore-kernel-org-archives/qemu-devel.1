Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0AFC2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901CE2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEMALVo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901CE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpJp-0002DI-MR
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8X-0003BF-Ox
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8V-0007cp-Et
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id k18so176998wmj.5
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7qdIVpv+Fj2dOjiIb2MIanH8g8e50FxyjJB1Ytaz/Is=;
 b=DEMALVo/jN1Rgoi/msJCVwbo3aNGIcQRHB2ogFO8g6vqtSJ/i1J9RudWGpT+Gptmhv
 mRe7TPtzkXp+JFuWGDLj/Pf222QZh6ybg8q3DHCsNqsV31ddNFwHoCugIVIz+girnH+Z
 Xy0ME0+FWnWcN8MQk58si2/yxUwaZTYefgCR7CZvDx8dR1OXPGWgOFu372Fpnj5dwYbQ
 Aw+hms1la1SrnHaLfGbu7fO28PWkh1lXHxQRBRhBpHw825vjwTl6bP8UbGH4tHM6zJoW
 +0WvS2kr16nBXWR2ppSSn+UpL6g13EE0lLMbkWMgbGG8KMPbKaG5GPNX580mNpub/lDY
 28zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7qdIVpv+Fj2dOjiIb2MIanH8g8e50FxyjJB1Ytaz/Is=;
 b=gFLEZVQvbAT7o4HCXM/p60p4ozGl2Xjmr+RWdaYi5tjy0vt5a9PtKD5C081dSnnWnB
 GPw2VEGLMupOGIsrw3GQ15txqoPwfp6Qrs7K6j8W++TOmBAQ3pcgqiCqrclZaqP/D0zX
 XGGawPhVplKaA3S24i05ZnOe9K/5folNoxh895LRHsEYjujoe8TAddc60oM/AKwl5/B0
 DlpELxUJd/FcGLXp+CeJ2Ocl1+ODnbWGiwE+waDNvLDcR8ru7tuvSjwE5fpnt/h9X8BH
 pV3BrglKOQIeGUFOO9JPVJEbTAv2Ncy1/7190aUXjOkrlr3ItNJbH8pY77uQgjlkURbf
 arPg==
X-Gm-Message-State: AOAM531MehtYfDsLZGTG/3NMMvg0wHoiu9phE/ctKAfmFM9UxTb2si8a
 akyNhsFIoe/gPqaexNLgkNKyVvEk7J+vOdNl
X-Google-Smtp-Source: ABdhPJxcauaXFlWkFqpgO7TGq5qbBoEaVLu6T8JKKmmz2olBbKJ5GohABOOnYckF3Tj6/2LTpcmvUA==
X-Received: by 2002:a05:600c:21c4:: with SMTP id
 x4mr15659299wmj.107.1600092433779; 
 Mon, 14 Sep 2020 07:07:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/36] hw/mem: Stubbed out NPCM7xx Memory Controller model
Date: Mon, 14 Sep 2020 15:06:32 +0100
Message-Id: <20200914140641.21369-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Havard Skinnemoen <hskinnemoen@google.com>

This just implements the bare minimum to cause the boot block to skip
memory initialization.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200911052101.2602693-10-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm7xx.h    |  2 +
 include/hw/mem/npcm7xx_mc.h | 36 ++++++++++++++++
 hw/arm/npcm7xx.c            |  6 +++
 hw/mem/npcm7xx_mc.c         | 84 +++++++++++++++++++++++++++++++++++++
 hw/mem/meson.build          |  1 +
 5 files changed, 129 insertions(+)
 create mode 100644 include/hw/mem/npcm7xx_mc.h
 create mode 100644 hw/mem/npcm7xx_mc.c

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 5816a07a72e..9fa84a0702f 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -18,6 +18,7 @@
 
 #include "hw/boards.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
 #include "hw/nvram/npcm7xx_otp.h"
@@ -71,6 +72,7 @@ typedef struct NPCM7xxState {
     NPCM7xxTimerCtrlState tim[3];
     NPCM7xxOTPState     key_storage;
     NPCM7xxOTPState     fuse_array;
+    NPCM7xxMCState      mc;
 } NPCM7xxState;
 
 #define TYPE_NPCM7XX    "npcm7xx"
diff --git a/include/hw/mem/npcm7xx_mc.h b/include/hw/mem/npcm7xx_mc.h
new file mode 100644
index 00000000000..7ed38be2431
--- /dev/null
+++ b/include/hw/mem/npcm7xx_mc.h
@@ -0,0 +1,36 @@
+/*
+ * Nuvoton NPCM7xx Memory Controller stub
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+#ifndef NPCM7XX_MC_H
+#define NPCM7XX_MC_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+/**
+ * struct NPCM7xxMCState - Device state for the memory controller.
+ * @parent: System bus device.
+ * @mmio: Memory region through which registers are accessed.
+ */
+typedef struct NPCM7xxMCState {
+    SysBusDevice parent;
+
+    MemoryRegion mmio;
+} NPCM7xxMCState;
+
+#define TYPE_NPCM7XX_MC "npcm7xx-mc"
+#define NPCM7XX_MC(obj) OBJECT_CHECK(NPCM7xxMCState, (obj), TYPE_NPCM7XX_MC)
+
+#endif /* NPCM7XX_MC_H */
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 91660025984..6bb1693833e 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -43,6 +43,7 @@
 #define NPCM7XX_CPUP_BA         (0xf03fe000)
 #define NPCM7XX_GCR_BA          (0xf0800000)
 #define NPCM7XX_CLK_BA          (0xf0801000)
+#define NPCM7XX_MC_BA           (0xf0824000)
 
 /* Internal AHB SRAM */
 #define NPCM7XX_RAM3_BA         (0xc0008000)
@@ -186,6 +187,7 @@ static void npcm7xx_init(Object *obj)
                             TYPE_NPCM7XX_KEY_STORAGE);
     object_initialize_child(obj, "otp2", &s->fuse_array,
                             TYPE_NPCM7XX_FUSE_ARRAY);
+    object_initialize_child(obj, "mc", &s->mc, TYPE_NPCM7XX_MC);
 
     for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
         object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
@@ -261,6 +263,10 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fuse_array), 0, NPCM7XX_OTP2_BA);
     npcm7xx_init_fuses(s);
 
+    /* Fake Memory Controller (MC). Cannot fail. */
+    sysbus_realize(SYS_BUS_DEVICE(&s->mc), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mc), 0, NPCM7XX_MC_BA);
+
     /* Timer Modules (TIM). Cannot fail. */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) != ARRAY_SIZE(s->tim));
     for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
diff --git a/hw/mem/npcm7xx_mc.c b/hw/mem/npcm7xx_mc.c
new file mode 100644
index 00000000000..0435d06ab44
--- /dev/null
+++ b/hw/mem/npcm7xx_mc.c
@@ -0,0 +1,84 @@
+/*
+ * Nuvoton NPCM7xx Memory Controller stub
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/mem/npcm7xx_mc.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#define NPCM7XX_MC_REGS_SIZE (4 * KiB)
+
+static uint64_t npcm7xx_mc_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    /*
+     * If bits 8..11 @ offset 0 are not zero, the boot block thinks the memory
+     * controller has already been initialized and will skip DDR training.
+     */
+    if (addr == 0) {
+        return 0x100;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: mostly unimplemented\n", __func__);
+
+    return 0;
+}
+
+static void npcm7xx_mc_write(void *opaque, hwaddr addr, uint64_t v,
+                             unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: mostly unimplemented\n", __func__);
+}
+
+static const MemoryRegionOps npcm7xx_mc_ops = {
+    .read = npcm7xx_mc_read,
+    .write = npcm7xx_mc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm7xx_mc_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxMCState *s = NPCM7XX_MC(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &npcm7xx_mc_ops, s, "regs",
+                          NPCM7XX_MC_REGS_SIZE);
+    sysbus_init_mmio(&s->parent, &s->mmio);
+}
+
+static void npcm7xx_mc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM7xx Memory Controller stub";
+    dc->realize = npcm7xx_mc_realize;
+}
+
+static const TypeInfo npcm7xx_mc_types[] = {
+    {
+        .name = TYPE_NPCM7XX_MC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCM7xxMCState),
+        .class_init = npcm7xx_mc_class_init,
+    },
+};
+DEFINE_TYPES(npcm7xx_mc_types);
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index ba424622bbb..0d22f2b5727 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -1,6 +1,7 @@
 mem_ss = ss.source_set()
 mem_ss.add(files('memory-device.c'))
 mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
+mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
 
 softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
-- 
2.20.1


