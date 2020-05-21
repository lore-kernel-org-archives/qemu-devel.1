Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDC3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C4320748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCnO9G9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C4320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbs0Q-0001eg-Mn
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32dTGXgsKCpoBMECHH8GI8HAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlY-0005ez-G9
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:04 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:40002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32dTGXgsKCpoBMECHH8GI8HAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlX-0001jW-1T
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:04 -0400
Received: by mail-yb1-xb49.google.com with SMTP id 137so6522265ybf.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Lq64b6uhYKAyEh1amBKVd/kb2V0lb2HNz0oL+oVCOyE=;
 b=XCnO9G9ZMWBJ2R6k1VYRhRklpObx/FjqWEi3C7V9UwAcmjYkLCD4HKZWfGu/oW4FHS
 Nf72nnp+AaLpKQEy/J9Tc5I7jVWUaKLx5/hqctTgtD1NjIAHxE31ccswdYa/uHVASRMc
 YtTYdrkKWXcioVtCk7nwvEGFrLRQKzZRJSEL2GkvvEABO0axO0od3CQq0frRLLHs7H00
 vwSoEtP2UhG9ONprAzq4H+lIWPgYROyRuJfw7nNcY1X/u3AkG2OrlCZC1zgssqqMuma7
 3vunMSujTAKrBmdG/rPqcqDcCxBLzovV56cXEp8qSWam6SiWsp6eeEaaRYFNSo6HBuhy
 yQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Lq64b6uhYKAyEh1amBKVd/kb2V0lb2HNz0oL+oVCOyE=;
 b=Sa5xYDGiIesxFiPrbjtkKz+/yTKk4IFf/PksOtCCD7dIsLHSO3FBECnLcZLNnW5YNm
 CGLlq13z1ZiSmCg4Yf+WGfy4tgPmjrQkaCvLdIVqXE4vefExdjbfm/4Zu22qtKSE4auL
 4z7HcpnR13zh+xqTscCuu4lsB1HykMlvq9n0oXMQh55xD282fBTCcyaOSu9fqnRanZvi
 3/lmx6b4FGINGcekGRV7990wlvLjztuMRuaZkce9/MXdRKZ7JwhCpBCkxN5oB4cYPe6w
 8JVGQjbTEzDGB/gsIX2iFAkbk1qmcX/0d8BL2bqKMlB6v0Wydqn1Q5/aumIVmZTGj2hF
 8xLA==
X-Gm-Message-State: AOAM531YZPb0fCZLSQAGN+TqxOfqxQho1IlUDTf591AG3BXcyzeVA7+5
 SOWYZj4IFsAE+pZT99uonHSw45y/dgb9yFSWeQ==
X-Google-Smtp-Source: ABdhPJxqh9lwdPE0gK20fFHH92yPbnwzPdqqwGb8qu4ze+DZ8tPGjvvqDNyKvxcpX+QHI9NcqhyJqqbX9ZcjvPt2PQ==
X-Received: by 2002:a25:13c5:: with SMTP id 188mr17635925ybt.353.1590088921407; 
 Thu, 21 May 2020 12:22:01 -0700 (PDT)
Date: Thu, 21 May 2020 12:21:29 -0700
In-Reply-To: <20200521192133.127559-1-hskinnemoen@google.com>
Message-Id: <20200521192133.127559-3-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 2/6] hw/misc: Add NPCM7xx System Global Control Registers
 device model
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=32dTGXgsKCpoBMECHH8GI8HAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2020 16:37:42 -0400
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

Implement a device model for the System Global Control Registers in the
NPCM730 and NPCM750 BMC SoCs.

This is primarily used to enable SMP boot (the boot ROM spins reading
the SCRPAD register); other registers are best effort for now.

The reset values of the MDLR and PWRON registers are determined by the
SoC variant (730 vs 750) and board straps respectively.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 MAINTAINERS                   |   8 ++
 hw/misc/Makefile.objs         |   1 +
 hw/misc/npcm7xx_gcr.c         | 160 ++++++++++++++++++++++++++++++++++
 hw/misc/trace-events          |   4 +
 include/hw/misc/npcm7xx_gcr.h |  74 ++++++++++++++++
 5 files changed, 247 insertions(+)
 create mode 100644 hw/misc/npcm7xx_gcr.c
 create mode 100644 include/hw/misc/npcm7xx_gcr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 87a412c229..5b150184ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -715,6 +715,14 @@ S: Odd Fixes
 F: hw/arm/musicpal.c
 F: docs/system/arm/musicpal.rst
 
