Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB85BC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838AC206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srQeX/Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838AC206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8mf-0001jq-Kz
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zs-0002Op-N8
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zm-00079c-MY
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so10998000wra.7
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FTcEdx91hjfnjb5bAZdKCB6+k5I0zgrWRM2RflzJehk=;
 b=srQeX/Qln56Dem9F3aOmGtplST7mUJ17CcfUfhtlSiS0rHDwwU86Q+tuucUhIcfu+m
 VxrC6fP4V/1n2uoAmva8BiIHDCC8axIM0T1gSCLy1Eu4kVKXoGXj4uMG0aAP+L3qIIy8
 AtkUvJ8dLIbGWH1fnW0GDUKLnuvWR6VCN9hchqUoAb5NUXg8YcYPIdS6/DW38RBvqjs1
 /s3NnEJjPEXAg4E0kmNGab9s9kh+Vz8pleTpCnizQ9NExCY9Ow71+er/TFes9icQjHCr
 QbqKoLDnxypcoDmtcv/8YvsbFkgof9LCA1U3aPWJFpwT8vZFwNMO0cUpuOmhhg9+V3g4
 nAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FTcEdx91hjfnjb5bAZdKCB6+k5I0zgrWRM2RflzJehk=;
 b=kaVF4UMXUdkPRbGH6ZkuSCISrO2OesZSrMdr3weEiDWmAjcF9kNlTk3+TJdJBhNpMX
 6Yr+nosARWf6/4eVvu51vdyGmDvyCYQYzTO9J0Wdt5RGeItrztj5bfHIsF+vdh3nRODj
 Qhyirs13p+v6kqywYlvAEbyWHXNKVC2d8c3UBoKoPh0+FVSFCPb+XFevY2jZX2roMfyT
 kcSHWtLrHh1FD7546fXVWoQnb5U+BsYMWENElLq0FlBVeJKO7O4XuGGM4GMVginGlnGF
 nqBV5ubrosA+SEK2D5EKDBhobDs2/oUBFT6QvtXxcIzYNX5TMuYSPMuEJr856dV+M9t6
 6V6A==
X-Gm-Message-State: AGi0PuYDEA3ejHTz69DvU3PvOXQ4ZeV2E/CbsPFxsvqNk+njZ0R/vU6q
 6szllBRjjI9isloUZ1txFjxlzpafDwbGdw==
X-Google-Smtp-Source: APiQypIYmLc7vo+hFN8yK2YtPzIXaiQRI6klLNhEX1mdRZCRiY52XhGAqFiv/rSuXy81R7r0IMnKOg==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr19503297wrm.106.1589204072830; 
 Mon, 11 May 2020 06:34:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/34] target/arm: Use SVEContLdSt for multi-register
 contiguous loads
Date: Mon, 11 May 2020 14:33:51 +0100
Message-Id: <20200511133405.5275-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200508154359.7494-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 223 ++++++++++++++--------------------------
 1 file changed, 79 insertions(+), 144 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 7992a569b0a..9365e326464 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4449,27 +4449,28 @@ static inline bool test_host_page(void *host)
 }
 
 /*
- * Common helper for all contiguous one-register predicated loads.
+ * Common helper for all contiguous 1,2,3,4-register predicated stores.
  */
 static inline QEMU_ALWAYS_INLINE
-void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
+void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
                uint32_t desc, const uintptr_t retaddr,
-               const int esz, const int msz,
+               const int esz, const int msz, const int N,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    void *vd = &env->vfp.zregs[rd];
     const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off, reg_last, mem_off;
     SVEContLdSt info;
     void *host;
-    int flags;
+    int flags, i;
 
     /* Find the active elements.  */
-    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, 1 << msz)) {
+    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, N << msz)) {
         /* The entire predicate was false; no load occurs.  */
-        memset(vd, 0, reg_max);
+        for (i = 0; i < N; ++i) {
+            memset(&env->vfp.zregs[(rd + i) & 31], 0, reg_max);
+        }
         return;
     }
 
@@ -4477,7 +4478,7 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
     sve_cont_ldst_pages(&info, FAULT_ALL, env, addr, MMU_DATA_LOAD, retaddr);
 
     /* Handle watchpoints for all active elements. */
-    sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, 1 << msz,
+    sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, N << msz,
                               BP_MEM_READ, retaddr);
 
     /* TODO: MTE check. */
@@ -4493,9 +4494,8 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
          * which for ARM will raise SyncExternal.  Perform the load
          * into scratch memory to preserve register state until the end.
          */
-        ARMVectorReg scratch;
+        ARMVectorReg scratch[4] = { };
 
-        memset(&scratch, 0, reg_max);
         mem_off = info.mem_off_first[0];
         reg_off = info.reg_off_first[0];
         reg_last = info.reg_off_last[1];
