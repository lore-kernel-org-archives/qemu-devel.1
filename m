Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D3CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E395620890
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSvZhak5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E395620890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsxw-0005XY-2T
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdswd-0003UI-V3
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:05:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdswc-0005D2-F8
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:05:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id j16so10962462wrb.7
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b1rnVPfR5Tx3kSg0YJymoHV+oJytl6k3F5aYs9rOE0Y=;
 b=HSvZhak5TuyQi5IWGcjjOMlGbsZjF0Y+Pnnp7jg47KH8u9bziJp1RV+tyAD8bqemmj
 sc/d231xp3cX+xmGHphArsopMn6lH4g2eue939MRJSO1nEtp6Jj3Tk3yPfrwMK56wjfo
 SFiRSetkMr+HF+8kY22xMxhxb0X6xfXRQPxEQ2ylQ7GYpvdWMhKA0qcdjWSA/bVumNaK
 NEdKLeLeXzvfLE3oBy7g5IRI3lYpBGvjdfhDcdfQzVt0Od5/5KikGl0x2tUv/SrHCz0A
 5NkszQYUfLpf36LG+LhnfKdleLh4PIGeovJAB/N5J3ouDj3YeUsiA6H2/s5xdju4BbPR
 Ux1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b1rnVPfR5Tx3kSg0YJymoHV+oJytl6k3F5aYs9rOE0Y=;
 b=luCWEfqqms3TYeP7ofYO8ivXWwXIh7ajuvf8gOsQB7LYMzhMWslKF9LlcFLWmXZSRn
 imf+39Tq2L8bGNcXRFTR/iiEY1qLhVzIxxet9AtJ8X6ILP5evIR50AZ1yy+a5oDrwUs9
 6Kq1FOp4LqV6IfjmfcOuFbpSLA6L6Hye/hAsmjLoEf+a5Q9MtCJNck38aRsq8KuQrAGc
 wj3aGBI2DtS17sjTg7AoslyW4r45om6yl0DH9FZE9rQpFJ6yWNnqEo2RhZpnrTTG4e1q
 u+EH7/eOheboVEaqO+f6Tcy/BY62A2lpPxvmAC9zBUkHUbboQHMa22VkFDE8bmzcqY0I
 q7/g==
X-Gm-Message-State: AOAM530r04wcHUbiRyEryaRxsxNNJTvFtB8xHIGuO9a2efu+Ik8FyTXt
 22uEf3iCj9tGW/6blS9fPCgm7w==
X-Google-Smtp-Source: ABdhPJwQQYQvJ8dfw9OoTs7N7MoL/SPkhPy4dg/zXOcDNb6JejgS9x0+uuk0P+hSUaxQSDnKs9pCEA==
X-Received: by 2002:adf:814a:: with SMTP id 68mr24367324wrm.177.1590573952701; 
 Wed, 27 May 2020 03:05:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t6sm2202626wma.4.2020.05.27.03.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 03:05:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 128271FF8C;
 Wed, 27 May 2020 11:05:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/3] linux-user: deal with address wrap for ARM_COMMPAGE on
 32 bit
Date: Wed, 27 May 2020 11:05:45 +0100
Message-Id: <20200527100546.29297-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527100546.29297-1-alex.bennee@linaro.org>
References: <20200527100546.29297-1-alex.bennee@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1880225 <1880225@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d6027867a1a..31defce95b5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2145,7 +2145,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, lon
 
 /* Return value for guest_base, or -1 if no hole found. */
 static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
-                               long align)
+                               long align, uintptr_t offset)
 {
     GSList *maps, *iter;
     uintptr_t this_start, this_end, next_start, brk;
@@ -2171,7 +2171,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
 
         this_end = ((MapInfo *)iter->data)->start;
         next_start = ((MapInfo *)iter->data)->end;
-        align_start = ROUND_UP(this_start, align);
+        align_start = ROUND_UP(this_start + offset, align);
 
         /* Skip holes that are too small. */
         if (align_start >= this_end) {
@@ -2221,6 +2221,7 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
 {
     uintptr_t loaddr = orig_loaddr;
     uintptr_t hiaddr = orig_hiaddr;
+    uintptr_t offset = 0;
     uintptr_t addr;
 
     if (hiaddr != orig_hiaddr) {
@@ -2234,18 +2235,19 @@ static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
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
             hiaddr = (uintptr_t)4 << 30;
         } else {
-            loaddr = ARM_COMMPAGE & -align;
+            offset = (128 * KiB);
         }
     }
 
-    addr = pgb_find_hole(loaddr, hiaddr - loaddr, align);
+    addr = pgb_find_hole(loaddr, hiaddr - loaddr, align, offset);
     if (addr == -1) {
         /*
          * If ARM_COMMPAGE, there *might* be a non-consecutive allocation
@@ -2280,7 +2282,7 @@ static void pgb_dynamic(const char *image_name, long align)
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


