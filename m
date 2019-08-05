Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B03C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4A82064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyLp9KQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4A82064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufVo-0003Et-Uw
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPe-0000TA-HV
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPc-0002ty-UC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:42 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPc-0002t8-O4; Mon, 05 Aug 2019 12:00:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id n4so4697513pgv.2;
 Mon, 05 Aug 2019 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=T4gWEqheZIhtcDwxIpXs5RA7DpA9pCq5dzxWFGrTfvE=;
 b=UyLp9KQfc/MVd4gsQy4vQYKIvfuBYhFDD5SzWi9VvUKcqsAKoV7bsfNbynpx8m8gb/
 sbJCaH6iCAX8mqwm5Ce5V6VLEHm7Jj6dWxhCYqjstuhNm59jDucdVTduVroK9/JYSXj1
 7rooElJNMeHtLwNkOSF88XzqYS6gB0jy0z2Hl6FnA98eW58qlCc9m7DCWjoy63lytGij
 7//n9WBF+Tg+xRV3SWPYI/6tdH6pTjdtl7ZFDMWxt/om9zAvrGI5G9sgq8a73YHkO32W
 mNzGkybt7iHtnyCP4SSmtrcCGnuJTpDgt5TqaQvkgaxkJLdgxP4VANGjuV5gd3DBsBYz
 Pvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=T4gWEqheZIhtcDwxIpXs5RA7DpA9pCq5dzxWFGrTfvE=;
 b=UAQF18jqd45sEi8zYSx5kz2Dh2NK+CYXN2bbAbdokafuNXBraPebwsR3rt79KY+BzF
 Mcp9HQDvJZSF/XCwPvu9FY7xfSJp3mKP0fp3tCrFwuU8KzCecHLOZ00ULEPZpCkp4uOh
 aZRJzN8KGcNzWKk3ppmVaKB6jS4dXwkEQaX1Spv+OHZHhTTdhl26ZoLgUjACIjMXNKIY
 rHdJEdfsRbKTae9w1v6F+PFk3L/Tcxj1Ss+Km5DUIzA/rOsDNjWw01VuZq1tEOVMPpFF
 dhGFPIzkoJ3tAj8DbsCMS89ot4K0cvN/rDnPLCR4KW4MrYiqPDb7vM6FUV/wJrazj8og
 aSrg==
X-Gm-Message-State: APjAAAWgkbdfxWCBqaL/sW7DCuyjGZcril5cjM+IBnkm1T0PetYi/RKc
 zvBkKcULI76L02+HF0fq92w=
X-Google-Smtp-Source: APXvYqwud1n6taQWJ0ssBASDFSWWp4uz+YLNBEIR1h7PwAeGjNcPNxrij3yUYCICq9uJ5F4x0Fw2Bg==
X-Received: by 2002:a62:e315:: with SMTP id g21mr75883388pfh.225.1565020839923; 
 Mon, 05 Aug 2019 09:00:39 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.38
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:39 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:06 -0700
Message-Id: <1565020823-24223-12-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 11/28] riscv: sifive: Rename sifive_prci.{c,
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

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/Makefile.objs                              |  2 +-
 hw/riscv/sifive_e.c                                 |  4 ++--
 hw/riscv/{sifive_prci.c => sifive_e_prci.c}         | 14 +++++++-------
 include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} | 14 +++++++-------
 4 files changed, 17 insertions(+), 17 deletions(-)
 rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (90%)
 rename include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} (82%)

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
similarity index 90%
rename from hw/riscv/sifive_prci.c
rename to hw/riscv/sifive_e_prci.c
index f406682..acb914d 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -1,5 +1,5 @@
 /*
- * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt)
+ * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt)
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
@@ -22,7 +22,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
-#include "hw/riscv/sifive_prci.h"
+#include "hw/riscv/sifive_e_prci.h"
 
 static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -82,10 +82,10 @@ static const MemoryRegionOps sifive_prci_ops = {
 
 static void sifive_prci_init(Object *obj)
 {
-    SiFivePRCIState *s = SIFIVE_PRCI(obj);
+    SiFivePRCIState *s = SIFIVE_E_PRCI(obj);
 
     memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
-                          TYPE_SIFIVE_PRCI, 0x8000);
+                          TYPE_SIFIVE_E_PRCI, 0x8000);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
@@ -97,7 +97,7 @@ static void sifive_prci_init(Object *obj)
 }
 
 static const TypeInfo sifive_prci_info = {
-    .name          = TYPE_SIFIVE_PRCI,
+    .name          = TYPE_SIFIVE_E_PRCI,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SiFivePRCIState),
     .instance_init = sifive_prci_init,
@@ -114,9 +114,9 @@ type_init(sifive_prci_register_types)
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
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_e_prci.h
similarity index 82%
rename from include/hw/riscv/sifive_prci.h
rename to include/hw/riscv/sifive_e_prci.h
index bd51c4a..7932fe7 100644
--- a/include/hw/riscv/sifive_prci.h
+++ b/include/hw/riscv/sifive_e_prci.h
@@ -1,5 +1,5 @@
 /*
- * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt) interface
+ * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt) interface
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
@@ -16,8 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HW_SIFIVE_PRCI_H
-#define HW_SIFIVE_PRCI_H
+#ifndef HW_SIFIVE_E_PRCI_H
+#define HW_SIFIVE_E_PRCI_H
 
 enum {
     SIFIVE_PRCI_HFROSCCFG   = 0x0,
@@ -47,10 +47,10 @@ enum {
     SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
 };
 
-#define TYPE_SIFIVE_PRCI "riscv.sifive.prci"
+#define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
 
-#define SIFIVE_PRCI(obj) \
-    OBJECT_CHECK(SiFivePRCIState, (obj), TYPE_SIFIVE_PRCI)
+#define SIFIVE_E_PRCI(obj) \
+    OBJECT_CHECK(SiFivePRCIState, (obj), TYPE_SIFIVE_E_PRCI)
 
 typedef struct SiFivePRCIState {
     /*< private >*/
@@ -64,6 +64,6 @@ typedef struct SiFivePRCIState {
     uint32_t plloutdiv;
 } SiFivePRCIState;
 
-DeviceState *sifive_prci_create(hwaddr addr);
+DeviceState *sifive_e_prci_create(hwaddr addr);
 
 #endif
-- 
2.7.4