+Nuvoton NPCM7xx
+M: Havard Skinnemoen <hskinnemoen@google.com>
+M: Tyrone Ting <kfting@nuvoton.com>
+L: qemu-arm@nongnu.org
+S: Supported
+F: hw/misc/npcm7xx*
+F: include/hw/misc/npcm7xx*
+
 nSeries
 M: Andrzej Zaborowski <balrogg@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 68aae2eabb..4d83fa337b 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -51,6 +51,7 @@ common-obj-$(CONFIG_IMX) += imx_rngc.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
 common-obj-$(CONFIG_MAINSTONE) += mst_fpga.o
+common-obj-$(CONFIG_NPCM7XX) += npcm7xx_gcr.o
 common-obj-$(CONFIG_OMAP) += omap_clk.o
 common-obj-$(CONFIG_OMAP) += omap_gpmc.o
 common-obj-$(CONFIG_OMAP) += omap_l4.o
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
new file mode 100644
index 0000000000..cd8690a968
--- /dev/null
+++ b/hw/misc/npcm7xx_gcr.c
@@ -0,0 +1,160 @@
+/*
+ * Nuvoton NPCM7xx System Global Control Registers.
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#include "trace.h"
+
+static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
+    [NPCM7XX_GCR_PDID]          = 0x04A92750,   /* Poleg A1 */
+    [NPCM7XX_GCR_MISCPE]        = 0x0000FFFF,
+    [NPCM7XX_GCR_SPSWC]         = 0x00000003,
+    [NPCM7XX_GCR_INTCR]         = 0x0000035E,
+    [NPCM7XX_GCR_HIFCR]         = 0x0000004E,
+    [NPCM7XX_GCR_RESSR]         = 0x80000000,
+    [NPCM7XX_GCR_DSCNT]         = 0x000000c0,
+    [NPCM7XX_GCR_DAVCLVLR]      = 0x5A00F3CF,
+    [NPCM7XX_GCR_INTCR3]        = 0x00001002,
+    [NPCM7XX_GCR_SCRPAD]        = 0x00000008,
+    [NPCM7XX_GCR_USB1PHYCTL]    = 0x034730E4,
+    [NPCM7XX_GCR_USB2PHYCTL]    = 0x034730E4,
+};
+
+static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t reg = offset / sizeof(uint32_t);
+    NPCM7xxGCRState *s = opaque;
+
+    if (reg >= NPCM7XX_GCR_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
+                      __func__, (unsigned int)offset);
+        return 0;
+    }
+
+    trace_npcm7xx_gcr_read(offset, s->regs[reg]);
+
+    return s->regs[reg];
+}
+
+static void npcm7xx_gcr_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    uint32_t reg = offset / sizeof(uint32_t);
+    NPCM7xxGCRState *s = opaque;
+    uint32_t value = v;
+
+    trace_npcm7xx_gcr_write(offset, value);
+
+    if (reg >= NPCM7XX_GCR_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
+                      __func__, (unsigned int)offset);
+        return;
+    }
+
+    switch (reg) {
+    case NPCM7XX_GCR_PDID:
+    case NPCM7XX_GCR_PWRON:
+    case NPCM7XX_GCR_INTSR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is read-only\n",
+                      __func__, (unsigned int)offset);
+        return;
+
+    case NPCM7XX_GCR_RESSR:
+    case NPCM7XX_GCR_CP2BST:
+        /* Write 1 to clear */
+        value = s->regs[reg] & ~value;
+        break;
+
+    case NPCM7XX_GCR_RLOCKR1:
+    case NPCM7XX_GCR_MDLR:
+        /* Write 1 to set */
+        value |= s->regs[reg];
+        break;
+    };
+
+    s->regs[reg] = value;
+}
+
+static const struct MemoryRegionOps npcm7xx_gcr_ops = {
+    .read       = npcm7xx_gcr_read,
+    .write      = npcm7xx_gcr_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid      = {
+        .min_access_size        = 4,
+        .max_access_size        = 4,
+        .unaligned              = false,
+    },
+};
+
+static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxGCRState *s = NPCM7XX_GCR(obj);
+
+    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
+
+    switch (type) {
+    case RESET_TYPE_COLD:
+        memcpy(s->regs, cold_reset_values, sizeof(s->regs));
+        s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
+        s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
+        break;
+    }
+}
+
+static void npcm7xx_gcr_init(Object *obj)
+{
+    NPCM7xxGCRState *s = NPCM7XX_GCR(obj);
+
+    memory_region_init_io(&s->iomem, obj, &npcm7xx_gcr_ops, s,
+                          TYPE_NPCM7XX_GCR, 4 * KiB);
+    sysbus_init_mmio(&s->parent, &s->iomem);
+}
+
+static Property npcm7xx_gcr_properties[] = {
+    DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr, 0),
+    DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "NPCM7xx System Global Control Registers";
+    rc->phases.enter = npcm7xx_gcr_enter_reset;
+
+    device_class_set_props(dc, npcm7xx_gcr_properties);
+}
+
+static const TypeInfo npcm7xx_gcr_info = {
+    .name               = TYPE_NPCM7XX_GCR,
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .instance_size      = sizeof(NPCM7xxGCRState),
+    .instance_init      = npcm7xx_gcr_init,
+    .class_init         = npcm7xx_gcr_class_init,
+};
+
+static void npcm7xx_gcr_register_type(void)
+{
+    type_register_static(&npcm7xx_gcr_info);
+}
+type_init(npcm7xx_gcr_register_type);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index a5862b2bed..d200438dbf 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -103,6 +103,10 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
 
