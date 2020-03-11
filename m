Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C91EC10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBEC2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QR0vyAfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBEC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvEm-0002AQ-GA
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6b-0006FL-PO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6Z-0001ws-Kd
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:37 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:34341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6Y-0001tB-7v
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id a23so630448plm.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3qRBHeH49omwqgoxg8Z+ZrefAQ7kYCLg+akntsfuZdA=;
 b=QR0vyAfXuvl8umdBF3mzlxvOCfvxsRghnY2q01fR0IaVMAMSiFnoy9QsH7BNhA652F
 MFLrDpP6DPCiSXowIJfoAgQHSdz7uZeNQz2DeY50VZFkuJghMXu5FsU5zzvW+j4cVoaD
 bXO45GF7RwA5i+Dmsu5bPT8Nrs2XRII0sVS6dSeQhbXapVNWF/JIgV/bt7MjV7gu6BmX
 FyAIiUn88NWN47ByGImQFIVw2gZP/cWrTPUgX6L88NY3f+86Iy26fxNP135MFGqDTIKg
 /VqZ7aqTlJ3YFTPVc8xnS/qLAfcQx+0qffx71PjMhsrHEnJTyrUDAMBM+YL1v/XkU7FO
 kULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3qRBHeH49omwqgoxg8Z+ZrefAQ7kYCLg+akntsfuZdA=;
 b=FfkvzGM8HwnfJEqJBrunbMTqi8nwct50dsjRhuL5MvkdlO50qFZfsNSnoOveocgz6m
 FCUN+CAwnDkfu8Scp1UUXLfvjn2a9aSYtj2IxI/7Mu053zSHbeZiY6rUY6947U94yVPh
 e/lAyl8DXjJgOQVcNWhyDO/dGyKvW5O3h0tdTsItjDIDlLsRC9MzYWCAzv4edcXKeOcQ
 dHNBADVhJTdwzQNGfwsxT+DT1LFxIymQ8AQ8irBZJ5jIh3m24rJbPikFdyhcKYiht2GI
 8uuE73/LZRNb0RpDJ9q1pr2SP+Vya9M5oFfmY81W7PTkKz2X3aKt1s3V22O1GpYh5Jon
 7cdQ==
X-Gm-Message-State: ANhLgQ0rovBZPqlpPqEqApRjmAfZ41ZM0qExlr4Ck763POA0Hh6atZ6L
 itukmB0N3wsZSMpwDUW9UoWhRdMWo/w=
X-Google-Smtp-Source: ADFU+vuZuH6tHfEPvGuVxPO2i2jSrf7AW1wuRDOSvQlQVE7cyjpgrEhBFZG+P32jS1JXgkDSWByBoQ==
X-Received: by 2002:a17:902:7b8d:: with SMTP id
 w13mr1795283pll.78.1583909070792; 
 Tue, 10 Mar 2020 23:44:30 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] target/arm: Adjust interface of sve_ld1_host_fn
Date: Tue, 10 Mar 2020 23:44:11 -0700
Message-Id: <20200311064420.30606-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 127 +++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 61 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 3f653e46a0..1397c2b634 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3972,20 +3972,10 @@ void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
  */
 
 /*
- * Load elements into @vd, controlled by @vg, from @host + @mem_ofs.
- * Memory is valid through @host + @mem_max.  The register element
- * indicies are inferred from @mem_ofs, as modified by the types for
- * which the helper is built.  Return the @mem_ofs of the first element
- * not loaded (which is @mem_max if they are all loaded).
- *
- * For softmmu, we have fully validated the guest page.  For user-only,
- * we cannot fully validate without taking the mmap lock, but since we
- * know the access is within one host page, if any access is valid they
- * all must be valid.  However, when @vg is all false, it may be that
- * no access is valid.
+ * Load elements into @vd + @reg_off, from @host,
+ * or the reverse for stores.
  */
-typedef intptr_t sve_ld1_host_fn(void *vd, void *vg, void *host,
-                                 intptr_t mem_ofs, intptr_t mem_max);
+typedef void sve_ldst1_host_fn(void *vd, intptr_t reg_off, void *host);
 
 /*
  * Load one element into @vd + @reg_off from (@env, @vaddr, @ra).
@@ -4000,23 +3990,16 @@ typedef void sve_ldst1_tlb_fn(CPUARMState *env, void *vd, intptr_t reg_off,
  * For *_tlb, this uses the cpu_*_data_ra helpers.  There are not
  * endian-specific versions of these, so we must handle endianness
  * locally.
+ *
+ * For *_host, this is a trivial application of the <qemu/bswap.h>
+ * endian-specific access followed by a store into the vector register.
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
 
 #define DO_LD_TLB(NAME, H, TYPEE, TYPEM, BSWAP, TLB) \
@@ -4414,7 +4397,7 @@ static inline bool test_host_page(void *host)
 static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
                       uint32_t desc, const uintptr_t retaddr,
                       const int esz, const int msz,
-                      sve_ld1_host_fn *host_fn,
+                      sve_ldst1_host_fn *host_fn,
                       sve_ldst1_tlb_fn *tlb_fn)
 {
     const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
@@ -4448,8 +4431,12 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
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
@@ -4462,7 +4449,12 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
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
@@ -4480,9 +4472,13 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
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
@@ -4709,7 +4705,7 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
 static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                         uint32_t desc, const uintptr_t retaddr,
                         const int esz, const int msz,
-                        sve_ld1_host_fn *host_fn,
+                        sve_ldst1_host_fn *host_fn,
                         sve_ldst1_tlb_fn *tlb_fn)
 {
     const TCGMemOpIdx oi = extract32(desc, SIMD_DATA_SHIFT, MEMOPIDX_SHIFT);
@@ -4719,7 +4715,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     const int diffsz = esz - msz;
     const intptr_t reg_max = simd_oprsz(desc);
     const intptr_t mem_max = reg_max >> diffsz;
-    intptr_t split, reg_off, mem_off;
+    intptr_t split, reg_off, mem_off, i;
     void *host;
 
     /* Skip to the first active element.  */
@@ -4742,28 +4738,18 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
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
@@ -4780,11 +4766,15 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
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
@@ -4794,7 +4784,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
  */
 static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
                         uint32_t desc, const int esz, const int msz,
-                        sve_ld1_host_fn *host_fn)
+                        sve_ldst1_host_fn *host_fn)
 {
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
     void *vd = &env->vfp.zregs[rd];
@@ -4809,7 +4799,13 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
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
@@ -4829,8 +4825,12 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
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
@@ -4851,8 +4851,13 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
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


