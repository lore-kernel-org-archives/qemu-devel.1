Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01538C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26132078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfMbn4rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26132078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibq0-00071n-2A
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeH-0007qU-UI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibeG-0004Pz-QB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id p5so20691678wrw.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zZed/y7QNny6kF0a14GXywWS17AGkkgGYqHaLimRe4g=;
 b=MfMbn4rEJRBBEYQmbyHlgeHjmEgYadWZC5Z4oQkHw3p8L1ahRn5cknwXJEkUQoOiiw
 4Cr6743DQDdthweo06PKIO0rzlkCA2Gh5suvp1bvRYMJw1xolMxKtOeDSrSM8VltLDW3
 S1u8uImQ0VQlziJ8sR9RDlbGmAUfyiHCikSXvlZ3Vt4RzouZ7xA2rkmbA0gBjhBQ1BQ/
 4g9Hhzq4xCHb5bHzkXCcQ4p5fAaqkl06aZWqxICsntovoslqOXSuvZudZ+aLMsFAe+hj
 mwRBzYmEqJL1QM7uzjf3VuoRBeWWSNMqCzfGVPFcaZ+HwkL8yQgHzxLigT+yAtBIo7Kk
 77+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zZed/y7QNny6kF0a14GXywWS17AGkkgGYqHaLimRe4g=;
 b=i7jNI1GylDRCUCI6ow+zPwvpCtq2LAWKCRqDlzS+VZCVm+VL+HuyC/MrP8vfsGCOLl
 sn2QettwR9l/whfxCZ54ufKOfpf9EX3miS7tnkWWPxPXjho8uYMpF3Z6Fpmp+ONS3A05
 HCR3PsbpitYPBhE2NEm1XBRaeafUKXhC6+i7DAC8OwjcZqumTa21Zrqv66HAhHaZv5YC
 x8Mr8oRzDrOK71aVX7QRCoDxbix7f6TiwQ+Wmt5wkkKByPR4/BGYVtwK2mzMuqOZ67W2
 bkhLw2k7fxx/J7iN7upjodE6WpP9NIbUK0abEdB3eEtsngVKjV7KQvnP8ygvFLyuYU/6
 RE+A==
X-Gm-Message-State: AOAM531otV1bLOv1wlqZ4xfRN3LOU55fKMqv7UhjgL8M9Gy3wcQmqZYT
 h4mVe4yfEuQ1gVqa2CnPq/sohw==
X-Google-Smtp-Source: ABdhPJwLGez/q8PnyeLMNfVex5VnstkIutRrFNo8+knXabKS3EIS0QytdHyWyhfB5uNB9yy9UHAEkw==
X-Received: by 2002:adf:e58c:: with SMTP id l12mr3717353wrm.34.1591699107336; 
 Tue, 09 Jun 2020 03:38:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm2947032wra.86.2020.06.09.03.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B504B1FF9A;
 Tue,  9 Jun 2020 11:38:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/17] linux-user: deal with address wrap for ARM_COMMPAGE on
 32 bit
Date: Tue,  9 Jun 2020 11:38:03 +0100
Message-Id: <20200609103809.23443-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Bug 1880225 <1880225@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We rely on the pointer to wrap when accessing the high address of the
COMMPAGE so it lands somewhere reasonable. However on 32 bit hosts we
cannot afford just to map the entire 4gb address range. The old mmap
trial and error code handled this by just checking we could map both
the guest_base and the computed COMMPAGE address.

We can't just manipulate loadaddr to get what we want so we introduce
an offset which pgb_find_hole can apply when looking for a gap for
guest_base that ensures there is space left to map the COMMPAGE
afterwards.

This is arguably a little inefficient for the one 32 bit
value (kuser_helper_version) we need to keep there given all the
actual code entries are picked up during the translation phase.

