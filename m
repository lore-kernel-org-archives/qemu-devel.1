Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB4C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89168208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K01SY383"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89168208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBv8V-0000Yu-3Q
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6f-0006R3-P1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6d-00021V-Fl
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:41 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6d-00020n-7q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:39 -0400
Received: by mail-pl1-x644.google.com with SMTP id ay11so632423plb.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KhxITN+NjmEXUXhdWp+bRLvbeT9VqflVpRPfCgP2sDA=;
 b=K01SY383f8aqADDrj0upIPIKGpQoU0zUlEzSfCwYctxykf5wgQFE9IQxNCfJvIUNHm
 OBByQVOUBuJtB+6VJ+HI14y2nNJPNWb6WNZVf9FFxwC7DRl8E3+3nNSi6t7kZlQ9zdcp
 PLGc1eEQVk6pT09At+jFxQbd3jBxo556CiGTzFKNiw2Zsm7n/uUf4gj7qfkNNfaTyLyC
 F4sT19Y0R7pevYh/JPYXQpJrn8NWN4ujHcBeqW/Lu83K7lIE/Lm25lUSLevv6IX+dMEq
 7DIwcwj4DX0zeer+KgRew1kBfUu/HMFdZ/G0LqezpZAi6oywzgFLFCz6Ba+tZLnpTxIG
 MDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KhxITN+NjmEXUXhdWp+bRLvbeT9VqflVpRPfCgP2sDA=;
 b=S//qHPpIUpZHU1mrljVodb+jGF6+NkauhGKf8Ag0JeFTPUleyFdylEr4dgrI0+EwmR
 YxwrhgDwSVDRvKLCGfu342NMH9TlEzLV1DtT8hwbbyl++eZ+agUTPjM1HI9M9Z6hR4Cu
 +6SM7Kp6z3m4Kp1pIRMl4D3O2WUY0spfKufmfoNRGXQVyqhe1JIkDtF9IoWXk9tw2hGw
 L7wNgkQcQvpGdZmbc4rze+dinQiZjoOuxjp5t7Sbbbcp+psYFLujfvbIWpcy6mRzKIrb
 Du2tjlzqGZkerVm9tDeR/wnKNEsSwsiV/e11mJb10CWAnn33OPv3rvVOvXSDjoJL1bX8
 jCVw==
X-Gm-Message-State: ANhLgQ2xHMaEaXX71GMfDi4vwMRkSuJN2DyvdO+PdoCjbBe3oAkM6Z0b
 x4y+ze9nTSxgUmCfbzmjn7Oz35hL+NU=
X-Google-Smtp-Source: ADFU+vvHKL5wWPCOVIHa7QNGUf3SAildcKM4fkQKtR5Jg7gw912WM3T1/EfxgLqAfZI7PKsOhBWFaA==
X-Received: by 2002:a17:90a:7309:: with SMTP id
 m9mr1850242pjk.52.1583909077579; 
 Tue, 10 Mar 2020 23:44:37 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/16] target/arm: Use SVEContLdSt for contiguous stores
Date: Tue, 10 Mar 2020 23:44:16 -0700
Message-Id: <20200311064420.30606-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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

Follow the model set up for contiguous loads.  This handles
watchpoints correctly for contiguous stores, recognizing the
exception before any changes to memory.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 288 ++++++++++++++++++++++------------------
 1 file changed, 162 insertions(+), 126 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9198e1612a..c6f22928d5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4002,6 +4002,13 @@ static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
     *(TYPEE *)(vd + H(reg_off)) = val;                                 \
 }
 
+#define DO_ST_HOST(NAME, H, TYPEE, TYPEM, HOST) \
+static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
+{                                                                      \
+    TYPEM val = *(TYPEE *)(vd + H(reg_off));                           \
+    HOST(host, val);                                                   \
+}
+
 #define DO_LD_TLB(NAME, H, TYPEE, TYPEM, BSWAP, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
