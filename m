Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F16C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA222087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obpXcAXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA222087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza9l-0002us-MR
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxq-0004yV-AO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxo-0007Lo-5k
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:18 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxn-0007Ib-TR; Mon, 19 Aug 2019 01:12:16 -0400
Received: by mail-pg1-x542.google.com with SMTP id n4so479881pgv.2;
 Sun, 18 Aug 2019 22:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=hwsDOFM9wmvxntg+3qjEvkGADgEwKM2RCT7gLTqielU=;
 b=obpXcAXXJEToLHsIgzCl3lNpqBMZFsTkTYhVguN0gd9bqm6uqyK9/U+2NGMDBq7RYu
 C8pKOj9p7zNjfZsVtWzqth9Q7Nt2kp7WZNkrXTyUfmb9IOu9z32Lx4HOhr87883xfAuH
 ibtuPrP6FIlGfq9ABi1td89O+t5uJtzUVx0Jg4EQ+pj+w3qDffbF8JoL25JPLe5qKqeL
 u0RyWk8OyQuEuCBt3pB4BXAXAgQYd5dwvv6+p7hK9IN2+m+yLOB8Q8jov9zUJSgdVfjB
 qw5uwp+vR6CCUMHtPsXKtPC1oqr5L31XF/U+ntSwgL8EIqSrMNqV7IHoioUn/1SVOzOb
 qXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=hwsDOFM9wmvxntg+3qjEvkGADgEwKM2RCT7gLTqielU=;
 b=OmBZxuCGMtOHS4MXnLjDoNnn2TjdV4hk6iIlO6hO3wfoZ/952nYWCuyx5jjVFVo8rk
 aRUf3PfomvqMGI7rRfHXwUueoN9a6tw2rzG2We92iN4oG9D6VTh8bXS/89PTC+afe3Gj
 xyK+EIH0StuPLiA2RcNszJ2cMDwgc3cTFk9bio/2uMQGaxb84SkxMDnNa1srir4F/wTS
 bI0kgHX0ce4nc9vwzlHjA4EvkQx9aEt2tnA0Z57hEUihiX2lvMNj18xpVsUj7Q1+1Y6L
 60HUeqoqoPA5YFiatMwY4oKmruFRdYzvX/THnvTdxMKdx3xUoBagTYSHqgprlQN5/J40
 A9CA==
X-Gm-Message-State: APjAAAUP2uMWuDUK3C0k407WYPlNMIki04f52WRTKHi9uAW/4dZwYQn+
 KN+6jxoAXRBDTMIr+5nxBfE=
X-Google-Smtp-Source: APXvYqyWTSs0bAHAXp+2hqiOAVVFBm+r79fpyzmLqx2+yGz7znbnL/8+Eu0odt7WcUzEa0J69V2eyw==
X-Received: by 2002:a65:5082:: with SMTP id r2mr17985736pgp.170.1566191534871; 
 Sun, 18 Aug 2019 22:12:14 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.13
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:14 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:40 -0700
Message-Id: <1566191521-7820-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v4 07/28] riscv: sifive: Rename sifive_prci.{c,
 h} to sifive_e_prci.{c, h}
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

Current SiFive PRCI model only works with sifive_e machine, as it
only emulates registers or PRCI block in the FE310 SoC.

Rename the file name to make it clear that it is for sifive_e.
This also prefix "sifive_e"/"SIFIVE_E" for all macros, variables
and functions.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>

---

Changes in v4:
- prefix all macros/variables/functions with SIFIVE_E/sifive_e
  in the sifive_e_prci driver

Changes in v3: None
Changes in v2: None

 hw/riscv/Makefile.objs                      |  2 +-
 hw/riscv/sifive_e.c                         |  4 +-
 hw/riscv/{sifive_prci.c => sifive_e_prci.c} | 79 ++++++++++++++---------------
 include/hw/riscv/sifive_e_prci.h            | 69 +++++++++++++++++++++++++
 include/hw/riscv/sifive_prci.h              | 69 -------------------------
 5 files changed, 111 insertions(+), 112 deletions(-)
 rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (50%)
 create mode 100644 include/hw/riscv/sifive_e_prci.h
 delete mode 100644 include/hw/riscv/sifive_prci.h

diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index eb9d4f9..c859697 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -2,9 +2,9 @@ obj-y += boot.o
 obj-$(CONFIG_SPIKE) += riscv_htif.o
 obj-$(CONFIG_HART) += riscv_hart.o
 obj-$(CONFIG_SIFIVE_E) += sifive_e.o
+obj-$(CONFIG_SIFIVE_E) += sifive_e_prci.o
 obj-$(CONFIG_SIFIVE) += sifive_clint.o
 obj-$(CONFIG_SIFIVE) += sifive_gpio.o
-obj-$(CONFIG_SIFIVE) += sifive_prci.o
 obj-$(CONFIG_SIFIVE) += sifive_plic.o
 obj-$(CONFIG_SIFIVE) += sifive_test.o
 obj-$(CONFIG_SIFIVE_U) += sifive_u.o
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 2a499d8..2d67670 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -41,9 +41,9 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
-#include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_e.h"
+#include "hw/riscv/sifive_e_prci.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
@@ -174,7 +174,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
-    sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
+    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
 
     /* GPIO */
 
diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_e_prci.c
similarity index 50%
rename from hw/riscv/sifive_prci.c
rename to hw/riscv/sifive_e_prci.c
index f406682..e87a3ce 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -1,5 +1,5 @@
 /*
- * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt)
+ * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt)
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
@@ -22,46 +22,46 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
-#include "hw/riscv/sifive_prci.h"
+#include "hw/riscv/sifive_e_prci.h"
 
-static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
+static uint64_t sifive_e_prci_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    SiFivePRCIState *s = opaque;
+    SiFiveEPRCIState *s = opaque;
     switch (addr) {
-    case SIFIVE_PRCI_HFROSCCFG:
+    case SIFIVE_E_PRCI_HFROSCCFG:
         return s->hfrosccfg;
-    case SIFIVE_PRCI_HFXOSCCFG:
+    case SIFIVE_E_PRCI_HFXOSCCFG:
         return s->hfxosccfg;
-    case SIFIVE_PRCI_PLLCFG:
+    case SIFIVE_E_PRCI_PLLCFG:
         return s->pllcfg;
-    case SIFIVE_PRCI_PLLOUTDIV:
+    case SIFIVE_E_PRCI_PLLOUTDIV:
         return s->plloutdiv;
     }
     hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);
     return 0;
 }
 
-static void sifive_prci_write(void *opaque, hwaddr addr,
-           uint64_t val64, unsigned int size)
+static void sifive_e_prci_write(void *opaque, hwaddr addr,
+                                uint64_t val64, unsigned int size)
 {
-    SiFivePRCIState *s = opaque;
+    SiFiveEPRCIState *s = opaque;
     switch (addr) {
-    case SIFIVE_PRCI_HFROSCCFG:
+    case SIFIVE_E_PRCI_HFROSCCFG:
         s->hfrosccfg = (uint32_t) val64;
         /* OSC stays ready */
-        s->hfrosccfg |= SIFIVE_PRCI_HFROSCCFG_RDY;
+        s->hfrosccfg |= SIFIVE_E_PRCI_HFROSCCFG_RDY;
         break;
-    case SIFIVE_PRCI_HFXOSCCFG:
+    case SIFIVE_E_PRCI_HFXOSCCFG:
         s->hfxosccfg = (uint32_t) val64;
         /* OSC stays ready */
-        s->hfxosccfg |= SIFIVE_PRCI_HFXOSCCFG_RDY;
+        s->hfxosccfg |= SIFIVE_E_PRCI_HFXOSCCFG_RDY;
         break;