Fixes: ee94743034b
Bug: https://bugs.launchpad.net/qemu/+bug/1880225
Cc: Bug 1880225 <1880225@bugs.launchpad.net>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200605154929.26910-13-alex.bennee@linaro.org>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 475d243f3bd..b5cb21384a1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -389,7 +389,7 @@ static bool init_guest_commpage(void)
 {
     void *want = g2h(ARM_COMMPAGE & -qemu_host_page_size);
     void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
 
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
@@ -2113,7 +2113,8 @@ static void pgb_have_guest_base(const char *image_name, abi_ulong guest_loaddr,
  * only dumbly iterate up the host address space seeing if the
  * allocation would work.
  */
-static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, long align)
+static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
+                                        long align, uintptr_t offset)
 {
     uintptr_t base;
 
@@ -2123,7 +2124,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, lon
     while (true) {
         uintptr_t align_start, end;
         align_start = ROUND_UP(base, align);
-        end = align_start + guest_size;
+        end = align_start + guest_size + offset;
 
         /* if brk is anywhere in the range give ourselves some room to grow. */
         if (align_start <= brk && brk < end) {
@@ -2138,7 +2139,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, lon
                                      PROT_NONE, flags, -1, 0);
             if (mmap_start != MAP_FAILED) {
                 munmap((void *) align_start, guest_size);
-                return (uintptr_t) mmap_start;
+                return (uintptr_t) mmap_start + offset;
             }
             base += qemu_host_page_size;
         }
@@ -2147,7 +2148,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, lon
 
 /* Return value for guest_base, or -1 if no hole found. */
 static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
-                               long align)
+                               long align, uintptr_t offset)
 {
     GSList *maps, *iter;
     uintptr_t this_start, this_end, next_start, brk;
@@ -2161,7 +2162,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
     brk = (uintptr_t)sbrk(0);
 
     if (!maps) {
-        return pgd_find_hole_fallback(guest_size, brk, align);
+        return pgd_find_hole_fallback(guest_size, brk, align, offset);
     }
 
     /* The first hole is before the first map entry. */
@@ -2173,7 +2174,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
 
         this_end = ((MapInfo *)iter->data)->start;
         next_start = ((MapInfo *)iter->data)->end;
-        align_start = ROUND_UP(this_start, align);
+        align_start = ROUND_UP(this_start + offset, align);
 
         /* Skip holes that are too small. */
         if (align_start >= this_end) {
@@ -2223,6 +2224,7 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
 {
     uintptr_t loaddr = orig_loaddr;
     uintptr_t hiaddr = orig_hiaddr;
+    uintptr_t offset = 0;
     uintptr_t addr;
 
     if (hiaddr != orig_hiaddr) {
@@ -2236,18 +2238,19 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
     if (ARM_COMMPAGE) {
         /*
          * Extend the allocation to include the commpage.
-         * For a 64-bit host, this is just 4GiB; for a 32-bit host,
-         * the address arithmetic will wrap around, but the difference
-         * will produce the correct allocation size.
+         * For a 64-bit host, this is just 4GiB; for a 32-bit host we
+         * need to ensure there is space bellow the guest_base so we
+         * can map the commpage in the place needed when the address
+         * arithmetic wraps around.
          */
         if (sizeof(uintptr_t) == 8 || loaddr >= 0x80000000u) {
-            hiaddr = (uintptr_t)4 << 30;
+            hiaddr = (uintptr_t) 4 << 30;
         } else {
-            loaddr = ARM_COMMPAGE & -align;
+            offset = -(ARM_COMMPAGE & -align);
         }
     }
 
-    addr = pgb_find_hole(loaddr, hiaddr - loaddr, align);
+    addr = pgb_find_hole(loaddr, hiaddr - loaddr, align, offset);
     if (addr == -1) {
         /*
          * If ARM_COMMPAGE, there *might* be a non-consecutive allocation
@@ -2282,7 +2285,7 @@ static void pgb_dynamic(const char *image_name, long align)
          * just above that, and maximises the positive guest addresses.
          */
         commpage = ARM_COMMPAGE & -align;
-        addr = pgb_find_hole(commpage, -commpage, align);
+        addr = pgb_find_hole(commpage, -commpage, align, 0);
         assert(addr != -1);
         guest_base = addr;
     }
-- 
2.20.1


