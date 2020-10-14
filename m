Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33534C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AE720848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AE720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfcu-0004EA-Er
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kSfaW-0001wi-2Y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:09:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:2248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kSfaU-0002rj-0V
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:08:59 -0400
IronPort-SDR: tm5xqzGlHwIxbLsJRDXQ6+/w3oRH08McvEyy3lMJ/txnVmJHLOtQMZQO653I3Lco+UXkk7gLhy
 G/q0ty2zXKhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166153446"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="166153446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 05:08:54 -0700
IronPort-SDR: YB3U6vn3yl6hXMS1OdOfo1v/UzWk5JzdZfWxGuAdFw+qSCDByzuELIPkoQQ+qvQdef/m7fQ473
 N3hItoHY7wJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="463865106"
Received: from snr.bj.intel.com ([10.240.192.237])
 by orsmga004.jf.intel.com with ESMTP; 14 Oct 2020 05:08:53 -0700
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH 2/2] i386/cpu: Make the Intel PT LIP feature configurable
Date: Wed, 14 Oct 2020 16:04:43 +0800
Message-Id: <20201014080443.23751-2-luwei.kang@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201014080443.23751-1-luwei.kang@intel.com>
References: <20201014080443.23751-1-luwei.kang@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=luwei.kang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 08:08:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Luwei Kang <luwei.kang@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current implementation will disable the guest Intel PT
feature if the Intel PT LIP feature is supported on the host,
but the LIP feature is comming soon(e.g. SnowRidge and later).

This patch will make the guest LIP feature configurable and
Intel PT feature can be enabled in guest when the guest LIP
status same with the host.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.c | 29 +++++++++++++++++++++++++++--
 target/i386/cpu.h |  4 ++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 24644abfd4..aeabdd5bd4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -672,6 +672,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
           /* missing:
           CPUID_XSAVE_XSAVEC, CPUID_XSAVE_XSAVES */
+#define TCG_14_0_ECX_FEATURES 0
 
 typedef enum FeatureWordType {
    CPUID_FEATURE_WORD,
@@ -1301,6 +1302,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         }
     },
 
+    [FEAT_14_0_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "intel-pt-lip",
+        },
+        .cpuid = {
+            .eax = 0x14,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_ECX,
+        },
+        .tcg_features = TCG_14_0_ECX_FEATURES,
+    },
+
 };
 
 typedef struct FeatureMask {
@@ -5743,6 +5764,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = INTEL_PT_MAX_SUBLEAF;
             *ebx = INTEL_PT_MINIMAL_EBX;
             *ecx = INTEL_PT_MINIMAL_ECX;
+            if (env->features[FEAT_14_0_ECX] & CPUID_14_0_ECX_LIP) {
+                *ecx |= CPUID_14_0_ECX_LIP;
+            }
         } else if (count == 1) {
             *eax = INTEL_PT_MTC_BITMAP | INTEL_PT_ADDR_RANGES_NUM;
             *ebx = INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
@@ -6416,8 +6440,9 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
                ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) >=
                                            INTEL_PT_ADDR_RANGES_NUM) &&
                ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) ==
-                    (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) &&
-               !(ecx_0 & INTEL_PT_IP_LIP)) {
+                        (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) &&
+               ((ecx_0 & CPUID_14_0_ECX_LIP) ==
+                        (env->features[FEAT_14_0_ECX] & CPUID_14_0_ECX_LIP))) {
                 if (cpu->intel_pt_auto_level) {
                     x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
                 } else if (cpu->env.cpuid_min_level < 0x14) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51c1d5f60a..1fcd93e39a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -541,6 +541,7 @@ typedef enum FeatureWord {
     FEAT_VMX_EPT_VPID_CAPS,
     FEAT_VMX_BASIC,
     FEAT_VMX_VMFUNC,
+    FEAT_14_0_ECX,
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -797,6 +798,9 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 /* AVX512 BFloat16 Instruction */
 #define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
 
+/* Packets which contain IP payload have LIP values */
+#define CPUID_14_0_ECX_LIP              (1U << 31)
+
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
 /* Always save/restore FP error pointers */
-- 
2.18.4


