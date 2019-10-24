Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE101CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFA321655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMHLOjgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFA321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdl4-0002F1-PL
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdih-0006vR-DI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdif-0007cr-Sv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdid-0007ag-VY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id r141so2730756wme.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=klIHsHZRArDFTcQXKJkBiIBV52Qlwr6+QqqMGTKzp4Y=;
 b=MMHLOjgl1bnUBY6IdFLx285S7DNwKFsOmKFUhbFwpwfHtuIGPnwREJjhs8s9HTTy/n
 ql7iBfG+OFMnetnBsLrSI84jdSAnNQ9mNLiodWzgOE2ijTb5o5UJo5qDXCrWplVGG1Iq
 8BgLwLwyCItaLKzAP0SqsHK181uPRsV9eEeY0ilUTzZV/gHHqVG77oNEqTFh3/FynE+W
 hzHjn1AN6DYdJQ+yKlo3Fp4Bsw3WvFdDCBddjuzzDqlZcOt97h0GWnI0qq+kWTEt7LW/
 ZPbXCVBv/+aRGAS+sEXElbTxlUsYv9h5I4aHOXQIW6G68I9MH+sIP6AGdivNCm+Cg7Le
 ylOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=klIHsHZRArDFTcQXKJkBiIBV52Qlwr6+QqqMGTKzp4Y=;
 b=le9UAQRbHPMFg6XOhz4m48mwdFsrR1ndj/U9wvz0ShTKva+35NWGqzrRc3U77npm9F
 6qdarn/KqccgQRtUHlSul8z3yeF1IuPQ8khnSZa6T9gkFlf1k28tovO980T6hnVHjBXe
 N+WhfSWzhZIFkPxFn7QuoVuZsNsrs4jzwJRumaK0RYreKrAIP3mJJZfwY7oUsjOOrX9l
 fGE1+lKbOBqmFUIh5Y7/7XjUL/A5fMwZOMOL5PYggCv5CQAQCn298jUwnNAgX3Pidwi+
 g+NGe+R6DRdgfdQwIMm5s4SzlnUYN9CZxcIF8n03Vfqv0JW94VbYcgFO9gitqliIDqd2
 7dCw==
X-Gm-Message-State: APjAAAVhSO/ekQ6i1igpZcvvxXUPPiU91mF6ItZrKt7U/HrcNCvE9O2c
 bOpQZBE1rJ/iUFvEicvWyckxw+FM
X-Google-Smtp-Source: APXvYqzECZXcbGB7oBpbaaliiXU+gqvirWlpGsd4yHMYg5ElFnnphMNWamuXzaY9vxNqJ+EgrqUoPg==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr5491549wme.0.1571925841889;
 Thu, 24 Oct 2019 07:04:01 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/39] i386/kvm: add NoNonArchitecturalCoreSharing Hyper-V
 enlightenment
Date: Thu, 24 Oct 2019 16:03:20 +0200
Message-Id: <1571925835-31930-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Hyper-V TLFS specifies this enlightenment as:
"NoNonArchitecturalCoreSharing - Indicates that a virtual processor will never
share a physical core with another virtual processor, except for virtual
processors that are reported as sibling SMT threads. This can be used as an
optimization to avoid the performance overhead of STIBP".

However, STIBP is not the only implication. It was found that Hyper-V on
KVM doesn't pass MD_CLEAR bit to its guests if it doesn't see
NoNonArchitecturalCoreSharing bit.

KVM reports NoNonArchitecturalCoreSharing in KVM_GET_SUPPORTED_HV_CPUID to
indicate that SMT on the host is impossible (not supported of forcefully
disabled).

Implement NoNonArchitecturalCoreSharing support in QEMU as tristate:
'off' - the feature is disabled (default)
'on' - the feature is enabled. This is only safe if vCPUS are properly
 pinned and correct topology is exposed. As CPU pinning is done outside
 of QEMU the enablement decision will be made on a higher level.
