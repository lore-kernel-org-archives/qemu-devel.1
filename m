Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD83FC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1672070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFmMudyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1672070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCMZ-00027P-LK
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3F-0001u2-OO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3B-0006gZ-2a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:41 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC3A-0006fw-LT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id d17so2989301pgo.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JFw94RsIxJxFivVcuXkKXo6q5XbvxxZGz8yeQyMWqCM=;
 b=cFmMudyCL5EI8OXGwns3X5ZE4DD6TKeFnanfayi3wjqcOP4XMi/IzjYjKW4x/bjZg4
 2RaocvujBqiVo4mJRcYyXNQD/5KKZCvRxbt4LOza1u5CKGKh0kWl4lui5xVyktXtMJan
 FSsq/arZksdJbqydh3CrX9Xofby9GFuttXCLBUeuY9M49LoeRFQzY9XSf8nE8swYslYh
 u/rq+BprLSmFLYXeEqQ3f41jmTojRmQAJYeG2lDyimLQ+yDe6v5AlUJTCxp/AtTMa1Nl
 QxBvZLh0BgZjuJSXBmL2zTBdtNl7zwYwzwIZhiQroOE4ZoyxOKCJqm2wUFjp5IeKPjBE
 HOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JFw94RsIxJxFivVcuXkKXo6q5XbvxxZGz8yeQyMWqCM=;
 b=sOUws+tff1sqWiGnTKaERT0oB8vQiwPUr/r1BSP652XZkVghsksHgBA8LqWUGHqdZd
 s+4M1TNl86Gp/DsD68qZjo0DC4cWmXQbvQhHs4R9dJAt9kYl9vHiqUftPwgm17K9VlSG
 EHxRysUI/HqSYex4aH8WPBYVR87BazKkllFyeUuIxqOov9G1S/XgNGWMLDLigHyf9IAV
 /SH05K57Fq1ztAQyo3ynkd0Es8S1oPy7c5O4U/c+XxojDzsW7qo2Msb4/EBcVi6mtwnn
 k5Hf8S9jMZpFjmP0LGcTuFOQHW+MYFawbH3PlnVufTa7fZVs69Gk/Gixcs6Zs6JKLsb2
 oyTQ==
X-Gm-Message-State: AGi0PuZu0F+bGe9JENgUAvQeLiMhSPgCMgsGyqLbG12IET1/yIRFtPps
 Q1sBtI1bxiXpZWPhYWy6vevyhhc+M9k=
X-Google-Smtp-Source: APiQypIFccFxsXjvfYO7FPxUrRTbrBuIA46egB9sf0m03sOmduvWhhJBwNNZB7ca6VVXMKUSU0Qg/Q==
X-Received: by 2002:a63:b604:: with SMTP id j4mr4041718pgf.124.1588264114413; 
 Thu, 30 Apr 2020 09:28:34 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/18] target/arm: Use SVEContLdSt for contiguous stores
Date: Thu, 30 Apr 2020 09:28:09 -0700
Message-Id: <20200430162813.17671-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Follow the model set up for contiguous loads.  This handles
watchpoints correctly for contiguous stores, recognizing the
exception before any changes to memory.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 285 ++++++++++++++++++++++------------------
 1 file changed, 159 insertions(+), 126 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f4969347d4..4ed9bbe1ee 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3995,6 +3995,10 @@ static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
     *(TYPEE *)(vd + H(reg_off)) = val;                                 \
 }
 
+#define DO_ST_HOST(NAME, H, TYPEE, TYPEM, HOST) \
+static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
+{ HOST(host, (TYPEM)*(TYPEE *)(vd + H(reg_off))); }
+
 #define DO_LD_TLB(NAME, H, TYPEE, TYPEM, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
@@ -4022,6 +4026,7 @@ DO_LD_PRIM_1(ld1bdu,     , uint64_t, uint8_t)
 DO_LD_PRIM_1(ld1bds,     , uint64_t,  int8_t)
 
 #define DO_ST_PRIM_1(NAME, H, TE, TM)                   \
+    DO_ST_HOST(st1##NAME, H, TE, TM, stb_p)             \
     DO_ST_TLB(st1##NAME, H, TE, TM, cpu_stb_data_ra)
 
 DO_ST_PRIM_1(bb,   H1,  uint8_t, uint8_t)
@@ -4036,6 +4041,8 @@ DO_ST_PRIM_1(bd,     , uint64_t, uint8_t)
     DO_LD_TLB(ld1##NAME##_le, H, TE, TM, cpu_##LD##_le_data_ra)
 
 #define DO_ST_PRIM_2(NAME, H, TE, TM, ST) \
+    DO_ST_HOST(st1##NAME##_be, H, TE, TM, ST##_be_p)    \
+    DO_ST_HOST(st1##NAME##_le, H, TE, TM, ST##_le_p)    \
     DO_ST_TLB(st1##NAME##_be, H, TE, TM, cpu_##ST##_be_data_ra) \
     DO_ST_TLB(st1##NAME##_le, H, TE, TM, cpu_##ST##_le_data_ra)
 
@@ -4908,151 +4915,177 @@ DO_LDFF1_LDNF1_2(dd,  MO_64, MO_64)
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


