Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64569C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8252076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtsPqbT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8252076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJdZ-0003Ir-Et
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNJaA-00028C-3F
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNJa8-00064Y-1a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601401107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtUu3CrhzYIb4RtcP4t2TtTUzaKmg5OKUKRpAVs4XzY=;
 b=VtsPqbT9lQJSi9O2Sl2t46bc8HUAjZnL6m04xl5PhWZ6YtPP+xACbuiMBTFs2nfYSOBXY9
 xIcJd66hKSMQ/hfnwU9kSmffe9c3/u4QFelUVIYjHmaJDsPrPTAz1tz4HhLMAu17o5jlH6
 eZYgoJHLpz/iYJFiyy8PwiIixPE20fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-p9Oqmer9ODmglN_hJt-Msg-1; Tue, 29 Sep 2020 13:38:24 -0400
X-MC-Unique: p9Oqmer9ODmglN_hJt-Msg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51520EAC52;
 Tue, 29 Sep 2020 17:38:23 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0A725C1CF;
 Tue, 29 Sep 2020 17:38:22 +0000 (UTC)
Date: Tue, 29 Sep 2020 13:38:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Subject: Re: [Qemu-devel PATCH v2] target/i386: add "-cpu,lbr-fmt=*" support
 to enable guest LBR
Message-ID: <20200929173822.GK3717385@habkost.net>
References: <20200929061217.118440-1-like.xu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20200929061217.118440-1-like.xu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Strong,
 Beeman" <beeman.strong@intel.com>, "Kang, Luwei" <luwei.kang@intel.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(CCing the people from the thread, as kvm_exact_match_flags would
be useful for INTEL_PT_IP_LIP)

On Tue, Sep 29, 2020 at 02:12:17PM +0800, Like Xu wrote:
> The last branch recording (LBR) is a performance monitor unit (PMU)
> feature on Intel processors that records a running trace of the most
> recent branches taken by the processor in the LBR stack. The QEMU
> could configure whether it's enabled or not for each guest via CLI.
> 
> The LBR feature would be enabled on the guest if:
> - the KVM is enabled and the PMU is enabled and,
> - the msr-based-feature IA32_PERF_CAPABILITIES is supporterd on KVM and,
> - the supported returned value for lbr_fmt from this msr is not zero and,
> - the requested guest vcpu model does support FEAT_1_ECX.CPUID_EXT_PDCM,
> - the configured lbr-fmt value is the same as the host lbr_fmt value.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

The approach below looks better, thanks!  Only one problem below,
with a few suggestions and questions:

> ---
>  target/i386/cpu.c | 16 ++++++++++++++++
>  target/i386/cpu.h | 10 ++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3ffd877dd5..b10344be01 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6461,6 +6461,13 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>              x86_cpu_get_supported_feature_word(w, false);
>          uint64_t requested_features = env->features[w];
>          uint64_t unavailable_features = requested_features & ~host_feat;
> +        if (w == FEAT_PERF_CAPABILITIES &&
> +            (requested_features & PERF_CAP_LBR_FMT)) {
> +            if ((host_feat & PERF_CAP_LBR_FMT) !=
> +                (requested_features & PERF_CAP_LBR_FMT)) {
> +                unavailable_features |= PERF_CAP_LBR_FMT;
> +            }
> +        }

This looks correct, but needs to be conditional on kvm_enabled().

I also have a suggestion: instead of hardcoding the
PERF_CAPABILITIES rules in this loop, this could become a
FeatureWordInfo field.  It would be very useful for other
features like intel-pt, where we need some bits to match the host
too.

Could you please check if the following patch works?

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b10344be010..d4107dcc026 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -704,6 +704,8 @@ typedef struct FeatureWordInfo {
     uint64_t migratable_flags; /* Feature flags known to be migratable */
     /* Features that shouldn't be auto-enabled by "-cpu host" */
     uint64_t no_autoenable_flags;
+    /* Bits that must match host exactly when using KVM */
+    uint64_t kvm_exact_match_flags;
 } FeatureWordInfo;
 
 static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
