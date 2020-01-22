Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BACC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D66D2465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxFO1QrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D66D2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5rC-0002Sf-Fg
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pL-0000hn-76
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pH-0001jK-LH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:07 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu5pH-0001iw-Du
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:03 -0500
Received: by mail-pj1-x1043.google.com with SMTP id s94so1514091pjc.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xfvVMl489iCh1aQTVlahIVDKwKd8nPWhtAysKtwW+lo=;
 b=pxFO1QrMe8ZeRH4IceujXtr15ctSUNKgXTYvX2zno/nGWCtJbsriXjPR6DOwujHsA3
 t4GNjIodvw6WrT2dCF/ZsFrrUnWa6Kd/sf251x7BrpAk6ru5SSbjGmLIgPyLb6PUOrA4
 b3NFEgTHxoXvTTQlzusXSFyThqv2aEag7tDLH8D+15ZwnIWuOHfUygodmIpbhhGXkR2q
 AdlqfON4blfFFzM6yqVmfPQChpg9gAhDjgtqJ/KALxqI5YFG8dS1gJqpic8qIhaOLf0s
 /dKfJba0Dx07SrZl2/DZwJBcFskXMO3IlWpNumosyCv45ejlbSHFJRq9T9pTZrKnWB+F
 gySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xfvVMl489iCh1aQTVlahIVDKwKd8nPWhtAysKtwW+lo=;
 b=jarTCAM6gvz0UxH0tghzE5kw6WGPedfGxvIDNrFY+rBaAL9L8/kkxbJnifPH2RpbAy
 skBN40YkU5VbsY1BeDawcqwzwYfipuKKRhSAPTtHV41hGr2y0wf+hk2YjgH7/p5dRHqO
 rs3+08MfGbdjqffN2VL2klMlYjl3o6mIaYwjnkMM9smDvo2q0Iu8HEfkxzK8xHERICW8
 iZy7tPJnpwQeMNWzW+CH73vnKbzcv01OqhO0N+w1daguVkgXaPMvQarD9BiIw5IxHs4y
 15sh2nE+uhn3AIzJNQA0yxltWSwGRAOKHSIeE5gYHL9IAzFceuv7Bo9r1Uyf3d1PHflF
 vhsg==
X-Gm-Message-State: APjAAAW6x9sdUTapHQvE+Qj+TsoPGf9d215KapmyDjvhpOToVIlAojN3
 FKYhCoAyGW4Kkr2/uxdqqcetz8vBIxE=
X-Google-Smtp-Source: APXvYqzrHvRMTbvoqHXLfsxIozDoKCD5y72fF3wylxvWx5enzGNkTFgQigj/ia2unJb0Pgl1SxsoNw==
X-Received: by 2002:a17:902:bd89:: with SMTP id
 q9mr8801573pls.38.1579660381820; 
 Tue, 21 Jan 2020 18:33:01 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id t1sm42935209pgq.23.2020.01.21.18.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:33:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] hw/hppa/dino.c: Improve emulation of Dino PCI chip
Date: Tue, 21 Jan 2020 16:32:46 -1000
Message-Id: <20200122023256.27556-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122023256.27556-1-richard.henderson@linaro.org>
References: <20200122023256.27556-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

The tests of the dino chip with the Online-diagnostics CD
("ODE DINOTEST") now succeeds.
Additionally add some qemu trace events.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191220211512.3289-2-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/dino.c       | 97 +++++++++++++++++++++++++++++++++++++-------
 MAINTAINERS          |  2 +-
 hw/hppa/trace-events |  5 +++
 3 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index ab6969b45f..9797a7f0d9 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -1,7 +1,7 @@
 /*
- * HP-PARISC Dino PCI chipset emulation.
+ * HP-PARISC Dino PCI chipset emulation, as in B160L and similiar machines
  *
- * (C) 2017 by Helge Deller <deller@gmx.de>
+ * (C) 2017-2019 by Helge Deller <deller@gmx.de>
  *
  * This work is licensed under the GNU GPL license version 2 or later.
  *
@@ -21,6 +21,7 @@
 #include "migration/vmstate.h"
 #include "hppa_sys.h"
 #include "exec/address-spaces.h"
+#include "trace.h"
 
 
 #define TYPE_DINO_PCI_HOST_BRIDGE "dino-pcihost"
@@ -82,11 +83,28 @@
 #define DINO_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
 
+#define DINO800_REGS ((DINO_TLTIM - DINO_GMASK) / 4)
+static const uint32_t reg800_keep_bits[DINO800_REGS] = {
+            MAKE_64BIT_MASK(0, 1),
+            MAKE_64BIT_MASK(0, 7),
+            MAKE_64BIT_MASK(0, 7),
+            MAKE_64BIT_MASK(0, 8),
+            MAKE_64BIT_MASK(0, 7),
+            MAKE_64BIT_MASK(0, 9),
+            MAKE_64BIT_MASK(0, 32),
+            MAKE_64BIT_MASK(0, 8),
+            MAKE_64BIT_MASK(0, 30),
+            MAKE_64BIT_MASK(0, 25),
+            MAKE_64BIT_MASK(0, 22),
+            MAKE_64BIT_MASK(0, 9),
+};
+
 typedef struct DinoState {
     PCIHostState parent_obj;
 
     /* PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
        so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.  */
