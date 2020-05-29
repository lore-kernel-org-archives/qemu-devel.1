Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54A1205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54A1205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZi1-0004Hy-SJ
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jeZh0-0002sH-5R
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:44:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:51955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jeZgy-0003au-AB
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:44:37 -0400
IronPort-SDR: xTJ8t7HIl+gYAALx5yHT31/Y+6cYcIhvfqs9X2L2EQmOiR+BXE1DfJ3v7RrcdPk0HG8V7M0+ZO
 wr7X132bzXZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 00:44:32 -0700
IronPort-SDR: pAtbK/ZL4wacXy7akSK8f7a0OgGWVX08DhI71Z2hZ3eKkQvYg35mTSDAggH76/oKq+wmzgFMJO
 u/2QKvbu0L7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; d="scan'208";a="302754570"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org)
 ([10.239.48.212])
 by fmsmga002.fm.intel.com with ESMTP; 29 May 2020 00:44:29 -0700
From: Like Xu <like.xu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [Qemu-devel PATCH] target/i386: define a new MSR based feature word -
 FEAT_PERF_CAPABILITIES
Date: Fri, 29 May 2020 15:43:47 +0800
Message-Id: <20200529074347.124619-5-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200529074347.124619-1-like.xu@linux.intel.com>
References: <20200529074347.124619-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=like.xu@linux.intel.com; helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:44:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Cc: Wanpeng Li <wanpengli@tencent.com>, Like Xu <like.xu@linux.intel.com>,
 kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Jim Mattson <jmattson@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Perfmon and Debug Capability MSR named IA32_PERF_CAPABILITIES is
a feature-enumerating MSR, which only enumerates the feature full-width
write (via bit 13) by now which indicates the processor supports IA32_A_PMCx
interface for updating bits 32 and above of IA32_PMCx.

The existence of MSR IA32_PERF_CAPABILITIES is enumerated by CPUID.1:ECX[15].

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 target/i386/cpu.c | 29 +++++++++++++++++++++++++++++
 target/i386/cpu.h |  3 +++
 target/i386/kvm.c | 20 ++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3733d9a279..be56966bb0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1139,6 +1139,22 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .index = MSR_IA32_CORE_CAPABILITY,
         },
     },
+    [FEAT_PERF_CAPABILITIES] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "full-width-write", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_PERF_CAPABILITIES,
+        },
+    },
 
     [FEAT_VMX_PROCBASED_CTLS] = {
         .type = MSR_FEATURE_WORD,
@@ -1316,6 +1332,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
         .to = { FEAT_CORE_CAPABILITY,       ~0ull },
     },
+    {
+        .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
+        .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
+    },
     {
         .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
         .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
@@ -5488,6 +5508,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
             *edx |= CPUID_HT;
         }
+        if (!cpu->enable_pmu) {
+            *ecx &= ~CPUID_EXT_PDCM;
+        }
         break;
     case 2:
         /* cache info: needed for Pentium Pro compatibility */
@@ -6505,6 +6528,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (kvm_enabled() && cpu->enable_pmu &&
+        (kvm_arch_get_supported_cpuid(kvm_state, 1, 0, R_ECX) &
+         CPUID_EXT_PDCM)) {
+        env->features[FEAT_1_ECX] |= CPUID_EXT_PDCM;
+    }
+
     if (cpu->ucode_rev == 0) {
         /* The default is the same as KVM's.  */
         if (IS_AMD_CPU(env)) {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 408392dbf6..fad2f874bd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -356,6 +356,8 @@ typedef enum X86Seg {
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
 #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
 
+#define MSR_IA32_PERF_CAPABILITIES      0x345
+
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
@@ -529,6 +531,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
     FEAT_CORE_CAPABILITY,
+    FEAT_PERF_CAPABILITIES,
     FEAT_VMX_PROCBASED_CTLS,
     FEAT_VMX_SECONDARY_CTLS,
     FEAT_VMX_PINBASED_CTLS,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 34f838728d..9be6f76b2c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -106,6 +106,7 @@ static bool has_msr_core_capabs;
 static bool has_msr_vmx_vmfunc;
 static bool has_msr_ucode_rev;
 static bool has_msr_vmx_procbased_ctls2;
+static bool has_msr_perf_capabs;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2027,6 +2028,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_CORE_CAPABILITY:
                 has_msr_core_capabs = true;
                 break;
+            case MSR_IA32_PERF_CAPABILITIES:
+                has_msr_perf_capabs = true;
+                break;
             case MSR_IA32_VMX_VMFUNC:
                 has_msr_vmx_vmfunc = true;
                 break;
@@ -2643,6 +2647,18 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
                       VMCS12_MAX_FIELD_INDEX << 1);
 }
 
+static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
+{
+    uint64_t kvm_perf_cap =
+        kvm_arch_get_supported_msr_feature(kvm_state,
+                                           MSR_IA32_PERF_CAPABILITIES);
+
+    if (kvm_perf_cap) {
+        kvm_msr_entry_add(cpu, MSR_IA32_PERF_CAPABILITIES,
+                        kvm_perf_cap & f[FEAT_PERF_CAPABILITIES]);
+    }
+}
+
 static int kvm_buf_set_msrs(X86CPU *cpu)
 {
     int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
@@ -2675,6 +2691,10 @@ static void kvm_init_msrs(X86CPU *cpu)
                           env->features[FEAT_CORE_CAPABILITY]);
     }
 
+    if (has_msr_perf_capabs && cpu->enable_pmu) {
+        kvm_msr_entry_add_perf(cpu, env->features);
+    }
+
     if (has_msr_ucode_rev) {
         kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
     }
-- 
2.21.3