@@ -1143,6 +1145,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .msr = {
             .index = MSR_IA32_PERF_CAPABILITIES,
         },
+        /*
+         * KVM is not able to emulate a VCPU with LBR_FMT different
+         * from the host, so LBR_FMT must match the host exactly.
+         */
+        .kvm_exact_match_flags = PERF_CAP_LBR_FMT,
     },
 
     [FEAT_VMX_PROCBASED_CTLS] = {
@@ -6457,16 +6464,15 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     }
 
     for (w = 0; w < FEATURE_WORDS; w++) {
+        FeatureWordInfo *fi = &feature_word_info[w];
         uint64_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
         uint64_t requested_features = env->features[w];
         uint64_t unavailable_features = requested_features & ~host_feat;
-        if (w == FEAT_PERF_CAPABILITIES &&
-            (requested_features & PERF_CAP_LBR_FMT)) {
-            if ((host_feat & PERF_CAP_LBR_FMT) !=
-                (requested_features & PERF_CAP_LBR_FMT)) {
-                unavailable_features |= PERF_CAP_LBR_FMT;
-            }
+        if (kvm_enabled()) {
+            uint64_t mismatches = (requested_features ^ host_feat) &
+                                  fi->kvm_exact_match_flags;
+            mark_unavailable_features(cpu, w, mismatches, "feature doesn't match host");
         }
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
  
---------------------------

>          mark_unavailable_features(cpu, w, unavailable_features, prefix);
>      }
>  
> @@ -6533,6 +6540,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    if (cpu->lbr_fmt) {
> +        if (!cpu->enable_pmu) {
> +            error_setg(errp, "LBR is unsupported since guest PMU is disabled.");
> +            return;
> +        }

This is not wrong, but looks like an obstacle for making the
feature migratable and needs to be addressed as a follow up if
you want live migration support.  CPUID[0xA] is exposing host
CPUID directly if enable_pmu is enabled.

Also, I don't understand why PDCM is being silently disabled at
cpu_x86_cpuid() if enable_pmu is not set.  Isn't it valid to set
PDCM=1 without CPUID[0xA]?


> +        env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
> +    }
> +
>      /* mwait extended info: needed for Core compatibility */
>      /* We always wake on interrupt even if host does not have the capability */
>      cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
> @@ -7157,6 +7172,7 @@ static Property x86_cpu_properties[] = {
>  #endif
>      DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
>      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
> +    DEFINE_PROP_UINT8("lbr-fmt", X86CPU, lbr_fmt, 0),
>  
>      DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
>                         HYPERV_SPINLOCK_NEVER_NOTIFY),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index f519d2bfd4..c1cf8b7160 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -357,6 +357,7 @@ typedef enum X86Seg {
>  #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
>  
>  #define MSR_IA32_PERF_CAPABILITIES      0x345
> +#define PERF_CAP_LBR_FMT      0x3f
>  
>  #define MSR_IA32_TSX_CTRL		0x122
>  #define MSR_IA32_TSCDEADLINE            0x6e0
> @@ -1701,6 +1702,15 @@ struct X86CPU {
>       */
>      bool enable_pmu;
>  
> +    /*
> +     * Configure LBR_FMT bits on IA32_PERF_CAPABILITIES MSR.
> +     * This can't be enabled by default yet because it doesn't have
> +     * ABI stability guarantees, as it is only allowed to pass all
> +     * LBR_FMT bits returned by kvm_arch_get_supported_msr_feature()
> +     * (that depends on host CPU and kernel capabilities) to the guest.
> +     */
> +    uint8_t lbr_fmt;
> +
>      /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
>       * disabled by default to avoid breaking migration between QEMU with
>       * different LMCE configurations.
> -- 
> 2.21.3
> 

-- 
Eduardo


