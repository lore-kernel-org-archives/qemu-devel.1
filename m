Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C97C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF83207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF83207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcMj-00048x-1G
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsh-0007Uz-0J
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbse-000704-NE
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:34 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:41945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbse-0006zK-Eh
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:32 -0400
Received: by mail-pg1-f174.google.com with SMTP id x15so37191pgg.8
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=zGpRrVU/cmmuauofKLw0g+DvOsADD0jTvEtalEs51oU=;
 b=qih0Kz8JuHdpqlAj8LrNgjCmDsjLYjGKnUtJmFqMlvP2OqYKpjeEsQlGH3CpF11f9a
 3Zl7vGu0j7QXDkcI3KeKhzJBd1C4sg3/0k4NywpmnvdRsy10hEo5xh3oafZUMRwoKubm
 mcfQr2ochRQxz94pb3IouMDDhgCCGChm8sbKK5dE7Cg7Lhb5r5aAO4kl65mlujuHswrD
 +T6EVRAAUpjsy414dnZLDlO8kxFSYCv7zej12jGvd5iHazmV1caNx11Zhmd/shjA0/TB
 HG7hVgppGLWzejeatjTAz0eSbJHjNDgsHlbtbwFJZ1IYlq1dnv3JpEnIuPdY25HKhWkT
 KJpw==
X-Gm-Message-State: APjAAAUxGlZaugPXFpk+IGrDoG/u0DOY2AnYAeCCUEVuLFXd/6Ta1C5m
 ilpZxWTpHn6eBPvC2HNcAt8h0Q==
X-Google-Smtp-Source: APXvYqxMisQPTWMG1jYUHnELMW8JLu5Ipp6ukjkAbxw1INJAaNIGvYijHQyBo5R3fIYNEcqWBGM3Ag==
X-Received: by 2002:a65:6445:: with SMTP id s5mr70212pgv.86.1568820511202;
 Wed, 18 Sep 2019 08:28:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id m9sm6589887pgr.24.2019.09.18.08.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:30 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:25 -0700
Message-Id: <20190918145640.17349-34-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.174
Subject: [Qemu-devel] [PULL 33/48] riscv: sifive: Implement PRCI model for
 FU540
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

This adds a simple PRCI model for FU540 (sifive_u). It has different
register layout from the existing PRCI model for FE310 (sifive_e).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/Makefile.objs           |   1 +
 hw/riscv/sifive_u_prci.c         | 169 +++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_prci.h |  81 +++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 hw/riscv/sifive_u_prci.c
 create mode 100644 include/hw/riscv/sifive_u_prci.h

diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index c8596977a8..b95bbd51e2 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -8,6 +8,7 @@ obj-$(CONFIG_SIFIVE) += sifive_gpio.o
 obj-$(CONFIG_SIFIVE) += sifive_plic.o
 obj-$(CONFIG_SIFIVE) += sifive_test.o
 obj-$(CONFIG_SIFIVE_U) += sifive_u.o
+obj-$(CONFIG_SIFIVE_U) += sifive_u_prci.o
 obj-$(CONFIG_SIFIVE) += sifive_uart.o
 obj-$(CONFIG_SPIKE) += spike.o
 obj-$(CONFIG_RISCV_VIRT) += virt.o
