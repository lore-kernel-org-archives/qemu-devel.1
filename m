Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A5C54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1809E206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2YW8y5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1809E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8g4-00072T-5A
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zg-00022a-EZ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:28 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Ze-00074I-Vv
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id g12so19266643wmh.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zAWAHddUEw4C2UEsSfPl55AqQD5kSZuypfZNPPCY+D0=;
 b=e2YW8y5DvyDy3CJtt5i2a9URGSSPcPGxrP+a6eVkOe3fvv4KEImYzvKKZ4UO6uoHJJ
 QwRXi0GOoVAcECn2/NjI6RVZYzAY5iaIxYOVFdw7buohwL7vcwsrcxFYTyHhMRNp8aTj
 Em4TN/IdOFtNPo5pVVB2253liCV5u39lLkpqlSqLRtdwj90h8KrFG01hSPuA0eNJHk9N
 vRWYnyOETccugy3LH3IT5IE6SwTOJmF184Cc6M+NxY9tbJJ1qRGPQTY7X27Rmy8+E5Lz
 iVycgdpf2YZ8YiaTcp94OKYvZ4tWClXl5ZgXBe3xlgM5CEdCrgJszCyPyZJ/Kz5XIfXW
 +86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zAWAHddUEw4C2UEsSfPl55AqQD5kSZuypfZNPPCY+D0=;
 b=awwqGY/hhy4aUQbo0oXyVSzvoUGita6ddPOIeP0nHDplsJ77+4F/cgAS0NvoKKhKJ0
 Hwbfq33wCZu84EIqbKah0BxCxblntAQPLw1IcTgRijM7VlGu20RKU77av0wPmalddtpV
 0T3JUyNENNEGTbUONpgVtofwuuN3bfaB3Y52m8q+jknOurudmbFJEZ+dtvU2iHgWSDFi
 9IjnqSBexJhFsRbhhmspAN67uzcIbvdSUwRUhgak0d/bNrnsedpviPk7CpCwK41Hwbq6
 QvvLFe1HdEOs7vsvTEKNt7L2vTWPEGJfDiv/WXuLjI9VDY2rpURcpEocRLwE/ifNH2OF
 LDYA==
X-Gm-Message-State: AGi0PuZNsVr4tb9UY4ZuPRz/LP78QjlO8fAUOijo9Rb+4xEUvQep00YM
 MJuA7u1fjJ4KgvwrW7LfbRTHKnHM1pn3kw==
X-Google-Smtp-Source: APiQypIPihQaz3XN9cQClfu3aWaeJ9BhdbHg8e5ThXnw75eFs95gHkIva7AYsm41wuL/HxIL8lJKVA==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr1649543wml.62.1589204065090;
 Mon, 11 May 2020 06:34:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/34] target/arm: Drop manual handling of
 set/clear_helper_retaddr
Date: Mon, 11 May 2020 14:33:46 +0100
Message-Id: <20200511133405.5275-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Since we converted back to cpu_*_data_ra, we do not need to
do this ourselves.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200508154359.7494-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 655bc9476f4..aad2c8c2371 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4133,12 +4133,6 @@ static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
     return MIN(split, mem_max - mem_off) + mem_off;
 }
 
-#ifndef CONFIG_USER_ONLY
-/* These are normally defined only for CONFIG_USER_ONLY in <exec/cpu_ldst.h> */
-static inline void set_helper_retaddr(uintptr_t ra) { }
-static inline void clear_helper_retaddr(void) { }
-#endif
-
 /*
  * The result of tlb_vaddr_to_host for user-only is just g2h(x),
  * which is always non-null.  Elide the useless test.
@@ -4180,7 +4174,6 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
         return;
     }
     mem_off = reg_off >> diffsz;
-    set_helper_retaddr(retaddr);
 
     /*
      * If the (remaining) load is entirely within a single page, then:
@@ -4195,7 +4188,6 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
         if (test_host_page(host)) {
             mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
             tcg_debug_assert(mem_off == mem_max);
-            clear_helper_retaddr();
             /* After having taken any fault, zero leading inactive elements. */
             swap_memzero(vd, reg_off);
             return;
@@ -4246,7 +4238,6 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
     }
 #endif
 
-    clear_helper_retaddr();
     memcpy(vd, &scratch, reg_max);
 }
 
@@ -4306,7 +4297,6 @@ static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
     intptr_t i, oprsz = simd_oprsz(desc);
     ARMVectorReg scratch[2] = { };
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -4318,7 +4308,6 @@ static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 2 * size;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4333,7 +4322,6 @@ static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
     intptr_t i, oprsz = simd_oprsz(desc);
     ARMVectorReg scratch[3] = { };
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -4346,7 +4334,6 @@ static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 3 * size;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4362,7 +4349,6 @@ static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
     intptr_t i, oprsz = simd_oprsz(desc);
     ARMVectorReg scratch[4] = { };
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -4376,7 +4362,6 @@ static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 4 * size;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4483,7 +4468,6 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
         return;
     }
     mem_off = reg_off >> diffsz;
