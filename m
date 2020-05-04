Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28A6206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFuOAsvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28A6206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaIa-0001e0-Re
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHf-0008Fn-C7
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:19 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHd-0000jK-QS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id x25so8239146wmc.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UVhhXcdxrGLYsLe+7//SNheQ2AAv7+PIw7zV3mc83cI=;
 b=FFuOAsvJqrEfDWjW/CObHYSJ0S1q9ld+nfC0vY+fXaxtaKLqlsUd8OG5WatLSld9Wy
 wQRhkUj6DCkEipEsDHIIlV4+wEtKlLdR3EREqnCmLKjLDDG46zp+7Md88RguPijYLhPu
 b/ew5op8zPg4kX7NSaCQiSOF7pT0Y5wa/Ju5G/FTLhg6xFrMVJ1B0ByWe43IlomqYiI0
 TAfQX6uZDAKuSfeH+muKriggmUuPlSM7c9ojE10fGVtPl1vt60tmvFGbDGoTbh5bm04M
 Jr5Ur6ke06+saxyKagTD8RBwwEjBtwFerxXe50nQH2m5sestKkuwR8WUSVp3AYoWWF6F
 phYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UVhhXcdxrGLYsLe+7//SNheQ2AAv7+PIw7zV3mc83cI=;
 b=aX2f0fB5275rE88usAK6yn+Q27yQOX7lz0vReasw7QpWRfcGYTX24jd3I6AYzmfX3g
 c0HrmEV1pye5W2fsAXhq/PoHHKvwy30/uMdWaS9DdVfAo3SwAyQwSqlkmiRm4XcZ5i7C
 kIFz6kpFAxsijsjbUDd6rATIkGV5WoWKP1oSW3hnrLNun+X0jhCT4Wio3dh5ANADIxit
 /6q37OaxNsOMfrtwTJJ4jT2eMRivOjwS/KutHWILxFnt6i3aKcIqB4wHOYCFV+QQNnvS
 WvHbKYwDKh7kWxA056j7ZiEjOvb1PstkiT3HJF8Hqu4E91Awn9+1ELs07idwGbP/YfTc
 7V9Q==
X-Gm-Message-State: AGi0Pua3cYtrgKkCkhKKghF8SKZcmGl76S5arftPzOLhp66JGZTiYaky
 L9RE2v7gXjP6KjiUVaU415TVr9F6RlYgCw==
X-Google-Smtp-Source: APiQypLMNEigRv42F7iMdYQUG2a2qjd438IQC+/U8qI34c+G8AriIz7i1b0kn6tXLW0wA8wpygS/jg==
X-Received: by 2002:a05:600c:2c04:: with SMTP id
 q4mr13835079wmg.7.1588595595680; 
 Mon, 04 May 2020 05:33:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/39] target/arm: Don't use a TLB for ARMMMUIdx_Stage2
Date: Mon,  4 May 2020 13:32:33 +0100
Message-Id: <20200504123309.3808-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

We define ARMMMUIdx_Stage2 as being an MMU index which uses a QEMU
TLB.  However we never actually use the TLB -- all stage 2 lookups
are done by direct calls to get_phys_addr_lpae() followed by a
physical address load via address_space_ld*().

Remove Stage2 from the list of ARM MMU indexes which correspond to
real core MMU indexes, and instead put it in the set of "NOTLB" ARM
MMU indexes.

This allows us to drop NB_MMU_MODES to 11.  It also means we can
safely add support for the ARMv8.3-TTS2UXN extension, which adds
permission bits to the stage 2 descriptors which define execute
permission separatel for EL0 and EL1; supporting that while keeping
Stage2 in a QEMU TLB would require us to use separate TLBs for
"Stage2 for an EL0 access" and "Stage2 for an EL1 access", which is a
lot of extra complication given we aren't even using the QEMU TLB.

In the process of updating the comment on our MMU index use,
fix a couple of other minor errors:
 * NS EL2 EL2&0 was missing from the list in the comment
 * some text hadn't been updated from when we bumped NB_MMU_MODES
   above 8

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200330210400.11724-2-peter.maydell@linaro.org
---
 target/arm/cpu-param.h |   2 +-
 target/arm/cpu.h       |  21 +++++---
 target/arm/helper.c    | 112 ++++-------------------------------------
 3 files changed, 27 insertions(+), 108 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index d593b60b28d..6321385b469 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -29,6 +29,6 @@
 # define TARGET_PAGE_BITS_MIN  10
 #endif
 
