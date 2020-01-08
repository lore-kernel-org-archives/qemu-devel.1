Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3709DC33CA2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55A920643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYujIN/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55A920643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHbM-00084q-PK
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVX-0001Ld-TN
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVV-0002ZQ-5M
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ipHVU-0002YG-EI; Wed, 08 Jan 2020 15:00:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id b19so233533wmj.4;
 Wed, 08 Jan 2020 12:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fNYUuz0mgFtwPh2tLYOsH+fNNunhmOF9a7dklOB6TPo=;
 b=NYujIN/XJgJ7UleT14IfEm4skfAUYb5w1pE9X4Wwt/rclYSTdPCY7qgi8u4GfJNv1x
 24F4k8yRNnJ5YXGFOaGE/NxSed7CfNMDgHx4QPA7eOsqqUa6jOiYZ1aMfhIr7iCogGPE
 Y8VtoqIYIQT0FDzz+zoRA48pRk+8mbiN0FF4kHC2quEH4BgU7yLPlKW9nIRO6RqmpwiR
 tsh8TFbNI+jj8QeZJBtb9B9D+6pQ4BXfedV9141aDHJUCEWMpcn5/1IZAAMEanYbjw+d
 t22PeghB5AfK18gL6qeyev3HDvk55d+qZbwPqOoqKTPQs4ukMwZ0UTLWHZq7O0v5q22c
 1hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fNYUuz0mgFtwPh2tLYOsH+fNNunhmOF9a7dklOB6TPo=;
 b=N8jDc98H5fqdLgYtYZp88RHsNV+tcgBP/0Yh9TQSmCGLoefYfg9psaabPx5an0SQyR
 SL3gTDAw5zyyJ2btNHjtofjqZnrrYeGqHoflxId3SMOinKK7VkGpKIHqq7J4gkVdy82N
 rDPo15isqTHp7Vpm8tNpzWmy5zQ6JfOMV4yUfWgznyRT7gxV3fyBh06NfSutff0VWzqX
 zvbbQDFjASICpJ2G2rGBsv5ntzy291dhGfc2y9oob0qAqsDGYoUiOkM3yXAlqoRAQEID
 wHg2TZ8JvXh66jAs0eKglVgSZouRNaueAFgPd5cMA727qWnEjA/u8WeDd53tiNRZDtQQ
 c84Q==
X-Gm-Message-State: APjAAAWTz1+wWtGl5w99CR+F5Q1gKOFvP3aliz/tzYtYzkhC0WV6QmId
 1d+oRLi34wJ9CpzR7xsgqTuAvvRq
X-Google-Smtp-Source: APXvYqxsdJ4R5eyNdCSX0V7pI6LBZZUFcJjLONBNGW5u6PhvD8Qmss/Z+ioD4jlwR5XfPLIMykn/nQ==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr295756wme.177.1578513642790; 
 Wed, 08 Jan 2020 12:00:42 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id u18sm4970099wrt.26.2020.01.08.12.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:00:41 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/17] hw/arm/allwinner: add CPU Configuration module
Date: Wed,  8 Jan 2020 21:00:09 +0100
Message-Id: <20200108200020.4745-7-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108200020.4745-1-nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various Allwinner System on Chip designs contain multiple processors
that can be configured and reset using the generic CPU Configuration
module interface. This commit adds support for the Allwinner CPU
configuration interface which emulates the following features:

 * CPU reset
 * CPU status
 * Shared 64-bit timer

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 include/hw/arm/allwinner-h3.h      |   3 +
 include/hw/misc/allwinner-cpucfg.h |  54 ++++++
 hw/arm/allwinner-h3.c              |   9 +-
 hw/misc/allwinner-cpucfg.c         | 282 +++++++++++++++++++++++++++++
 hw/misc/Makefile.objs              |   1 +
 hw/misc/trace-events               |   5 +
 6 files changed, 353 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/allwinner-cpucfg.h
 create mode 100644 hw/misc/allwinner-cpucfg.c

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 26706f4fa6..5a25a92eae 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -44,6 +44,7 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/allwinner-h3-ccu.h"
+#include "hw/misc/allwinner-cpucfg.h"
 #include "hw/misc/allwinner-h3-sysctrl.h"
 #include "target/arm/cpu.h"
 
@@ -80,6 +81,7 @@ enum {
     AW_H3_GIC_CPU,
     AW_H3_GIC_HYP,
     AW_H3_GIC_VCPU,
+    AW_H3_CPUCFG,
     AW_H3_SDRAM
 };
 