-    case SIFIVE_PRCI_PLLCFG:
+    case SIFIVE_E_PRCI_PLLCFG:
         s->pllcfg = (uint32_t) val64;
         /* PLL stays locked */
-        s->pllcfg |= SIFIVE_PRCI_PLLCFG_LOCK;
+        s->pllcfg |= SIFIVE_E_PRCI_PLLCFG_LOCK;
         break;
-    case SIFIVE_PRCI_PLLOUTDIV:
+    case SIFIVE_E_PRCI_PLLOUTDIV:
         s->plloutdiv = (uint32_t) val64;
         break;
     default:
@@ -70,9 +70,9 @@ static void sifive_prci_write(void *opaque, hwaddr addr,
     }
 }
 
-static const MemoryRegionOps sifive_prci_ops = {
-    .read = sifive_prci_read,
-    .write = sifive_prci_write,
+static const MemoryRegionOps sifive_e_prci_ops = {
+    .read = sifive_e_prci_read,
+    .write = sifive_e_prci_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 4,
@@ -80,43 +80,42 @@ static const MemoryRegionOps sifive_prci_ops = {
     }
 };
 
-static void sifive_prci_init(Object *obj)
+static void sifive_e_prci_init(Object *obj)
 {
-    SiFivePRCIState *s = SIFIVE_PRCI(obj);
+    SiFiveEPRCIState *s = SIFIVE_E_PRCI(obj);
 
-    memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
-                          TYPE_SIFIVE_PRCI, 0x8000);
+    memory_region_init_io(&s->mmio, obj, &sifive_e_prci_ops, s,
+                          TYPE_SIFIVE_E_PRCI, 0x8000);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
-    s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
-    s->hfxosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
-    s->pllcfg = (SIFIVE_PRCI_PLLCFG_REFSEL | SIFIVE_PRCI_PLLCFG_BYPASS |
-                SIFIVE_PRCI_PLLCFG_LOCK);
-    s->plloutdiv = SIFIVE_PRCI_PLLOUTDIV_DIV1;
-
+    s->hfrosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
+    s->hfxosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
+    s->pllcfg = (SIFIVE_E_PRCI_PLLCFG_REFSEL | SIFIVE_E_PRCI_PLLCFG_BYPASS |
+                 SIFIVE_E_PRCI_PLLCFG_LOCK);
+    s->plloutdiv = SIFIVE_E_PRCI_PLLOUTDIV_DIV1;
 }
 
-static const TypeInfo sifive_prci_info = {
-    .name          = TYPE_SIFIVE_PRCI,
+static const TypeInfo sifive_e_prci_info = {
+    .name          = TYPE_SIFIVE_E_PRCI,
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SiFivePRCIState),
-    .instance_init = sifive_prci_init,
+    .instance_size = sizeof(SiFiveEPRCIState),
+    .instance_init = sifive_e_prci_init,
 };
 
-static void sifive_prci_register_types(void)
+static void sifive_e_prci_register_types(void)
 {
-    type_register_static(&sifive_prci_info);
+    type_register_static(&sifive_e_prci_info);
 }
 
-type_init(sifive_prci_register_types)
+type_init(sifive_e_prci_register_types)
 
 
 /*
  * Create PRCI device.
  */