-#define NB_MMU_MODES 12
+#define NB_MMU_MODES 11
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8b9f2961ba0..fe03a74bf08 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2801,6 +2801,9 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  *     handling via the TLB. The only way to do a stage 1 translation without
  *     the immediate stage 2 translation is via the ATS or AT system insns,
  *     which can be slow-pathed and always do a page table walk.
+ *     The only use of stage 2 translations is either as part of an s1+2
+ *     lookup or when loading the descriptors during a stage 1 page table walk,
+ *     and in both those cases we don't use the TLB.
  *  4. we can also safely fold together the "32 bit EL3" and "64 bit EL3"
  *     translation regimes, because they map reasonably well to each other
  *     and they can't both be active at the same time.
@@ -2816,15 +2819,15 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  * NS EL1 EL1&0 stage 1+2 (aka NS PL1)
  * NS EL1 EL1&0 stage 1+2 +PAN
  * NS EL0 EL2&0
+ * NS EL2 EL2&0
  * NS EL2 EL2&0 +PAN
  * NS EL2 (aka NS PL2)
  * S EL0 EL1&0 (aka S PL0)
  * S EL1 EL1&0 (not used if EL3 is 32 bit)
  * S EL1 EL1&0 +PAN
  * S EL3 (aka S PL1)
- * NS EL1&0 stage 2
  *
- * for a total of 12 different mmu_idx.
+ * for a total of 11 different mmu_idx.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish NS EL0 and NS EL1 (and
@@ -2846,7 +2849,8 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
  * are not quite the same -- different CPU types (most notably M profile
  * vs A/R profile) would like to use MMU indexes with different semantics,
  * but since we don't ever need to use all of those in a single CPU we
- * can avoid setting NB_MMU_MODES to more than 8. The lower bits of
+ * can avoid having to set NB_MMU_MODES to "total number of A profile MMU
+ * modes + total number of M profile MMU modes". The lower bits of
  * ARMMMUIdx are the core TLB mmu index, and the higher bits are always
  * the same for any particular CPU.
  * Variables of type ARMMUIdx are always full values, and the core
@@ -2894,8 +2898,6 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_SE10_1_PAN = 9 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE3        = 10 | ARM_MMU_IDX_A,
 
-    ARMMMUIdx_Stage2     = 11 | ARM_MMU_IDX_A,
-
     /*
      * These are not allocated TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
@@ -2903,6 +2905,14 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1_PAN = 2 | ARM_MMU_IDX_NOTLB,
+    /*
+     * Not allocated a TLB: used only for second stage of an S12 page
+     * table walk, or for descriptor loads during first stage of an S1
+     * page table walk. Note that if we ever want to have a TLB for this
+     * then various TLB flush insns which currently are no-ops or flush
+     * only stage 1 MMU indexes will need to change to flush stage 2.
+     */
+    ARMMMUIdx_Stage2     = 3 | ARM_MMU_IDX_NOTLB,
 
     /*
      * M-profile.
@@ -2936,7 +2946,6 @@ typedef enum ARMMMUIdxBit {
     TO_CORE_BIT(SE10_1),
     TO_CORE_BIT(SE10_1_PAN),
     TO_CORE_BIT(SE3),
-    TO_CORE_BIT(Stage2),
 
     TO_CORE_BIT(MUser),
     TO_CORE_BIT(MPriv),
diff --git a/target/arm/helper.c b/target/arm/helper.c
index dfefb9b3d9b..f785e012cde 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -814,8 +814,7 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs,
                         ARMMMUIdxBit_E10_1 |
                         ARMMMUIdxBit_E10_1_PAN |
-                        ARMMMUIdxBit_E10_0 |
-                        ARMMMUIdxBit_Stage2);
+                        ARMMMUIdxBit_E10_0);
 }
 
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -826,46 +825,9 @@ static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs,
                                         ARMMMUIdxBit_E10_1 |
                                         ARMMMUIdxBit_E10_1_PAN |
-                                        ARMMMUIdxBit_E10_0 |
-                                        ARMMMUIdxBit_Stage2);
+                                        ARMMMUIdxBit_E10_0);
 }
 
-static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                            uint64_t value)
-{
-    /* Invalidate by IPA. This has to invalidate any structures that
-     * contain only stage 2 translation information, but does not need
-     * to apply to structures that contain combined stage 1 and stage 2
-     * translation information.
-     * This must NOP if EL2 isn't implemented or SCR_EL3.NS is zero.
-     */
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr;
-
-    if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
-        return;
-    }
-
-    pageaddr = sextract64(value << 12, 0, 40);
-
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
-}
-
-static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                               uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr;
-
-    if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
-        return;
-    }
-
-    pageaddr = sextract64(value << 12, 0, 40);
-
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_Stage2);
-}
 
 static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
                               uint64_t value)
