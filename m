Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BFAC54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428AF20746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKLzrKvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428AF20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8og-0005TS-AC
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zu-0002RR-73
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:32848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zt-0007BZ-2a
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id d207so3953788wmd.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kGEWwYkEPVetaxFpZUAVs0CR3KabQ3E43eVBDyJWj+A=;
 b=JKLzrKvNI2ThdqadmSHBlgUzLMkXiCVyusPG/0QQA+OHu2EQVlmfBe2LEmOzV6lWuB
 oUNhJOjvoA50KfoMVYYom2UtAUB60T6I1WZ+gxVsiO2MvQYNHhZQFIUE0/x3vADMFPPh
 Vqv+d9/KCj7mP3xLPCCeEEU9fnCC+5jTiuQZAksV2NiXAuV0t5NcC2OAT1GA3g8QoURn
 ezgDGwn8dcdFt7hYvcMvEIN/YunHHtgAWTvSJF1FHA0MC7mqonJEC8xn+Tx26cubKXPa
 C1slLYSL83Zwky/49WyEY8sNqLHDirWuibr1/gAUx9dZbG6oYcyJYXU4jKm6H6cpQBIZ
 JD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kGEWwYkEPVetaxFpZUAVs0CR3KabQ3E43eVBDyJWj+A=;
 b=K5uvW/3ennKVXYwNz9c4jOlucm6RY9zsn1p6j3+XR9aRlmMKIAxwZ/g1eCzVIO9S/W
 6CWUNDU52N98b6BOGgmSM4qM3ZzaM+xLcCRm3FrpE3VOAqhHH/eDrCHQuBYY377h93Zz
 uojqUad/Tp+8QxPULW57DRyClN3Fd+p8cXvcnIph/rjun40Fm5enwauiJuLjnPoHeQEV
 SZpvgKM5fqmvJm3EpO4qJotNjvq9LH48qJ7AkP30kTdlAHuJqJ8nJq6DsHK7KOwoMSUL
 3HiaZewFsx6TT1W5ZgmRheUB8Y3Cwu9h1G4wwRJ3iWRl2hgGwhxoVzjmhzeRDtDBwUiK
 N1HQ==
X-Gm-Message-State: AGi0PuYAofNSPCcnTz+iS9tjNKkoVK69+yYwUp4JhG2mGmOv/D0tRyHa
 +6CQRpIgxml4Nl9IYJi5Bku4JKvCWuqQdQ==
X-Google-Smtp-Source: APiQypIrfFwrGZHvtt6TVtgL0kpOeF8VVKLVSlLXW7DN0sZpEkxVGm40F5hXivLtWkR0O3zhBpaAQA==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr20440311wmh.119.1589204078270; 
 Mon, 11 May 2020 06:34:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/34] target/arm: Reuse sve_probe_page for scatter stores
Date: Mon, 11 May 2020 14:33:55 +0100
Message-Id: <20200511133405.5275-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Message-id: 20200508154359.7494-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 182 ++++++++++++++++++++++++----------------
 1 file changed, 111 insertions(+), 71 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 1560129b080..ad7e10f1e79 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5413,94 +5413,134 @@ DO_LDFF1_ZPZ_D(dd_be, zd, MO_64)
 
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


