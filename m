Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F3C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14E720873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnsSDz7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14E720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvJl-0002Gl-0U
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6j-0006Uc-LB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6h-00024i-Cs
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:45 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6h-00023q-1q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:43 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ca13so505618pjb.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lMQ8Ls/5UNh2CeM9JrBjlxyyT05PO0oq+06rVR26ElQ=;
 b=pnsSDz7uX7GhYBZZYMXEfjVFEGPwaQGv7iR7MVDt6XU0LW1Tc/eITVr8UjAcfxvK4V
 2B4Fu0DhX74i8csLOBBc+UDgPV85jn5k84zP86wz9JIuJ1V5T840XSH3obuDoTn/6Fbp
 tYzJOBB3QsLnT643Tp5+KdKKwjHOU+cNNHu2kh7Z37ZMteBQNAf8ah68jkLbsR9PGjK/
 f+A6jOioYsKWmdEAHaoK1u2yLyT+ID8FJFKXIgPhvDeTc8HpoN7smPU3NCHOolFjgmW4
 la7nrqjJmb6BQiW5r4AAPyoq602MxLUej4VkFpm2Lw410Poj3NiLhVHVxMEcjF9bl1ho
 3x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lMQ8Ls/5UNh2CeM9JrBjlxyyT05PO0oq+06rVR26ElQ=;
 b=uj4P/eco1zmtYZ9uFRY6BBQJOmaFe/QFB49STpAdWHyXIHDMeC7iRt+0uej2Vpd3O0
 Z0G53vq0QIWqcRFfI5k7zA7SMz01apJX8i+5RosuPCiuuRjWnOtzKjQ/Ve2Qh6vE7gUR
 9p4DAj081ahyg1fb5KEVuO3FWpPfwhFMi8Am+4HMBrCRd3qAfilyvCX7TaKWGMTl5NpD
 CbC918Zroxb938XOf6j5fZx9DnYaEC36mp407l9wfx/26Pajq4Uc7a/MM45GFGiSl03a
 TtbUBNYePxh09kgCdc2TqpNxOUu0RGNjuwhdIU57oX/mVGM++BzFChqPp3Hh6wtng2Z9
 s/TA==
X-Gm-Message-State: ANhLgQ1XKWO5j0Y6phn+gKMsuV6PFlgbWJtWfagt52GS+gMsCkFau716
 1c+2CpSVF4Nrxh9XcImo1GlZt/RIuao=
X-Google-Smtp-Source: ADFU+vvjqqoWeA5l4BdfN6GnjVYhrsVIGO924tfsDbRVTQHq670SCt1jVayt476ortzERQb9HQSPrQ==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id
 kb8mr1881923pjb.113.1583909080607; 
 Tue, 10 Mar 2020 23:44:40 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] target/arm: Reuse sve_probe_page for scatter stores
Date: Tue, 10 Mar 2020 23:44:18 -0700
Message-Id: <20200311064420.30606-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 182 ++++++++++++++++++++++++----------------
 1 file changed, 111 insertions(+), 71 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a33699adf8..e8b8f2560d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5414,94 +5414,134 @@ DO_LDFF1_ZPZ_D(dd_be, zd, MO_64)
 
 /* Stores with a vector index.  */
 
