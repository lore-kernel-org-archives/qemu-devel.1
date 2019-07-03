Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1501C06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6B3218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6B3218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiarJ-0007GA-04
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapH-0005F4-QI
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapG-0006AB-6r
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapF-000675-Px
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so1149755lfa.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=skpCsY6OAelSjirFF1wZzpzLaY2+CMd8k4r3QNyFPh4=;
 b=ikTf/8eHIRAtcUY8czrNSV7LSWY2tBat+p+gu0s4szMhl9AT2LE6EcHrO9ShvuMbCa
 9Mg4ELRd0IhNIJ3Hfc0EX+VlMA3dFOrAVI+/G+fGkv5K0q1uDyAoqIU0M6oP25xYeMCQ
 ulSxFjnyfPqMmMDiCXeEJvZhIx/2M6t13pfwQhKILaPkY29S2QL+0eHUuNiUJJ6Pr51I
 l8ttEUPYYc2niYFCJ1mQUAI23reZcz4arGkCIaumV4Low2iVE2EuE3ATXDr8Qk58W/00
 vJqkKSJW/6LQ7Ddt/P03gohmEThXeevTCf4xittx3z/NU9dkqFFgLny9VvBGpVb+kQgu
 I3ig==
X-Gm-Message-State: APjAAAVeZ+/YPLxNcLMWPOBBg2TXs4Qf9vF/P/nbdSCF3ZQEbOF1Vj2O
 Mo3IM+5nuIPWHS0AEKln7F73+OtDzK714Q==
X-Google-Smtp-Source: APXvYqx4/XwrJolzQkVq7Y611MNjFUEam8+qDYP7005onwVrTsEaqzkIuJr3henY80K3VngycRmJ/A==
X-Received: by 2002:a19:c7ca:: with SMTP id x193mr3276437lff.151.1562143272015; 
 Wed, 03 Jul 2019 01:41:12 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id p5sm339162ljb.91.2019.07.03.01.41.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:11 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:18 -0700
Message-Id: <20190703084048.6980-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.65
Subject: [Qemu-devel] [PULL 02/32] sifive_prci: Read and write PRCI registers
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