@@ -4031,6 +4038,7 @@ DO_LD_PRIM_1(ld1bdu,     , uint64_t, uint8_t)
 DO_LD_PRIM_1(ld1bds,     , uint64_t,  int8_t)
 
 #define DO_ST_PRIM_1(NAME, H, TE, TM)                   \
+    DO_ST_HOST(st1##NAME, H, TE, TM, stb_p)             \
     DO_ST_TLB(st1##NAME, H, TE, TM, , cpu_stb_data_ra)
 
 DO_ST_PRIM_1(bb,   H1,  uint8_t, uint8_t)
@@ -4045,6 +4053,8 @@ DO_ST_PRIM_1(bd,     , uint64_t, uint8_t)
     DO_LD_TLB(ld1##NAME##_le, H, TE, TM, le_##BSWAP, cpu_##LD##_data_ra)
 
 #define DO_ST_PRIM_2(NAME, H, TE, TM, BSWAP, ST)        \
+    DO_ST_HOST(st1##NAME##_be, H, TE, TM, ST##_be_p)    \
+    DO_ST_HOST(st1##NAME##_le, H, TE, TM, ST##_le_p)    \
     DO_ST_TLB(st1##NAME##_be, H, TE, TM, be_##BSWAP, cpu_##ST##_data_ra) \
     DO_ST_TLB(st1##NAME##_le, H, TE, TM, le_##BSWAP, cpu_##ST##_data_ra)
 
@@ -4906,151 +4916,177 @@ DO_LDFF1_LDNF1_2(dd,  MO_64, MO_64)
 #undef DO_LDFF1_LDNF1_2
 
 /*
- * Common helpers for all contiguous 1,2,3,4-register predicated stores.
+ * Common helper for all contiguous 1,2,3,4-register predicated stores.
  */
-static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, const uintptr_t ra,
-                      const int esize, const int msize,
-                      sve_ldst1_tlb_fn *tlb_fn)
+
+static inline QEMU_ALWAYS_INLINE
+void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
+               const uintptr_t retaddr, const int esz,
+               const int msz, const int N,
+               sve_ldst1_host_fn *host_fn,
+               sve_ldst1_tlb_fn *tlb_fn)
 {
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    void *vd = &env->vfp.zregs[rd];
+    const intptr_t reg_max = simd_oprsz(desc);
+    intptr_t reg_off, reg_last, mem_off;
+    SVEContLdSt info;
+    void *host;
+    int i, flags;
 
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, vd, i, addr, ra);
+    /* Find the active elements.  */
+    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, N << msz)) {
+        /* The entire predicate was false; no store occurs.  */
+        return;
+    }
+
+    /* Probe the page(s).  Exit with exception for any invalid page. */
+    sve_cont_ldst_pages(&info, FAULT_ALL, env, addr, MMU_DATA_STORE, retaddr);
+
+    /* Handle watchpoints for all active elements. */
+    sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, N << msz,
+                              BP_MEM_WRITE, retaddr);
+
+    /* TODO: MTE check. */
+
+    flags = info.page[0].flags | info.page[1].flags;
+    if (unlikely(flags != 0)) {
+#ifdef CONFIG_USER_ONLY
+        g_assert_not_reached();
+#else
+        /*
+         * At least one page includes MMIO.
+         * Any bus operation can fail with cpu_transaction_failed,
+         * which for ARM will raise SyncExternal.  We cannot avoid
+         * this fault and will leave with the store incomplete.
+         */
+        mem_off = info.mem_off_first[0];
+        reg_off = info.reg_off_first[0];
+        reg_last = info.reg_off_last[1];
+        if (reg_last < 0) {
+            reg_last = info.reg_off_split;
+            if (reg_last < 0) {
+                reg_last = info.reg_off_last[0];
             }
-            i += esize, pg >>= esize;
-            addr += msize;
-        } while (i & 15);
+        }
+
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    for (i = 0; i < N; ++i) {
+                        tlb_fn(env, &env->vfp.zregs[(rd + i) & 31], reg_off,
+                               addr + mem_off + (i << msz), retaddr);
+                    }
+                }
+                reg_off += 1 << esz;
+                mem_off += N << msz;
+            } while (reg_off & 63);
+        } while (reg_off <= reg_last);
+        return;
+#endif
+    }
+
+    mem_off = info.mem_off_first[0];
+    reg_off = info.reg_off_first[0];
+    reg_last = info.reg_off_last[0];
+    host = info.page[0].host;
+
+    while (reg_off <= reg_last) {
+        uint64_t pg = vg[reg_off >> 6];
+        do {
+            if ((pg >> (reg_off & 63)) & 1) {
+                for (i = 0; i < N; ++i) {
+                    host_fn(&env->vfp.zregs[(rd + i) & 31], reg_off,
+                            host + mem_off + (i << msz));
+                }
+            }
+            reg_off += 1 << esz;
+            mem_off += N << msz;
+        } while (reg_off <= reg_last && (reg_off & 63));
+    }
+
+    /*
+     * Use the slow path to manage the cross-page misalignment.
+     * But we know this is RAM and cannot trap.
+     */
+    mem_off = info.mem_off_split;
+    if (unlikely(mem_off >= 0)) {
+        reg_off = info.reg_off_split;
+        for (i = 0; i < N; ++i) {
+            tlb_fn(env, &env->vfp.zregs[(rd + i) & 31], reg_off,
+                   addr + mem_off + (i << msz), retaddr);
+        }
+    }
+
+    mem_off = info.mem_off_first[1];
+    if (unlikely(mem_off >= 0)) {
+        reg_off = info.reg_off_first[1];
+        reg_last = info.reg_off_last[1];
+        host = info.page[1].host;
+
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    for (i = 0; i < N; ++i) {
+                        host_fn(&env->vfp.zregs[(rd + i) & 31], reg_off,
+                                host + mem_off + (i << msz));
+                    }
+                }
+                reg_off += 1 << esz;
+                mem_off += N << msz;
+            } while (reg_off & 63);
+        } while (reg_off <= reg_last);
     }
 }
 