-static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
-                       target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
+static inline QEMU_ALWAYS_INLINE
+void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
+               target_ulong base, uint32_t desc, uintptr_t retaddr,
+               int esize, int msize, zreg_off_fn *off_fn,
+               sve_ldst1_host_fn *host_fn,
+               sve_ldst1_tlb_fn *tlb_fn)
 {
     const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t i, oprsz = simd_oprsz(desc);
+    const int mmu_idx = cpu_mmu_index(env, false);
+    const intptr_t reg_max = simd_oprsz(desc);
+    void *host[ARM_MAX_VQ * 4];
+    intptr_t reg_off, i;
+    SVEHostPage info, info2;
 
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
+    /*
+     * Probe all of the elements for host addresses and flags.
+     */
+    i = reg_off = 0;
+    do {
+        uint64_t pg = vg[reg_off >> 6];
         do {
-            if (likely(pg & 1)) {
-                target_ulong off = off_fn(vm, i);
-                tlb_fn(env, vd, i, base + (off << scale), ra);
+            target_ulong addr = base + (off_fn(vm, reg_off) << scale);
+            target_ulong in_page = -(addr | TARGET_PAGE_MASK);
+
+            host[i] = NULL;
+            if (likely((pg >> (reg_off & 63)) & 1)) {
+                if (likely(in_page >= msize)) {
+                    sve_probe_page(&info, false, env, addr, 0, MMU_DATA_STORE,
+                                   mmu_idx, retaddr);
+                    host[i] = info.host;
+                } else {
+                    /*
+                     * Element crosses the page boundary.
+                     * Probe both pages, but do not record the host address,
+                     * so that we use the slow path.
+                     */
+                    sve_probe_page(&info, false, env, addr, 0,
+                                   MMU_DATA_STORE, mmu_idx, retaddr);
+                    sve_probe_page(&info2, false, env, addr + in_page, 0,
+                                   MMU_DATA_STORE, mmu_idx, retaddr);
+                    info.flags |= info2.flags;
+                }
+
+                if (unlikely(info.flags & TLB_WATCHPOINT)) {
+                    cpu_check_watchpoint(env_cpu(env), addr, msize,
+                                         info.attrs, BP_MEM_WRITE, retaddr);
+                }
+                /* TODO: MTE check. */
             }
-            i += 4, pg >>= 4;
-        } while (i & 15);
-    }
-}
+            i += 1;
+            reg_off += esize;
+        } while (reg_off & 63);
+    } while (reg_off < reg_max);
 
