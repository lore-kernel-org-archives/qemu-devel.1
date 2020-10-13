Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C97FC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCE520878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCE520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCe0-0006RQ-Rg
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa3-0001tJ-81
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:57342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa0-0006YN-9W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:34 -0400
IronPort-SDR: wp/REynN/RsjlmX+JZtVCYoUFkSRa9CLq//nA2dsDdDehoDXIt3XoJXno2/r2+dJGw0I+SoID7
 BwJzMfHIBdKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162385619"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="162385619"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 22:10:27 -0700
IronPort-SDR: +dl0vwq0Ih/4eIsFXEgSpoy/eQzSMwSAD4jWsiV2zbgs2QDCQPGINuUAmQ8+OgmpQRSpj88gIf
 wMsZJdHDDz6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="420427115"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com)
 ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2020 22:10:25 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, sean.j.christopherson@intel.com, qemu-devel@nongnu.org
Subject: [Qemu-devel][PATCH v6 1/6] x86/cpu: Rename XSAVE related feature
 words.
Date: Tue, 13 Oct 2020 13:19:30 +0800
Message-Id: <20201013051935.6052-2-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201013051935.6052-1-weijiang.yang@intel.com>
References: <20201013051935.6052-1-weijiang.yang@intel.com>
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=weijiang.yang@intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 01:10:25
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yang Weijiang <weijiang.yang@intel.com>, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With more components in XSS being developed on Intel platform,
it's necessary to clean up existing XSAVE related feature words to
make the name clearer. It's to prepare for adding CET related support
in following patches.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c        | 60 ++++++++++++++++++++--------------------
 target/i386/cpu.h        |  6 ++--
 target/i386/fpu_helper.c |  2 +-
 target/i386/translate.c  |  2 +-
 4 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 588f32e136..e2891740f1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1050,7 +1050,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
-    [FEAT_XSAVE] = {
+    [FEAT_XSAVE_INSTRUCTION] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "xsaveopt", "xsavec", "xgetbv1", "xsaves",
@@ -1084,7 +1084,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .cpuid = { .eax = 6, .reg = R_EAX, },
         .tcg_features = TCG_6_EAX_FEATURES,
     },