@@ -111,6 +113,7 @@ typedef struct AwH3State {
     const hwaddr *memmap;
     AwA10PITState timer;
     AwH3ClockCtlState ccu;
+    AwCpuCfgState cpucfg;
     AwH3SysCtrlState sysctrl;
     GICState gic;
     MemoryRegion sram_a1;
diff --git a/include/hw/misc/allwinner-cpucfg.h b/include/hw/misc/allwinner-cpucfg.h
new file mode 100644
index 0000000000..2c0e5b7e03
--- /dev/null
+++ b/include/hw/misc/allwinner-cpucfg.h
@@ -0,0 +1,54 @@
+/*
+ * Allwinner CPU Configuration Module emulation
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
+#ifndef HW_MISC_ALLWINNER_CPUCFG_H
+#define HW_MISC_ALLWINNER_CPUCFG_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * Object model
+ * @{
+ */
+
+#define TYPE_AW_CPUCFG   "allwinner-cpucfg"
+#define AW_CPUCFG(obj) \
+    OBJECT_CHECK(AwCpuCfgState, (obj), TYPE_AW_CPUCFG)
+
+/** @} */
+
+/**
+ * Allwinner CPU Configuration Module instance state
+ */
+typedef struct AwCpuCfgState {
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
+} AwCpuCfgState;
+
+#endif /* HW_MISC_ALLWINNER_CPUCFG_H */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index d261d7b2be..e9ad6d23df 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -54,6 +54,7 @@ const hwaddr allwinner_h3_memmap[] = {
     [AW_H3_GIC_CPU]    = 0x01c82000,
     [AW_H3_GIC_HYP]    = 0x01c84000,
     [AW_H3_GIC_VCPU]   = 0x01c86000,
+    [AW_H3_CPUCFG]     = 0x01f01c00,
     [AW_H3_SDRAM]      = 0x40000000
 };
 
@@ -120,7 +121,6 @@ struct AwH3Unimplemented {
     { "r_wdog",    0x01f01000, 1 * KiB },
     { "r_prcm",    0x01f01400, 1 * KiB },
     { "r_twd",     0x01f01800, 1 * KiB },
-    { "r_cpucfg",  0x01f01c00, 1 * KiB },
     { "r_cir-rx",  0x01f02000, 1 * KiB },
     { "r_twi",     0x01f02400, 1 * KiB },
     { "r_uart",    0x01f02800, 1 * KiB },
@@ -193,6 +193,9 @@ static void allwinner_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "sysctrl", &s->sysctrl, sizeof(s->sysctrl),
                           TYPE_AW_H3_SYSCTRL);
+
+    sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg),
+                          TYPE_AW_CPUCFG);
 }
 
 static void allwinner_h3_realize(DeviceState *dev, Error **errp)
@@ -309,6 +312,10 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     qdev_init_nofail(DEVICE(&s->sysctrl));
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0, s->memmap[AW_H3_SYSCTRL]);
 
+    /* CPU Configuration */
+    qdev_init_nofail(DEVICE(&s->cpucfg));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, s->memmap[AW_H3_CPUCFG]);
+
     /* Universal Serial Bus */
     sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
