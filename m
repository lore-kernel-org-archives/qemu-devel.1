Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D55DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EA620EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyxvaDMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EA620EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpPH-0001FF-Uz
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8Q-0002qN-54
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8N-0007bf-OP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id j2so18905834wrx.7
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YCu0n1JEsrF/B9nL33kDrLLwfyYN/wEe5ndCSsAOrNM=;
 b=wyxvaDMA5wymGk9hDv7bJN9et+I9JOngVr07+ZA53iXbi9ugw5/ss31CWJ/pBI+ZCz
 SNlemDUpJB02Za2UtJtxlKX3wB8E+p0mhcCnDtyBSk0VG/e2QMoTIeLPAv0V0O7EHPUS
 xALBBSldRbD5o2s6/qxPPn/Ug0KxQVGERsD2Q6Bj4XHA4nORDkkG8WiKxCf9b9aCmTCg
 iTzpFli4NE8v+P1ttnGeLyLC36UbKA9iQZNAEm+yM8GIEjY/9d6R9w10Evl7eA59u9rZ
 jfHAPILGYxtnl4H5YjGPrtEzy+U6A8t1SNUYuEcWM+XMDNZ4awpnUiDCGzWZ+ce/kibt
 Susw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YCu0n1JEsrF/B9nL33kDrLLwfyYN/wEe5ndCSsAOrNM=;
 b=VvT76VAofslfL9M0repTziK8pO3RtMm5yBWz3G2jgvBK0yFho5/5zQzVNRTjFkAmY9
 h9DITjXS8OlwcpCEJl+G8sWp70fL++NVH7M1KIH3AbwjdqlYuphDRM+Uun4RCuxiK5IC
 Gm0eoeG+DwOnHJo4hFCHZt53MKrOv/zMYb2KWmzLWgNBkHOcSThzG9zjTEkUzdPEakJ8
 bbnn8Dz/7n/Jzc6h5TG5LXL6sFYXZ2OF/HjOscY5AFBpGp38VIwRn/elGATEQZLMrgiA
 /HMQog5o1wEpW9x+HwJEFPKr16aI6DiBb9E8SwSn3HSy6N6XRf0PxmiRebPkqaizQrBQ
 3OJA==
X-Gm-Message-State: AOAM532RCwrEfg+7nZCvgrcGRNeQRc0SFsVQ1K9SpKB3wKztqXwPkzZe
 syH3fpZMcql6QDQ6NQaOvo3NA87PTh2Qdrvu
X-Google-Smtp-Source: ABdhPJweW8X6u4pdsKLM7uVeSmnZhAqC3vKVcWqzB/MIGmk1Q9wiExSnMITlS1gpJ7KjNtXwI/Gm/Q==
X-Received: by 2002:adf:a3d4:: with SMTP id m20mr11550788wrb.29.1600092426020; 
 Mon, 14 Sep 2020 07:07:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/36] hw/misc: Add NPCM7xx Clock Controller device model
Date: Mon, 14 Sep 2020 15:06:25 +0100
Message-Id: <20200914140641.21369-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Enough functionality to boot the Linux kernel has been implemented. This
includes:

  - Correct power-on reset values so the various clock rates can be
    accurately calculated.
  - Clock enables stick around when written.

In addition, a best effort attempt to implement SECCNT and CNTR25M was
made even though I don't think the kernel needs them.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200911052101.2602693-3-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/npcm7xx_clk.h |  48 ++++++
 hw/misc/npcm7xx_clk.c         | 266 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 hw/misc/trace-events          |   4 +
 4 files changed, 319 insertions(+)
 create mode 100644 include/hw/misc/npcm7xx_clk.h
 create mode 100644 hw/misc/npcm7xx_clk.c