'auto' - copy KVM setting. As during live migration SMT settings on the
source and destination host may differ this requires us to add a migration
blocker.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20191018163908.10246-1-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/hyperv.txt            | 13 +++++++++++++
 target/i386/cpu.c          |  2 ++
 target/i386/cpu.h          |  2 ++
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          | 26 ++++++++++++++++++++++++++
 5 files changed, 44 insertions(+)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index 8fdf25c..6518b71 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -184,6 +184,19 @@ enabled.
 
 Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
 
+3.17. hv-no-nonarch-coresharing=on/off/auto
+===========================================
+This enlightenment tells guest OS that virtual processors will never share a
+physical core unless they are reported as sibling SMT threads. This information
+is required by Windows and Hyper-V guests to properly mitigate SMT related CPU
+vulnerabilities.
+When the option is set to 'auto' QEMU will enable the feature only when KVM
+reports that non-architectural coresharing is impossible, this means that
+hyper-threading is not supported or completely disabled on the host. This
+setting also prevents migration as SMT settings on the destination may differ.
+When the option is set to 'on' QEMU will always enable the feature, regardless
+of host setup. To keep guests secure, this can only be used in conjunction with
+exposing correct vCPU topology and vCPU pinning.
 
 4. Development features
 ========================
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 47200b4..6c87c99 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6174,6 +6174,8 @@ static Property x86_cpu_properties[] = {
                       HYPERV_FEAT_IPI, 0),
     DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
                       HYPERV_FEAT_STIMER_DIRECT, 0),
+    DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
+                            hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
     DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
 
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cedb5bc..c50a9c7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 #include "hyperv-proto.h"
 #include "exec/cpu-defs.h"
+#include "qapi/qapi-types-common.h"
 
 /* The x86 has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
@@ -1614,6 +1615,7 @@ struct X86CPU {
     bool hyperv_synic_kvm_only;
     uint64_t hyperv_features;
     bool hyperv_passthrough;
+    OnOffAuto hyperv_no_nonarch_cs;
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index cffac10..056a305 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -63,6 +63,7 @@
 #define HV_CLUSTER_IPI_RECOMMENDED          (1u << 10)
 #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
 #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
+#define HV_NO_NONARCH_CORESHARING           (1u << 18)
 
 /*
  * Basic virtualized MSRs
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0e3da99..49a3011 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1227,6 +1227,16 @@ static int hyperv_handle_properties(CPUState *cs,
         }
     }
 
+    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
+        env->features[FEAT_HV_RECOMM_EAX] |= HV_NO_NONARCH_CORESHARING;
+    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
+        c = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
+        if (c) {
+            env->features[FEAT_HV_RECOMM_EAX] |=
+                c->eax & HV_NO_NONARCH_CORESHARING;
+        }
+    }
+
     /* Features */
     r = hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC);
@@ -1340,6 +1350,7 @@ free:
 }
 
 static Error *hv_passthrough_mig_blocker;
+static Error *hv_no_nonarch_cs_mig_blocker;
 
 static int hyperv_init_vcpu(X86CPU *cpu)
 {
@@ -1359,6 +1370,21 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         }
     }
 
+    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO &&
+        hv_no_nonarch_cs_mig_blocker == NULL) {
+        error_setg(&hv_no_nonarch_cs_mig_blocker,
+                   "'hv-no-nonarch-coresharing=auto' CPU flag prevents migration"
+                   " use explicit 'hv-no-nonarch-coresharing=on' instead (but"
+                   " make sure SMT is disabled and/or that vCPUs are properly"
+                   " pinned)");
+        ret = migrate_add_blocker(hv_no_nonarch_cs_mig_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(hv_no_nonarch_cs_mig_blocker);
+            return ret;
+        }
+    }
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) && !hv_vpindex_settable) {
         /*
          * the kernel doesn't support setting vp_index; assert that its value
-- 
1.8.3.1



