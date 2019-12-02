Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689FFC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FAE82071F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrfGIqVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAE82071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibtXG-00033B-A7
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxR-0002b7-C4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxN-0000cO-IP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:12 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ibsxK-0000Yq-Fi; Mon, 02 Dec 2019 16:10:06 -0500
Received: by mail-wm1-x344.google.com with SMTP id g206so842287wme.1;
 Mon, 02 Dec 2019 13:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h+Tla/hLm55CHAFtteEGlDuBFiTlLj9DvIB7CMAPe0U=;
 b=nrfGIqVqRbt7KSSVeD1gS+X4WPnrIyzuiRlPn3nEaqGL417jGLEWJZDYs9/6XbSpLF
 5qB+iykwbGI4Y1wFOrjxWC1ELQWSXBhnYI33igURPxPI7CpybY/jV/L7nFbIJzNF3nlv
 9BqNCEZ4vlhMwgRzwtABSDJ/5IoRGlEO54niMC0t634UvtrcMG7G1K1KC32otlIBveja
 7VoB2smZ7SBVqXBP+uPM4Ay86xvq56uljkKe53yK6QI+NPaPYn33QTqlSO1uI3/ZG3b3
 n7DmYkieRYnhx4Qa9cVA+foV+KYWDh4tGPEVxow6q3BfLQl2VIVpR2WtfALaPnUq8QWO
 sasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=h+Tla/hLm55CHAFtteEGlDuBFiTlLj9DvIB7CMAPe0U=;
 b=JMQ0ubyAIoLl/whuu8u0hMt9H9W/ez544SRhTXw/JGxjBleTQEvYUAIX19BK66gKZ+
 1vegkSQDMpOiZViNoGX3No0iNI7VwpLbfWHCQ0wVo2TlczIgd+ynPAVk484SZ7SJIniF
 1UF8OtlkmAuzEuFXYiD6pLn0Q57Dsdy/jluTRJkIqvcc/emW45kSj3fqNFVuW1w+gfJH
 xEqUe80aP44kROrijwTXI8MOlUnS+gAgPsPqc9SuJ1kcWQaLSj8RUuumeJ7bC4r6f4cE
 w1JQsnZTNpBAZiPCfBR0/jFWNKbNxkW6iXTFsJqwGhCJnFM07d7hdf/88IUiHGZgvMUY
 f8sQ==
X-Gm-Message-State: APjAAAUXJt5r5f4Wf5KrnDLGnK2Oq1DSgjHWTPCC8VcCcLvS4ZgYtECN
 QAZcxQXZ5DBlXvp75mpbv/v08znf
X-Google-Smtp-Source: APXvYqw19bYDiNd1ZTbVxqeeSMuDEmV5T0DCFA0fHOto5GoVwwhCpN0VpgyUmURETx8spDwc4DBYJg==
X-Received: by 2002:a7b:cb87:: with SMTP id m7mr9521215wmi.148.1575320999594; 
 Mon, 02 Dec 2019 13:09:59 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id f1sm770859wrp.93.2019.12.02.13.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 13:09:58 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/10] arm: allwinner-h3: add Clock Control Unit
Date: Mon,  2 Dec 2019 22:09:40 +0100
Message-Id: <20191202210947.3603-4-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
X-Mailman-Approved-At: Mon, 02 Dec 2019 16:38:21 -0500
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Clock Control Unit is responsible for clock signal generation,
configuration and distribution in the Allwinner H3 System on Chip.
This commit adds support for the Clock Control Unit which emulates
a simple read/write register interface.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/allwinner-h3.c              |  11 ++
 hw/misc/Makefile.objs              |   1 +
 hw/misc/allwinner-h3-clk.c         | 227 +++++++++++++++++++++++++++++
 include/hw/arm/allwinner-h3.h      |   2 +
 include/hw/misc/allwinner-h3-clk.h |  41 ++++++
 5 files changed, 282 insertions(+)
 create mode 100644 hw/misc/allwinner-h3-clk.c
 create mode 100644 include/hw/misc/allwinner-h3-clk.h

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 470fdfebef..5566e979ec 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -37,6 +37,9 @@ static void aw_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
                           TYPE_AW_A10_PIT);
