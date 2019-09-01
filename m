Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92523C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C87121874
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY44b1vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C87121874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GDP-0004Bm-B8
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzs-0007ir-D7
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzo-0006hZ-U0
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzo-0006fI-LE; Sat, 31 Aug 2019 22:53:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id o3so5029670plb.13;
 Sat, 31 Aug 2019 19:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=0i/Q3kM4jZmOQ6Hg+5v/0ykFeVQzqZJhOTarCEnNoRg=;
 b=QY44b1vSu+4FtCy6bQPPcbJurlGk5b1YnBxaYuBQohwSWZwk86lU13ju7TYrxmFor9
 aOVF3YesVsGLrqA+vtTtY+1NdXNOux8V8c8cRtBIIEoczvRGDQArvRUvZ8hwpoYHfljx
 M51N6+V/YjqcnIoGjEswpzRLbWUT5Ehj9RqDRx7gtO77JeFpaSmNvNczcS4RCNPfZ8MU
 ElPTaBmP1qjf3xWrBF5FKUzfYiBRd7+SXMuYPAZFmWI+kFEXqfVo9GKmcSbn90vebSV1
 3F/srPscvHWu1ENEFLjBTd24DfWWxkWwb8Fgmw8hB/CydtwRwgIQURLs7WDZ4O98+ot3
 4kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=0i/Q3kM4jZmOQ6Hg+5v/0ykFeVQzqZJhOTarCEnNoRg=;
 b=fouiKuF0QTaDEJw6izcZThwyXpoFD6ruguIkGopti7qk6LJgIE2LpzHml+fdEQxOQ+
 CNyr1q2lGuAmyIbk16gK28hzjq/9olEA0K1ZiMf7AqU/V5jvtHmfYMxztzj6JOPjDdnP
 G0V7OZYYCXItdVKTLjn7ZAoNzbNNUuUz+PqhYnm6ffRT4Se8+jF6BSZR57/RD3j6ca+I
 9x0kXqN6hms0Ep8tYJtDhLJSSWOuEejj579P4Dl6AjxA+LEgj2E6P25GN5kJg3eexFyC
 IAEbI+NdMZzxtudCBmlH8JaspoGekpYfUcZyDfXijp+PKgxS23HQ4aoM3c6G4M3bC053
 eYTw==
X-Gm-Message-State: APjAAAUMx2NF6QXJe3n9CHCtkpwlQ9O21/sBrMHO2W4SiTvMWeiaAwKF
 HXKT3Z66hcBeXis1kh4BJ90=
X-Google-Smtp-Source: APXvYqzKkGj1TIrgWNrSjG9ANstMUurroS0PuCaqGVVDyFKW3hL28hthnx9HqC54IyRniD5XavcEDw==
X-Received: by 2002:a17:902:1024:: with SMTP id
 b33mr23989792pla.325.1567306419622; 
 Sat, 31 Aug 2019 19:53:39 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.38
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:38 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:53:00 -0700
Message-Id: <1567306391-2682-20-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 19/30] riscv: sifive: Implement PRCI model
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v7: None
Changes in v6:
- fix incorrectly indented comment lines
- remove unneeded brackets around assignment

Changes in v5:
- change to use defines instead of enums
- change to use qemu_log_mask(LOG_GUEST_ERROR,...) in sifive_u_prci
- creating a 32-bit val variable and using that instead of casting
  everywhere in sifive_u_prci_write()
- move all register initialization to sifive_u_prci_reset() function
- drop sifive_u_prci_create()
- s/codes that worked/code that works/g

Changes in v4:
- prefix all macros/variables/functions with SIFIVE_U/sifive_u
  in the sifive_u_prci driver

Changes in v3: None
Changes in v2: None

 hw/riscv/Makefile.objs           |   1 +
 hw/riscv/sifive_u_prci.c         | 169 +++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_prci.h |  81 +++++++++++++++++++
 3 files changed, 251 insertions(+)
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
index 0000000..ade2a1c
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
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%x\n",
+                  __func__, (int)addr);
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
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
+                      __func__, (int)addr, (int)val64);
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
index 0000000..60a2eab
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
2.7.4


