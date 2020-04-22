Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21B0C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A938D206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EE8ORcH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A938D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR7D2-0006em-Rr
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74i-0000lT-Tz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74h-0005TG-GO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:28 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74g-0005LI-SN
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:26 -0400
Received: by mail-pl1-x644.google.com with SMTP id t4so423816plq.12
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=suwrl9RFQOuVoDr4Q1KFh+iDEpTs3nZzUnaA8dPRNoc=;
 b=EE8ORcH7c25Y8idjVFFCe+3g3o7NQku+RgtNpE7HrHokOkOD0Ehzy9Lwk6Cxl/AWIi
 GNRTlQ39PPoU4QMQCdEybfxTNdasF4ei11yii9d/6jlP7VOGHNv5jIs4usEErirJwdB3
 Qpcexe14v7YtgFo0Ukyky+I3ryZjODaXHOUr+wpNVYGSioLJ35z3j0HqlIAM07O552A4
 BZWNy1PBTqEqRd/lDz640NzV8VWJukewQ/kEKtBrnEu8L8d1rxH0cRdvC+zrJfrFN/WY
 JRfbOF4DMG2dCzSg+vKbknqZDEyWUt00yC/SBg/BWXzSUqt0/HId1vlDXk5PyJrwTtHf
 ucDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=suwrl9RFQOuVoDr4Q1KFh+iDEpTs3nZzUnaA8dPRNoc=;
 b=sS/fxoJ0491rCvEsEyzVbKKa3dXJF38IVPke8cgpPxAIw4s5uumRVQzQkHc/G01pJk
 OJYGuwQgOmnm6hZNg/rHwcc+yScFvlMvakDyecvhcgsCq9w3zdRtr+tGcGTyMu9mnhcM
 QAOYWNhgqFxbCcChO0nDKxLncBg9+EeNhmqSUfnMdWzs4SEN5cnl1T7u0jzgaRYaq3iX
 9UkhAl4Tc8bq6NY+J44N9OmBKSid2Ib1YbB8JYDUVeVO1TRzQK2ECr+BX+hexWv8zf1S
 U3liOwHdOXQfT6WSYN7gLdFtdK0NXnfSUqFdqnvnF7LRUNo61+Z4TY9OHyDnsZGoeA5/
 9fcg==
X-Gm-Message-State: AGi0PubVjEGqKtm30r0DhrRjZ5+LBk7f1LWiFqvDSk3nGqvd0Q5gom5m
 +EtIB9KFoloHXYRmMpKEvn75jiFn/wE=
X-Google-Smtp-Source: APiQypKe4P6djiVz3UyCCXp4NF+UNzSfhuPEc4WVM1O76QKNz1tYmQZqCMufnyi2ZgdqnF+XMlVFuw==
X-Received: by 2002:a17:90a:2fc8:: with SMTP id
 n8mr9086745pjm.159.1587530003767; 
 Tue, 21 Apr 2020 21:33:23 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/18] target/arm: Adjust interface of sve_ld1_host_fn
Date: Tue, 21 Apr 2020 21:33:00 -0700
Message-Id: <20200422043309.18430-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current interface includes a loop; change it to load a
single element.  We will then be able to use the function
for ld{2,3,4} where individual vector elements are not adjacent.

Replace each call with the simplest possible loop over active
elements.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 124 ++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 61 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 2f053a9152..d007137735 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3972,20 +3972,10 @@ void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
  */
 
 /*
- * Load elements into @vd, controlled by @vg, from @host + @mem_ofs.
- * Memory is valid through @host + @mem_max.  The register element
- * indices are inferred from @mem_ofs, as modified by the types for
- * which the helper is built.  Return the @mem_ofs of the first element
- * not loaded (which is @mem_max if they are all loaded).
- *
- * For softmmu, we have fully validated the guest page.  For user-only,
- * we cannot fully validate without taking the mmap lock, but since we
- * know the access is within one host page, if any access is valid they
- * all must be valid.  However, when @vg is all false, it may be that
- * no access is valid.
+ * Load one element into @vd + @reg_off from @host.
+ * The controlling predicate is known to be true.
  */