+
+    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
+                          TYPE_AW_H3_CLK);
 }
 
 static void aw_h3_realize(DeviceState *dev, Error **errp)
@@ -172,6 +175,14 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_C_BASE,
                                 &s->sram_c);
 
+    /* Clock Control Unit */
+    object_property_set_bool(OBJECT(&s->ccu), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
+
     /* UART */
     if (serial_hd(0)) {
         serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index ba898a5781..200ed44ce1 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) += macio/
 
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-clk.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
diff --git a/hw/misc/allwinner-h3-clk.c b/hw/misc/allwinner-h3-clk.c
new file mode 100644
index 0000000000..77c55b4f92
--- /dev/null
+++ b/hw/misc/allwinner-h3-clk.c
@@ -0,0 +1,227 @@
+/*
+ * Allwinner H3 Clock Control Unit emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/allwinner-h3-clk.h"
+
+/* CCU register offsets */
+#define REG_PLL_CPUX             (0x0000) /* PLL CPUX Control */
+#define REG_PLL_AUDIO            (0x0008) /* PLL Audio Control */
+#define REG_PLL_VIDEO            (0x0010) /* PLL Video Control */
+#define REG_PLL_VE               (0x0018) /* PLL VE Control */
+#define REG_PLL_DDR              (0x0020) /* PLL DDR Control */
+#define REG_PLL_PERIPH0          (0x0028) /* PLL Peripherals 0 Control */
+#define REG_PLL_GPU              (0x0038) /* PLL GPU Control */
+#define REG_PLL_PERIPH1          (0x0044) /* PLL Peripherals 1 Control */
+#define REG_PLL_DE               (0x0048) /* PLL Display Engine Control */
+#define REG_CPUX_AXI             (0x0050) /* CPUX/AXI Configuration */
+#define REG_APB1                 (0x0054) /* ARM Peripheral Bus 1 Config */
+#define REG_APB2                 (0x0058) /* ARM Peripheral Bus 2 Config */
+#define REG_MBUS                 (0x00FC) /* MBUS Reset */
+#define REG_PLL_TIME0            (0x0200) /* PLL Stable Time 0 */
+#define REG_PLL_TIME1            (0x0204) /* PLL Stable Time 1 */
+#define REG_PLL_CPUX_BIAS        (0x0220) /* PLL CPUX Bias */
+#define REG_PLL_AUDIO_BIAS       (0x0224) /* PLL Audio Bias */
+#define REG_PLL_VIDEO_BIAS       (0x0228) /* PLL Video Bias */
+#define REG_PLL_VE_BIAS          (0x022C) /* PLL VE Bias */
+#define REG_PLL_DDR_BIAS         (0x0230) /* PLL DDR Bias */
+#define REG_PLL_PERIPH0_BIAS     (0x0234) /* PLL Peripherals 0 Bias */
+#define REG_PLL_GPU_BIAS         (0x023C) /* PLL GPU Bias */
+#define REG_PLL_PERIPH1_BIAS     (0x0244) /* PLL Peripherals 1 Bias */
+#define REG_PLL_DE_BIAS          (0x0248) /* PLL Display Engine Bias */
+#define REG_PLL_CPUX_TUNING      (0x0250) /* PLL CPUX Tuning */
+#define REG_PLL_DDR_TUNING       (0x0260) /* PLL DDR Tuning */
+#define REG_INDEX(offset)        (offset / sizeof(uint32_t))
+
+/* CCU register flags */
+#define REG_PLL_ENABLE           (1 << 31)
+#define REG_PLL_LOCK             (1 << 28)
+
+/* CCU register reset values */
+#define REG_PLL_CPUX_RST         (0x00001000)
+#define REG_PLL_AUDIO_RST        (0x00035514)
+#define REG_PLL_VIDEO_RST        (0x03006207)
+#define REG_PLL_VE_RST           (0x03006207)
+#define REG_PLL_DDR_RST          (0x00001000)
+#define REG_PLL_PERIPH0_RST      (0x00041811)
+#define REG_PLL_GPU_RST          (0x03006207)
+#define REG_PLL_PERIPH1_RST      (0x00041811)
+#define REG_PLL_DE_RST           (0x03006207)
+#define REG_CPUX_AXI_RST         (0x00010000)
+#define REG_APB1_RST             (0x00001010)
+#define REG_APB2_RST             (0x01000000)
+#define REG_MBUS_RST             (0x80000000)
+#define REG_PLL_TIME0_RST        (0x000000FF)
+#define REG_PLL_TIME1_RST        (0x000000FF)
+#define REG_PLL_CPUX_BIAS_RST    (0x08100200)
+#define REG_PLL_AUDIO_BIAS_RST   (0x10100000)
+#define REG_PLL_VIDEO_BIAS_RST   (0x10100000)
+#define REG_PLL_VE_BIAS_RST      (0x10100000)
+#define REG_PLL_DDR_BIAS_RST     (0x81104000)
+#define REG_PLL_PERIPH0_BIAS_RST (0x10100010)
+#define REG_PLL_GPU_BIAS_RST     (0x10100000)
+#define REG_PLL_PERIPH1_BIAS_RST (0x10100010)
+#define REG_PLL_DE_BIAS_RST      (0x10100000)
+#define REG_PLL_CPUX_TUNING_RST  (0x0A101000)
+#define REG_PLL_DDR_TUNING_RST   (0x14880000)
+
+static uint64_t allwinner_h3_clk_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    const AwH3ClockState *s = (AwH3ClockState *)opaque;
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_CLK_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void allwinner_h3_clk_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwH3ClockState *s = (AwH3ClockState *)opaque;
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_CLK_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    switch (offset) {
+    case REG_PLL_CPUX:    /* PLL CPUX Control */
+    case REG_PLL_AUDIO:   /* PLL Audio Control */
+    case REG_PLL_VIDEO:   /* PLL Video Control */
+    case REG_PLL_VE:      /* PLL VE Control */
+    case REG_PLL_DDR:     /* PLL DDR Control */
+    case REG_PLL_PERIPH0: /* PLL Peripherals 0 Control */
+    case REG_PLL_GPU:     /* PLL GPU Control */
+    case REG_PLL_PERIPH1: /* PLL Peripherals 1 Control */
+    case REG_PLL_DE:      /* PLL Display Engine Control */
+        if (val & REG_PLL_ENABLE) {
+            val |= REG_PLL_LOCK;
+        }
+        break;
+    default:
+        break;
+    }
+
+    s->regs[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_h3_clk_ops = {
+    .read = allwinner_h3_clk_read,
+    .write = allwinner_h3_clk_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    }
+};
+
+static void allwinner_h3_clk_reset(DeviceState *dev)
+{
+    AwH3ClockState *s = AW_H3_CLK(dev);
+
+    /* Set default values for registers */
+    s->regs[REG_INDEX(REG_PLL_CPUX)] = REG_PLL_CPUX_RST;
+    s->regs[REG_INDEX(REG_PLL_AUDIO)] = REG_PLL_AUDIO_RST;
+    s->regs[REG_INDEX(REG_PLL_VIDEO)] = REG_PLL_VIDEO_RST;
+    s->regs[REG_INDEX(REG_PLL_VE)] = REG_PLL_VE_RST;
+    s->regs[REG_INDEX(REG_PLL_DDR)] = REG_PLL_DDR_RST;
+    s->regs[REG_INDEX(REG_PLL_PERIPH0)] = REG_PLL_PERIPH0_RST;
+    s->regs[REG_INDEX(REG_PLL_GPU)] = REG_PLL_GPU_RST;
+    s->regs[REG_INDEX(REG_PLL_PERIPH1)] = REG_PLL_PERIPH1_RST;
+    s->regs[REG_INDEX(REG_PLL_DE)] = REG_PLL_DE_RST;
+    s->regs[REG_INDEX(REG_CPUX_AXI)] = REG_CPUX_AXI_RST;
+    s->regs[REG_INDEX(REG_APB1)] = REG_APB1_RST;
+    s->regs[REG_INDEX(REG_APB2)] = REG_APB2_RST;
+    s->regs[REG_INDEX(REG_MBUS)] = REG_MBUS_RST;
+    s->regs[REG_INDEX(REG_PLL_TIME0)] = REG_PLL_TIME0_RST;
+    s->regs[REG_INDEX(REG_PLL_TIME1)] = REG_PLL_TIME1_RST;
+    s->regs[REG_INDEX(REG_PLL_CPUX_BIAS)] = REG_PLL_CPUX_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_AUDIO_BIAS)] = REG_PLL_AUDIO_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_VIDEO_BIAS)] = REG_PLL_VIDEO_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_VE_BIAS)] = REG_PLL_VE_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_DDR_BIAS)] = REG_PLL_DDR_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_PERIPH0_BIAS)] = REG_PLL_PERIPH0_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_GPU_BIAS)] = REG_PLL_GPU_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_PERIPH1_BIAS)] = REG_PLL_PERIPH1_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_DE_BIAS)] = REG_PLL_DE_BIAS_RST;
+    s->regs[REG_INDEX(REG_PLL_CPUX_TUNING)] = REG_PLL_CPUX_TUNING_RST;
+    s->regs[REG_INDEX(REG_PLL_DDR_TUNING)] = REG_PLL_DDR_TUNING_RST;
+}
+
+static void allwinner_h3_clk_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void allwinner_h3_clk_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3ClockState *s = AW_H3_CLK(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_clk_ops, s,
+                          TYPE_AW_H3_CLK, AW_H3_CLK_REGS_MEM_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_h3_clk_vmstate = {
+    .name = TYPE_AW_H3_CLK,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwH3ClockState, AW_H3_CLK_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_clk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_clk_reset;
+    dc->realize = allwinner_h3_clk_realize;
+    dc->vmsd = &allwinner_h3_clk_vmstate;
+}
+
+static const TypeInfo allwinner_h3_clk_info = {
+    .name          = TYPE_AW_H3_CLK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_clk_init,
+    .instance_size = sizeof(AwH3ClockState),
+    .class_init    = allwinner_h3_clk_class_init,
+};
+
+static void allwinner_h3_clk_register(void)
+{
+    type_register_static(&allwinner_h3_clk_info);
+}
+
+type_init(allwinner_h3_clk_register)
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index af368c2254..e596516c5c 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -26,6 +26,7 @@
 #include "hw/arm/boot.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
+#include "hw/misc/allwinner-h3-clk.h"
 #include "target/arm/cpu.h"
 
 #define AW_H3_SRAM_A1_BASE     (0x00000000)
@@ -109,6 +110,7 @@ typedef struct AwH3State {
 
     qemu_irq irq[AW_H3_GIC_NUM_SPI];
     AwA10PITState timer;
+    AwH3ClockState ccu;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-h3-clk.h b/include/hw/misc/allwinner-h3-clk.h
new file mode 100644
index 0000000000..69ea559db1
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-clk.h
@@ -0,0 +1,41 @@
+/*
+ * Allwinner H3 Clock Control Unit emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_MISC_ALLWINNER_H3_CLK_H
+#define HW_MISC_ALLWINNER_H3_CLK_H
+
+#include "hw/sysbus.h"
+
+#define AW_H3_CLK_REGS_MAX_ADDR (0x304)
+#define AW_H3_CLK_REGS_NUM      (AW_H3_CLK_REGS_MAX_ADDR / sizeof(uint32_t))
+#define AW_H3_CLK_REGS_MEM_SIZE (1024)
+
+#define TYPE_AW_H3_CLK    "allwinner-h3-clk"
+#define AW_H3_CLK(obj)    OBJECT_CHECK(AwH3ClockState, (obj), TYPE_AW_H3_CLK)
+
+typedef struct AwH3ClockState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    uint32_t regs[AW_H3_CLK_REGS_NUM];
+} AwH3ClockState;
+
+#endif
-- 
2.17.1


