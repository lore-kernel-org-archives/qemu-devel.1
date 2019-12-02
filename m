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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE01CC432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B82320717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSigWBGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B82320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibtSD-00074x-S3
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxR-0002b8-CR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxO-0000eY-B5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:12 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ibsxK-0000Ze-T0; Mon, 02 Dec 2019 16:10:08 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so832211wmc.2;
 Mon, 02 Dec 2019 13:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6mohYVc55+3KFtvWDD44Yy/lRiZu/L99ANQeBUfkI2w=;
 b=uSigWBGqzoAwI+P2C+q5Yx/llTHRDCinveHXuALIGGg/dQ9lx7TuvrliC5GXiHGAfo
 Wx+1NxP4wCm1F6nGQ89Ensb6ogUnDdheYxrqFRT4gN0SCtB105JK0YBAhndG9hzpvNjH
 y1vutiiYVXGx0JMSKbeuElb9mLNR08NjkNlj27VOZEpixX7P4YSI08rUJCpLKn5z5xRn
 258vIVzoLMbwgQeQx2BN2gPICiloUWQMsxSY3LxSrYoDaKokdqEapzt0IFytWhFGSUDn
 vIXKk2C8ksJ9xNvE4KSCyRmbFsDioCsBpj40ANxfpk/jitW0hlJZsLO6EEwL8oHVPNRU
 4dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6mohYVc55+3KFtvWDD44Yy/lRiZu/L99ANQeBUfkI2w=;
 b=Q1zd1JhAeXucbbVp27IsA+X/sEowQXyQp1XUjavdZsqh+BAJ0UQHfLdu5aUWG9vTnP
 X/HIthpK6DUOf6OWkoHkBMJb8aNODeqY/hjPrwSiXEjkU6Eb2TlFurNOANaQY4rMrzBk
 4CUKcgh45hysUaOzHpY7JB3o4ouKrJk2QA5/1ucIDIyePukG9ZlP6q1lgRDUSnHQqe53
 g6kxbiDKrup/hNpSKXH7x+A7LNmkWp/FvtBGmbnnLkePNCiVaR4KPisAZfKwJxX7bMFd
 6Yr8uGUi1VUQgXHr0oC3PTSeyKc4oa+ZXa2p+WmGQJgRMT7yVfkQ/saMEDMXWX7g6UnB
 iVkQ==
X-Gm-Message-State: APjAAAXiKwx+sxdk2eMzf+XnzxfzDio1YClBSZ/o0dRJamHi9UEFYnGp
 Nqu9IVut+no/TayFr37ZMqPn793R
X-Google-Smtp-Source: APXvYqxx6qXyvz4dKHhNT5NjsleT4hvl04XfmRIZy3SV8yBhFpL9HS6B1oR4Rdp5Cvz21rlgpGej8A==
X-Received: by 2002:a05:600c:2318:: with SMTP id
 24mr30400612wmo.21.1575321002800; 
 Mon, 02 Dec 2019 13:10:02 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id f1sm770859wrp.93.2019.12.02.13.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 13:10:02 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/10] arm: allwinner-h3: add CPU Configuration module
Date: Mon,  2 Dec 2019 22:09:44 +0100
Message-Id: <20191202210947.3603-8-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

The Allwinner H3 System on Chip design contains four ARM Cortex A7
processors that can be configured and reset using the CPU Configuration
module interface. This commit adds support for the CPU configuration
interface which emulates the following features:

 * CPU reset
 * Shared 64-bit timer

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/allwinner-h3.c                 |  11 +
 hw/misc/Makefile.objs                 |   1 +
 hw/misc/allwinner-h3-cpucfg.c         | 280 ++++++++++++++++++++++++++
 include/hw/arm/allwinner-h3.h         |   2 +
 include/hw/misc/allwinner-h3-cpucfg.h |  44 ++++
 5 files changed, 338 insertions(+)
 create mode 100644 hw/misc/allwinner-h3-cpucfg.c
 create mode 100644 include/hw/misc/allwinner-h3-cpucfg.h

diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index ebd8fde412..44aba1de6a 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -44,6 +44,9 @@ static void aw_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "syscon", &s->syscon, sizeof(s->syscon),
                           TYPE_AW_H3_SYSCON);
+
+    sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg),
+                          TYPE_AW_H3_CPUCFG);
 }
 
 static void aw_h3_realize(DeviceState *dev, Error **errp)
@@ -195,6 +198,14 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscon), 0, AW_H3_SYSCON_BASE);
 
