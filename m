Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB1C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5ED2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwjhBoQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5ED2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpNa-00076n-Dc
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8P-0002nm-8D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:09 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:39425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8M-0007bO-OS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:08 -0400
Received: by mail-wr1-x429.google.com with SMTP id a17so18900667wrn.6
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=baZr89eDpeN6CarggpLZkd5v07+BnHw4MjZMWFCQ4a8=;
 b=ZwjhBoQE76WAbt98QJWWv/Vun+lx7aLJHqYlxKwKl9xvFm7jL2eH01bDA3EMtPUtPY
 60x9lH/pp7+mpwHNIYLLCy2uP1RPGsE3rPLFak6CyNeaaQb3Z28XXCBg9iBKsfFGHshl
 5UzAVNhAGggRqy8luqN9o+LzX3OwGEqgDg0mBnC7btyLYaakLVMHzD5selAuQR9R68SM
 jSmnuTGPZHsqwS8OKzl/6M7faghGdwNL8HUvBu3pKmPQClNyP5Gyp3/paCHU59M75kix
 /LC1di3okXGAD4Hk3l5Ncx+AN791XA7LKmU5StSS0iDusWDLryMRs0/zMK2ZnIG9soAw
 0oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=baZr89eDpeN6CarggpLZkd5v07+BnHw4MjZMWFCQ4a8=;
 b=FRtlBrB8krdq5VhP66Xyt4YMQgNoia0xgVPQrvPWS8KzLPHBErynxbeg9VlczwIEtQ
 FCSrydTNL9eXZueDmK9KeDXCe1hnYLSdVkQZuT4MeaLm/m8XBX+i6XeiJS9iQzfMM8hn
 58KYW6c/2rNQI5D8pnnkczLRQ98tPbIzU4oHNYbD4SRKPtAn4C/SYwstaSpNAzMJSmH2
 JXtQwihYInMtOat/xkImN4aJLPuWUhf4JWk6887MeSudkd5EpOz6I2Xro0S5pJux1gMr
 cZM2dq//8OJjnPFHygzrIDCVuyhEMmasH0kvna6mV/aerrPJOsYAoepUbkimlcqndDjq
 FXpQ==
X-Gm-Message-State: AOAM533L2ah1XDMfqsi51+zabNkpUJvRS5SoFvw0qOQZoMMIShmY6uRb
 YRYPtmZS4Pd471jQ7xPCKGHIFAHwBEb6yDRt
X-Google-Smtp-Source: ABdhPJxyATqDhZfBAcQRDhh9X6861xEBRjTo5xBU7W0bWpfuCsD+edSftzENK4G++q6rh91KL9NkHg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr16011580wro.314.1600092424664; 
 Mon, 14 Sep 2020 07:07:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/36] hw/misc: Add NPCM7xx System Global Control Registers
 device model
Date: Mon, 14 Sep 2020 15:06:24 +0100
Message-Id: <20200914140641.21369-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Implement a device model for the System Global Control Registers in the
NPCM730 and NPCM750 BMC SoCs.

This is primarily used to enable SMP boot (the boot ROM spins reading
the SCRPAD register) and DDR memory initialization; other registers are
best effort for now.

The reset values of the MDLR and PWRON registers are determined by the
SoC variant (730 vs 750) and board straps respectively.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200911052101.2602693-2-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/npcm7xx_gcr.h |  43 ++++++
 hw/misc/npcm7xx_gcr.c         | 269 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                   |   8 +
 hw/arm/Kconfig                |   3 +
 hw/misc/meson.build           |   3 +
 hw/misc/trace-events          |   4 +
 6 files changed, 330 insertions(+)
 create mode 100644 include/hw/misc/npcm7xx_gcr.h
 create mode 100644 hw/misc/npcm7xx_gcr.c

diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm7xx_gcr.h
new file mode 100644
index 00000000000..13109d9d324
--- /dev/null
+++ b/include/hw/misc/npcm7xx_gcr.h
@@ -0,0 +1,43 @@
+/*
+ * Nuvoton NPCM7xx System Global Control Registers.
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
+#ifndef NPCM7XX_GCR_H
+#define NPCM7XX_GCR_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+/*
+ * Number of registers in our device state structure. Don't change this without
+ * incrementing the version_id in the vmstate.
+ */
+#define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
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
+    uint32_t reset_intcr3;
+} NPCM7xxGCRState;
+
+#define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
+#define NPCM7XX_GCR(obj) OBJECT_CHECK(NPCM7xxGCRState, (obj), TYPE_NPCM7XX_GCR)
+
+#endif /* NPCM7XX_GCR_H */
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
new file mode 100644
index 00000000000..745f6908097
--- /dev/null
+++ b/hw/misc/npcm7xx_gcr.c
@@ -0,0 +1,269 @@
+/*
+ * Nuvoton NPCM7xx System Global Control Registers.
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
+#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#include "trace.h"
+
+#define NPCM7XX_GCR_MIN_DRAM_SIZE   (128 * MiB)
+#define NPCM7XX_GCR_MAX_DRAM_SIZE   (2 * GiB)
+
+enum NPCM7xxGCRRegisters {
+    NPCM7XX_GCR_PDID,
+    NPCM7XX_GCR_PWRON,
+    NPCM7XX_GCR_MFSEL1          = 0x0c / sizeof(uint32_t),
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
+    NPCM7XX_GCR_VSINTR          = 0x0ac / sizeof(uint32_t),
+    NPCM7XX_GCR_MFSEL4,
+    NPCM7XX_GCR_CPBPNTR         = 0x0c4 / sizeof(uint32_t),
+    NPCM7XX_GCR_CPCTL           = 0x0d0 / sizeof(uint32_t),
+    NPCM7XX_GCR_CP2BST,
+    NPCM7XX_GCR_B2CPNT,
+    NPCM7XX_GCR_CPPCTL,
+    NPCM7XX_GCR_I2CSEGSEL,
+    NPCM7XX_GCR_I2CSEGCTL,
+    NPCM7XX_GCR_VSRCR,
+    NPCM7XX_GCR_MLOCKR,
+    NPCM7XX_GCR_SCRPAD          = 0x013c / sizeof(uint32_t),
+    NPCM7XX_GCR_USB1PHYCTL,
+    NPCM7XX_GCR_USB2PHYCTL,
+    NPCM7XX_GCR_REGS_END,
+};
+
+static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
+    [NPCM7XX_GCR_PDID]          = 0x04a92750,   /* Poleg A1 */
+    [NPCM7XX_GCR_MISCPE]        = 0x0000ffff,
+    [NPCM7XX_GCR_SPSWC]         = 0x00000003,
+    [NPCM7XX_GCR_INTCR]         = 0x0000035e,
+    [NPCM7XX_GCR_HIFCR]         = 0x0000004e,
+    [NPCM7XX_GCR_INTCR2]        = (1U << 19),   /* DDR initialized */
+    [NPCM7XX_GCR_RESSR]         = 0x80000000,
+    [NPCM7XX_GCR_DSCNT]         = 0x000000c0,
+    [NPCM7XX_GCR_DAVCLVLR]      = 0x5a00f3cf,
+    [NPCM7XX_GCR_SCRPAD]        = 0x00000008,
+    [NPCM7XX_GCR_USB1PHYCTL]    = 0x034730e4,
+    [NPCM7XX_GCR_USB2PHYCTL]    = 0x034730e4,
+};
+
+static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t reg = offset / sizeof(uint32_t);
+    NPCM7xxGCRState *s = opaque;
+
+    if (reg >= NPCM7XX_GCR_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
+                      __func__, offset);
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
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%04" HWADDR_PRIx " out of range\n",
+                      __func__, offset);
+        return;
+    }
+
+    switch (reg) {
+    case NPCM7XX_GCR_PDID:
+    case NPCM7XX_GCR_PWRON:
+    case NPCM7XX_GCR_INTSR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
+                      __func__, offset);
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
+    .endianness = DEVICE_LITTLE_ENDIAN,
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
+        s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
+        break;
+    }
+}
+
+static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    NPCM7xxGCRState *s = NPCM7XX_GCR(dev);
+    uint64_t dram_size;
+    Object *obj;
+
+    obj = object_property_get_link(OBJECT(dev), "dram-mr", errp);
+    if (!obj) {
+        error_prepend(errp, "%s: required dram-mr link not found: ", __func__);
+        return;
+    }
+    dram_size = memory_region_size(MEMORY_REGION(obj));
+    if (!is_power_of_2(dram_size) ||
+        dram_size < NPCM7XX_GCR_MIN_DRAM_SIZE ||
+        dram_size > NPCM7XX_GCR_MAX_DRAM_SIZE) {
+        g_autofree char *sz = size_to_str(dram_size);
+        g_autofree char *min_sz = size_to_str(NPCM7XX_GCR_MIN_DRAM_SIZE);
+        g_autofree char *max_sz = size_to_str(NPCM7XX_GCR_MAX_DRAM_SIZE);
+        error_setg(errp, "%s: unsupported DRAM size %s", __func__, sz);
+        error_append_hint(errp,
+                          "DRAM size must be a power of two between %s and %s,"
+                          " inclusive.\n", min_sz, max_sz);
+        return;
+    }
+
+    /* Power-on reset value */
+    s->reset_intcr3 = 0x00001002;
+
+    /*
+     * The GMMAP (Graphics Memory Map) field is used by u-boot to detect the
+     * DRAM size, and is normally initialized by the boot block as part of DRAM
+     * training. However, since we don't have a complete emulation of the
+     * memory controller and try to make it look like it has already been
+     * initialized, the boot block will skip this initialization, and we need
+     * to make sure this field is set correctly up front.
+     *
+     * WARNING: some versions of u-boot only looks at bits 8 and 9, so 2 GiB of
+     * DRAM will be interpreted as 128 MiB.
+     *
+     * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb5408dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
+     */
+    s->reset_intcr3 |= ctz64(dram_size / NPCM7XX_GCR_MIN_DRAM_SIZE) << 8;
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
+static const VMStateDescription vmstate_npcm7xx_gcr = {
+    .name = "npcm7xx-gcr",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, NPCM7xxGCRState, NPCM7XX_GCR_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
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
+    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM7XX_GCR_NR_REGS);
+
+    dc->desc = "NPCM7xx System Global Control Registers";
+    dc->realize = npcm7xx_gcr_realize;
+    dc->vmsd = &vmstate_npcm7xx_gcr;
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
diff --git a/MAINTAINERS b/MAINTAINERS
index d817ee6c6f8..c95a00c12dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -750,6 +750,14 @@ S: Odd Fixes
 F: hw/arm/musicpal.c
 F: docs/system/arm/musicpal.rst
 