-DeviceState *sifive_prci_create(hwaddr addr)
+DeviceState *sifive_e_prci_create(hwaddr addr)
 {
-    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_PRCI);
+    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_E_PRCI);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     return dev;
diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/riscv/sifive_e_prci.h
new file mode 100644
index 0000000..c4b76aa
--- /dev/null
+++ b/include/hw/riscv/sifive_e_prci.h
@@ -0,0 +1,69 @@
+/*
+ * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt) interface
+ *
+ * Copyright (c) 2017 SiFive, Inc.
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
+#ifndef HW_SIFIVE_E_PRCI_H
+#define HW_SIFIVE_E_PRCI_H
+
+enum {
+    SIFIVE_E_PRCI_HFROSCCFG = 0x0,
+    SIFIVE_E_PRCI_HFXOSCCFG = 0x4,
+    SIFIVE_E_PRCI_PLLCFG    = 0x8,
+    SIFIVE_E_PRCI_PLLOUTDIV = 0xC
+};
+
+enum {
+    SIFIVE_E_PRCI_HFROSCCFG_RDY = (1 << 31),
+    SIFIVE_E_PRCI_HFROSCCFG_EN  = (1 << 30)
+};
+
+enum {
+    SIFIVE_E_PRCI_HFXOSCCFG_RDY = (1 << 31),
+    SIFIVE_E_PRCI_HFXOSCCFG_EN  = (1 << 30)
+};
+
+enum {
+    SIFIVE_E_PRCI_PLLCFG_PLLSEL = (1 << 16),
+    SIFIVE_E_PRCI_PLLCFG_REFSEL = (1 << 17),
+    SIFIVE_E_PRCI_PLLCFG_BYPASS = (1 << 18),
+    SIFIVE_E_PRCI_PLLCFG_LOCK   = (1 << 31)
+};
+
+enum {
+    SIFIVE_E_PRCI_PLLOUTDIV_DIV1 = (1 << 8)
+};
+
+#define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
+
+#define SIFIVE_E_PRCI(obj) \
+    OBJECT_CHECK(SiFiveEPRCIState, (obj), TYPE_SIFIVE_E_PRCI)
+
+typedef struct SiFiveEPRCIState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    uint32_t hfrosccfg;
+    uint32_t hfxosccfg;
+    uint32_t pllcfg;
+    uint32_t plloutdiv;
+} SiFiveEPRCIState;
+
+DeviceState *sifive_e_prci_create(hwaddr addr);
+
+#endif
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_prci.h
deleted file mode 100644
index bd51c4a..0000000
--- a/include/hw/riscv/sifive_prci.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt) interface
- *
- * Copyright (c) 2017 SiFive, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef HW_SIFIVE_PRCI_H
-#define HW_SIFIVE_PRCI_H
-
-enum {
-    SIFIVE_PRCI_HFROSCCFG   = 0x0,
-    SIFIVE_PRCI_HFXOSCCFG   = 0x4,
-    SIFIVE_PRCI_PLLCFG      = 0x8,
-    SIFIVE_PRCI_PLLOUTDIV   = 0xC
-};
-
-enum {
-    SIFIVE_PRCI_HFROSCCFG_RDY   = (1 << 31),
-    SIFIVE_PRCI_HFROSCCFG_EN    = (1 << 30)
-};
-
-enum {
-    SIFIVE_PRCI_HFXOSCCFG_RDY   = (1 << 31),
-    SIFIVE_PRCI_HFXOSCCFG_EN    = (1 << 30)
-};
-
-enum {
-    SIFIVE_PRCI_PLLCFG_PLLSEL   = (1 << 16),
-    SIFIVE_PRCI_PLLCFG_REFSEL   = (1 << 17),
-    SIFIVE_PRCI_PLLCFG_BYPASS   = (1 << 18),
-    SIFIVE_PRCI_PLLCFG_LOCK     = (1 << 31)
-};
-
-enum {
-    SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
-};
-
-#define TYPE_SIFIVE_PRCI "riscv.sifive.prci"
-
-#define SIFIVE_PRCI(obj) \
-    OBJECT_CHECK(SiFivePRCIState, (obj), TYPE_SIFIVE_PRCI)
-
-typedef struct SiFivePRCIState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-
-    /*< public >*/
-    MemoryRegion mmio;
-    uint32_t hfrosccfg;
-    uint32_t hfxosccfg;
-    uint32_t pllcfg;
-    uint32_t plloutdiv;
-} SiFivePRCIState;
-
-DeviceState *sifive_prci_create(hwaddr addr);
-
-#endif
-- 
2.7.4