+# npcm7xx_gcr.c
+npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+
 # stm32f4xx_syscfg
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm7xx_gcr.h
new file mode 100644
index 0000000000..e74a0e6305
--- /dev/null
+++ b/include/hw/misc/npcm7xx_gcr.h
@@ -0,0 +1,74 @@
+/*
+ * Nuvoton NPCM7xx System Global Control Registers.
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef NPCM7XX_GCR_H
+#define NPCM7XX_GCR_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+enum NPCM7xxGCRRegisters {
+    NPCM7XX_GCR_PDID,
+    NPCM7XX_GCR_PWRON,
+    NPCM7XX_GCR_MFSEL1          = 0x0C / sizeof(uint32_t),
+    NPCM7XX_GCR_MFSEL2,
+    NPCM7XX_GCR_MISCPE,
+    NPCM7XX_GCR_SPSWC           = 0x038 / sizeof(uint32_t),
+    NPCM7XX_GCR_INTCR,
+    NPCM7XX_GCR_INTSR,
+    NPCM7XX_GCR_HIFCR           = 0x050 / sizeof(uint32_t),
+    NPCM7XX_GCR_INTCR2          = 0x060 / sizeof(uint32_t),
+    NPCM7XX_GCR_MFSEL3,
+    NPCM7XX_GCR_SRCNT,
+    NPCM7XX_GCR_RESSR,
+    NPCM7XX_GCR_RLOCKR1,
+    NPCM7XX_GCR_FLOCKR1,
+    NPCM7XX_GCR_DSCNT,
+    NPCM7XX_GCR_MDLR,
+    NPCM7XX_GCR_SCRPAD3,
+    NPCM7XX_GCR_SCRPAD2,
+    NPCM7XX_GCR_DAVCLVLR        = 0x098 / sizeof(uint32_t),
+    NPCM7XX_GCR_INTCR3,
+    NPCM7XX_GCR_VSINTR          = 0x0AC / sizeof(uint32_t),
+    NPCM7XX_GCR_MFSEL4,
+    NPCM7XX_GCR_CPBPNTR         = 0x0C4 / sizeof(uint32_t),
+    NPCM7XX_GCR_CPCTL           = 0x0D0 / sizeof(uint32_t),
+    NPCM7XX_GCR_CP2BST,
+    NPCM7XX_GCR_B2CPNT,
+    NPCM7XX_GCR_CPPCTL,
+    NPCM7XX_GCR_I2CSEGSEL,
+    NPCM7XX_GCR_I2CSEGCTL,
+    NPCM7XX_GCR_VSRCR,
+    NPCM7XX_GCR_MLOCKR,
+    NPCM7XX_GCR_SCRPAD          = 0x013C / sizeof(uint32_t),
+    NPCM7XX_GCR_USB1PHYCTL,
+    NPCM7XX_GCR_USB2PHYCTL,
+    NPCM7XX_GCR_NR_REGS,
+};
+
+typedef struct NPCM7xxGCRState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    uint32_t regs[NPCM7XX_GCR_NR_REGS];
+
+    uint32_t reset_pwron;
+    uint32_t reset_mdlr;
+} NPCM7xxGCRState;
+
+#define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
+#define NPCM7XX_GCR(obj) OBJECT_CHECK(NPCM7xxGCRState, (obj), TYPE_NPCM7XX_GCR)
+
+#endif /* NPCM7XX_GCR_H */
-- 
2.27.0.rc0.183.gde8f92d652-goog