@@ -4510,21 +4510,29 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
             uint64_t pg = vg[reg_off >> 6];
             do {
                 if ((pg >> (reg_off & 63)) & 1) {
-                    tlb_fn(env, &scratch, reg_off, addr + mem_off, retaddr);
+                    for (i = 0; i < N; ++i) {
+                        tlb_fn(env, &scratch[i], reg_off,
+                               addr + mem_off + (i << msz), retaddr);
+                    }
                 }
                 reg_off += 1 << esz;
-                mem_off += 1 << msz;
+                mem_off += N << msz;
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
 
-        memcpy(vd, &scratch, reg_max);
+        for (i = 0; i < N; ++i) {
+            memcpy(&env->vfp.zregs[(rd + i) & 31], &scratch[i], reg_max);
+        }
         return;
 #endif
     }
 
     /* The entire operation is in RAM, on valid pages. */
 
-    memset(vd, 0, reg_max);
+    for (i = 0; i < N; ++i) {
+        memset(&env->vfp.zregs[(rd + i) & 31], 0, reg_max);
+    }
+
     mem_off = info.mem_off_first[0];
     reg_off = info.reg_off_first[0];
     reg_last = info.reg_off_last[0];
@@ -4534,10 +4542,13 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
         uint64_t pg = vg[reg_off >> 6];
         do {
             if ((pg >> (reg_off & 63)) & 1) {
-                host_fn(vd, reg_off, host + mem_off);
+                for (i = 0; i < N; ++i) {
+                    host_fn(&env->vfp.zregs[(rd + i) & 31], reg_off,
+                            host + mem_off + (i << msz));
+                }
             }
             reg_off += 1 << esz;
-            mem_off += 1 << msz;
+            mem_off += N << msz;
         } while (reg_off <= reg_last && (reg_off & 63));
     }
 
@@ -4547,7 +4558,11 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
      */
     mem_off = info.mem_off_split;
     if (unlikely(mem_off >= 0)) {
-        tlb_fn(env, vd, info.reg_off_split, addr + mem_off, retaddr);
+        reg_off = info.reg_off_split;
+        for (i = 0; i < N; ++i) {
+            tlb_fn(env, &env->vfp.zregs[(rd + i) & 31], reg_off,
+                   addr + mem_off + (i << msz), retaddr);
+        }
     }
 
     mem_off = info.mem_off_first[1];
@@ -4560,10 +4575,13 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
             uint64_t pg = vg[reg_off >> 6];
             do {
                 if ((pg >> (reg_off & 63)) & 1) {
-                    host_fn(vd, reg_off, host + mem_off);
+                    for (i = 0; i < N; ++i) {
+                        host_fn(&env->vfp.zregs[(rd + i) & 31], reg_off,
+                                host + mem_off + (i << msz));
+                    }
                 }
                 reg_off += 1 << esz;
-                mem_off += 1 << msz;
+                mem_off += N << msz;
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
     }
@@ -4573,7 +4591,7 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
 void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
                             target_ulong addr, uint32_t desc)  \
 {                                                              \
-    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, 0,            \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1,      \
               sve_##NAME##_host, sve_##NAME##_tlb);            \
 }
 
@@ -4581,159 +4599,76 @@ void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
 void HELPER(sve_##NAME##_le_r)(CPUARMState *env, void *vg,        \
                                target_ulong addr, uint32_t desc)  \
 {                                                                 \
-    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,          \
               sve_##NAME##_le_host, sve_##NAME##_le_tlb);         \
 }                                                                 \
 void HELPER(sve_##NAME##_be_r)(CPUARMState *env, void *vg,        \
                                target_ulong addr, uint32_t desc)  \
 {                                                                 \
-    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,          \
               sve_##NAME##_be_host, sve_##NAME##_be_tlb);         \
 }
 
-DO_LD1_1(ld1bb,  0)
-DO_LD1_1(ld1bhu, 1)
-DO_LD1_1(ld1bhs, 1)
-DO_LD1_1(ld1bsu, 2)
-DO_LD1_1(ld1bss, 2)
-DO_LD1_1(ld1bdu, 3)
-DO_LD1_1(ld1bds, 3)
+DO_LD1_1(ld1bb,  MO_8)
+DO_LD1_1(ld1bhu, MO_16)
+DO_LD1_1(ld1bhs, MO_16)
+DO_LD1_1(ld1bsu, MO_32)
+DO_LD1_1(ld1bss, MO_32)
+DO_LD1_1(ld1bdu, MO_64)
+DO_LD1_1(ld1bds, MO_64)
 
-DO_LD1_2(ld1hh,  1, 1)
-DO_LD1_2(ld1hsu, 2, 1)
-DO_LD1_2(ld1hss, 2, 1)
-DO_LD1_2(ld1hdu, 3, 1)
-DO_LD1_2(ld1hds, 3, 1)
+DO_LD1_2(ld1hh,  MO_16, MO_16)
+DO_LD1_2(ld1hsu, MO_32, MO_16)
+DO_LD1_2(ld1hss, MO_32, MO_16)
+DO_LD1_2(ld1hdu, MO_64, MO_16)
+DO_LD1_2(ld1hds, MO_64, MO_16)
 