-    set_helper_retaddr(retaddr);
 
     /*
      * If the (remaining) load is entirely within a single page, then:
@@ -4498,7 +4482,6 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
         if (test_host_page(host)) {
             mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
             tcg_debug_assert(mem_off == mem_max);
-            clear_helper_retaddr();
             /* After any fault, zero any leading inactive elements.  */
             swap_memzero(vd, reg_off);
             return;
@@ -4541,7 +4524,6 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     }
 #endif
 
-    clear_helper_retaddr();
     record_fault(env, reg_off, reg_max);
 }
 
@@ -4687,7 +4669,6 @@ static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
     intptr_t i, oprsz = simd_oprsz(desc);
     void *vd = &env->vfp.zregs[rd];
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -4698,7 +4679,6 @@ static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += msize;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 }
 
 static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4711,7 +4691,6 @@ static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
     void *d1 = &env->vfp.zregs[rd];
     void *d2 = &env->vfp.zregs[(rd + 1) & 31];
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -4723,7 +4702,6 @@ static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 2 * msize;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 }
 
 static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4737,7 +4715,6 @@ static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
     void *d2 = &env->vfp.zregs[(rd + 1) & 31];
     void *d3 = &env->vfp.zregs[(rd + 2) & 31];
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -4750,7 +4727,6 @@ static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 3 * msize;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 }
 
 static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4765,7 +4741,6 @@ static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
     void *d3 = &env->vfp.zregs[(rd + 2) & 31];
     void *d4 = &env->vfp.zregs[(rd + 3) & 31];
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -4779,7 +4754,6 @@ static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 4 * msize;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 }
 
 #define DO_STN_1(N, NAME, ESIZE) \
@@ -4875,7 +4849,6 @@ static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
     intptr_t i, oprsz = simd_oprsz(desc);
     ARMVectorReg scratch = { };
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -4886,7 +4859,6 @@ static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
             i += 4, pg >>= 4;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(vd, &scratch, oprsz);
@@ -4900,7 +4872,6 @@ static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
     intptr_t i, oprsz = simd_oprsz(desc) / 8;
     ARMVectorReg scratch = { };
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; i++) {
         uint8_t pg = *(uint8_t *)(vg + H1(i));
         if (likely(pg & 1)) {
@@ -4908,7 +4879,6 @@ static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
             tlb_fn(env, &scratch, i * 8, base + (off << scale), ra);
         }
     }
-    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(vd, &scratch, oprsz * 8);
@@ -5080,13 +5050,11 @@ static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
     reg_off = find_next_active(vg, 0, reg_max, MO_32);
     if (likely(reg_off < reg_max)) {
         /* Perform one normal read, which will fault or not.  */
-        set_helper_retaddr(ra);
         addr = off_fn(vm, reg_off);
         addr = base + (addr << scale);
         tlb_fn(env, vd, reg_off, addr, ra);
 
         /* The rest of the reads will be non-faulting.  */
-        clear_helper_retaddr();
     }
 
     /* After any fault, zero the leading predicated false elements.  */
@@ -5122,13 +5090,11 @@ static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
     reg_off = find_next_active(vg, 0, reg_max, MO_64);
     if (likely(reg_off < reg_max)) {
         /* Perform one normal read, which will fault or not.  */
-        set_helper_retaddr(ra);
         addr = off_fn(vm, reg_off);
         addr = base + (addr << scale);
         tlb_fn(env, vd, reg_off, addr, ra);
 
         /* The rest of the reads will be non-faulting.  */
-        clear_helper_retaddr();
     }
 
     /* After any fault, zero the leading predicated false elements.  */
@@ -5240,7 +5206,6 @@ static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc);
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; ) {
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
         do {
@@ -5251,7 +5216,6 @@ static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
             i += 4, pg >>= 4;
         } while (i & 15);
     }
-    clear_helper_retaddr();
 }
 
 static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
@@ -5261,7 +5225,6 @@ static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     intptr_t i, oprsz = simd_oprsz(desc) / 8;
 
-    set_helper_retaddr(ra);
     for (i = 0; i < oprsz; i++) {
         uint8_t pg = *(uint8_t *)(vg + H1(i));
         if (likely(pg & 1)) {
@@ -5269,7 +5232,6 @@ static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
             tlb_fn(env, vd, i * 8, base + (off << scale), ra);
         }
     }
-    clear_helper_retaddr();
 }
 
 #define DO_ST1_ZPZ_S(MEM, OFS) \
-- 
2.20.1