+    uint32_t config_reg_dino; /* keep original copy, including 2 lowest bits */
 
     uint32_t iar0;
     uint32_t iar1;
@@ -94,8 +112,12 @@ typedef struct DinoState {
     uint32_t ipr;
     uint32_t icr;
     uint32_t ilr;
+    uint32_t io_fbb_en;
     uint32_t io_addr_en;
     uint32_t io_control;
+    uint32_t toc_addr;
+
+    uint32_t reg800[DINO800_REGS];
 
     MemoryRegion this_mem;
     MemoryRegion pci_mem;
@@ -106,8 +128,6 @@ typedef struct DinoState {
     MemoryRegion bm_ram_alias;
     MemoryRegion bm_pci_alias;
     MemoryRegion bm_cpu_alias;
-
-    MemoryRegion cpu0_eir_mem;
 } DinoState;
 
 /*
@@ -122,6 +142,8 @@ static void gsc_to_pci_forwarding(DinoState *s)
     tmp = extract32(s->io_control, 7, 2);
     enabled = (tmp == 0x01);
     io_addr_en = s->io_addr_en;
+    /* Mask out first (=firmware) and last (=Dino) areas. */
+    io_addr_en &= ~(BIT(31) | BIT(0));
 
     memory_region_transaction_begin();
     for (i = 1; i < 31; i++) {
@@ -142,6 +164,8 @@ static bool dino_chip_mem_valid(void *opaque, hwaddr addr,
                                 unsigned size, bool is_write,
                                 MemTxAttrs attrs)
 {
+    bool ret = false;
+
     switch (addr) {
     case DINO_IAR0:
     case DINO_IAR1:
@@ -152,16 +176,22 @@ static bool dino_chip_mem_valid(void *opaque, hwaddr addr,
     case DINO_ICR:
     case DINO_ILR:
     case DINO_IO_CONTROL:
+    case DINO_IO_FBB_EN:
     case DINO_IO_ADDR_EN:
     case DINO_PCI_IO_DATA:
-        return true;
+    case DINO_TOC_ADDR:
+    case DINO_GMASK ... DINO_TLTIM:
+        ret = true;
+        break;
     case DINO_PCI_IO_DATA + 2:
-        return size <= 2;
+        ret = (size <= 2);
+        break;
     case DINO_PCI_IO_DATA + 1:
     case DINO_PCI_IO_DATA + 3:
-        return size == 1;
+        ret = (size == 1);
     }
-    return false;
+    trace_dino_chip_mem_valid(addr, ret);
+    return ret;
 }
 
 static MemTxResult dino_chip_read_with_attrs(void *opaque, hwaddr addr,
@@ -194,6 +224,9 @@ static MemTxResult dino_chip_read_with_attrs(void *opaque, hwaddr addr,
         }
         break;
 
+    case DINO_IO_FBB_EN:
+        val = s->io_fbb_en;
+        break;
     case DINO_IO_ADDR_EN:
         val = s->io_addr_en;
         break;
@@ -227,12 +260,28 @@ static MemTxResult dino_chip_read_with_attrs(void *opaque, hwaddr addr,
     case DINO_IRR1:
         val = s->ilr & s->imr & s->icr;
         break;
+    case DINO_TOC_ADDR:
+        val = s->toc_addr;
+        break;
+    case DINO_GMASK ... DINO_TLTIM:
+        val = s->reg800[(addr - DINO_GMASK) / 4];
+        if (addr == DINO_PAMR) {
+            val &= ~0x01;  /* LSB is hardwired to 0 */
+        }
+        if (addr == DINO_MLTIM) {
+            val &= ~0x07;  /* 3 LSB are hardwired to 0 */
+        }
+        if (addr == DINO_BRDG_FEAT) {
+            val &= ~(0x10710E0ul | 8); /* bits 5-7, 24 & 15 reserved */
+        }
+        break;
 
     default:
         /* Controlled by dino_chip_mem_valid above.  */
         g_assert_not_reached();
     }
 
+    trace_dino_chip_read(addr, val);
     *data = val;
     return ret;
 }
@@ -245,6 +294,9 @@ static MemTxResult dino_chip_write_with_attrs(void *opaque, hwaddr addr,
     AddressSpace *io;
     MemTxResult ret;
     uint16_t ioaddr;
+    int i;
+
+    trace_dino_chip_write(addr, val);
 
     switch (addr) {
     case DINO_IO_DATA ... DINO_PCI_IO_DATA + 3:
@@ -266,9 +318,11 @@ static MemTxResult dino_chip_write_with_attrs(void *opaque, hwaddr addr,
         }
         return ret;
 
+    case DINO_IO_FBB_EN:
+        s->io_fbb_en = val & 0x03;
+        break;
     case DINO_IO_ADDR_EN:
-        /* Never allow first (=firmware) and last (=Dino) areas.  */
-        s->io_addr_en = val & 0x7ffffffe;
+        s->io_addr_en = val;
         gsc_to_pci_forwarding(s);
         break;
     case DINO_IO_CONTROL:
@@ -292,6 +346,10 @@ static MemTxResult dino_chip_write_with_attrs(void *opaque, hwaddr addr,
         /* Any write to IPR clears the register.  */
         s->ipr = 0;
         break;
+    case DINO_TOC_ADDR:
+        /* IO_COMMAND of CPU with client_id bits */
+        s->toc_addr = 0xFFFA0030 | (val & 0x1e000);
+        break;
 
     case DINO_ILR:
     case DINO_IRR0:
@@ -299,6 +357,12 @@ static MemTxResult dino_chip_write_with_attrs(void *opaque, hwaddr addr,
         /* These registers are read-only.  */
         break;
 
+    case DINO_GMASK ... DINO_TLTIM:
+        i = (addr - DINO_GMASK) / 4;
+        val &= reg800_keep_bits[i];
+        s->reg800[i] = val;
+        break;
+
     default:
         /* Controlled by dino_chip_mem_valid above.  */
         g_assert_not_reached();
@@ -323,7 +387,7 @@ static const MemoryRegionOps dino_chip_ops = {
 
 static const VMStateDescription vmstate_dino = {
     .name = "Dino",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(iar0, DinoState),
@@ -332,13 +396,14 @@ static const VMStateDescription vmstate_dino = {
         VMSTATE_UINT32(ipr, DinoState),
         VMSTATE_UINT32(icr, DinoState),
         VMSTATE_UINT32(ilr, DinoState),
+        VMSTATE_UINT32(io_fbb_en, DinoState),
         VMSTATE_UINT32(io_addr_en, DinoState),
         VMSTATE_UINT32(io_control, DinoState),
+        VMSTATE_UINT32(toc_addr, DinoState),
         VMSTATE_END_OF_LIST()
     }
 };
 
-
 /* Unlike pci_config_data_le_ops, no check of high bit set in config_reg.  */
 
 static uint64_t dino_config_data_read(void *opaque, hwaddr addr, unsigned len)
@@ -362,14 +427,16 @@ static const MemoryRegionOps dino_config_data_ops = {
 
 static uint64_t dino_config_addr_read(void *opaque, hwaddr addr, unsigned len)
 {
-    PCIHostState *s = opaque;
-    return s->config_reg;
+    DinoState *s = opaque;
+    return s->config_reg_dino;
 }
 
 static void dino_config_addr_write(void *opaque, hwaddr addr,
                                    uint64_t val, unsigned len)
 {
     PCIHostState *s = opaque;
+    DinoState *ds = opaque;
+    ds->config_reg_dino = val; /* keep a copy of original value */
     s->config_reg = val & ~3U;
 }
 
@@ -453,6 +520,8 @@ PCIBus *dino_init(MemoryRegion *addr_space,
 
     dev = qdev_create(NULL, TYPE_DINO_PCI_HOST_BRIDGE);
     s = DINO_PCI_HOST_BRIDGE(dev);
+    s->iar0 = s->iar1 = CPU_HPA + 3;
+    s->toc_addr = 0xFFFA0030; /* IO_COMMAND of CPU */
 
     /* Dino PCI access from main memory.  */
     memory_region_init_io(&s->this_mem, OBJECT(s), &dino_chip_ops,
diff --git a/MAINTAINERS b/MAINTAINERS
index 2c768ed3d8..b287cbeaa8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -890,7 +890,7 @@ F: hw/*/etraxfs_*.c
 
 HP-PARISC Machines
 ------------------
-Dino
+HP B160L
 M: Richard Henderson <rth@twiddle.net>
 R: Helge Deller <deller@gmx.de>
 S: Odd Fixes
diff --git a/hw/hppa/trace-events b/hw/hppa/trace-events
index 4e2acb6176..f943b16c4e 100644
--- a/hw/hppa/trace-events
+++ b/hw/hppa/trace-events
@@ -2,3 +2,8 @@
 
 # pci.c
 hppa_pci_iack_write(void) ""
+
+# dino.c
+dino_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
+dino_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+dino_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
-- 
2.20.1