-static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, const uintptr_t ra,
-                      const int esize, const int msize,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    void *d1 = &env->vfp.zregs[rd];
-    void *d2 = &env->vfp.zregs[(rd + 1) & 31];
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, d1, i, addr, ra);
-                tlb_fn(env, d2, i, addr + msize, ra);
-            }
-            i += esize, pg >>= esize;
-            addr += 2 * msize;
-        } while (i & 15);
-    }
-}
-
-static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, const uintptr_t ra,
-                      const int esize, const int msize,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    void *d1 = &env->vfp.zregs[rd];
-    void *d2 = &env->vfp.zregs[(rd + 1) & 31];
-    void *d3 = &env->vfp.zregs[(rd + 2) & 31];
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, d1, i, addr, ra);
-                tlb_fn(env, d2, i, addr + msize, ra);
-                tlb_fn(env, d3, i, addr + 2 * msize, ra);
-            }
-            i += esize, pg >>= esize;
-            addr += 3 * msize;
-        } while (i & 15);
-    }
-}
-
-static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, const uintptr_t ra,
-                      const int esize, const int msize,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    void *d1 = &env->vfp.zregs[rd];
-    void *d2 = &env->vfp.zregs[(rd + 1) & 31];
-    void *d3 = &env->vfp.zregs[(rd + 2) & 31];
-    void *d4 = &env->vfp.zregs[(rd + 3) & 31];
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, d1, i, addr, ra);
-                tlb_fn(env, d2, i, addr + msize, ra);
-                tlb_fn(env, d3, i, addr + 2 * msize, ra);
-                tlb_fn(env, d4, i, addr + 3 * msize, ra);
-            }
-            i += esize, pg >>= esize;
-            addr += 4 * msize;
-        } while (i & 15);
-    }
-}
-
-#define DO_STN_1(N, NAME, ESIZE) \
-void QEMU_FLATTEN HELPER(sve_st##N##NAME##_r) \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
+#define DO_STN_1(N, NAME, ESZ) \
+void HELPER(sve_st##N##NAME##_r)(CPUARMState *env, void *vg,        \
+                                 target_ulong addr, uint32_t desc)  \
 {                                                                   \
-    sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, 1,           \
-                  sve_st1##NAME##_tlb);                             \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, N,           \
+              sve_st1##NAME##_host, sve_st1##NAME##_tlb);           \
 }
 
-#define DO_STN_2(N, NAME, ESIZE, MSIZE) \
-void QEMU_FLATTEN HELPER(sve_st##N##NAME##_le_r) \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+#define DO_STN_2(N, NAME, ESZ, MSZ) \
+void HELPER(sve_st##N##NAME##_le_r)(CPUARMState *env, void *vg,       \
+                                    target_ulong addr, uint32_t desc) \
 {                                                                     \
-    sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
-                  sve_st1##NAME##_le_tlb);                            \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,              \
+              sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);       \
 }                                                                     \
-void QEMU_FLATTEN HELPER(sve_st##N##NAME##_be_r)                      \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+void HELPER(sve_st##N##NAME##_be_r)(CPUARMState *env, void *vg,       \
+                                    target_ulong addr, uint32_t desc) \
 {                                                                     \
-    sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
-                  sve_st1##NAME##_be_tlb);                            \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,              \
+              sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);       \
 }
 
