Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C87C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECF020720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZnjYYK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECF020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04sO-0005f2-Mr
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hl-0008VI-A3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hj-0002Zb-46
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:01 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hi-0002Yi-Ri
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id p9so2810839wmc.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=W2HZqnuC60aXsny1KNbG94Z0aqtIVe7Zch4rDZBnHMc=;
 b=UZnjYYK0nhBKSriWsNEZKjgBlMA3iXUqZYWn9Q6Go8E0DjTGiRrLIz9ThyQKSmekd4
 qFaNMqqx6PIsP4CjBPexUHyMfhHc86rlt49RdVebO8DogSfB+LGNM348htYxZnrmXUEg
 s9bvGeSAOwFqDj0R0tsBg7jhvgkTzqMKrZf8dO9aVd9PUgoSBRPczvhDAcJva8YKzH4r
 +w8LK9ROEwUxG1fzOcx1tddjBBWPwWUgmgjXzt7HG3QeZJ7imq/SNL+wWkFrJachJ01U
 DvjiMi5IwJMqsxN05B71Hzl+7ag/jQ+1S0z8ULbqhIZAtb4/SEK69xdjzaejjNM1vMrh
 kGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W2HZqnuC60aXsny1KNbG94Z0aqtIVe7Zch4rDZBnHMc=;
 b=aHLzvtImx/v9FzbGNg5af7mr224tygYYnZRitFfLe23hALEilO53E0DPaOn9Br5pzZ
 wrGpnUqsAZJ55uZFO5ur9EIjDSA8PunNfQxEt+x2F4D6YKMvu5glwHDeWVtHLMkr0dGP
 kMiiYArSzjcnOieghQHhjC3jFO/aJ7lX2mz8MRcXab9mBhS59EBPUUU6NhaNK1wtyRtW
 GzqqtBiqnv8QExlzWolV1uY+HY6Nl4UyvsbsdjKUiARIWWuKAzM/azN5DG1e88WPMtQd
 JGlMSqkK9pjtSKwtc8t+nphfxPIWVaCfLclVTacaRsuAfTQlDOblWDi5bQhXOK7T2oEr
 MmRg==
X-Gm-Message-State: APjAAAU6mapOakeP5iEiQd4YKfbAyGn5QXWDm9mgqRqU/y3w4R6KrTgN
 OwFw5aaYvejL9poRxL2q/1hJj13NhbY=
X-Google-Smtp-Source: APXvYqw7wd+XmwqK2q7l7/K7FyfPzoIFeGH8BMjaPFdNXfKo44fkBjSC+UMYsLn5VTNL0CbMoNAOuQ==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr4709300wme.30.1581086037332; 
 Fri, 07 Feb 2020 06:33:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/48] target/arm: Rename ARMMMUIdx_S2NS to ARMMMUIdx_Stage2
Date: Fri,  7 Feb 2020 14:33:06 +0000
Message-Id: <20200207143343.30322-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

The EL1&0 regime is the only one that uses 2-stage translation.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  4 +--
 target/arm/internals.h     |  2 +-
 target/arm/helper.c        | 57 ++++++++++++++++++++------------------
 target/arm/translate-a64.c |  2 +-
 target/arm/translate.c     |  2 +-
 5 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 272104afbb9..c6da3d3043a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2911,7 +2911,7 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_S1E3 = 3 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
     ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
@@ -2937,7 +2937,7 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_S1E3 = 1 << 3,
     ARMMMUIdxBit_S1SE0 = 1 << 4,
     ARMMMUIdxBit_S1SE1 = 1 << 5,
-    ARMMMUIdxBit_S2NS = 1 << 6,
+    ARMMMUIdxBit_Stage2 = 1 << 6,
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
     ARMMMUIdxBit_MUserNegPri = 1 << 2,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index d4ea6cfe9d1..1509e45e98a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -813,7 +813,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1NSE0:
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_S1E2:
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 95b67ba6c5f..a6d4f449cc7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -672,7 +672,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs,
                         ARMMMUIdxBit_E10_1 |
                         ARMMMUIdxBit_E10_0 |
-                        ARMMMUIdxBit_S2NS);
+                        ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -683,7 +683,7 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
                                         ARMMMUIdxBit_E10_1 |
                                         ARMMMUIdxBit_E10_0 |
-                                        ARMMMUIdxBit_S2NS);
+                                        ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -704,7 +704,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 40);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -720,7 +720,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 40);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S2NS);
+                                             ARMMMUIdxBit_Stage2);
 }
 
 static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3578,12 +3578,15 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
-    /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
+    /*
+     * A change in VMID to the stage2 page table (Stage2) invalidates
+     * the combined stage 1&2 tlbs (EL10_1 and EL10_0).
+     */
     if (raw_read(env, ri) != value) {
         tlb_flush_by_mmuidx(cs,
                             ARMMMUIdxBit_E10_1 |
                             ARMMMUIdxBit_E10_0 |
-                            ARMMMUIdxBit_S2NS);
+                            ARMMMUIdxBit_Stage2);
         raw_write(env, ri, value);
     }
 }
@@ -3979,7 +3982,7 @@ static int alle1_tlbmask(CPUARMState *env)
     if (arm_is_secure_below_el3(env)) {
         return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
     } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0 | ARMMMUIdxBit_S2NS;
+        return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0 | ARMMMUIdxBit_Stage2;
     } else {
         return ARMMMUIdxBit_E10_1 | ARMMMUIdxBit_E10_0;
     }