-    [FEAT_XSAVE_COMP_LO] = {
+    [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
             .eax = 0xD,
@@ -1097,7 +1097,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
             XSTATE_PKRU_MASK,
     },
-    [FEAT_XSAVE_COMP_HI] = {
+    [FEAT_XSAVE_XCR0_HI] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
             .eax = 0xD,
@@ -1369,7 +1369,7 @@ static FeatureDep feature_dependencies[] = {
         .to = { FEAT_VMX_SECONDARY_CTLS,    ~0ull },
     },
     {
-        .from = { FEAT_XSAVE,               CPUID_XSAVE_XSAVES },
+        .from = { FEAT_XSAVE_INSTRUCTION,   CPUID_XSAVE_XSAVES },
         .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_XSAVES },
     },
     {
@@ -1502,8 +1502,8 @@ static inline bool accel_uses_host_cpuid(void)
 
 static inline uint64_t x86_cpu_xsave_components(X86CPU *cpu)
 {
-    return ((uint64_t)cpu->env.features[FEAT_XSAVE_COMP_HI]) << 32 |
-           cpu->env.features[FEAT_XSAVE_COMP_LO];
+    return ((uint64_t)cpu->env.features[FEAT_XSAVE_XCR0_HI]) << 32 |
+           cpu->env.features[FEAT_XSAVE_XCR0_LO];
 }
 
 const char *get_register_name_32(unsigned int reg)
@@ -2390,7 +2390,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
@@ -2479,7 +2479,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
@@ -2574,7 +2574,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM,
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
@@ -2704,7 +2704,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
             CPUID_7_0_EBX_SMAP,
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
@@ -2834,7 +2834,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
          * and the only one defined in Skylake (processor tracing)
          * probably will block migration anyway.
          */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -2954,7 +2954,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
          * and the only one defined in Skylake (processor tracing)
          * probably will block migration anyway.
          */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -3089,7 +3089,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
                 * and the only one defined in Skylake (processor tracing)
                 * probably will block migration anyway.
                 */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -3228,7 +3228,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
          * and the only one defined in Skylake (processor tracing)
          * probably will block migration anyway.
          */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -3331,7 +3331,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
                 * and the only one defined in Skylake (processor tracing)
                 * probably will block migration anyway.
                 */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -3448,7 +3448,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
                 * and the only one defined in Skylake (processor tracing)
                 * probably will block migration anyway.
                 */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -3581,7 +3581,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
          * and the only one defined in Skylake (processor tracing)
          * probably will block migration anyway.
          */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC | CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
@@ -3712,7 +3712,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
          * and the only one defined in Skylake (processor tracing)
          * probably will block migration anyway.
          */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -3814,7 +3814,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
         .features[FEAT_7_0_EDX] =
             CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS,
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
@@ -3985,7 +3985,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
             CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
             CPUID_7_0_EBX_SHA_NI,
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -4063,7 +4063,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component.
          */
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
@@ -4113,7 +4113,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_CLWB,
         .features[FEAT_7_0_ECX] =
             CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_RDPID,
-        .features[FEAT_XSAVE] =
+        .features[FEAT_XSAVE_INSTRUCTION] =
             CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
             CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
         .features[FEAT_6_EAX] =
@@ -4689,8 +4689,8 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
     /* XSAVE components are automatically enabled by other features,
      * so return the original feature name instead
      */
-    if (w == FEAT_XSAVE_COMP_LO || w == FEAT_XSAVE_COMP_HI) {
-        int comp = (w == FEAT_XSAVE_COMP_HI) ? bitnr + 32 : bitnr;
+    if (w == FEAT_XSAVE_XCR0_LO || w == FEAT_XSAVE_XCR0_HI) {
+        int comp = (w == FEAT_XSAVE_XCR0_HI) ? bitnr + 32 : bitnr;
 
         if (comp < ARRAY_SIZE(x86_ext_save_areas) &&
             x86_ext_save_areas[comp].bits) {
@@ -5736,8 +5736,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
         if (count == 0) {
             *ecx = xsave_area_size(x86_cpu_xsave_components(cpu));
-            *eax = env->features[FEAT_XSAVE_COMP_LO];
-            *edx = env->features[FEAT_XSAVE_COMP_HI];
+            *eax = env->features[FEAT_XSAVE_XCR0_LO];
+            *edx = env->features[FEAT_XSAVE_XCR0_HI];
             /*
              * The initial value of xcr0 and ebx == 0, On host without kvm
              * commit 412a3c41(e.g., CentOS 6), the ebx's value always == 0
@@ -5746,7 +5746,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             *ebx = kvm_enabled() ? *ecx : xsave_area_size(env->xcr0);
         } else if (count == 1) {
-            *eax = env->features[FEAT_XSAVE];
+            *eax = env->features[FEAT_XSAVE_INSTRUCTION];
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             if ((x86_cpu_xsave_components(cpu) >> count) & 1) {
                 const ExtSaveArea *esa = &x86_ext_save_areas[count];
@@ -6307,8 +6307,8 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
         }
     }
 
-    env->features[FEAT_XSAVE_COMP_LO] = mask;
-    env->features[FEAT_XSAVE_COMP_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_XCR0_LO] = mask;
+    env->features[FEAT_XSAVE_XCR0_HI] = mask >> 32;
 }
 
 /***** Steps involved on loading and filtering CPUID data
@@ -6423,7 +6423,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0008_EBX);
         x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
-        x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+        x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE_INSTRUCTION);
 
         /* Intel Processor Trace requires CPUID[0x14] */
         if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1a5c174dc..b86eb8dba0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -525,10 +525,10 @@ typedef enum FeatureWord {
     FEAT_HV_RECOMM_EAX, /* CPUID[4000_0004].EAX */
     FEAT_HV_NESTED_EAX, /* CPUID[4000_000A].EAX */
     FEAT_SVM,           /* CPUID[8000_000A].EDX */
-    FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
+    FEAT_XSAVE_INSTRUCTION, /* CPUID[EAX=0xd,ECX=1].EAX */
     FEAT_6_EAX,         /* CPUID[6].EAX */
-    FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
-    FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
+    FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
+    FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
     FEAT_CORE_CAPABILITY,
     FEAT_PERF_CAPABILITIES,
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 4ea73874d8..a104467a18 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -2891,7 +2891,7 @@ uint64_t helper_xgetbv(CPUX86State *env, uint32_t ecx)
     case 0:
         return env->xcr0;
     case 1:
-        if (env->features[FEAT_XSAVE] & CPUID_XSAVE_XGETBV1) {
+        if (env->features[FEAT_XSAVE_INSTRUCTION] & CPUID_XSAVE_XGETBV1) {
             return env->xcr0 & get_xinuse(env);
         }
         break;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index caea6f5fb1..8510300ae6 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8481,7 +8481,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_ext2_features = env->features[FEAT_8000_0001_EDX];
     dc->cpuid_ext3_features = env->features[FEAT_8000_0001_ECX];
     dc->cpuid_7_0_ebx_features = env->features[FEAT_7_0_EBX];
-    dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
+    dc->cpuid_xsave_features = env->features[FEAT_XSAVE_INSTRUCTION];
 #ifdef TARGET_X86_64
     dc->lma = (flags >> HF_LMA_SHIFT) & 1;
     dc->code64 = (flags >> HF_CS64_SHIFT) & 1;
-- 
2.26.2