+Nuvoton NPCM7xx
+M: Havard Skinnemoen <hskinnemoen@google.com>
+M: Tyrone Ting <kfting@nuvoton.com>
+L: qemu-arm@nongnu.org
+S: Supported
+F: hw/*/npcm7xx*
+F: include/hw/*/npcm7xx*
+
 nSeries
 M: Andrzej Zaborowski <balrogg@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index bc3a423940b..4aec9c63f87 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -355,6 +355,9 @@ config XLNX_VERSAL
     select VIRTIO_MMIO
     select UNIMP
 
+config NPCM7XX
+    bool
+
 config FSL_IMX25
     bool
     select IMX
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index bd24132757a..e5cda41e1c5 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -56,6 +56,9 @@ softmmu_ss.add(when: 'CONFIG_IMX', if_true: files(
 ))
 softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-hpdmc.c', 'milkymist-pfpu.c'))
 softmmu_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mst_fpga.c'))
+softmmu_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
+  'npcm7xx_gcr.c',
+))
 softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files(
   'omap_clk.c',
   'omap_gpmc.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 56a622d1e97..57b18cf63ef 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -110,6 +110,10 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
 
+# npcm7xx_gcr.c
+npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+
 # stm32f4xx_syscfg.c
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
-- 
2.20.1