diff --git a/hw/misc/allwinner-cpucfg.c b/hw/misc/allwinner-cpucfg.c
new file mode 100644
index 0000000000..58c7a1448d
--- /dev/null
+++ b/hw/misc/allwinner-cpucfg.c
@@ -0,0 +1,282 @@
+/*
+ * Allwinner CPU Configuration Module emulation
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
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "qemu/timer.h"
+#include "hw/core/cpu.h"
+#include "arm-powerctl.h"
+#include "hw/misc/allwinner-cpucfg.h"
+#include "trace.h"
+
+/* CPUCFG register offsets */
+enum {
+    REG_CPUS_RST_CTRL       = 0x0000, /* CPUs Reset Control */
+    REG_CPU0_RST_CTRL       = 0x0040, /* CPU#0 Reset Control */
+    REG_CPU0_CTRL           = 0x0044, /* CPU#0 Control */
+    REG_CPU0_STATUS         = 0x0048, /* CPU#0 Status */
+    REG_CPU1_RST_CTRL       = 0x0080, /* CPU#1 Reset Control */
+    REG_CPU1_CTRL           = 0x0084, /* CPU#1 Control */
+    REG_CPU1_STATUS         = 0x0088, /* CPU#1 Status */
+    REG_CPU2_RST_CTRL       = 0x00C0, /* CPU#2 Reset Control */
+    REG_CPU2_CTRL           = 0x00C4, /* CPU#2 Control */
+    REG_CPU2_STATUS         = 0x00C8, /* CPU#2 Status */
+    REG_CPU3_RST_CTRL       = 0x0100, /* CPU#3 Reset Control */
+    REG_CPU3_CTRL           = 0x0104, /* CPU#3 Control */
+    REG_CPU3_STATUS         = 0x0108, /* CPU#3 Status */
+    REG_CPU_SYS_RST         = 0x0140, /* CPU System Reset */
+    REG_CLK_GATING          = 0x0144, /* CPU Clock Gating */
+    REG_GEN_CTRL            = 0x0184, /* General Control */
+    REG_SUPER_STANDBY       = 0x01A0, /* Super Standby Flag */
+    REG_ENTRY_ADDR          = 0x01A4, /* Reset Entry Address */
+    REG_DBG_EXTERN          = 0x01E4, /* Debug External */
+    REG_CNT64_CTRL          = 0x0280, /* 64-bit Counter Control */
+    REG_CNT64_LOW           = 0x0284, /* 64-bit Counter Low */
+    REG_CNT64_HIGH          = 0x0288, /* 64-bit Counter High */
+};
+
+/* CPUCFG register flags */
+enum {
+    CPUX_RESET_RELEASED     = ((1 << 1) | (1 << 0)),
+    CPUX_STATUS_SMP         = (1 << 0),
+    CPU_SYS_RESET_RELEASED  = (1 << 0),
+    CLK_GATING_ENABLE       = ((1 << 8) | 0xF),
+};
+
+/* CPUCFG register reset values */
+enum {
+    REG_CLK_GATING_RST      = 0x0000010F,
+    REG_GEN_CTRL_RST        = 0x00000020,
+    REG_SUPER_STANDBY_RST   = 0x0,
+    REG_CNT64_CTRL_RST      = 0x0,
+};
+
+static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
+{
+    int ret;
+
+    trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
+
+    ret = arm_set_cpu_on(cpu_id, s->entry_addr, 0, 3, false);
+    if (ret != QEMU_ARM_POWERCTL_RET_SUCCESS) {
+        error_report("%s: failed to bring up CPU %d: err %d",
+                     __func__, cpu_id, ret);
+        return;
+    }
+}
+
+static uint64_t allwinner_cpucfg_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    const AwCpuCfgState *s = AW_CPUCFG(opaque);
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
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_cpucfg_read(offset, val, size);
+
+    return val;
+}
+
+static void allwinner_cpucfg_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwCpuCfgState *s = AW_CPUCFG(opaque);
+
+    trace_allwinner_cpucfg_write(offset, val, size);
+
+    switch (offset) {
+    case REG_CPUS_RST_CTRL:     /* CPUs Reset Control */
+    case REG_CPU_SYS_RST:       /* CPU System Reset */
+        break;
+    case REG_CPU0_RST_CTRL:     /* CPU#0 Reset Control */
+        if (val) {
+            allwinner_cpucfg_cpu_reset(s, 0);
+        }
+        break;
+    case REG_CPU1_RST_CTRL:     /* CPU#1 Reset Control */
+        if (val) {
+            allwinner_cpucfg_cpu_reset(s, 1);
+        }
+        break;
+    case REG_CPU2_RST_CTRL:     /* CPU#2 Reset Control */
+        if (val) {
+            allwinner_cpucfg_cpu_reset(s, 2);
+        }
+        break;
+    case REG_CPU3_RST_CTRL:     /* CPU#3 Reset Control */
+        if (val) {
+            allwinner_cpucfg_cpu_reset(s, 3);
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
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+}
+
+static const MemoryRegionOps allwinner_cpucfg_ops = {
+    .read = allwinner_cpucfg_read,
+    .write = allwinner_cpucfg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_cpucfg_reset(DeviceState *dev)
+{
+    AwCpuCfgState *s = AW_CPUCFG(dev);
+
+    /* Set default values for registers */
+    s->gen_ctrl = REG_GEN_CTRL_RST;
+    s->super_standby = REG_SUPER_STANDBY_RST;
+    s->entry_addr = 0;
+    s->counter_ctrl = REG_CNT64_CTRL_RST;
+}
+
+static void allwinner_cpucfg_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwCpuCfgState *s = AW_CPUCFG(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_cpucfg_ops, s,
+                          TYPE_AW_CPUCFG, 1 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_cpucfg_vmstate = {
+    .name = "allwinner-cpucfg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(gen_ctrl, AwCpuCfgState),
+        VMSTATE_UINT32(super_standby, AwCpuCfgState),
+        VMSTATE_UINT32(counter_ctrl, AwCpuCfgState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_cpucfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_cpucfg_reset;
+    dc->vmsd = &allwinner_cpucfg_vmstate;
+}
+
+static const TypeInfo allwinner_cpucfg_info = {
+    .name          = TYPE_AW_CPUCFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_cpucfg_init,
+    .instance_size = sizeof(AwCpuCfgState),
+    .class_init    = allwinner_cpucfg_class_init,
+};
+
+static void allwinner_cpucfg_register(void)
+{
+    type_register_static(&allwinner_cpucfg_info);
+}
+
+type_init(allwinner_cpucfg_register)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 2d6b1a4257..12c2c306b5 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -29,6 +29,7 @@ common-obj-$(CONFIG_MACIO) += macio/
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
+obj-$(CONFIG_ALLWINNER_H3) += allwinner-cpucfg.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sysctrl.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 2e0c820834..d3e0952429 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# allwinner-cpucfg.c
+allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t reset_addr) "id %u, reset_addr 0x%" PRIu32
+allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+
 # eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
 ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
-- 
2.17.1


