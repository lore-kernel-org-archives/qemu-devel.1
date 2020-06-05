Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670B2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334C0206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFjeECQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334C0206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEjG-0001HY-EH
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbP-00041v-LB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbO-0004MD-Fh
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so8877048wmh.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ou/1yLdNR/Td2p6rgjvxI8THzHHOh+I9GsvdOs07AMM=;
 b=uFjeECQGJhmpjJSX9xWl6GS9H2uG1KOKVQOLtLl4pfL9X7sUjGgOCwmhrJercWMRy3
 9fBcZiROldGuVlirunkq9GJFB1FEuABDY1XTBucjKvYOTJqneANe3dJfAJPbLBDu/4aX
 DxbuAp4gHkCIr+lIA6eUqVYwX4t0xOgQqBNjtgzMMmbHN5jeicvyCbFA90UlztrFNIPb
 v7Ohe2TY4GOq+7atqQ2daTiRmIMpbAMvasB34l6KRFtD3dC3Z3MrltdoITo/zsxei/NO
 ayO58UN/r0qHjSQPwSmRohYrYTTn7IamxQHGBO7PGreZYZn+Fbkc2Xqy7wS2xBjH+gzX
 Fu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ou/1yLdNR/Td2p6rgjvxI8THzHHOh+I9GsvdOs07AMM=;
 b=lgSJsXwg8yAZZ7s9TAEr9YPJUUX4F8eic2WCZ3O/PjORMvSU6wHuP2sFAvUFwTmp+E
 uWhUexrY1lgQgN3BbMH6HvQkuoOqmAZ0BY+ZlmmP/lNenoM8FxWdbDBTFgsl5ZJauxD7
 89kjg8/MHu0sB5fxGYA9bJObvHDREFb3UAvMiJ9S94ldEjEn1qFRJID4fl3/1pRx5HDQ
 fRKfpn6A2TRuRaGN794WKHpWkio0lw6+QdTSljWdOlWgy7FFB53JhMqq2ufY1Emy6Mdy
 QYfPetwcnKLqDeUFI2NPayB3xxb6nR5rzo+frmaNLydyebr6GSRuA71mnAXauymYnWBw
 l2sQ==
X-Gm-Message-State: AOAM530nqP0GEYHiZT7UpOleqPdVGD/oNwhOCNgvlxMOeP49OIc/p8fZ
 F3RLQOLiKKkjhwSO11HSe9GbNg==
X-Google-Smtp-Source: ABdhPJzjJysKDY3Jcd/Cdqp85W47q9lx7lR6kZdTsdKOGXx3dZANCe5i6fCLGG0FS/UWizphnexE/w==
X-Received: by 2002:a1c:9ec4:: with SMTP id h187mr3266598wme.27.1591372189031; 
 Fri, 05 Jun 2020 08:49:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j190sm11823001wmb.33.2020.06.05.08.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3129C1FF9B;
 Fri,  5 Jun 2020 16:49:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 12/14] linux-user: deal with address wrap for ARM_COMMPAGE
 on 32 bit
Date: Fri,  5 Jun 2020 16:49:27 +0100
Message-Id: <20200605154929.26910-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Message-Id: <20200527100546.29297-3-alex.bennee@linaro.org>

---
v3
  - base offset on ARM_COMMPAGE
  - ensure we MAP_FIXED the commpage
  - support offset in pgd_find_hole_fallback
---
 linux-user/elfload.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

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