diff --git a/hw/riscv/sifive_u_prci.c b/hw/riscv/sifive_u_prci.c
new file mode 100644
index 0000000000..4fa590c064
--- /dev/null
+++ b/hw/riscv/sifive_u_prci.c
@@ -0,0 +1,169 @@
+/*
+ * QEMU SiFive U PRCI (Power, Reset, Clock, Interrupt)
+ *
+ * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
+ *
+ * Simple model of the PRCI to emulate register reads made by the SDK BSP
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/riscv/sifive_u_prci.h"
+
+static uint64_t sifive_u_prci_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    SiFiveUPRCIState *s = opaque;
+
+    switch (addr) {
+    case SIFIVE_U_PRCI_HFXOSCCFG:
+        return s->hfxosccfg;
+    case SIFIVE_U_PRCI_COREPLLCFG0:
+        return s->corepllcfg0;
+    case SIFIVE_U_PRCI_DDRPLLCFG0:
+        return s->ddrpllcfg0;
+    case SIFIVE_U_PRCI_DDRPLLCFG1:
+        return s->ddrpllcfg1;
+    case SIFIVE_U_PRCI_GEMGXLPLLCFG0:
+        return s->gemgxlpllcfg0;
+    case SIFIVE_U_PRCI_GEMGXLPLLCFG1:
+        return s->gemgxlpllcfg1;
+    case SIFIVE_U_PRCI_CORECLKSEL:
+        return s->coreclksel;
+    case SIFIVE_U_PRCI_DEVICESRESET:
+        return s->devicesreset;
+    case SIFIVE_U_PRCI_CLKMUXSTATUS:
+        return s->clkmuxstatus;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
+
+    return 0;
+}
+
+static void sifive_u_prci_write(void *opaque, hwaddr addr,
+                                uint64_t val64, unsigned int size)
+{
+    SiFiveUPRCIState *s = opaque;
+    uint32_t val32 = (uint32_t)val64;
+
+    switch (addr) {
+    case SIFIVE_U_PRCI_HFXOSCCFG:
+        s->hfxosccfg = val32;
+        /* OSC stays ready */
+        s->hfxosccfg |= SIFIVE_U_PRCI_HFXOSCCFG_RDY;
+        break;
+    case SIFIVE_U_PRCI_COREPLLCFG0:
+        s->corepllcfg0 = val32;
+        /* internal feedback */
+        s->corepllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
+        /* PLL stays locked */
+        s->corepllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
+        break;
+    case SIFIVE_U_PRCI_DDRPLLCFG0:
+        s->ddrpllcfg0 = val32;
+        /* internal feedback */
+        s->ddrpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
+        /* PLL stays locked */
+        s->ddrpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
+        break;
+    case SIFIVE_U_PRCI_DDRPLLCFG1:
+        s->ddrpllcfg1 = val32;
+        break;
+    case SIFIVE_U_PRCI_GEMGXLPLLCFG0:
+        s->gemgxlpllcfg0 = val32;
+        /* internal feedback */
+        s->gemgxlpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
+        /* PLL stays locked */
+        s->gemgxlpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
+        break;
+    case SIFIVE_U_PRCI_GEMGXLPLLCFG1:
+        s->gemgxlpllcfg1 = val32;
+        break;
+    case SIFIVE_U_PRCI_CORECLKSEL:
+        s->coreclksel = val32;
+        break;
+    case SIFIVE_U_PRCI_DEVICESRESET:
+        s->devicesreset = val32;
+        break;
+    case SIFIVE_U_PRCI_CLKMUXSTATUS:
+        s->clkmuxstatus = val32;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%" HWADDR_PRIx
+                      " v=0x%x\n", __func__, addr, val32);
+    }
+}
+
+static const MemoryRegionOps sifive_u_prci_ops = {
+    .read = sifive_u_prci_read,
+    .write = sifive_u_prci_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static void sifive_u_prci_realize(DeviceState *dev, Error **errp)
+{
+    SiFiveUPRCIState *s = SIFIVE_U_PRCI(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_u_prci_ops, s,
+                          TYPE_SIFIVE_U_PRCI, SIFIVE_U_PRCI_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+}
+
+static void sifive_u_prci_reset(DeviceState *dev)
+{
+    SiFiveUPRCIState *s = SIFIVE_U_PRCI(dev);
+
+    /* Initialize register to power-on-reset values */
+    s->hfxosccfg = SIFIVE_U_PRCI_HFXOSCCFG_RDY | SIFIVE_U_PRCI_HFXOSCCFG_EN;
+    s->corepllcfg0 = SIFIVE_U_PRCI_PLLCFG0_DIVR | SIFIVE_U_PRCI_PLLCFG0_DIVF |
+                     SIFIVE_U_PRCI_PLLCFG0_DIVQ | SIFIVE_U_PRCI_PLLCFG0_FSE |
+                     SIFIVE_U_PRCI_PLLCFG0_LOCK;
+    s->ddrpllcfg0 = SIFIVE_U_PRCI_PLLCFG0_DIVR | SIFIVE_U_PRCI_PLLCFG0_DIVF |
+                    SIFIVE_U_PRCI_PLLCFG0_DIVQ | SIFIVE_U_PRCI_PLLCFG0_FSE |
+                    SIFIVE_U_PRCI_PLLCFG0_LOCK;
+    s->gemgxlpllcfg0 = SIFIVE_U_PRCI_PLLCFG0_DIVR | SIFIVE_U_PRCI_PLLCFG0_DIVF |
+                       SIFIVE_U_PRCI_PLLCFG0_DIVQ | SIFIVE_U_PRCI_PLLCFG0_FSE |
+                       SIFIVE_U_PRCI_PLLCFG0_LOCK;
+    s->coreclksel = SIFIVE_U_PRCI_CORECLKSEL_HFCLK;
+}
+
+static void sifive_u_prci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = sifive_u_prci_realize;
+    dc->reset = sifive_u_prci_reset;
+}
+
+static const TypeInfo sifive_u_prci_info = {
+    .name          = TYPE_SIFIVE_U_PRCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFiveUPRCIState),
+    .class_init    = sifive_u_prci_class_init,
+};
+
+static void sifive_u_prci_register_types(void)
+{
+    type_register_static(&sifive_u_prci_info);
+}
+
+type_init(sifive_u_prci_register_types)
diff --git a/include/hw/riscv/sifive_u_prci.h b/include/hw/riscv/sifive_u_prci.h
new file mode 100644
index 0000000000..60a2eab0e9
--- /dev/null
+++ b/include/hw/riscv/sifive_u_prci.h
@@ -0,0 +1,81 @@
+/*
+ * QEMU SiFive U PRCI (Power, Reset, Clock, Interrupt) interface
+ *
+ * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_SIFIVE_U_PRCI_H
+#define HW_SIFIVE_U_PRCI_H
+
+#define SIFIVE_U_PRCI_HFXOSCCFG     0x00
+#define SIFIVE_U_PRCI_COREPLLCFG0   0x04
+#define SIFIVE_U_PRCI_DDRPLLCFG0    0x0C
+#define SIFIVE_U_PRCI_DDRPLLCFG1    0x10
+#define SIFIVE_U_PRCI_GEMGXLPLLCFG0 0x1C
+#define SIFIVE_U_PRCI_GEMGXLPLLCFG1 0x20
+#define SIFIVE_U_PRCI_CORECLKSEL    0x24
+#define SIFIVE_U_PRCI_DEVICESRESET  0x28
+#define SIFIVE_U_PRCI_CLKMUXSTATUS  0x2C
+
+/*
+ * Current FU540-C000 manual says ready bit is at bit 29, but
+ * freedom-u540-c000-bootloader codes (ux00prci.h) says it is at bit 31.
+ * We have to trust the actual code that works.
+ *
+ * see https://github.com/sifive/freedom-u540-c000-bootloader
+ */
+
+#define SIFIVE_U_PRCI_HFXOSCCFG_EN  (1 << 30)
+#define SIFIVE_U_PRCI_HFXOSCCFG_RDY (1 << 31)
+
+/* xxxPLLCFG0 register bits */
+#define SIFIVE_U_PRCI_PLLCFG0_DIVR  (1 << 0)
+#define SIFIVE_U_PRCI_PLLCFG0_DIVF  (31 << 6)
+#define SIFIVE_U_PRCI_PLLCFG0_DIVQ  (3 << 15)
+#define SIFIVE_U_PRCI_PLLCFG0_FSE   (1 << 25)
+#define SIFIVE_U_PRCI_PLLCFG0_LOCK  (1 << 31)
+
+/* xxxPLLCFG1 register bits */
+#define SIFIVE_U_PRCI_PLLCFG1_CKE   (1 << 24)
+
+/* coreclksel register bits */
+#define SIFIVE_U_PRCI_CORECLKSEL_HFCLK  (1 << 0)
+
+
+#define SIFIVE_U_PRCI_REG_SIZE  0x1000
+
+#define TYPE_SIFIVE_U_PRCI      "riscv.sifive.u.prci"
+
+#define SIFIVE_U_PRCI(obj) \
+    OBJECT_CHECK(SiFiveUPRCIState, (obj), TYPE_SIFIVE_U_PRCI)
+
+typedef struct SiFiveUPRCIState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    uint32_t hfxosccfg;
+    uint32_t corepllcfg0;
+    uint32_t ddrpllcfg0;
+    uint32_t ddrpllcfg1;
+    uint32_t gemgxlpllcfg0;
+    uint32_t gemgxlpllcfg1;
+    uint32_t coreclksel;
+    uint32_t devicesreset;
+    uint32_t clkmuxstatus;
+} SiFiveUPRCIState;
+
+#endif /* HW_SIFIVE_U_PRCI_H */
-- 
2.21.0