-DO_LD1_2(ld1ss,  2, 2)
-DO_LD1_2(ld1sdu, 3, 2)
-DO_LD1_2(ld1sds, 3, 2)
+DO_LD1_2(ld1ss,  MO_32, MO_32)
+DO_LD1_2(ld1sdu, MO_64, MO_32)
+DO_LD1_2(ld1sds, MO_64, MO_32)
 
-DO_LD1_2(ld1dd,  3, 3)
+DO_LD1_2(ld1dd,  MO_64, MO_64)
 
 #undef DO_LD1_1
 #undef DO_LD1_2
 
-/*
- * Common helpers for all contiguous 2,3,4-register predicated loads.
- */
-static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, int size, uintptr_t ra,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    ARMVectorReg scratch[2] = { };
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, ra);
-            }
-            i += size, pg >>= size;
-            addr += 2 * size;
-        } while (i & 15);
-    }
-
-    /* Wait until all exceptions have been raised to write back.  */
-    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
-}
-
-static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, int size, uintptr_t ra,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    ARMVectorReg scratch[3] = { };
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, ra);
-                tlb_fn(env, &scratch[2], i, addr + 2 * size, ra);
-            }
-            i += size, pg >>= size;
-            addr += 3 * size;
-        } while (i & 15);
-    }
-
-    /* Wait until all exceptions have been raised to write back.  */
-    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 2) & 31], &scratch[2], oprsz);
-}
-
-static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, int size, uintptr_t ra,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    ARMVectorReg scratch[4] = { };
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, ra);
-                tlb_fn(env, &scratch[2], i, addr + 2 * size, ra);
-                tlb_fn(env, &scratch[3], i, addr + 3 * size, ra);
-            }
-            i += size, pg >>= size;
-            addr += 4 * size;
-        } while (i & 15);
-    }
-
-    /* Wait until all exceptions have been raised to write back.  */
-    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 2) & 31], &scratch[2], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 3) & 31], &scratch[3], oprsz);
-}
-
 #define DO_LDN_1(N) \
-void QEMU_FLATTEN HELPER(sve_ld##N##bb_r) \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
-{                                                                   \
-    sve_ld##N##_r(env, vg, addr, desc, 1, GETPC(), sve_ld1bb_tlb);  \
+void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg,        \
+                             target_ulong addr, uint32_t desc)  \
+{                                                               \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), MO_8, MO_8, N,      \
+              sve_ld1bb_host, sve_ld1bb_tlb);                   \
 }
 
-#define DO_LDN_2(N, SUFF, SIZE)                                       \
-void QEMU_FLATTEN HELPER(sve_ld##N##SUFF##_le_r)                      \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+#define DO_LDN_2(N, SUFF, ESZ) \
+void HELPER(sve_ld##N##SUFF##_le_r)(CPUARMState *env, void *vg,       \
+                                    target_ulong addr, uint32_t desc) \
 {                                                                     \
-    sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
-                  sve_ld1##SUFF##_le_tlb);                            \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,              \
+              sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb);       \
 }                                                                     \
-void QEMU_FLATTEN HELPER(sve_ld##N##SUFF##_be_r)                      \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+void HELPER(sve_ld##N##SUFF##_be_r)(CPUARMState *env, void *vg,       \
+                                    target_ulong addr, uint32_t desc) \
 {                                                                     \
-    sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
-                  sve_ld1##SUFF##_be_tlb);                            \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,              \
+              sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb);       \
 }
 
 DO_LDN_1(2)
 DO_LDN_1(3)
 DO_LDN_1(4)
 
-DO_LDN_2(2, hh, 2)
-DO_LDN_2(3, hh, 2)
-DO_LDN_2(4, hh, 2)
+DO_LDN_2(2, hh, MO_16)
+DO_LDN_2(3, hh, MO_16)
+DO_LDN_2(4, hh, MO_16)
 
-DO_LDN_2(2, ss, 4)
-DO_LDN_2(3, ss, 4)
-DO_LDN_2(4, ss, 4)
+DO_LDN_2(2, ss, MO_32)
+DO_LDN_2(3, ss, MO_32)
+DO_LDN_2(4, ss, MO_32)
 
-DO_LDN_2(2, dd, 8)
-DO_LDN_2(3, dd, 8)
-DO_LDN_2(4, dd, 8)
+DO_LDN_2(2, dd, MO_64)
+DO_LDN_2(3, dd, MO_64)
+DO_LDN_2(4, dd, MO_64)
 
 #undef DO_LDN_1
 #undef DO_LDN_2
-- 
2.20.1