-static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
-                       target_ulong base, uint32_t desc, uintptr_t ra,
-                       zreg_off_fn *off_fn, sve_ldst1_tlb_fn *tlb_fn)
-{
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
-    intptr_t i, oprsz = simd_oprsz(desc) / 8;
-
-    for (i = 0; i < oprsz; i++) {
-        uint8_t pg = *(uint8_t *)(vg + H1(i));
-        if (likely(pg & 1)) {
-            target_ulong off = off_fn(vm, i * 8);
-            tlb_fn(env, vd, i * 8, base + (off << scale), ra);
+    /*
+     * Now that we have recognized all exceptions except SyncExternal
+     * (from TLB_MMIO), which we cannot avoid, perform all of the stores.
+     *
+     * Note for the common case of an element in RAM, not crossing a page
+     * boundary, we have stored the host address in host[].  This doubles
+     * as a first-level check against the predicate, since only enabled
+     * elements have non-null host addresses.
+     */
+    i = reg_off = 0;
+    do {
+        void *h = host[i];
+        if (likely(h != NULL)) {
+            host_fn(vd, reg_off, h);
+        } else if ((vg[reg_off >> 6] >> (reg_off & 63)) & 1) {
+            target_ulong addr = base + (off_fn(vm, reg_off) << scale);
+            tlb_fn(env, vd, reg_off, addr, retaddr);
         }
-    }
+        i += 1;
+        reg_off += esize;
+    } while (reg_off < reg_max);
 }
 
-#define DO_ST1_ZPZ_S(MEM, OFS) \
-void QEMU_FLATTEN HELPER(sve_st##MEM##_##OFS) \
-    (CPUARMState *env, void *vd, void *vg, void *vm,         \
-     target_ulong base, uint32_t desc)                       \
-{                                                            \
-    sve_st1_zs(env, vd, vg, vm, base, desc, GETPC(),         \
-              off_##OFS##_s, sve_st1##MEM##_tlb);            \
+#define DO_ST1_ZPZ_S(MEM, OFS, MSZ) \
+void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                            \
+    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 4, 1 << MSZ,             \
+              off_##OFS##_s, sve_st1##MEM##_host, sve_st1##MEM##_tlb);       \
 }
 
-#define DO_ST1_ZPZ_D(MEM, OFS) \
-void QEMU_FLATTEN HELPER(sve_st##MEM##_##OFS) \
-    (CPUARMState *env, void *vd, void *vg, void *vm,         \
-     target_ulong base, uint32_t desc)                       \
-{                                                            \
-    sve_st1_zd(env, vd, vg, vm, base, desc, GETPC(),         \
-               off_##OFS##_d, sve_st1##MEM##_tlb);           \
+#define DO_ST1_ZPZ_D(MEM, OFS, MSZ) \
+void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint32_t desc) \
+{                                                                            \
+    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 8, 1 << MSZ,             \
+              off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb);       \
 }
 
-DO_ST1_ZPZ_S(bs, zsu)
-DO_ST1_ZPZ_S(hs_le, zsu)
-DO_ST1_ZPZ_S(hs_be, zsu)
-DO_ST1_ZPZ_S(ss_le, zsu)
-DO_ST1_ZPZ_S(ss_be, zsu)
+DO_ST1_ZPZ_S(bs, zsu, MO_8)
+DO_ST1_ZPZ_S(hs_le, zsu, MO_16)
+DO_ST1_ZPZ_S(hs_be, zsu, MO_16)
+DO_ST1_ZPZ_S(ss_le, zsu, MO_32)
+DO_ST1_ZPZ_S(ss_be, zsu, MO_32)
 
-DO_ST1_ZPZ_S(bs, zss)
-DO_ST1_ZPZ_S(hs_le, zss)
-DO_ST1_ZPZ_S(hs_be, zss)
-DO_ST1_ZPZ_S(ss_le, zss)
-DO_ST1_ZPZ_S(ss_be, zss)
+DO_ST1_ZPZ_S(bs, zss, MO_8)
+DO_ST1_ZPZ_S(hs_le, zss, MO_16)
+DO_ST1_ZPZ_S(hs_be, zss, MO_16)
+DO_ST1_ZPZ_S(ss_le, zss, MO_32)
+DO_ST1_ZPZ_S(ss_be, zss, MO_32)
 
-DO_ST1_ZPZ_D(bd, zsu)
-DO_ST1_ZPZ_D(hd_le, zsu)
-DO_ST1_ZPZ_D(hd_be, zsu)
-DO_ST1_ZPZ_D(sd_le, zsu)
-DO_ST1_ZPZ_D(sd_be, zsu)
-DO_ST1_ZPZ_D(dd_le, zsu)
-DO_ST1_ZPZ_D(dd_be, zsu)
+DO_ST1_ZPZ_D(bd, zsu, MO_8)
+DO_ST1_ZPZ_D(hd_le, zsu, MO_16)
+DO_ST1_ZPZ_D(hd_be, zsu, MO_16)
+DO_ST1_ZPZ_D(sd_le, zsu, MO_32)
+DO_ST1_ZPZ_D(sd_be, zsu, MO_32)
+DO_ST1_ZPZ_D(dd_le, zsu, MO_64)
+DO_ST1_ZPZ_D(dd_be, zsu, MO_64)
 
-DO_ST1_ZPZ_D(bd, zss)
-DO_ST1_ZPZ_D(hd_le, zss)
-DO_ST1_ZPZ_D(hd_be, zss)
-DO_ST1_ZPZ_D(sd_le, zss)
-DO_ST1_ZPZ_D(sd_be, zss)
-DO_ST1_ZPZ_D(dd_le, zss)
-DO_ST1_ZPZ_D(dd_be, zss)
+DO_ST1_ZPZ_D(bd, zss, MO_8)
+DO_ST1_ZPZ_D(hd_le, zss, MO_16)
+DO_ST1_ZPZ_D(hd_be, zss, MO_16)
+DO_ST1_ZPZ_D(sd_le, zss, MO_32)
+DO_ST1_ZPZ_D(sd_be, zss, MO_32)
+DO_ST1_ZPZ_D(dd_le, zss, MO_64)
+DO_ST1_ZPZ_D(dd_be, zss, MO_64)
 
-DO_ST1_ZPZ_D(bd, zd)
-DO_ST1_ZPZ_D(hd_le, zd)
-DO_ST1_ZPZ_D(hd_be, zd)
-DO_ST1_ZPZ_D(sd_le, zd)
-DO_ST1_ZPZ_D(sd_be, zd)
-DO_ST1_ZPZ_D(dd_le, zd)
-DO_ST1_ZPZ_D(dd_be, zd)
+DO_ST1_ZPZ_D(bd, zd, MO_8)
+DO_ST1_ZPZ_D(hd_le, zd, MO_16)
+DO_ST1_ZPZ_D(hd_be, zd, MO_16)
+DO_ST1_ZPZ_D(sd_le, zd, MO_32)
+DO_ST1_ZPZ_D(sd_be, zd, MO_32)
+DO_ST1_ZPZ_D(dd_le, zd, MO_64)
+DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
-- 
2.20.1


