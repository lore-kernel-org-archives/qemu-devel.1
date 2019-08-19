Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF910C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35052087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7hOFQyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35052087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzaG9-0002eo-Qu
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZy2-0005FU-6h
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxz-00083v-TA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:30 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxy-0007wO-Mp; Mon, 19 Aug 2019 01:12:27 -0400
Received: by mail-pg1-x543.google.com with SMTP id l21so477302pgm.3;
 Sun, 18 Aug 2019 22:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=AEACQ0YfVs7DR0q5IyIIsqldEXVTHPRPqrZ1CcOkJPM=;
 b=j7hOFQyvXj8m7oDjHoWisLs9hKJL+3OaYx3Eq5LuqTdjMdK7b3SPoQRy3hG0XcxIds
 kF1qhAyRWZfNf753QLajiLS5+IWCSGeg3iVKqDtdLH23pOW9xedhAYKtwX/y1TZrMupX
 gjIz6l2qBdj0Y+F5XrcGqOsyLyAjQhZFo1kBwYmfE42A7cfVB7zfNH/RYIKSKr3lefBJ
 BftghMRRCTmOpsWvZfzCB6OCgCa4H8s6xzxJ/YoMAAfgleUZ5JN/zQKszj4jrbyMhqbo
 Xbi03Qrqew4s337dazpPMIlb4lGUD2LgGGH5gaY3JGmJB7h/tEj4FvalsERPjp3H/l4l
 zHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=AEACQ0YfVs7DR0q5IyIIsqldEXVTHPRPqrZ1CcOkJPM=;
 b=hODtEoV/gRVvxDJvTowEP8Uf4cp7KvYJ/f3tVQ6kPHLphckRnp/+a5fSMAXv1yc8uJ
 A/pVFp0p9CsGMibzJO/E3qpsj997Fbbx5yvejsmvsIl8rRncFT/Uz8DUwNI1P4jjDiLm
 cPfaaoFg75rNI5HsBFA1hodkhFq5n5emA/K4zoBpNqeZb1V5A9g0EQ/8C6HLMUwI60vP
 RZqJvWfSvOOh5QYbl/1xQ5hK5DXZXN+rbDhK/l27tXr+sTJw3g0mekMmVEsEOTHysCWJ
 usDe41eHVVbzm9vrApseDlpWjWbmiiB95bXzjWhQO/E4JNsasSv7XDEMzZVOm8NjdVL7
 TagA==
X-Gm-Message-State: APjAAAWGVcIwkksYpHZJcusxQZBg9Gse7ez/mOkYJRKerhsMIlNydFa7
 kI5FHAJJ+ZB9UcLi8/5z3Cc=
X-Google-Smtp-Source: APXvYqz8hX205qROvFgWCHgJuQc0PkOowkjwNxBAb3LxXwHWh4VBtG1MYk9NVbGyn22HX92JasigsA==
X-Received: by 2002:a63:ec48:: with SMTP id r8mr17502745pgj.387.1566191545506; 
 Sun, 18 Aug 2019 22:12:25 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.24
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:24 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:50 -0700
Message-Id: <1566191521-7820-18-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v4 17/28] riscv: sifive: Implement PRCI model
 for FU540
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

This adds a simple PRCI model for FU540 (sifive_u). It has different
register layout from the existing PRCI model for FE310 (sifive_e).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v4:
- prefix all macros/variables/functions with SIFIVE_U/sifive_u
  in the sifive_u_prci driver

Changes in v3: None
Changes in v2: None

 hw/riscv/Makefile.objs           |   1 +
 hw/riscv/sifive_u_prci.c         | 165 +++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_prci.h |  90 +++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 hw/riscv/sifive_u_prci.c
 create mode 100644 include/hw/riscv/sifive_u_prci.h

diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index c859697..b95bbd5 100644
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
index 0000000..578c643
--- /dev/null
+++ b/hw/riscv/sifive_u_prci.c
@@ -0,0 +1,165 @@
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
+#include "qemu/module.h"
+#include "target/riscv/cpu.h"
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
+    hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);
+    return 0;
+}
+
+static void sifive_u_prci_write(void *opaque, hwaddr addr,
+                                uint64_t val64, unsigned int size)
+{
+    SiFiveUPRCIState *s = opaque;
+
+    switch (addr) {
+    case SIFIVE_U_PRCI_HFXOSCCFG:
+        s->hfxosccfg = (uint32_t) val64;
+        /* OSC stays ready */
+        s->hfxosccfg |= SIFIVE_U_PRCI_HFXOSCCFG_RDY;
+        break;
+    case SIFIVE_U_PRCI_COREPLLCFG0:
+        s->corepllcfg0 = (uint32_t) val64;
+        /* internal feedback */
+        s->corepllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
+        /* PLL stays locked */
+        s->corepllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
+        break;
+    case SIFIVE_U_PRCI_DDRPLLCFG0:
+        s->ddrpllcfg0 = (uint32_t) val64;
+        /* internal feedback */
+        s->ddrpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
+        /* PLL stays locked */
+        s->ddrpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
+        break;
+    case SIFIVE_U_PRCI_DDRPLLCFG1:
+        s->ddrpllcfg1 = (uint32_t) val64;
+        break;
+    case SIFIVE_U_PRCI_GEMGXLPLLCFG0:
+        s->gemgxlpllcfg0 = (uint32_t) val64;
+         /* internal feedback */
+        s->gemgxlpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_FSE;
+       /* PLL stays locked */
+        s->gemgxlpllcfg0 |= SIFIVE_U_PRCI_PLLCFG0_LOCK;
+        break;
+    case SIFIVE_U_PRCI_GEMGXLPLLCFG1:
+        s->gemgxlpllcfg1 = (uint32_t) val64;
+        break;
+    case SIFIVE_U_PRCI_CORECLKSEL:
+        s->coreclksel = (uint32_t) val64;
+        break;
+    case SIFIVE_U_PRCI_DEVICESRESET:
+        s->devicesreset = (uint32_t) val64;
+        break;
+    case SIFIVE_U_PRCI_CLKMUXSTATUS:
+        s->clkmuxstatus = (uint32_t) val64;
+        break;
+    default:
+        hw_error("%s: bad write: addr=0x%x v=0x%x\n",
+                 __func__, (int)addr, (int)val64);
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
+static void sifive_u_prci_init(Object *obj)
+{
+    SiFiveUPRCIState *s = SIFIVE_U_PRCI(obj);
+
+    memory_region_init_io(&s->mmio, obj, &sifive_u_prci_ops, s,
+                          TYPE_SIFIVE_U_PRCI, SIFIVE_U_PRCI_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    /* Initialize register to power-on-reset values */
+    s->hfxosccfg = (SIFIVE_U_PRCI_HFXOSCCFG_RDY | SIFIVE_U_PRCI_HFXOSCCFG_EN);
+    s->corepllcfg0 = (SIFIVE_U_PRCI_PLLCFG0_DIVR | SIFIVE_U_PRCI_PLLCFG0_DIVF |
+                      SIFIVE_U_PRCI_PLLCFG0_DIVQ | SIFIVE_U_PRCI_PLLCFG0_FSE |
+                      SIFIVE_U_PRCI_PLLCFG0_LOCK);
+    s->ddrpllcfg0 = (SIFIVE_U_PRCI_PLLCFG0_DIVR | SIFIVE_U_PRCI_PLLCFG0_DIVF |
+                     SIFIVE_U_PRCI_PLLCFG0_DIVQ | SIFIVE_U_PRCI_PLLCFG0_FSE |
+                     SIFIVE_U_PRCI_PLLCFG0_LOCK);
+    s->gemgxlpllcfg0 = (SIFIVE_U_PRCI_PLLCFG0_DIVR |
+                        SIFIVE_U_PRCI_PLLCFG0_DIVF |
+                        SIFIVE_U_PRCI_PLLCFG0_DIVQ |
+                        SIFIVE_U_PRCI_PLLCFG0_FSE |
+                        SIFIVE_U_PRCI_PLLCFG0_LOCK);
+    s->coreclksel = SIFIVE_U_PRCI_CORECLKSEL_HFCLK;
+}
+
+static const TypeInfo sifive_u_prci_info = {
+    .name          = TYPE_SIFIVE_U_PRCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFiveUPRCIState),
+    .instance_init = sifive_u_prci_init,
+};
+
+static void sifive_u_prci_register_types(void)
+{
+    type_register_static(&sifive_u_prci_info);
+}
+
+type_init(sifive_u_prci_register_types)
+
+
+/* Create PRCI device */
+DeviceState *sifive_u_prci_create(hwaddr addr)
+{
+    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_U_PRCI);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    return dev;
+}
diff --git a/include/hw/riscv/sifive_u_prci.h b/include/hw/riscv/sifive_u_prci.h
new file mode 100644
index 0000000..66eacb5
--- /dev/null
+++ b/include/hw/riscv/sifive_u_prci.h
@@ -0,0 +1,90 @@
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
+enum {
+    SIFIVE_U_PRCI_HFXOSCCFG     = 0x00,
+    SIFIVE_U_PRCI_COREPLLCFG0   = 0x04,
+    SIFIVE_U_PRCI_DDRPLLCFG0    = 0x0C,
+    SIFIVE_U_PRCI_DDRPLLCFG1    = 0x10,
+    SIFIVE_U_PRCI_GEMGXLPLLCFG0 = 0x1C,
+    SIFIVE_U_PRCI_GEMGXLPLLCFG1 = 0x20,
+    SIFIVE_U_PRCI_CORECLKSEL    = 0x24,
+    SIFIVE_U_PRCI_DEVICESRESET  = 0x28,
+    SIFIVE_U_PRCI_CLKMUXSTATUS  = 0x2C
+};
+
+/*
+ * Current FU540-C000 manual says ready bit is at bit 29, but
+ * freedom-u540-c000-bootloader codes (ux00prci.h) says it is at bit 31.
+ * We have to trust the actual codes that worked.
+ *
+ * see https://github.com/sifive/freedom-u540-c000-bootloader
+ */
+enum {
+    SIFIVE_U_PRCI_HFXOSCCFG_EN  = (1 << 30),
+    SIFIVE_U_PRCI_HFXOSCCFG_RDY = (1 << 31),
+};
+
+/* xxxPLLCFG0 register bits */
+enum {
+    SIFIVE_U_PRCI_PLLCFG0_DIVR  = (1 << 0),
+    SIFIVE_U_PRCI_PLLCFG0_DIVF  = (31 << 6),
+    SIFIVE_U_PRCI_PLLCFG0_DIVQ  = (3 << 15),
+    SIFIVE_U_PRCI_PLLCFG0_FSE   = (1 << 25),
+    SIFIVE_U_PRCI_PLLCFG0_LOCK  = (1 << 31)
+};
+
+/* xxxPLLCFG1 register bits */
+enum {
+    SIFIVE_U_PRCI_PLLCFG1_CKE   = (1 << 24)
+};
+
+enum {
+    SIFIVE_U_PRCI_CORECLKSEL_HFCLK = (1 << 0)
+};
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
+DeviceState *sifive_u_prci_create(hwaddr addr);
+
+#endif /* HW_SIFIVE_U_PRCI_H */
-- 
2.7.4


