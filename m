Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F03DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB81520725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgxLQVg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB81520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5Qy-0005Pq-Ty
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5At-0007vM-Ay
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:31 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ar-0005ey-DY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:30 -0400
Received: by mail-pj1-x1044.google.com with SMTP id 7so5362328pjo.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JFw94RsIxJxFivVcuXkKXo6q5XbvxxZGz8yeQyMWqCM=;
 b=FgxLQVg4gMsfyp1vDGi0yT4THchWQaZgiMxUAEk++/zIRojwET643mRnTnr1Nob6uc
 +IJv9hqVfiLlO84k+4Lo3gsjvwqnMl6C0rx4DptFGIrY+xsZWdpUL1rt9PdQw4kLi6RZ
 Hhpyt5KTNknTbqyJi5hFSDr5NXGAsttVYnEtjRSlrvCgR0tfn21zuBfAo/sJe/7UaoCk
 O8Yky3ER7aj1CY5RqTdJiaAjK8/0g/FmxxHdkJkQtYtR0g7jJAYtbzhMzItX/I2xtCHY
 Vii+TMqbxKYJobjrAI4jspXppzMl1FRLwQ6h31SfObK+nzEae0EjRbKIle+ugX4fU3W0
 O2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JFw94RsIxJxFivVcuXkKXo6q5XbvxxZGz8yeQyMWqCM=;
 b=VnuUGmMNCQxaAxZkoRM1bZtFT+wDsPiRSlIyA8bHb5tozpkyNWK68hSlGFkwChb1cz
 guQCXEXZWEsxYTxA5jnUS+JoPH5TUXY7HCw3sVKWQbLEQSBgBXo1C3bv/HFGwGXX/6wB
 zrUm5sMPeYOIPQIBJn/eMjgu88M1F8YBH0H00wKghwmwuzDqCzrX9kPIwrCVVK9B7ASM
 AB0v6roiZmU6YvOeqAcCMYgniWMM9K4bi8C1zH6cuRuHKCZTzza/f9aplwLxSranpxMU
 QwG7y2RFAN1SBoFcLG/UY04expeDj44MgMPWFjvYR7ikFbr7KNqstML0o5y3BkQyJG1B
 VOaQ==
X-Gm-Message-State: AGi0Pua0/IEab/BC9UZ5F/lg3YrIveUNjZxnIjS1TsXzQvJ3kwPTjHD6
 C8LyqoPw2VYyztXRSAfnAL4kRl/hbyI=
X-Google-Smtp-Source: APiQypIzi/df03qRaV4Om0qey438TtHiXW4pteKVVn3YnD3h4WQL12H5IYwZe02y3K7pBvBi5JaEAg==
X-Received: by 2002:a17:90a:7065:: with SMTP id
 f92mr6653664pjk.160.1588952665760; 
 Fri, 08 May 2020 08:44:25 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o99sm2727662pjo.8.2020.05.08.08.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:44:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/19] target/arm: Use SVEContLdSt for contiguous stores
Date: Fri,  8 May 2020 08:43:55 -0700
Message-Id: <20200508154359.7494-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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


