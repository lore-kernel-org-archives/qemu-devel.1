Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C96C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 02:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE422190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 02:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbCwuk/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE422190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4G2k-0001Qs-AD
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 22:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzg-0007cG-1p
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzd-0006P5-Tp
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:31 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzd-0006No-MW; Sat, 31 Aug 2019 22:53:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id az1so4092938plb.6;
 Sat, 31 Aug 2019 19:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=3gPXuF8DTtQY+sieWCstJKIb4KmsuKA2RH20YnVdJmE=;
 b=ZbCwuk/1oFpTu+FqSK4gy3tcPxLsaBWCgTZz0biNzaFdRZst9ZSrdapBijAnRbX9Eg
 XVotTpogSIatg+ak96OUP2YFhWHzVT89csJviJpJMMFSpUKzGEoP90DD9MFZ+4keDd4d
 0o5vlZGhLYZTg0vwNyVLS4GK460X1nkyiX+kpabVwCfhXR16VoXOmy7v24iXDShWCPo7
 wqKKW4Qj+kD7UL7iINuCG98NNylOxVaM1KTwSAZxWVfGAyyrlfhFgV6lqReJMBDQUG31
 CDseqAqwYYb/RD+UaLXkhMQjvdH4l5imOnuEkVLLPtjuQD7Ryy5I4lVMuJTJ4P2h6Cwa
 danw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=3gPXuF8DTtQY+sieWCstJKIb4KmsuKA2RH20YnVdJmE=;
 b=i9ij789/H5KMnjBQKLvhiERnfB6FTukYmePxNFyr7Gi/WaKUBWBjIO05rAy1AFc+va
 +F95sBRXdoblt5oaRlsrYi+y1QoPg1FXtvGvNoEU6Kw+lPi/rUzklH6XYlv+XNii+fgo
 yQ+V0SiBjJof2UAP05p9BzQXa/nd0XWWnxVcprm3JXUVkPG47ptukEe4Xvo5g1jIzBLk
 bqWH9hPO30DYMnUrYb82fBZxkgtwUkx0Qo2MBRdIaP4joIS/AJlCW0IRXV6YUzxhGT+R
 tCOGtqqtuJ6jPHEQFdC41LA4kzA3V7fgnVzY1+HtD10DtSz4GPmAfKiEJaLemFaT0ydO
 wCVA==
X-Gm-Message-State: APjAAAVY52D/UYSnpe5oKui7omlam1JU3bYdmbYrB3dug5PAX5eI62AU
 zm9SqZ0rDh+3Fx7mF3pz2Ww=
X-Google-Smtp-Source: APXvYqx2sz3tgc3OCdNtgVbS5lHJvcB4FagFCVQSHywRq9JQrRWMZDa4mpymSDXZ3gr4CojAXeZ6EA==
X-Received: by 2002:a17:902:e407:: with SMTP id
 ci7mr23873370plb.326.1567306408654; 
 Sat, 31 Aug 2019 19:53:28 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.27
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:27 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:50 -0700
Message-Id: <1567306391-2682-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v7 09/30] riscv: sifive: Rename sifive_prci.{c,
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v7: None
Changes in v6: None
Changes in v5: None
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
 rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (51%)
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
similarity index 51%
rename from hw/riscv/sifive_prci.c
rename to hw/riscv/sifive_e_prci.c
index 1957dcd..c514032 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -1,5 +1,5 @@
 /*
- * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt)
+ * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt)
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
@@ -22,19 +22,19 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
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
     qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%x\n",
@@ -42,27 +42,27 @@ static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
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
@@ -71,9 +71,9 @@ static void sifive_prci_write(void *opaque, hwaddr addr,
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
@@ -81,43 +81,42 @@ static const MemoryRegionOps sifive_prci_ops = {
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


