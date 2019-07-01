Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAF6C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D903E206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doeo1Nlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D903E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7nB-00034Y-6E
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4UG-0002GB-24
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4UA-0002WM-R9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:09:21 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:33907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4UA-0002S3-IQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:09:18 -0400
Received: by mail-wm1-f51.google.com with SMTP id w9so991984wmd.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jtDC6+RlmBJHfbCA1udB+lS55G6A49jnV1UvKe11c8o=;
 b=doeo1Nlk9UaOOivObZ7YmoEfYJpnB8L15MbfPltri3VZNmaI/yFn2bdXSmDpobWfUK
 BzYdubxf+lpG+O9MT0kqOwlzD63FQHpKuWTgYmZl+UxRyPonTPKerRFwNEROrgrWhEyq
 KCNCg/CpZ3RxhQxPIKEFl8HpjmJrP1hn2DokrjWOVZmrp8AZd0x+vUj+jJy4NYiaJNoU
 i7m7ZxMw4KGpOazY/9je8T9C2i/AA5Xk/rLZeb6isi6yjxyfZNjDm4CC86kSL9tze9Jw
 yRx/TYsRQuqPaNP+FngKyXKe8Bo6nPa7btWTM/OtcVdtXXKEFB4NiHBqFlIERyqOT57z
 UYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jtDC6+RlmBJHfbCA1udB+lS55G6A49jnV1UvKe11c8o=;
 b=gRZpIWG8zQM4SYagAgb5qyQQ+o7qFpEV3NP6cVgIO10E0WReb+3V6vZL2X2x8bZW1G
 W++YBFswJ8O6PUqLteY4DfsUMLco23/bYpqe8aIIKniXb2rxQjs51lXxpUbkvvlU6g2H
 6B7SZjxr0KTbz7DOtAku44BLUQ45NO4kLO1ccJ5vNLavbMnvvwbq7pAtII2nr6PPeYdI
 qc4oY9JtdqFEZ0yDTObv6A3GJOHcHfFGBYEzOLshL+ai8o5LCFgZoiOECV/9Dm3KRgqh
 xXPC43ZrBZ/MHX6dSdvlbcXAEQUjZ/Dproai58AwkD6AtaSw0ODKjxXsohb6hotYdSFQ
 t/BA==
X-Gm-Message-State: APjAAAW3cAJ5Xe/U/l3MENX55+NlEGU03NI3crJfLJsF8Wv3yMC79V1m
 xV/NdUyNgopzx8swqcJ8jb2lMfy5sit6+Q==
X-Google-Smtp-Source: APXvYqzX+/TeEcc+Of6b1LkyyJVbXhenRakwWEbBHU+SQEJkZP9GUzm4wYXu/8Svpq3OJ4ukweNZKg==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr139071wmb.130.1561999209936;
 Mon, 01 Jul 2019 09:40:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:20 +0100
Message-Id: <20190701163943.22313-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.51
Subject: [Qemu-devel] [PULL 23/46] hw/misc/aspeed_xdma: New device
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

From: Eddie James <eajames@linux.ibm.com>