-DO_STN_1(1, bb, 1)
-DO_STN_1(1, bh, 2)
-DO_STN_1(1, bs, 4)
-DO_STN_1(1, bd, 8)
-DO_STN_1(2, bb, 1)
-DO_STN_1(3, bb, 1)
-DO_STN_1(4, bb, 1)
+DO_STN_1(1, bb, MO_8)
+DO_STN_1(1, bh, MO_16)
+DO_STN_1(1, bs, MO_32)
+DO_STN_1(1, bd, MO_64)
+DO_STN_1(2, bb, MO_8)
+DO_STN_1(3, bb, MO_8)
+DO_STN_1(4, bb, MO_8)
 
-DO_STN_2(1, hh, 2, 2)
-DO_STN_2(1, hs, 4, 2)
-DO_STN_2(1, hd, 8, 2)
-DO_STN_2(2, hh, 2, 2)
-DO_STN_2(3, hh, 2, 2)
-DO_STN_2(4, hh, 2, 2)
+DO_STN_2(1, hh, MO_16, MO_16)
+DO_STN_2(1, hs, MO_32, MO_16)
+DO_STN_2(1, hd, MO_64, MO_16)
+DO_STN_2(2, hh, MO_16, MO_16)
+DO_STN_2(3, hh, MO_16, MO_16)
+DO_STN_2(4, hh, MO_16, MO_16)
 
-DO_STN_2(1, ss, 4, 4)
-DO_STN_2(1, sd, 8, 4)
-DO_STN_2(2, ss, 4, 4)
-DO_STN_2(3, ss, 4, 4)
-DO_STN_2(4, ss, 4, 4)
+DO_STN_2(1, ss, MO_32, MO_32)
+DO_STN_2(1, sd, MO_64, MO_32)
+DO_STN_2(2, ss, MO_32, MO_32)
+DO_STN_2(3, ss, MO_32, MO_32)
+DO_STN_2(4, ss, MO_32, MO_32)
 
-DO_STN_2(1, dd, 8, 8)
-DO_STN_2(2, dd, 8, 8)
-DO_STN_2(3, dd, 8, 8)
-DO_STN_2(4, dd, 8, 8)
+DO_STN_2(1, dd, MO_64, MO_64)
+DO_STN_2(2, dd, MO_64, MO_64)
+DO_STN_2(3, dd, MO_64, MO_64)
+DO_STN_2(4, dd, MO_64, MO_64)
 
 #undef DO_STN_1
 #undef DO_STN_2
-- 
2.20.1


