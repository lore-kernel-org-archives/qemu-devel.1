Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C3C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 06:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7AC20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 06:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7AC20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN8wb-0002Oe-HQ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 02:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1kN8vj-0001xN-Al
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 02:16:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:30319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1kN8vh-0000dR-2u
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 02:16:03 -0400
IronPort-SDR: Ko9CbXwZfpRiJT9Je8u1imtyp1+xe2UC9uiRL4zGIHgU3HgVSRLctAWdJPnRmmf/WwDvYvI9LK
 HeSH863KkwBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="226269555"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; d="scan'208";a="226269555"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 23:15:56 -0700
IronPort-SDR: jZkTOBOXLq0ojd5Pq5/yIZvda97yNq+UwfbSR24fmBZ01jaJymxltqmkUUqlHfU9LROvPw6PWn
 exq/rsnTKHOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; d="scan'208";a="340737780"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org)
 ([10.239.48.212])
 by orsmga008.jf.intel.com with ESMTP; 28 Sep 2020 23:15:54 -0700
From: Like Xu <like.xu@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Subject: [Qemu-devel PATCH v2] target/i386: add "-cpu,
 lbr-fmt=*" support to enable guest LBR
Date: Tue, 29 Sep 2020 14:12:17 +0800
Message-Id: <20200929061217.118440-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=like.xu@linux.intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:15:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The last branch recording (LBR) is a performance monitor unit (PMU)
feature on Intel processors that records a running trace of the most
recent branches taken by the processor in the LBR stack. The QEMU
could configure whether it's enabled or not for each guest via CLI.

The LBR feature would be enabled on the guest if:
- the KVM is enabled and the PMU is enabled and,
- the msr-based-feature IA32_PERF_CAPABILITIES is supporterd on KVM and,
- the supported returned value for lbr_fmt from this msr is not zero and,
- the requested guest vcpu model does support FEAT_1_ECX.CPUID_EXT_PDCM,
- the configured lbr-fmt value is the same as the host lbr_fmt value.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 target/i386/cpu.c | 16 ++++++++++++++++
 target/i386/cpu.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ffd877dd5..b10344be01 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6461,6 +6461,13 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             x86_cpu_get_supported_feature_word(w, false);
         uint64_t requested_features = env->features[w];
         uint64_t unavailable_features = requested_features & ~host_feat;
+        if (w == FEAT_PERF_CAPABILITIES &&
+            (requested_features & PERF_CAP_LBR_FMT)) {
+            if ((host_feat & PERF_CAP_LBR_FMT) !=
+                (requested_features & PERF_CAP_LBR_FMT)) {
+                unavailable_features |= PERF_CAP_LBR_FMT;
+            }
+        }
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
@@ -6533,6 +6540,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (cpu->lbr_fmt) {
+        if (!cpu->enable_pmu) {
+            error_setg(errp, "LBR is unsupported since guest PMU is disabled.");
+            return;
+        }
+        env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
+    }
+
     /* mwait extended info: needed for Core compatibility */
     /* We always wake on interrupt even if host does not have the capability */
     cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
@@ -7157,6 +7172,7 @@ static Property x86_cpu_properties[] = {
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
+    DEFINE_PROP_UINT8("lbr-fmt", X86CPU, lbr_fmt, 0),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_NOTIFY),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f519d2bfd4..c1cf8b7160 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -357,6 +357,7 @@ typedef enum X86Seg {
 #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
 
 #define MSR_IA32_PERF_CAPABILITIES      0x345
+#define PERF_CAP_LBR_FMT      0x3f
 
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
@@ -1701,6 +1702,15 @@ struct X86CPU {
      */
     bool enable_pmu;
 
+    /*
+     * Configure LBR_FMT bits on IA32_PERF_CAPABILITIES MSR.
+     * This can't be enabled by default yet because it doesn't have
+     * ABI stability guarantees, as it is only allowed to pass all
+     * LBR_FMT bits returned by kvm_arch_get_supported_msr_feature()
+     * (that depends on host CPU and kernel capabilities) to the guest.
+     */
+    uint8_t lbr_fmt;
+
     /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
      * disabled by default to avoid breaking migration between QEMU with
      * different LMCE configurations.
-- 
2.21.3