diff --git a/include/hw/misc/npcm7xx_clk.h b/include/hw/misc/npcm7xx_clk.h
new file mode 100644
index 00000000000..cdcc9e85342
--- /dev/null
+++ b/include/hw/misc/npcm7xx_clk.h
@@ -0,0 +1,48 @@
+/*
+ * Nuvoton NPCM7xx Clock Control Registers.
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
+#ifndef NPCM7XX_CLK_H
+#define NPCM7XX_CLK_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+/*
+ * The reference clock frequency for the timer modules, and the SECCNT and
+ * CNTR25M registers in this module, is always 25 MHz.
+ */
+#define NPCM7XX_TIMER_REF_HZ            (25000000)
+
+/*
+ * Number of registers in our device state structure. Don't change this without
+ * incrementing the version_id in the vmstate.
+ */
+#define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
+
+typedef struct NPCM7xxCLKState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    uint32_t regs[NPCM7XX_CLK_NR_REGS];
+
+    /* Time reference for SECCNT and CNTR25M, initialized by power on reset */
+    int64_t ref_ns;
+} NPCM7xxCLKState;
+
+#define TYPE_NPCM7XX_CLK "npcm7xx-clk"
+#define NPCM7XX_CLK(obj) OBJECT_CHECK(NPCM7xxCLKState, (obj), TYPE_NPCM7XX_CLK)
+
+#endif /* NPCM7XX_CLK_H */
diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
new file mode 100644
index 00000000000..21ab4200d1c
--- /dev/null
+++ b/hw/misc/npcm7xx_clk.c
@@ -0,0 +1,266 @@
+/*
+ * Nuvoton NPCM7xx Clock Control Registers.
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
+#include "hw/misc/npcm7xx_clk.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/units.h"
+#include "trace.h"
+
+#define PLLCON_LOKI     BIT(31)
+#define PLLCON_LOKS     BIT(30)
+#define PLLCON_PWDEN    BIT(12)
+
+enum NPCM7xxCLKRegisters {
+    NPCM7XX_CLK_CLKEN1,
+    NPCM7XX_CLK_CLKSEL,
+    NPCM7XX_CLK_CLKDIV1,
+    NPCM7XX_CLK_PLLCON0,
+    NPCM7XX_CLK_PLLCON1,
+    NPCM7XX_CLK_SWRSTR,
+    NPCM7XX_CLK_IPSRST1         = 0x20 / sizeof(uint32_t),
+    NPCM7XX_CLK_IPSRST2,
+    NPCM7XX_CLK_CLKEN2,
+    NPCM7XX_CLK_CLKDIV2,
+    NPCM7XX_CLK_CLKEN3,
+    NPCM7XX_CLK_IPSRST3,
+    NPCM7XX_CLK_WD0RCR,
+    NPCM7XX_CLK_WD1RCR,
+    NPCM7XX_CLK_WD2RCR,
+    NPCM7XX_CLK_SWRSTC1,
+    NPCM7XX_CLK_SWRSTC2,
+    NPCM7XX_CLK_SWRSTC3,
+    NPCM7XX_CLK_SWRSTC4,
+    NPCM7XX_CLK_PLLCON2,
+    NPCM7XX_CLK_CLKDIV3,
+    NPCM7XX_CLK_CORSTC,
+    NPCM7XX_CLK_PLLCONG,
+    NPCM7XX_CLK_AHBCKFI,
+    NPCM7XX_CLK_SECCNT,
+    NPCM7XX_CLK_CNTR25M,
+    NPCM7XX_CLK_REGS_END,
+};
+
+/*
+ * These reset values were taken from version 0.91 of the NPCM750R data sheet.
+ *
+ * All are loaded on power-up reset. CLKENx and SWRSTR should also be loaded on
+ * core domain reset, but this reset type is not yet supported by QEMU.
+ */
+static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] = {
+    [NPCM7XX_CLK_CLKEN1]        = 0xffffffff,
+    [NPCM7XX_CLK_CLKSEL]        = 0x004aaaaa,
+    [NPCM7XX_CLK_CLKDIV1]       = 0x5413f855,
+    [NPCM7XX_CLK_PLLCON0]       = 0x00222101 | PLLCON_LOKI,
+    [NPCM7XX_CLK_PLLCON1]       = 0x00202101 | PLLCON_LOKI,
+    [NPCM7XX_CLK_IPSRST1]       = 0x00001000,
+    [NPCM7XX_CLK_IPSRST2]       = 0x80000000,
+    [NPCM7XX_CLK_CLKEN2]        = 0xffffffff,
+    [NPCM7XX_CLK_CLKDIV2]       = 0xaa4f8f9f,
+    [NPCM7XX_CLK_CLKEN3]        = 0xffffffff,
+    [NPCM7XX_CLK_IPSRST3]       = 0x03000000,
+    [NPCM7XX_CLK_WD0RCR]        = 0xffffffff,
+    [NPCM7XX_CLK_WD1RCR]        = 0xffffffff,
+    [NPCM7XX_CLK_WD2RCR]        = 0xffffffff,
+    [NPCM7XX_CLK_SWRSTC1]       = 0x00000003,
+    [NPCM7XX_CLK_PLLCON2]       = 0x00c02105 | PLLCON_LOKI,
+    [NPCM7XX_CLK_CORSTC]        = 0x04000003,
+    [NPCM7XX_CLK_PLLCONG]       = 0x01228606 | PLLCON_LOKI,
+    [NPCM7XX_CLK_AHBCKFI]       = 0x000000c8,
+};
+
+static uint64_t npcm7xx_clk_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t reg = offset / sizeof(uint32_t);
+    NPCM7xxCLKState *s = opaque;
+    int64_t now_ns;
+    uint32_t value = 0;
+
+    if (reg >= NPCM7XX_CLK_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    switch (reg) {
+    case NPCM7XX_CLK_SWRSTR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: register @ 0x%04" HWADDR_PRIx " is write-only\n",
+                      __func__, offset);
+        break;
+
+    case NPCM7XX_CLK_SECCNT:
+        now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        value = (now_ns - s->ref_ns) / NANOSECONDS_PER_SECOND;
+        break;
+
+    case NPCM7XX_CLK_CNTR25M:
+        now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        /*
+         * This register counts 25 MHz cycles, updating every 640 ns. It rolls
+         * over to zero every second.
+         *
+         * The 4 LSBs are always zero: (1e9 / 640) << 4 = 25000000.
+         */
+        value = (((now_ns - s->ref_ns) / 640) << 4) % NPCM7XX_TIMER_REF_HZ;
+        break;
+
+    default:
+        value = s->regs[reg];
+        break;
+    };
+
+    trace_npcm7xx_clk_read(offset, value);
+
+    return value;
+}
+
+static void npcm7xx_clk_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    uint32_t reg = offset / sizeof(uint32_t);
+    NPCM7xxCLKState *s = opaque;
+    uint32_t value = v;
+
+    trace_npcm7xx_clk_write(offset, value);
+
+    if (reg >= NPCM7XX_CLK_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
+                      __func__, offset);
+        return;
+    }
+
+    switch (reg) {
+    case NPCM7XX_CLK_SWRSTR:
+        qemu_log_mask(LOG_UNIMP, "%s: SW reset not implemented: 0x%02x\n",
+                      __func__, value);
+        value = 0;
+        break;
+
+    case NPCM7XX_CLK_PLLCON0:
+    case NPCM7XX_CLK_PLLCON1:
+    case NPCM7XX_CLK_PLLCON2:
+    case NPCM7XX_CLK_PLLCONG:
+        if (value & PLLCON_PWDEN) {
+            /* Power down -- clear lock and indicate loss of lock */
+            value &= ~PLLCON_LOKI;
+            value |= PLLCON_LOKS;
+        } else {
+            /* Normal mode -- assume always locked */
+            value |= PLLCON_LOKI;
+            /* Keep LOKS unchanged unless cleared by writing 1 */
+            if (value & PLLCON_LOKS) {
+                value &= ~PLLCON_LOKS;
+            } else {
+                value |= (value & PLLCON_LOKS);
+            }
+        }
+        break;
+
+    case NPCM7XX_CLK_CNTR25M:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
+                      __func__, offset);
+        return;
+    }
+
+    s->regs[reg] = value;
+}
+
+static const struct MemoryRegionOps npcm7xx_clk_ops = {
+    .read       = npcm7xx_clk_read,
+    .write      = npcm7xx_clk_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid      = {
+        .min_access_size        = 4,
+        .max_access_size        = 4,
+        .unaligned              = false,
+    },
+};
+
+static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
+
+    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
+
+    switch (type) {
+    case RESET_TYPE_COLD:
+        memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
+        s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        return;
+    }
+
+    /*
+     * A small number of registers need to be reset on a core domain reset,
+     * but no such reset type exists yet.
+     */
+    qemu_log_mask(LOG_UNIMP, "%s: reset type %d not implemented.",
+                  __func__, type);
+}
+
+static void npcm7xx_clk_init(Object *obj)
+{
+    NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
+
+    memory_region_init_io(&s->iomem, obj, &npcm7xx_clk_ops, s,
+                          TYPE_NPCM7XX_CLK, 4 * KiB);
+    sysbus_init_mmio(&s->parent, &s->iomem);
+}
+
+static const VMStateDescription vmstate_npcm7xx_clk = {
+    .name = "npcm7xx-clk",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, NPCM7xxCLKState, NPCM7XX_CLK_NR_REGS),
+        VMSTATE_INT64(ref_ns, NPCM7xxCLKState),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM7XX_CLK_NR_REGS);
+
+    dc->desc = "NPCM7xx Clock Control Registers";
+    dc->vmsd = &vmstate_npcm7xx_clk;
+    rc->phases.enter = npcm7xx_clk_enter_reset;
+}
+
+static const TypeInfo npcm7xx_clk_info = {
+    .name               = TYPE_NPCM7XX_CLK,
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .instance_size      = sizeof(NPCM7xxCLKState),
+    .instance_init      = npcm7xx_clk_init,
+    .class_init         = npcm7xx_clk_class_init,
+};
+
+static void npcm7xx_clk_register_type(void)
+{
+    type_register_static(&npcm7xx_clk_info);
+}
+type_init(npcm7xx_clk_register_type);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e5cda41e1c5..793d45b1dc4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -57,6 +57,7 @@ softmmu_ss.add(when: 'CONFIG_IMX', if_true: files(
 softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-hpdmc.c', 'milkymist-pfpu.c'))
 softmmu_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mst_fpga.c'))
 softmmu_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
+  'npcm7xx_clk.c',
   'npcm7xx_gcr.c',
 ))
 softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files(
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 57b18cf63ef..6054f9adf35 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -110,6 +110,10 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
 
+# npcm7xx_clk.c
+npcm7xx_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+
 # npcm7xx_gcr.c
 npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
-- 
2.20.1


