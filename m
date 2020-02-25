Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F088EC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B925F2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrItYgZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B925F2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZCM-0000Ut-Rl
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlE-0001fN-H2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlD-00016H-4i
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:24 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlC-00010Z-Tl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:23 -0500
Received: by mail-wm1-x332.google.com with SMTP id t79so1180105wmt.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=49JMCqWwAbNa6QDPdUhg7wDSO/diL9vpysZNve+rYwA=;
 b=IrItYgZF9t4dKZprr3cLIVukr0+3qao0ih5TfuJMNpI3CP82ITferoEu6DTosZimHw
 8gsHdueOYjnUsLiQBanrRmRaX4rLVBdky9nivVFoW+IxDF18/uMOEYeCv3BX/VxShsBy
 ph7cv5DYA7vqNZjHDGHdQRYqbUdQW+2d7mhdeQA0U5HywRQvxYTPAkgBZmDeAa+s6dFu
 LK4qZFeEZyzQeSC3dik8uphA6qUFrMZ2RsdM+C6SiWAedeYhXgVF7Qc8xrq4tKUDxMaA
 NUELNnel7/DRgLlhsphl1o3Ds0bpeS4G6mAsRRAzyFIIULboLhogQx7GRkIIr5WR0FH7
 6bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=49JMCqWwAbNa6QDPdUhg7wDSO/diL9vpysZNve+rYwA=;
 b=MgutbAwCIgudBJIp0QaZf43TdiDKgcJshUVfkPsJM0qlz7br/0LQZrNSAkB3j8kmHP
 4iVllcWl8Ibr3VQ2C2ANyLuM0P1DlkxxTFThnk+invMsbLo2b8PcpkCYGZYjv39hfvfN
 0Uxg4EgZddyVXXhIELppTg2UwX/bSRE8xuQQUg1XxHWd753XDQoG6GcePEDlTRTH+8Vb
 qTizN5hhQoeKcgXxnz1tt4MuGAWJxGzuhILZZ3CNwdgeZ26Gi8/kIhiSD01yos9P5N3w
 SSocEJVD9Ivuxjg3WEDRREMu7Cb2FeU9kqzvcFV6MxqEFWtsugu4T7jGIt4HwkvZ9LKm
 /McA==
X-Gm-Message-State: APjAAAXDk+GlDYH5eKkOAU6xELqi2riSigUwJ+Qrq8rgjPSI6dbwQawJ
 1GyrxfuqxeCMXgQh1McjhqxZT0Jl
X-Google-Smtp-Source: APXvYqwTv0HWBL9qCQ+ZfqYroN+D8iZhSIwUl2We8cGUKXCVLl52J8tiyqfcCwp2wUJZNgEehg2yIQ==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr5010053wmj.150.1582631541619; 
 Tue, 25 Feb 2020 03:52:21 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 081/136] hw: Remove unnecessary cast when calling
 dma_memory_read()
Date: Tue, 25 Feb 2020 12:50:11 +0100
Message-Id: <1582631466-13880-81-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since its introduction in commit d86a77f8abb, dma_memory_read()
always accepted void pointer argument. Remove the unnecessary
casts.

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v4: Drop parenthesis when removing cast (Eric Blake)
---
 hw/arm/smmu-common.c                   |  3 +--
 hw/arm/smmuv3.c                        | 10 ++++------
 hw/sd/sdhci.c                          | 15 +++++----------
 scripts/coccinelle/exec_rw_const.cocci | 23 +++++++++++++++++++++++
 4 files changed, 33 insertions(+), 18 deletions(-)
 create mode 100644 scripts/coccinelle/exec_rw_const.cocci

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 23eb117..0f2573f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -74,8 +74,7 @@ static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
     dma_addr_t addr = baseaddr + index * sizeof(*pte);
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr,
-                          (uint8_t *)pte, sizeof(*pte));
+    ret = dma_memory_read(&address_space_memory, addr, pte, sizeof(*pte));
 
     if (ret != MEMTX_OK) {
         info->type = SMMU_PTW_ERR_WALK_EABT;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8b5f157..57a79df 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -279,8 +279,7 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
     trace_smmuv3_get_ste(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr,
-                          (void *)buf, sizeof(*buf));
+    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -301,8 +300,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
 
     trace_smmuv3_get_cd(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr,
-                           (void *)buf, sizeof(*buf));
+    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -406,8 +404,8 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         l2_ste_offset = sid & ((1 << s->sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
-        ret = dma_memory_read(&address_space_memory, l1ptr,
-                              (uint8_t *)&l1std, sizeof(l1std));
+        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
+                              sizeof(l1std));
         if (ret != MEMTX_OK) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 69dc3e6..de63ffb 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -701,8 +701,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
     switch (SDHC_DMA_TYPE(s->hostctl1)) {
     case SDHC_CTRL_ADMA2_32:
-        dma_memory_read(s->dma_as, entry_addr, (uint8_t *)&adma2,
-                        sizeof(adma2));
+        dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2));
         adma2 = le64_to_cpu(adma2);
         /* The spec does not specify endianness of descriptor table.
          * We currently assume that it is LE.
@@ -713,8 +712,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->incr = 8;
         break;
     case SDHC_CTRL_ADMA1_32:
-        dma_memory_read(s->dma_as, entry_addr, (uint8_t *)&adma1,
-                        sizeof(adma1));
+        dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1));
         adma1 = le32_to_cpu(adma1);
         dscr->addr = (hwaddr)(adma1 & 0xFFFFF000);
         dscr->attr = (uint8_t)extract32(adma1, 0, 7);
@@ -726,13 +724,10 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         }
         break;
     case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(s->dma_as, entry_addr,
-                        (uint8_t *)(&dscr->attr), 1);
-        dma_memory_read(s->dma_as, entry_addr + 2,
-                        (uint8_t *)(&dscr->length), 2);
+        dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1);
+        dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2);
         dscr->length = le16_to_cpu(dscr->length);
-        dma_memory_read(s->dma_as, entry_addr + 4,
-                        (uint8_t *)(&dscr->addr), 8);
+        dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8);
         dscr->addr = le64_to_cpu(dscr->addr);
         dscr->attr &= (uint8_t) ~0xC0;
         dscr->incr = 12;
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
new file mode 100644
index 0000000..7e42682
--- /dev/null
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -0,0 +1,23 @@
+/*
+  Usage:
+
+    spatch \
+           --macro-file scripts/cocci-macro-file.h \
+           --sp-file scripts/coccinelle/exec_rw_const.cocci \
+           --keep-comments \
+           --in-place \
+           --dir .
+*/
+
+// Remove useless cast
+@@
+expression E1, E2, E3, E4;
+type T;
+@@
+(
+- dma_memory_read(E1, E2, (T *)(E3), E4)
++ dma_memory_read(E1, E2, E3, E4)
+|
+- dma_memory_write(E1, E2, (T *)(E3), E4)
++ dma_memory_write(E1, E2, E3, E4)
+)
-- 
1.8.3.1