-typedef intptr_t sve_ld1_host_fn(void *vd, void *vg, void *host,
-                                 intptr_t mem_ofs, intptr_t mem_max);
+typedef void sve_ldst1_host_fn(void *vd, intptr_t reg_off, void *host);
 
 /*
  * Load one element into @vd + @reg_off from (@env, @vaddr, @ra).
@@ -3999,20 +3989,10 @@ typedef void sve_ldst1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
  */
 
 #define DO_LD_HOST(NAME, H, TYPEE, TYPEM, HOST) \
-static intptr_t sve_##NAME##_host(void *vd, void *vg, void *host,           \
-                                  intptr_t mem_off, const intptr_t mem_max) \
-{                                                                           \
-    intptr_t reg_off = mem_off * (sizeof(TYPEE) / sizeof(TYPEM));           \
-    uint64_t *pg = vg;                                                      \
-    while (mem_off + sizeof(TYPEM) <= mem_max) {                            \
-        TYPEM val = 0;                                                      \
-        if (likely((pg[reg_off >> 6] >> (reg_off & 63)) & 1)) {             \
-            val = HOST(host + mem_off);                                     \
-        }                                                                   \
-        *(TYPEE *)(vd + H(reg_off)) = val;                                  \
-        mem_off += sizeof(TYPEM), reg_off += sizeof(TYPEE);                 \
-    }                                                                       \
-    return mem_off;                                                         \
+static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
+{                                                                      \
+    TYPEM val = HOST(host);                                            \
+    *(TYPEE *)(vd + H(reg_off)) = val;                                 \
 }
 
 #define DO_LD_TLB(NAME, H, TYPEE, TYPEM, TLB) \
@@ -4411,7 +4391,7 @@ static inline bool test_host_page(void *host)
 static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
                       uint32_t desc, const uintptr_t retaddr,
                       const int esz, const int msz,
-                      sve_ld1_host_fn *host_fn,
+                      sve_ldst1_host_fn *host_fn,
                       sve_ldst1_tlb_fn *tlb_fn)
 {
     const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
@@ -4445,8 +4425,12 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
     if (likely(split == mem_max)) {
         host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
         if (test_host_page(host)) {
-            mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
-            tcg_debug_assert(mem_off == mem_max);
+            intptr_t i = reg_off;
+            host -= mem_off;
+            do {
+                host_fn(vd, i, host + (i >> diffsz));
+                i = find_next_active(vg, i + (1 << esz), reg_max, esz);
+            } while (i < reg_max);
             /* After having taken any fault, zero leading inactive elements. */
             swap_memzero(vd, reg_off);
             return;
@@ -4459,7 +4443,12 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
      */
 #ifdef CONFIG_USER_ONLY
     swap_memzero(&scratch, reg_off);
-    host_fn(&scratch, vg, g2h(addr), mem_off, mem_max);
+    host = g2h(addr);
+    do {
+        host_fn(&scratch, reg_off, host + (reg_off >> diffsz));
+        reg_off += 1 << esz;
+        reg_off = find_next_active(vg, reg_off, reg_max, esz);
+    } while (reg_off < reg_max);
 #else
     memset(&scratch, 0, reg_max);
     goto start;
@@ -4477,9 +4466,13 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
             host = tlb_vaddr_to_host(env, addr + mem_off,
                                      MMU_DATA_LOAD, mmu_idx);
             if (host) {
-                mem_off = host_fn(&scratch, vg, host - mem_off,
-                                  mem_off, split);
-                reg_off = mem_off << diffsz;
+                host -= mem_off;
+                do {
+                    host_fn(&scratch, reg_off, host + mem_off);
+                    reg_off += 1 << esz;
+                    reg_off = find_next_active(vg, reg_off, reg_max, esz);
+                    mem_off = reg_off >> diffsz;
+                } while (split - mem_off >= (1 << msz));
                 continue;
             }
         }
@@ -4706,7 +4699,7 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
 static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                         uint32_t desc, const uintptr_t retaddr,
                         const int esz, const int msz,
-                        sve_ld1_host_fn *host_fn,
+                        sve_ldst1_host_fn *host_fn,
                         sve_ldst1_tlb_fn *tlb_fn)
 {
     const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
@@ -4716,7 +4709,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     const int diffsz = esz - msz;
     const intptr_t reg_max = simd_oprsz(desc);
     const intptr_t mem_max = reg_max >> diffsz;
-    intptr_t split, reg_off, mem_off;
+    intptr_t split, reg_off, mem_off, i;
     void *host;
 
     /* Skip to the first active element.  */
@@ -4739,28 +4732,18 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     if (likely(split == mem_max)) {
         host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
         if (test_host_page(host)) {
-            mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
-            tcg_debug_assert(mem_off == mem_max);
+            i = reg_off;
+            host -= mem_off;
+            do {
+                host_fn(vd, i, host + (i >> diffsz));
+                i = find_next_active(vg, i + (1 << esz), reg_max, esz);
+            } while (i < reg_max);
             /* After any fault, zero any leading inactive elements.  */
             swap_memzero(vd, reg_off);
             return;
         }
     }
 
-#ifdef CONFIG_USER_ONLY
-    /*
-     * The page(s) containing this first element at ADDR+MEM_OFF must
-     * be valid.  Considering that this first element may be misaligned
-     * and cross a page boundary itself, take the rest of the page from
-     * the last byte of the element.
-     */
-    split = max_for_page(addr, mem_off + (1 << msz) - 1, mem_max);
-    mem_off = host_fn(vd, vg, g2h(addr), mem_off, split);
-
-    /* After any fault, zero any leading inactive elements.  */
-    swap_memzero(vd, reg_off);
-    reg_off = mem_off << diffsz;
-#else
     /*
      * Perform one normal read, which will fault or not.
      * But it is likely to bring the page into the tlb.
@@ -4777,11 +4760,15 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     if (split >= (1 << msz)) {
         host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
         if (host) {
-            mem_off = host_fn(vd, vg, host - mem_off, mem_off, split);
-            reg_off = mem_off << diffsz;
+            host -= mem_off;
+            do {
+                host_fn(vd, reg_off, host + mem_off);
+                reg_off += 1 << esz;
+                reg_off = find_next_active(vg, reg_off, reg_max, esz);
+                mem_off = reg_off >> diffsz;
+            } while (split - mem_off >= (1 << msz));
         }
     }
-#endif
 
     record_fault(env, reg_off, reg_max);
 }
@@ -4791,7 +4778,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
  */
 static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
                         uint32_t desc, const int esz, const int msz,
-                        sve_ld1_host_fn *host_fn)
+                        sve_ldst1_host_fn *host_fn)
 {
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     void *vd = &env->vfp.zregs[rd];
@@ -4806,7 +4793,13 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
     host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_idx);
     if (likely(page_check_range(addr, mem_max, PAGE_READ) == 0)) {
         /* The entire operation is valid and will not fault.  */
-        host_fn(vd, vg, host, 0, mem_max);
+        reg_off = 0;
+        do {
+            mem_off = reg_off >> diffsz;
+            host_fn(vd, reg_off, host + mem_off);
+            reg_off += 1 << esz;
+            reg_off = find_next_active(vg, reg_off, reg_max, esz);
+        } while (reg_off < reg_max);
         return;
     }
 #endif