@@ -4133,7 +4136,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 48);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_S2NS);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -4149,7 +4152,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pageaddr = sextract64(value << 12, 0, 48);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_S2NS);
+                                             ARMMMUIdxBit_Stage2);
 }
 
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -8706,7 +8709,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
     case ARMMMUIdx_S1E2:
         return 2;
     case ARMMMUIdx_S1E3:
@@ -8760,7 +8763,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         /* HCR.DC means HCR.VM behaves as 1 */
         return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) == 0;
     }
@@ -8791,7 +8794,7 @@ static inline bool regime_translation_big_endian(CPUARMState *env,
 static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
                                    int ttbrn)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         return env->cp15.vttbr_el2;
     }
     if (ttbrn == 0) {
@@ -8806,7 +8809,7 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 /* Return the TCR controlling this translation regime */
 static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         return &env->cp15.vtcr_el2;
     }
     return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
@@ -8993,7 +8996,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     bool have_wxn;
     int wxn = 0;
 
-    assert(mmu_idx != ARMMMUIdx_S2NS);
+    assert(mmu_idx != ARMMMUIdx_Stage2);
 
     user_rw = simple_ap_to_rw_prot_is_user(ap, true);
     if (is_user) {
@@ -9085,7 +9088,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                ARMMMUFaultInfo *fi)
 {
     if ((mmu_idx == ARMMMUIdx_S1NSE0 || mmu_idx == ARMMMUIdx_S1NSE1) &&
-        !regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
+        !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
         int s2prot;
@@ -9102,7 +9105,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             pcacheattrs = &cacheattrs;
         }
 
-        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
+        ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_Stage2, &s2pa,
                                  &txattrs, &s2prot, &s2size, fi, pcacheattrs);
         if (ret) {
             assert(fi->type != ARMFault_None);
@@ -9574,7 +9577,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             /* VTCR_EL2 */
             tbi = tbid = hpd = false;
         } else {
@@ -9635,7 +9638,7 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
     int select, tsz;
     bool epd, hpd;
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         /* VTCR */
         bool sext = extract32(tcr, 4, 1);
         bool sign = extract32(tcr, 3, 1);
@@ -9737,7 +9740,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         level = 1;
         /* There is no TTBR1 for EL2 */
         ttbr1_valid = (el != 2);
-        addrsize = (mmu_idx == ARMMMUIdx_S2NS ? 40 : 32);
+        addrsize = (mmu_idx == ARMMMUIdx_Stage2 ? 40 : 32);
         inputsize = addrsize - param.tsz;
     }
 
@@ -9788,7 +9791,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         goto do_fault;
     }
 
-    if (mmu_idx != ARMMMUIdx_S2NS) {
+    if (mmu_idx != ARMMMUIdx_Stage2) {
         /* The starting level depends on the virtual address size (which can
          * be up to 48 bits) and the translation granule size. It indicates
          * the number of strides (stride bits at a time) needed to
@@ -9888,7 +9891,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         attrs = extract64(descriptor, 2, 10)
             | (extract64(descriptor, 52, 12) << 10);
 
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             /* Stage 2 table descriptors do not include any attribute fields */
             break;
         }
@@ -9919,7 +9922,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     ap = extract32(attrs, 4, 2);
     xn = extract32(attrs, 12, 1);
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    if (mmu_idx == ARMMMUIdx_Stage2) {
         ns = true;
         *prot = get_S2prot(env, ap, xn);
     } else {
@@ -9946,7 +9949,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     }
 
     if (cacheattrs != NULL) {
-        if (mmu_idx == ARMMMUIdx_S2NS) {
+        if (mmu_idx == ARMMMUIdx_Stage2) {
             cacheattrs->attrs = convert_stage2_attrs(env,
                                                      extract32(attrs, 0, 4));
         } else {
@@ -9967,7 +9970,7 @@ do_fault:
     fi->type = fault_type;
     fi->level = level;
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
-    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_S2NS);
+    fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_Stage2);
     return true;
 }
 
@@ -10781,13 +10784,13 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                                 prot, page_size, fi, cacheattrs);
 
             /* If S1 fails or S2 is disabled, return early.  */
-            if (ret || regime_translation_disabled(env, ARMMMUIdx_S2NS)) {
+            if (ret || regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
                 *phys_ptr = ipa;
                 return ret;
             }
 
             /* S1 is done. Now do S2 translation.  */
-            ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_S2NS,
+            ret = get_phys_addr_lpae(env, ipa, access_type, ARMMMUIdx_Stage2,
                                      phys_ptr, attrs, &s2_prot,
                                      page_size, fi,
                                      cacheattrs != NULL ? &cacheattrs2 : NULL);
@@ -10829,7 +10832,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     /* Fast Context Switch Extension. This doesn't exist at all in v8.
      * In v7 and earlier it affects all stage 1 translations.
      */
-    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_S2NS
+    if (address < 0x02000000 && mmu_idx != ARMMMUIdx_Stage2
         && !arm_feature(env, ARM_FEATURE_V8)) {
         if (regime_el(env, mmu_idx) == 3) {
             address += env->cp15.fcseidr_s;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index cb539b1eff0..d0d13e21754 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -119,7 +119,7 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     case ARMMMUIdx_S1SE1:
         useridx = ARMMMUIdx_S1SE0;
         break;
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
         g_assert_not_reached();
     default:
         useridx = s->mmu_idx;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f90f22ef90d..70b1fd3fe2a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -172,7 +172,7 @@ static inline int get_a32_user_mem_index(DisasContext *s)
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPrivNegPri:
         return arm_to_core_mmu_idx(ARMMMUIdx_MSUserNegPri);
-    case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_Stage2:
     default:
         g_assert_not_reached();
     }
-- 
2.20.1