The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
enable it for all of those. Add trace events on the important register
writes in the XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190618165311.27066-21-clg@kaod.org
[clg: - changed title ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs         |   1 +
 include/hw/arm/aspeed_soc.h   |   3 +
 include/hw/misc/aspeed_xdma.h |  30 +++++++
 hw/arm/aspeed_soc.c           |  17 ++++
 hw/misc/aspeed_xdma.c         | 165 ++++++++++++++++++++++++++++++++++
 hw/misc/trace-events          |   3 +
 6 files changed, 219 insertions(+)
 create mode 100644 include/hw/misc/aspeed_xdma.h
 create mode 100644 hw/misc/aspeed_xdma.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 77b9df9796e..e9aab519a1a 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -74,6 +74,7 @@ obj-$(CONFIG_ARMSSE_MHU) += armsse-mhu.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
 obj-$(CONFIG_AUX) += auxbus.o
+obj-$(CONFIG_ASPEED_SOC) += aspeed_xdma.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 75b557060b9..cef605ad6bd 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -15,6 +15,7 @@
 #include "hw/intc/aspeed_vic.h"
 #include "hw/misc/aspeed_scu.h"
 #include "hw/misc/aspeed_sdmc.h"
+#include "hw/misc/aspeed_xdma.h"
 #include "hw/timer/aspeed_timer.h"
 #include "hw/timer/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
@@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
     AspeedTimerCtrlState timerctrl;
     AspeedI2CState i2c;
     AspeedSCUState scu;
+    AspeedXDMAState xdma;
     AspeedSMCState fmc;
     AspeedSMCState spi[ASPEED_SPIS_NUM];
     AspeedSDMCState sdmc;
@@ -108,6 +110,7 @@ enum {
     ASPEED_ETH1,
     ASPEED_ETH2,
     ASPEED_SDRAM,
+    ASPEED_XDMA,
 };
 
 #endif /* ASPEED_SOC_H */
diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xdma.h
new file mode 100644
index 00000000000..00b45d931f8
--- /dev/null
+++ b/include/hw/misc/aspeed_xdma.h
@@ -0,0 +1,30 @@
+/*
+ * ASPEED XDMA Controller
+ * Eddie James <eajames@linux.ibm.com>
+ *
+ * Copyright (C) 2019 IBM Corp.
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_XDMA_H
+#define ASPEED_XDMA_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ASPEED_XDMA "aspeed.xdma"
+#define ASPEED_XDMA(obj) OBJECT_CHECK(AspeedXDMAState, (obj), TYPE_ASPEED_XDMA)
+
+#define ASPEED_XDMA_NUM_REGS (ASPEED_XDMA_REG_SIZE / sizeof(uint32_t))
+#define ASPEED_XDMA_REG_SIZE 0x7C
+
+typedef struct AspeedXDMAState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    char bmc_cmdq_readp_set;
+    uint32_t regs[ASPEED_XDMA_NUM_REGS];
+} AspeedXDMAState;
+
+#endif /* ASPEED_XDMA_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 02feb4361ba..443e4c49f21 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_VIC]    = 0x1E6C0000,
     [ASPEED_SDMC]   = 0x1E6E0000,
     [ASPEED_SCU]    = 0x1E6E2000,
+    [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
     [ASPEED_GPIO]   = 0x1E780000,
@@ -58,6 +59,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_VIC]    = 0x1E6C0000,
     [ASPEED_SDMC]   = 0x1E6E0000,
     [ASPEED_SCU]    = 0x1E6E2000,
+    [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
     [ASPEED_GPIO]   = 0x1E780000,
@@ -104,6 +106,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_I2C]    = 12,
     [ASPEED_ETH1]   = 2,
     [ASPEED_ETH2]   = 3,
+    [ASPEED_XDMA]   = 6,
 };
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -238,6 +241,9 @@ static void aspeed_soc_init(Object *obj)
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
     }
+
+    sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
+                          TYPE_ASPEED_XDMA);
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -406,6 +412,17 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
     }
+
+    /* XDMA */
+    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
+                    sc->info->memmap[ASPEED_XDMA]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
+                       aspeed_soc_get_irq(s, ASPEED_XDMA));
 }
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
new file mode 100644
index 00000000000..eebd4ad540a
--- /dev/null
+++ b/hw/misc/aspeed_xdma.c
@@ -0,0 +1,165 @@
+/*
+ * ASPEED XDMA Controller
+ * Eddie James <eajames@linux.ibm.com>
+ *
+ * Copyright (C) 2019 IBM Corp
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/misc/aspeed_xdma.h"
+#include "qapi/error.h"
+
+#include "trace.h"
+
+#define XDMA_BMC_CMDQ_ADDR         0x10
+#define XDMA_BMC_CMDQ_ENDP         0x14
+#define XDMA_BMC_CMDQ_WRP          0x18
+#define  XDMA_BMC_CMDQ_W_MASK      0x0003FFFF
+#define XDMA_BMC_CMDQ_RDP          0x1C
+#define  XDMA_BMC_CMDQ_RDP_MAGIC   0xEE882266
+#define XDMA_IRQ_ENG_CTRL          0x20
+#define  XDMA_IRQ_ENG_CTRL_US_COMP BIT(4)
+#define  XDMA_IRQ_ENG_CTRL_DS_COMP BIT(5)
+#define  XDMA_IRQ_ENG_CTRL_W_MASK  0xBFEFF07F
+#define XDMA_IRQ_ENG_STAT          0x24
+#define  XDMA_IRQ_ENG_STAT_US_COMP BIT(4)
+#define  XDMA_IRQ_ENG_STAT_DS_COMP BIT(5)
+#define  XDMA_IRQ_ENG_STAT_RESET   0xF8000000
+#define XDMA_MEM_SIZE              0x1000
+
+#define TO_REG(addr) ((addr) / sizeof(uint32_t))
+
+static uint64_t aspeed_xdma_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    uint32_t val = 0;
+    AspeedXDMAState *xdma = opaque;
+
+    if (addr < ASPEED_XDMA_REG_SIZE) {
+        val = xdma->regs[TO_REG(addr)];
+    }
+
+    return (uint64_t)val;
+}
+
+static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned int size)
+{
+    unsigned int idx;
+    uint32_t val32 = (uint32_t)val;
+    AspeedXDMAState *xdma = opaque;
+
+    if (addr >= ASPEED_XDMA_REG_SIZE) {
+        return;
+    }
+
+    switch (addr) {
+    case XDMA_BMC_CMDQ_ENDP:
+        xdma->regs[TO_REG(addr)] = val32 & XDMA_BMC_CMDQ_W_MASK;
+        break;
+    case XDMA_BMC_CMDQ_WRP:
+        idx = TO_REG(addr);
+        xdma->regs[idx] = val32 & XDMA_BMC_CMDQ_W_MASK;
+        xdma->regs[TO_REG(XDMA_BMC_CMDQ_RDP)] = xdma->regs[idx];
+
+        trace_aspeed_xdma_write(addr, val);
+
+        if (xdma->bmc_cmdq_readp_set) {
+            xdma->bmc_cmdq_readp_set = 0;
+        } else {
+            xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] |=
+                XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP;
+
+            if (xdma->regs[TO_REG(XDMA_IRQ_ENG_CTRL)] &
+                (XDMA_IRQ_ENG_CTRL_US_COMP | XDMA_IRQ_ENG_CTRL_DS_COMP))
+                qemu_irq_raise(xdma->irq);
+        }
+        break;
+    case XDMA_BMC_CMDQ_RDP:
+        trace_aspeed_xdma_write(addr, val);
+
+        if (val32 == XDMA_BMC_CMDQ_RDP_MAGIC) {
+            xdma->bmc_cmdq_readp_set = 1;
+        }
+        break;
+    case XDMA_IRQ_ENG_CTRL:
+        xdma->regs[TO_REG(addr)] = val32 & XDMA_IRQ_ENG_CTRL_W_MASK;
+        break;
+    case XDMA_IRQ_ENG_STAT:
+        trace_aspeed_xdma_write(addr, val);
+
+        idx = TO_REG(addr);
+        if (val32 & (XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP)) {
+            xdma->regs[idx] &=
+                ~(XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP);
+            qemu_irq_lower(xdma->irq);
+        }
+        break;
+    default:
+        xdma->regs[TO_REG(addr)] = val32;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_xdma_ops = {
+    .read = aspeed_xdma_read,
+    .write = aspeed_xdma_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void aspeed_xdma_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedXDMAState *xdma = ASPEED_XDMA(dev);
+
+    sysbus_init_irq(sbd, &xdma->irq);
+    memory_region_init_io(&xdma->iomem, OBJECT(xdma), &aspeed_xdma_ops, xdma,
+                          TYPE_ASPEED_XDMA, XDMA_MEM_SIZE);
+    sysbus_init_mmio(sbd, &xdma->iomem);
+}
+
+static void aspeed_xdma_reset(DeviceState *dev)
+{
+    AspeedXDMAState *xdma = ASPEED_XDMA(dev);
+
+    xdma->bmc_cmdq_readp_set = 0;
+    memset(xdma->regs, 0, ASPEED_XDMA_REG_SIZE);
+    xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] = XDMA_IRQ_ENG_STAT_RESET;
+
+    qemu_irq_lower(xdma->irq);
+}
+
+static const VMStateDescription aspeed_xdma_vmstate = {
+    .name = TYPE_ASPEED_XDMA,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedXDMAState, ASPEED_XDMA_NUM_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void aspeed_xdma_class_init(ObjectClass *classp, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(classp);
+
+    dc->realize = aspeed_xdma_realize;
+    dc->reset = aspeed_xdma_reset;
+    dc->vmsd = &aspeed_xdma_vmstate;
+}
+
+static const TypeInfo aspeed_xdma_info = {
+    .name          = TYPE_ASPEED_XDMA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedXDMAState),
+    .class_init    = aspeed_xdma_class_init,
+};
+
+static void aspeed_xdma_register_type(void)
+{
+    type_register_static(&aspeed_xdma_info);
+}
+type_init(aspeed_xdma_register_type);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 47e1bccf71d..c1ea1aa4376 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -140,3 +140,6 @@ armsse_cpuid_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 CPU_I
 # armsse-mhu.c
 armsse_mhu_read(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+
+# aspeed_xdma.c
+aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
-- 
2.20.1