+    /* CPU Configuration */
+    object_property_set_bool(OBJECT(&s->cpucfg), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, AW_H3_CPUCFG_BASE);
+
     /* Universal Serial Bus */
     sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
                          s->irq[AW_H3_GIC_SPI_EHCI0]);
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index b234aefba5..c4ca2ed689 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -29,6 +29,7 @@ common-obj-$(CONFIG_MACIO) += macio/
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-clk.o
+obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-cpucfg.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-syscon.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
diff --git a/hw/misc/allwinner-h3-cpucfg.c b/hw/misc/allwinner-h3-cpucfg.c
new file mode 100644
index 0000000000..b47feebd73
--- /dev/null
+++ b/hw/misc/allwinner-h3-cpucfg.c
@@ -0,0 +1,280 @@
+/*
+ * Allwinner H3 CPU Configuration Module emulation
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
+#include "qemu/error-report.h"
+#include "qemu/timer.h"
+#include "hw/core/cpu.h"
+#include "arm-powerctl.h"
+#include "hw/misc/allwinner-h3-cpucfg.h"
+#include "trace.h"
+
+/* CPUCFG register offsets */
+#define REG_CPUS_RST_CTRL       (0x0000) /* CPUs Reset Control */
+#define REG_CPU0_RST_CTRL       (0x0040) /* CPU#0 Reset Control */
+#define REG_CPU0_CTRL           (0x0044) /* CPU#0 Control */
+#define REG_CPU0_STATUS         (0x0048) /* CPU#0 Status */
+#define REG_CPU1_RST_CTRL       (0x0080) /* CPU#1 Reset Control */
+#define REG_CPU1_CTRL           (0x0084) /* CPU#1 Control */
+#define REG_CPU1_STATUS         (0x0088) /* CPU#1 Status */
+#define REG_CPU2_RST_CTRL       (0x00C0) /* CPU#2 Reset Control */
+#define REG_CPU2_CTRL           (0x00C4) /* CPU#2 Control */
+#define REG_CPU2_STATUS         (0x00C8) /* CPU#2 Status */
+#define REG_CPU3_RST_CTRL       (0x0100) /* CPU#3 Reset Control */
+#define REG_CPU3_CTRL           (0x0104) /* CPU#3 Control */
+#define REG_CPU3_STATUS         (0x0108) /* CPU#3 Status */
+#define REG_CPU_SYS_RST         (0x0140) /* CPU System Reset */
+#define REG_CLK_GATING          (0x0144) /* CPU Clock Gating */
+#define REG_GEN_CTRL            (0x0184) /* General Control */
+#define REG_SUPER_STANDBY       (0x01A0) /* Super Standby Flag */
+#define REG_ENTRY_ADDR          (0x01A4) /* Reset Entry Address */
+#define REG_DBG_EXTERN          (0x01E4) /* Debug External */
+#define REG_CNT64_CTRL          (0x0280) /* 64-bit Counter Control */
+#define REG_CNT64_LOW           (0x0284) /* 64-bit Counter Low */
+#define REG_CNT64_HIGH          (0x0288) /* 64-bit Counter High */
+
+/* CPUCFG register flags */
+#define CPUX_RESET_RELEASED     ((1 << 1) | (1 << 0))
+#define CPUX_STATUS_SMP         (1 << 0)
+#define CPU_SYS_RESET_RELEASED  (1 << 0)
+#define CLK_GATING_ENABLE       ((1 << 8) | 0xF)
+
+/* CPUCFG register reset values */
+#define REG_CLK_GATING_RST      (0x0000010F)
+#define REG_GEN_CTRL_RST        (0x00000020)
+#define REG_SUPER_STANDBY_RST   (0x0)
+#define REG_CNT64_CTRL_RST      (0x0)
+
+static void allwinner_h3_cpucfg_cpu_reset(AwH3CpuCfgState *s, uint8_t cpu_id)
+{
+    int ret;
+
+    trace_allwinner_h3_cpucfg_cpu_reset(cpu_id, s->entry_addr);
+
+    ret = arm_set_cpu_on(cpu_id, s->entry_addr, 0, 3, false);
+    if (ret != QEMU_ARM_POWERCTL_RET_SUCCESS) {
+        error_report("%s: failed to bring up CPU %d: err %d",
+                     __func__, cpu_id, ret);
+        return;
+    }
+}
+
+static uint64_t allwinner_h3_cpucfg_read(void *opaque, hwaddr offset,
+                                         unsigned size)
+{
+    const AwH3CpuCfgState *s = (AwH3CpuCfgState *)opaque;
+    uint64_t val = 0;
+
+    switch (offset) {
+    case REG_CPUS_RST_CTRL:     /* CPUs Reset Control */
+    case REG_CPU_SYS_RST:       /* CPU System Reset */
+        val = CPU_SYS_RESET_RELEASED;
+        break;
+    case REG_CPU0_RST_CTRL:     /* CPU#0 Reset Control */
+    case REG_CPU1_RST_CTRL:     /* CPU#1 Reset Control */
+    case REG_CPU2_RST_CTRL:     /* CPU#2 Reset Control */
+    case REG_CPU3_RST_CTRL:     /* CPU#3 Reset Control */
+        val = CPUX_RESET_RELEASED;
+        break;
+    case REG_CPU0_CTRL:         /* CPU#0 Control */
+    case REG_CPU1_CTRL:         /* CPU#1 Control */
+    case REG_CPU2_CTRL:         /* CPU#2 Control */
+    case REG_CPU3_CTRL:         /* CPU#3 Control */
+        val = 0;
+        break;
+    case REG_CPU0_STATUS:       /* CPU#0 Status */
+    case REG_CPU1_STATUS:       /* CPU#1 Status */
+    case REG_CPU2_STATUS:       /* CPU#2 Status */
+    case REG_CPU3_STATUS:       /* CPU#3 Status */
+        val = CPUX_STATUS_SMP;
+        break;
+    case REG_CLK_GATING:        /* CPU Clock Gating */
+        val = CLK_GATING_ENABLE;
+        break;
+    case REG_GEN_CTRL:          /* General Control */
+        val = s->gen_ctrl;
+        break;
+    case REG_SUPER_STANDBY:     /* Super Standby Flag */
+        val = s->super_standby;
+        break;
+    case REG_ENTRY_ADDR:        /* Reset Entry Address */
+        val = s->entry_addr;
+        break;
+    case REG_DBG_EXTERN:        /* Debug External */
+        break;
+    case REG_CNT64_CTRL:        /* 64-bit Counter Control */
+        val = s->counter_ctrl;
+        break;
+    case REG_CNT64_LOW:         /* 64-bit Counter Low */
+        val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) & 0xffffffff;
+        break;
+    case REG_CNT64_HIGH:        /* 64-bit Counter High */
+        val = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 32;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_h3_cpucfg_read(offset, val, size);
+
+    return val;
+}
+
+static void allwinner_h3_cpucfg_write(void *opaque, hwaddr offset,
+                                      uint64_t val, unsigned size)
+{
+    AwH3CpuCfgState *s = (AwH3CpuCfgState *)opaque;
+
+    trace_allwinner_h3_cpucfg_write(offset, val, size);
+
+    switch (offset) {
+    case REG_CPUS_RST_CTRL:     /* CPUs Reset Control */
+    case REG_CPU_SYS_RST:       /* CPU System Reset */
+        break;
+    case REG_CPU0_RST_CTRL:     /* CPU#0 Reset Control */
+        if (val) {
+            allwinner_h3_cpucfg_cpu_reset(s, 0);
+        }
+        break;
+    case REG_CPU1_RST_CTRL:     /* CPU#1 Reset Control */
+        if (val) {
+            allwinner_h3_cpucfg_cpu_reset(s, 1);
+        }
+        break;
+    case REG_CPU2_RST_CTRL:     /* CPU#2 Reset Control */
+        if (val) {
+            allwinner_h3_cpucfg_cpu_reset(s, 2);
+        }
+        break;
+    case REG_CPU3_RST_CTRL:     /* CPU#3 Reset Control */
+        if (val) {
+            allwinner_h3_cpucfg_cpu_reset(s, 3);
+        }
+        break;
+    case REG_CPU0_CTRL:         /* CPU#0 Control */
+    case REG_CPU1_CTRL:         /* CPU#1 Control */
+    case REG_CPU2_CTRL:         /* CPU#2 Control */
+    case REG_CPU3_CTRL:         /* CPU#3 Control */
+    case REG_CPU0_STATUS:       /* CPU#0 Status */
+    case REG_CPU1_STATUS:       /* CPU#1 Status */
+    case REG_CPU2_STATUS:       /* CPU#2 Status */
+    case REG_CPU3_STATUS:       /* CPU#3 Status */
+    case REG_CLK_GATING:        /* CPU Clock Gating */
+    case REG_GEN_CTRL:          /* General Control */
+        s->gen_ctrl = val;
+        break;
+    case REG_SUPER_STANDBY:     /* Super Standby Flag */
+        s->super_standby = val;
+        break;
+    case REG_ENTRY_ADDR:        /* Reset Entry Address */
+        s->entry_addr = val;
+        break;
+    case REG_DBG_EXTERN:        /* Debug External */
+        break;
+    case REG_CNT64_CTRL:        /* 64-bit Counter Control */
+        s->counter_ctrl = val;
+        break;
+    case REG_CNT64_LOW:         /* 64-bit Counter Low */
+    case REG_CNT64_HIGH:        /* 64-bit Counter High */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+}
+
+static const MemoryRegionOps allwinner_h3_cpucfg_ops = {
+    .read = allwinner_h3_cpucfg_read,
+    .write = allwinner_h3_cpucfg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    }
+};
+
+static void allwinner_h3_cpucfg_reset(DeviceState *dev)
+{
+    AwH3CpuCfgState *s = AW_H3_CPUCFG(dev);
+
+    /* Set default values for registers */
+    s->gen_ctrl = REG_GEN_CTRL_RST;
+    s->super_standby = REG_SUPER_STANDBY_RST;
+    s->entry_addr = 0;
+    s->counter_ctrl = REG_CNT64_CTRL_RST;
+}
+
+static void allwinner_h3_cpucfg_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void allwinner_h3_cpucfg_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3CpuCfgState *s = AW_H3_CPUCFG(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_cpucfg_ops, s,
+                          TYPE_AW_H3_CPUCFG, AW_H3_CPUCFG_REGS_MEM_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_h3_cpucfg_vmstate = {
+    .name = TYPE_AW_H3_CPUCFG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(gen_ctrl, AwH3CpuCfgState),
+        VMSTATE_UINT32(super_standby, AwH3CpuCfgState),
+        VMSTATE_UINT32(counter_ctrl, AwH3CpuCfgState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_cpucfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_cpucfg_reset;
+    dc->realize = allwinner_h3_cpucfg_realize;
+    dc->vmsd = &allwinner_h3_cpucfg_vmstate;
+}
+
+static const TypeInfo allwinner_h3_cpucfg_info = {
+    .name          = TYPE_AW_H3_CPUCFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_cpucfg_init,
+    .instance_size = sizeof(AwH3CpuCfgState),
+    .class_init    = allwinner_h3_cpucfg_class_init,
+};
+
+static void allwinner_h3_cpucfg_register(void)
+{
+    type_register_static(&allwinner_h3_cpucfg_info);
+}
+
+type_init(allwinner_h3_cpucfg_register)
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 2bc526b77b..374061b550 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -27,6 +27,7 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/allwinner-h3-clk.h"
+#include "hw/misc/allwinner-h3-cpucfg.h"
 #include "hw/misc/allwinner-h3-syscon.h"
 #include "target/arm/cpu.h"
 
@@ -112,6 +113,7 @@ typedef struct AwH3State {
     qemu_irq irq[AW_H3_GIC_NUM_SPI];
     AwA10PITState timer;
     AwH3ClockState ccu;
+    AwH3CpuCfgState cpucfg;
     AwH3SysconState syscon;
     GICState gic;
     MemoryRegion sram_a1;
diff --git a/include/hw/misc/allwinner-h3-cpucfg.h b/include/hw/misc/allwinner-h3-cpucfg.h
new file mode 100644
index 0000000000..808aaa90f6
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-cpucfg.h
@@ -0,0 +1,44 @@
+/*
+ * Allwinner H3 CPU Configuration Module emulation
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
+#ifndef HW_MISC_ALLWINNER_H3_CPUCFG_H
+#define HW_MISC_ALLWINNER_H3_CPUCFG_H
+
+#include "hw/sysbus.h"
+
+#define AW_H3_CPUCFG_REGS_MEM_SIZE  (1024)
+
+#define TYPE_AW_H3_CPUCFG   "allwinner-h3-cpucfg"
+#define AW_H3_CPUCFG(obj)   OBJECT_CHECK(AwH3CpuCfgState, (obj), \
+                                         TYPE_AW_H3_CPUCFG)
+
+typedef struct AwH3CpuCfgState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    uint32_t gen_ctrl;
+    uint32_t super_standby;
+    uint32_t entry_addr;
+    uint32_t counter_ctrl;
+
+} AwH3CpuCfgState;
+
+#endif
-- 
2.17.1