@@ -4826,8 +4819,12 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
     if (page_check_range(addr + mem_off, 1 << msz, PAGE_READ) == 0) {
         /* At least one load is valid; take the rest of the page.  */
         split = max_for_page(addr, mem_off + (1 << msz) - 1, mem_max);
-        mem_off = host_fn(vd, vg, host, mem_off, split);
-        reg_off = mem_off << diffsz;
+        do {
+            host_fn(vd, reg_off, host + mem_off);
+            reg_off += 1 << esz;
+            reg_off = find_next_active(vg, reg_off, reg_max, esz);
+            mem_off = reg_off >> diffsz;
+        } while (split - mem_off >= (1 << msz));
     }
 #else
     /*
@@ -4848,8 +4845,13 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
     host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
     split = max_for_page(addr, mem_off, mem_max);
     if (host && split >= (1 << msz)) {
-        mem_off = host_fn(vd, vg, host - mem_off, mem_off, split);
-        reg_off = mem_off << diffsz;
+        host -= mem_off;
+        do {
+            host_fn(vd, reg_off, host + mem_off);
+            reg_off += 1 << esz;
+            reg_off = find_next_active(vg, reg_off, reg_max, esz);
+            mem_off = reg_off >> diffsz;
+        } while (split - mem_off >= (1 << msz));
     }
 #endif
 
-- 
2.20.1


