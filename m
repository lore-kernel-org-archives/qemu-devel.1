Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA73C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 08:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D8F20739
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 08:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D8F20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk1II-0000by-1J
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 04:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jk1Ga-0006Xf-Vl
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 04:11:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:50495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jk1GX-0000MD-Dt
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 04:11:52 -0400
IronPort-SDR: P/spk5s+9/DMhtwxityM3dyPE4WgVbBWdFIRX2MCUuKw0+EtU4481M3NzlYE+vHyLDgN69hlag
 RmORVySvXf3g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2020 01:11:45 -0700
IronPort-SDR: AK6qlJLtROluxcMsH4ncP5Bzl2ypOMmN2KFrcBhDfVHb8eHrTJd83OdsFQD10TmzWoJ06oh5md
 h891sxQCa/SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,506,1583222400"; d="scan'208";a="474467502"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org)
 ([10.239.48.212])
 by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2020 01:11:41 -0700
From: Like Xu <like.xu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] target/i386: add -cpu,
 lbr=true support to enable guest LBR
Date: Sat, 13 Jun 2020 16:09:58 +0800
Message-Id: <20200613080958.132489-14-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200613080958.132489-1-like.xu@linux.intel.com>
References: <20200613080958.132489-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=like.xu@linux.intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 04:11:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: ak@linux.intel.com, Wanpeng Li <wanpengli@tencent.com>,
 Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, wei.w.wang@intel.com,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Jim Mattson <jmattson@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The LBR feature would be enabled on the guest if:
- the KVM is enabled and the PMU is enabled and,
- the msr-based-feature IA32_PERF_CAPABILITIES is supporterd and,
- the supported returned value for lbr_fmt from this msr is not zero.

The LBR feature would be disabled on the guest if:
- the msr-based-feature IA32_PERF_CAPABILITIES is unsupporterd OR,
- qemu set the IA32_PERF_CAPABILITIES msr feature without lbr_fmt values OR,
- the requested guest vcpu model doesn't support PDCM.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 25 +++++++++++++++++++++++--
 target/i386/cpu.h |  2 ++
 target/i386/kvm.c |  7 ++++++-
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2128f3d6fe..8d8d42a8ea 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -316,6 +316,7 @@ GlobalProperty pc_compat_1_5[] = {
     { "Nehalem-" TYPE_X86_CPU, "min-level", "2" },
     { "virtio-net-pci", "any_layout", "off" },
     { TYPE_X86_CPU, "pmu", "on" },
+    { TYPE_X86_CPU, "lbr", "on" },
     { "i440FX-pcihost", "short_root_bus", "0" },
     { "q35-pcihost", "short_root_bus", "0" },
 };
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e47c9d1604..262a2595fa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1142,8 +1142,8 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_PERF_CAPABILITIES] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "lbr-fmt-bit-0", "lbr-fmt-bit-1", "lbr-fmt-bit-2", "lbr-fmt-bit-3",
+            "lbr-fmt-bit-4", "lbr-fmt-bit-5", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "full-width-write", NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -4187,6 +4187,13 @@ static bool lmce_supported(void)
     return !!(mce_cap & MCG_LMCE_P);
 }
 
+static inline bool lbr_supported(void)
+{
+    return kvm_enabled() && (PERF_CAP_LBR_FMT &
+        kvm_arch_get_supported_msr_feature(kvm_state,
+                                           MSR_IA32_PERF_CAPABILITIES));
+}
+
 #define CPUID_MODEL_ID_SZ 48
 
 /**
@@ -4290,6 +4297,9 @@ static void max_x86_cpu_initfn(Object *obj)
     }
 
     object_property_set_bool(OBJECT(cpu), true, "pmu", &error_abort);
+    if (lbr_supported()) {
+        object_property_set_bool(OBJECT(cpu), true, "lbr", &error_abort);
+    }
 }
 
 static const TypeInfo max_x86_cpu_type_info = {
@@ -5510,6 +5520,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
+            if (cpu->enable_lbr) {
+                warn_report("LBR is unsupported since guest PMU is disabled.");
+                exit(1);
+            }
         }
         break;
     case 2:
@@ -6528,6 +6542,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (!cpu->max_features && cpu->enable_lbr &&
+        !(env->features[FEAT_1_ECX] & CPUID_EXT_PDCM)) {
+        warn_report("requested vcpu model doesn't support PDCM for LBR.");
+        exit(1);
+    }
+
     if (cpu->ucode_rev == 0) {
         /* The default is the same as KVM's.  */
         if (IS_AMD_CPU(env)) {
@@ -7165,6 +7185,7 @@ static Property x86_cpu_properties[] = {
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
+    DEFINE_PROP_BOOL("lbr", X86CPU, enable_lbr, false),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_RETRY),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fad2f874bd..e5f65e9b0c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -357,6 +357,7 @@ typedef enum X86Seg {
 #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
 
 #define MSR_IA32_PERF_CAPABILITIES      0x345
+#define PERF_CAP_LBR_FMT      0x3f
 
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
@@ -1686,6 +1687,7 @@ struct X86CPU {
      * capabilities) directly to the guest.
      */
     bool enable_pmu;
+    bool enable_lbr;
 
     /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
      * disabled by default to avoid breaking migration between QEMU with
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9be6f76b2c..524ae86b0c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2652,8 +2652,10 @@ static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
     uint64_t kvm_perf_cap =
         kvm_arch_get_supported_msr_feature(kvm_state,
                                            MSR_IA32_PERF_CAPABILITIES);
-
     if (kvm_perf_cap) {
+        if (!cpu->enable_lbr) {
+            kvm_perf_cap &= ~PERF_CAP_LBR_FMT;
+        }
         kvm_msr_entry_add(cpu, MSR_IA32_PERF_CAPABILITIES,
                         kvm_perf_cap & f[FEAT_PERF_CAPABILITIES]);
     }
@@ -2693,6 +2695,9 @@ static void kvm_init_msrs(X86CPU *cpu)
 
     if (has_msr_perf_capabs && cpu->enable_pmu) {
         kvm_msr_entry_add_perf(cpu, env->features);
+    } else if (!has_msr_perf_capabs && cpu->enable_lbr) {
+        warn_report("host doesn't support MSR_IA32_PERF_CAPABILITIES for LBR.");
+        exit(1);
     }
 
     if (has_msr_ucode_rev) {
-- 
2.21.3