@@ -4055,8 +4017,7 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         tlb_flush_by_mmuidx(cs,
                             ARMMMUIdxBit_E10_1 |
                             ARMMMUIdxBit_E10_1_PAN |
-                            ARMMMUIdxBit_E10_0 |
-                            ARMMMUIdxBit_Stage2);
+                            ARMMMUIdxBit_E10_0);
         raw_write(env, ri, value);
     }
 }
@@ -4538,11 +4499,6 @@ static int alle1_tlbmask(CPUARMState *env)
         return ARMMMUIdxBit_SE10_1 |
                ARMMMUIdxBit_SE10_1_PAN |
                ARMMMUIdxBit_SE10_0;
-    } else if (arm_feature(env, ARM_FEATURE_EL2)) {
-        return ARMMMUIdxBit_E10_1 |
-               ARMMMUIdxBit_E10_1_PAN |
-               ARMMMUIdxBit_E10_0 |
-               ARMMMUIdxBit_Stage2;
     } else {
         return ARMMMUIdxBit_E10_1 |
                ARMMMUIdxBit_E10_1_PAN |
@@ -4689,44 +4645,6 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                              ARMMMUIdxBit_SE3);
 }
 
-static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    /* Invalidate by IPA. This has to invalidate any structures that
-     * contain only stage 2 translation information, but does not need
-     * to apply to structures that contain combined stage 1 and stage 2
-     * translation information.
-     * This must NOP if EL2 isn't implemented or SCR_EL3.NS is zero.
-     */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
-    uint64_t pageaddr;
-
-    if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
-        return;
-    }
-
-    pageaddr = sextract64(value << 12, 0, 48);
-
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_Stage2);
-}
-
-static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                      uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr;
-
-    if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
-        return;
-    }
-
-    pageaddr = sextract64(value << 12, 0, 48);
-
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_Stage2);
-}
-
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                       bool isread)
 {
@@ -4965,12 +4883,10 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1is_write },
+      .access = PL2_W, .type = ARM_CP_NOP },
     { .name = "TLBI_IPAS2LE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1is_write },
+      .access = PL2_W, .type = ARM_CP_NOP },
     { .name = "TLBI_ALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
@@ -4981,12 +4897,10 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_alle1is_write },
     { .name = "TLBI_IPAS2E1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1_write },
+      .access = PL2_W, .type = ARM_CP_NOP },
     { .name = "TLBI_IPAS2LE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1_write },
+      .access = PL2_W, .type = ARM_CP_NOP },
     { .name = "TLBI_ALLE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
       .access = PL2_W, .type = ARM_CP_NO_RAW,
@@ -5067,20 +4981,16 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbimva_hyp_is_write },
     { .name = "TLBIIPAS2",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2_write },
+      .type = ARM_CP_NOP, .access = PL2_W },
     { .name = "TLBIIPAS2IS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2_is_write },
+      .type = ARM_CP_NOP, .access = PL2_W },
     { .name = "TLBIIPAS2L",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2_write },
+      .type = ARM_CP_NOP, .access = PL2_W },
     { .name = "TLBIIPAS2LIS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiipas2_is_write },
+      .type = ARM_CP_NOP, .access = PL2_W },
     /* 32 bit cache operations */
     { .name = "ICIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_pou_access },
-- 
2.20.1


