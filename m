Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3D2C5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C718205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C718205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgunb-00020L-E4
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgujz-00083N-SJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgujw-0008Hx-AW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:32:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgujw-0008Ft-4y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:32:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so1406553pgj.8
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=skpCsY6OAelSjirFF1wZzpzLaY2+CMd8k4r3QNyFPh4=;
 b=T6I+toM2PV93D1Cw1T1845bGcjC+dqhjusq+XNhNkazLxxHGIbgM/oWsEoY46K2YAE
 MmwF9Tp6/CEFRYsXJYYc4V1JLxu5l3ym6SFqjouxc6NdIhKGqvQpjOpZXKrv4GbsCXeC
 vVb5QRYAlBF+yT6MNqxg6q+rab1CmxSipLpOtZrJS5wFDuztzdiv0BCvC+oiOc7D8iCT
 52AXN+8YmNB7PebxvheGTMpNnXTEhA61feeH0cH4I2HWkZ+q5XdWvDd9uMzmC7AuF4vC
 SpA1kbD51Ch08x78TcG3SLvIUCdHNi9FUaYdfFdFNKyWkly4+MlIIKrFr/G2GFo1zR5b
 IHLg==
X-Gm-Message-State: APjAAAUi3LuQtOCJVnjptZNyPxiXFcSz/CmFfzKwEAyFLH0hA0vF3V1Z
 Md2d3x8yYXfei8wp436ZerFOYwofTCFsKTRZ
X-Google-Smtp-Source: APXvYqxI+aNpPXccr3z4WvuSCLEVcgWxMDCBxvRF+WloAzPZChPklHOGWTUMyC0Cpcp9l8wwBcYXXg==
X-Received: by 2002:a63:480a:: with SMTP id v10mr10470045pga.60.1561743164768; 
 Fri, 28 Jun 2019 10:32:44 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id v9sm2547121pgj.69.2019.06.28.10.32.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:32:43 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:31:55 -0700
Message-Id: <20190628173227.31925-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: [Qemu-devel] [PULL 02/34] sifive_prci: Read and write PRCI registers
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
Cc: Nathaniel Graff <nathaniel.graff@sifive.com>,
 Michael Clark <mjc@sifive.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nathaniel Graff <nathaniel.graff@sifive.com>

Writes to the SiFive PRCI registers are preserved while leaving the
ready bits set for the HFX/HFR oscillators and the lock bit set for the
PLL.

Signed-off-by: Nathaniel Graff <nathaniel.graff@sifive.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_prci.c         | 49 ++++++++++++++++++++++++++++------
 include/hw/riscv/sifive_prci.h | 32 ++++++++++++++++++++++
 2 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index fa136b5a9fe9..f406682c91f1 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -24,15 +24,18 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_prci.h"
 
-/* currently implements enough to mock freedom-e-sdk BSP clock programming */
-
 static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    if (addr == 0 /* PRCI_HFROSCCFG */) {
-        return 1 << 31; /* ROSC_RDY */
-    }
-    if (addr == 8 /* PRCI_PLLCFG    */) {
-        return 1 << 31; /* PLL_LOCK */
+    SiFivePRCIState *s = opaque;
+    switch (addr) {
+    case SIFIVE_PRCI_HFROSCCFG:
+        return s->hfrosccfg;
+    case SIFIVE_PRCI_HFXOSCCFG:
+        return s->hfxosccfg;
+    case SIFIVE_PRCI_PLLCFG:
+        return s->pllcfg;
+    case SIFIVE_PRCI_PLLOUTDIV:
+        return s->plloutdiv;
     }
     hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);
     return 0;
@@ -41,7 +44,30 @@ static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
 static void sifive_prci_write(void *opaque, hwaddr addr,
            uint64_t val64, unsigned int size)
 {
-    /* discard writes */
+    SiFivePRCIState *s = opaque;
+    switch (addr) {
+    case SIFIVE_PRCI_HFROSCCFG:
+        s->hfrosccfg = (uint32_t) val64;
+        /* OSC stays ready */
+        s->hfrosccfg |= SIFIVE_PRCI_HFROSCCFG_RDY;
+        break;
+    case SIFIVE_PRCI_HFXOSCCFG:
+        s->hfxosccfg = (uint32_t) val64;
+        /* OSC stays ready */
+        s->hfxosccfg |= SIFIVE_PRCI_HFXOSCCFG_RDY;
+        break;
+    case SIFIVE_PRCI_PLLCFG:
+        s->pllcfg = (uint32_t) val64;
+        /* PLL stays locked */
+        s->pllcfg |= SIFIVE_PRCI_PLLCFG_LOCK;
+        break;
+    case SIFIVE_PRCI_PLLOUTDIV:
+        s->plloutdiv = (uint32_t) val64;
+        break;
+    default:
+        hw_error("%s: bad write: addr=0x%x v=0x%x\n",
+                 __func__, (int)addr, (int)val64);
+    }
 }
 
 static const MemoryRegionOps sifive_prci_ops = {
@@ -61,6 +87,13 @@ static void sifive_prci_init(Object *obj)
     memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
                           TYPE_SIFIVE_PRCI, 0x8000);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
+    s->hfxosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
+    s->pllcfg = (SIFIVE_PRCI_PLLCFG_REFSEL | SIFIVE_PRCI_PLLCFG_BYPASS |
+                SIFIVE_PRCI_PLLCFG_LOCK);
+    s->plloutdiv = SIFIVE_PRCI_PLLOUTDIV_DIV1;
+
 }
 
 static const TypeInfo sifive_prci_info = {
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_prci.h
index b6f4c486cc1e..bd51c4af3c1c 100644
--- a/include/hw/riscv/sifive_prci.h
+++ b/include/hw/riscv/sifive_prci.h
@@ -19,6 +19,34 @@
 #ifndef HW_SIFIVE_PRCI_H
 #define HW_SIFIVE_PRCI_H
 
+enum {
+    SIFIVE_PRCI_HFROSCCFG   = 0x0,
+    SIFIVE_PRCI_HFXOSCCFG   = 0x4,
+    SIFIVE_PRCI_PLLCFG      = 0x8,
+    SIFIVE_PRCI_PLLOUTDIV   = 0xC
+};
+
+enum {
+    SIFIVE_PRCI_HFROSCCFG_RDY   = (1 << 31),
+    SIFIVE_PRCI_HFROSCCFG_EN    = (1 << 30)
+};
+
+enum {
+    SIFIVE_PRCI_HFXOSCCFG_RDY   = (1 << 31),
+    SIFIVE_PRCI_HFXOSCCFG_EN    = (1 << 30)
+};
+
+enum {
+    SIFIVE_PRCI_PLLCFG_PLLSEL   = (1 << 16),
+    SIFIVE_PRCI_PLLCFG_REFSEL   = (1 << 17),
+    SIFIVE_PRCI_PLLCFG_BYPASS   = (1 << 18),
+    SIFIVE_PRCI_PLLCFG_LOCK     = (1 << 31)
+};
+
+enum {
+    SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
+};
+
 #define TYPE_SIFIVE_PRCI "riscv.sifive.prci"
 
 #define SIFIVE_PRCI(obj) \
@@ -30,6 +58,10 @@ typedef struct SiFivePRCIState {
 
     /*< public >*/
     MemoryRegion mmio;
+    uint32_t hfrosccfg;
+    uint32_t hfxosccfg;
+    uint32_t pllcfg;
+    uint32_t plloutdiv;
 } SiFivePRCIState;
 
 DeviceState *sifive_prci_create(hwaddr addr);
-- 
2.21.0


