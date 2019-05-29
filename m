Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC197C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 20:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A076924189
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 20:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A076924189
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW5PD-0007M7-FA
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 16:42:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hW5OK-00073A-Va
	for qemu-devel@nongnu.org; Wed, 29 May 2019 16:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hW5OJ-0006Da-RA
	for qemu-devel@nongnu.org; Wed, 29 May 2019 16:41:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hW5OJ-00069q-3M
	for qemu-devel@nongnu.org; Wed, 29 May 2019 16:41:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so2403660pfd.2
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 13:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:mime-version
	:content-transfer-encoding:cc:from:to;
	bh=80RE6I//gD2gYR0rctF2qVLsvsYc9yppzUaiacmJdRE=;
	b=kg2TO/mMaNsL/q24stpBkdztuLxhjPNvYudzwyZvVQMxqd2xS64wRTtEg+x3NlibLh
	UmH1TDCT7ayCg4X1PfZR4MTWFTIEX/k76LuzQrHYP26BYVZ4fWGp1aYLPrj/Frvaqt85
	FMpIEfl9r1E23Aoh0TgLvl7GSywwAcNud/Xf3VrJAan68xusY9/2wLhdxiNSNlzJsCgv
	LqA6IU+WWhP6pJqvOzOTA6d4HMyWpW2IQiIbn+xhwaqCLdlGPcKZoLv0D8WmJYYbVx+s
	iutee4tVC0n5J9f2qXJavZqvYWQXumyNh+XRTjFaERaICjPKWoib5YERTMWEY8s2RMRy
	Lfuw==
X-Gm-Message-State: APjAAAVJraduJyRIuOl0fC6KDQDC13er4ySdD5kuq7x0D7nCinfdXvFy
	1VMHXZjmeoewXenOGqPeM8fAqqAEbUA=
X-Google-Smtp-Source: APXvYqx3G0/l4zgBQZQ4CYLRplw/Yk2QiR3I7o6HhqzVyOywxPqIwPRZdqALxF3YBn2SdhxIqwC8Ig==
X-Received: by 2002:a17:90a:65c2:: with SMTP id
	i2mr14222559pjs.54.1559162499192; 
	Wed, 29 May 2019 13:41:39 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id x18sm600635pfo.8.2019.05.29.13.41.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 13:41:38 -0700 (PDT)
Date: Wed, 29 May 2019 13:41:02 -0700
Message-Id: <20190529204101.26907-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: qemu-riscv@nongnu.org
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PATCH] sifive_prci: Read and write PRCI registers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Nathaniel Graff <nathaniel.graff@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org
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
index 0910ea32c1a5..d3716a928568 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -23,15 +23,18 @@
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
@@ -40,7 +43,30 @@ static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
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
@@ -60,6 +86,13 @@ static void sifive_prci_init(Object *obj)
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


