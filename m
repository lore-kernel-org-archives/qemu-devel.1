Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B7DC32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426892073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDo2PLRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426892073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itiSX-0008Vx-BV
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 20:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1itiPv-0007Sb-VC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1itiPu-0000cz-Ls
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:33:19 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1itiPs-0000Z4-08; Mon, 20 Jan 2020 20:33:16 -0500
Received: by mail-pj1-x1041.google.com with SMTP id d15so557383pjw.1;
 Mon, 20 Jan 2020 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hz3HUbbfMk3eAwn1j26oE45C8lSGBMv3GzNn4Rl2XPs=;
 b=KDo2PLRR6CoHHZ7kQnMt3AOKVNFG1Urt4xg2A6HPzB0fAWiuG9ylMV9OyT5LtyzmFK
 ExaYiPTclsZj2mSkqGojyTiuta/PpE5Q5gIHYBKgSKUgJ1I42d+GPXNlwBnjWS/WSdpW
 1ZFnQ/pOD8a4p7i8OSbU2tIp0H6/3aFtWXYDsR5FGzi9yuQeS+tewDA+YV22HJ5fvCJ0
 5TbSEeagN1UEN9/EmmvcB297TLMRV2hoxLDSjzQ6GkN0qYt66x1U95mTHxq4ceBoqWmF
 fZAWfZhva6dbeY+ebF4iy4DD2EpH6YXmagpL7dktTBuk2ImG513l87R64k/VJZ1O2++r
 m0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hz3HUbbfMk3eAwn1j26oE45C8lSGBMv3GzNn4Rl2XPs=;
 b=KeIMgX4xe7I2oxHyeZKzr8FQ73EkYzLU2bs10i/ZKC9Wx2VHvkWbn3hQ8XDX3p7B/1
 PDFz398TbZR3Lp2J4cW8WfA0tbaFYylwtz7Mjo4a84KJwCWc0hdNnduL2j0Opev8XWiK
 snWpD3B2qlu9o1lGsi1UkohM34XC0kfWSiaRIm8WQP61hFSsj4G6gY6bMjEDW49DFTTk
 +HfTU7ag9BQymRfzWCjUEUbDGUrUrwrJCKZnyyXml+vkFd4mXFnGo6a3N4xX4PppmuGe
 iHmoSMC2+ARNauRKA0VvFNg3b7rtlSHp65z3zi+X9K3IzbFG9SNReg1smdbYsnbdfo7B
 Kq7g==
X-Gm-Message-State: APjAAAVcagwZ/cbVT1h64oEdd6nOOELOhw9KUeq1yxf9fqkHHSDmub5u
 u2aonBMBig4zBioERJ8LdfT8EFgX
X-Google-Smtp-Source: APXvYqzIYzNZrQFA2RCYDCauTyYB+NdBGvwcwyUGiSH+Tn9mlTMiFpjNF1xeDKYsSFS0xf3OejnlMg==
X-Received: by 2002:a17:902:6ac7:: with SMTP id
 i7mr2761421plt.66.1579570393890; 
 Mon, 20 Jan 2020 17:33:13 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id x132sm40628397pfc.148.2020.01.20.17.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 17:33:13 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] aspeed/scu: Create separate write callbacks
Date: Tue, 21 Jan 2020 12:03:01 +1030
Message-Id: <20200121013302.43839-2-joel@jms.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121013302.43839-1-joel@jms.id.au>
References: <20200121013302.43839-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This splits the common write callback into separate ast2400 and ast2500
implementations. This makes it clearer when implementing differing
behaviour.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_scu.c | 80 +++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index f62fa25e3474..7108cad8c6a7 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -232,8 +232,47 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
     return s->regs[reg];
 }
 
-static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
-                             unsigned size)
+static void aspeed_ast2400_scu_write(void *opaque, hwaddr offset,
+                                     uint64_t data, unsigned size)
+{
+    AspeedSCUState *s = ASPEED_SCU(opaque);
+    int reg = TO_REG(offset);
+
+    if (reg >= ASPEED_SCU_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    if (reg > PROT_KEY && reg < CPU2_BASE_SEG1 &&
+            !s->regs[PROT_KEY]) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
+    }
+
+    trace_aspeed_scu_write(offset, size, data);
+
+    switch (reg) {
+    case PROT_KEY:
+        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        return;
+    case SILICON_REV:
+    case FREQ_CNTR_EVAL:
+    case VGA_SCRATCH1 ... VGA_SCRATCH8:
+    case RNG_DATA:
+    case FREE_CNTR4:
+    case FREE_CNTR4_EXT:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    s->regs[reg] = data;
+}
+
+static void aspeed_ast2500_scu_write(void *opaque, hwaddr offset,
+                                     uint64_t data, unsigned size)
 {
     AspeedSCUState *s = ASPEED_SCU(opaque);
     int reg = TO_REG(offset);
@@ -257,25 +296,11 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
     case PROT_KEY:
         s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
         return;
-    case CLK_SEL:
-        s->regs[reg] = data;
-        break;
     case HW_STRAP1:
-        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
-            s->regs[HW_STRAP1] |= data;
-            return;
-        }
-        /* Jump to assignment below */
-        break;
+        s->regs[HW_STRAP1] |= data;
+        return;
     case SILICON_REV:
-        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
-            s->regs[HW_STRAP1] &= ~data;
-        } else {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
-                          __func__, offset);
-        }
-        /* Avoid assignment below, we've handled everything */
+        s->regs[HW_STRAP1] &= ~data;
         return;
     case FREQ_CNTR_EVAL:
     case VGA_SCRATCH1 ... VGA_SCRATCH8:
@@ -291,9 +316,18 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
     s->regs[reg] = data;
 }
 
-static const MemoryRegionOps aspeed_scu_ops = {
+static const MemoryRegionOps aspeed_ast2400_scu_ops = {
+    .read = aspeed_scu_read,
+    .write = aspeed_ast2400_scu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static const MemoryRegionOps aspeed_ast2500_scu_ops = {
     .read = aspeed_scu_read,
-    .write = aspeed_scu_write,
+    .write = aspeed_ast2500_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
@@ -469,7 +503,7 @@ static void aspeed_2400_scu_class_init(ObjectClass *klass, void *data)
     asc->calc_hpll = aspeed_2400_scu_calc_hpll;
     asc->apb_divider = 2;
     asc->nr_regs = ASPEED_SCU_NR_REGS;
-    asc->ops = &aspeed_scu_ops;
+    asc->ops = &aspeed_ast2400_scu_ops;
 }
 
 static const TypeInfo aspeed_2400_scu_info = {
@@ -489,7 +523,7 @@ static void aspeed_2500_scu_class_init(ObjectClass *klass, void *data)
     asc->calc_hpll = aspeed_2500_scu_calc_hpll;
     asc->apb_divider = 4;
     asc->nr_regs = ASPEED_SCU_NR_REGS;
-    asc->ops = &aspeed_scu_ops;
+    asc->ops = &aspeed_ast2500_scu_ops;
 }
 
 static const TypeInfo aspeed_2500_scu_info = {
-- 
2.24.1


