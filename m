Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05749C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22A320652
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZZHIvtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22A320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8xq-0005yw-3V
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a7-0006i9-Vj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a4-0006hZ-5n
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8a3-0006H9-66
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id c6so4929085wml.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rLWxEjPZN+ttDy6470/jW3LY13Gz8VOEZike0sn0oXQ=;
 b=TZZHIvtLm+DkuRRO2AQJKzG01U+Je1wC8UwFdiM+DaXQr1qnIwzu3xBJy93qXwlY1o
 WyboqPgRUgr1qIIKQdP4XDR/t88qM8h95n+DbSvOYDwIIJKmwrLFzIMnoOyJLgzi5/a5
 HYuhiVTbXJW7cubRQFNsCK7uGU160ALpKOSNKJvNEmXNLobSxK2omSufOnMEo7jVVqo9
 5s7J+TeEQPAU2SNQMlxSR5EmTgW2tTB/is2vX6d2Cx/O8gnHD4eLAXqQi+U6UflyKzN9
 pLmSAalAvMtzvrJQkt4BqWIpAlYr/GE0B+J3gDxQSFz2z4gChiWlWu7brhoueuQApyoT
 mi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=rLWxEjPZN+ttDy6470/jW3LY13Gz8VOEZike0sn0oXQ=;
 b=G0Zh7t/MTQFQFoOrGVk1dVyYHuEg35699z0oS7UB0AHYRIjd1/F4DPr093CUCTFzvb
 O0uHochhXujQKQe2I4yBOvWNguP4Cj0jM51xIbDlVq3dEGsbbl7lrGNE5zSnNz5LDlJf
 cghuVc2SKIjl+RDHgD1SC6vHDQN90e8NqaTxca7F77T60m/OISmVi1hzBaSyG3nAHKBG
 EHK2GlmbjbLy+Yeme2k5zwitnhPPOflkeLNFUI1ZBm9DEmA7iuv/hbcY8wvNa9vNZJAk
 Ra8YXjPzNSd+nD1jr8HGKd905wUOzbx/xebAzpV9Eks32/tTWCkD/dZAgqPDfTpAxlwx
 PySg==
X-Gm-Message-State: APjAAAX8gIQqVtE77woBHapK4IeMj8PXD13L6sG7NlAxT1Wg5VVRHuk1
 GpG1soM3Q6gSr2A0WfspjYbnhbPG
X-Google-Smtp-Source: APXvYqwAUnczJwFYtM12p0LE6xdnzBvr+y1QVlH8VScxu4voXqZljbwu+u9naqQDgylmEkNib9QHDA==
X-Received: by 2002:a05:600c:2243:: with SMTP id
 a3mr1459914wmm.83.1561081360686; 
 Thu, 20 Jun 2019 18:42:40 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:12 +0200
Message-Id: <1561081350-3723-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 07/25] i386/kvm: implement 'hv-passthrough' mode
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

In many case we just want to give Windows guests all currently supported
Hyper-V enlightenments and that's where this new mode may come handy. We
pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.

hv_cpuid_check_and_set() is modified to also set cpu->hyperv_* flags as
we may want to check them later (and we actually do for hv_runtime,
hv_synic,...).

'hv-passthrough' is a development only feature, a migration blocker is
added to prevent issues while migrating between hosts with different
feature sets.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190517141924.19024-6-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/hyperv.txt   | 10 +++++++
 target/i386/cpu.c |  1 +
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index c423e0f..beadb2d 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -175,6 +175,16 @@ without the feature to find out if enabling it is beneficial.
 Requires: hv-vapic
 
 
+4. Development features
+========================
+In some cases (e.g. during development) it may make sense to use QEMU in
+'pass-through' mode and give Windows guests all enlightenments currently
+supported by KVM. This pass-through mode is enabled by "hv-passthrough" CPU
+flag.
+Note: enabling this flag effectively prevents migration as supported features
+may differ between target and destination.
+
+
 4. Useful links
 ================
 Hyper-V Top Level Functional specification and other information:
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e90c1ac..e07996c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5883,6 +5883,7 @@ static Property x86_cpu_properties[] = {
                       HYPERV_FEAT_EVMCS, 0),
     DEFINE_PROP_BIT64("hv-ipi", X86CPU, hyperv_features,
                       HYPERV_FEAT_IPI, 0),
+    DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
 
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 30cd1a0..86edbf5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1390,6 +1390,7 @@ struct X86CPU {
     char *hyperv_vendor_id;
     bool hyperv_synic_kvm_only;
     uint64_t hyperv_features;
+    bool hyperv_passthrough;
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a041b4d..93ac6ba 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -639,7 +639,7 @@ static bool hyperv_enabled(X86CPU *cpu)
     CPUState *cs = CPU(cpu);
     return kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV) > 0 &&
         ((cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) ||
-         cpu->hyperv_features);
+         cpu->hyperv_features || cpu->hyperv_passthrough);
 }
 
 static int kvm_arch_set_tsc_khz(CPUState *cs)
@@ -985,10 +985,10 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-    uint32_t r, fw, bits;;
+    uint32_t r, fw, bits;
     int i;
 
-    if (!hyperv_feat_enabled(cpu, feature)) {
+    if (!hyperv_feat_enabled(cpu, feature) && !cpu->hyperv_passthrough) {
         return 0;
     }
 
@@ -1001,15 +1001,23 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
         }
 
         if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) != bits) {
-            fprintf(stderr,
-                    "Hyper-V %s is not supported by kernel\n",
-                    kvm_hyperv_properties[feature].desc);
-            return 1;
+            if (hyperv_feat_enabled(cpu, feature)) {
+                fprintf(stderr,
+                        "Hyper-V %s is not supported by kernel\n",
+                        kvm_hyperv_properties[feature].desc);
+                return 1;
+            } else {
+                return 0;
+            }
         }
 
         env->features[fw] |= bits;
     }
 
+    if (cpu->hyperv_passthrough) {
+        cpu->hyperv_features |= BIT(feature);
+    }
+
     return 0;
 }
 
@@ -1027,22 +1035,29 @@ static int hyperv_handle_properties(CPUState *cs,
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     uint32_t cpuid_i = 0;
-    int r = 0;
+    int r;
 
     if (!hyperv_enabled(cpu))
         return 0;
 
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ||
+        cpu->hyperv_passthrough) {
         uint16_t evmcs_version;
 
-        if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
-                                (uintptr_t)&evmcs_version)) {
+        r = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
+                                (uintptr_t)&evmcs_version);
+
+        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) && r) {
             fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
                     kvm_hyperv_properties[HYPERV_FEAT_EVMCS].desc);
             return -ENOSYS;
         }
-        env->features[FEAT_HV_RECOMM_EAX] |= HV_ENLIGHTENED_VMCS_RECOMMENDED;
-        env->features[FEAT_HV_NESTED_EAX] = evmcs_version;
+
+        if (!r) {
+            env->features[FEAT_HV_RECOMM_EAX] |=
+                HV_ENLIGHTENED_VMCS_RECOMMENDED;
+            env->features[FEAT_HV_NESTED_EAX] = evmcs_version;
+        }
     }
 
     if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_CPUID) > 0) {
@@ -1051,8 +1066,33 @@ static int hyperv_handle_properties(CPUState *cs,
         cpuid = get_supported_hv_cpuid_legacy(cs);
     }
 
+    if (cpu->hyperv_passthrough) {
+        memcpy(cpuid_ent, &cpuid->entries[0],
+               cpuid->nent * sizeof(cpuid->entries[0]));
+
+        c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
+        if (c) {
+            env->features[FEAT_HYPERV_EAX] = c->eax;
+            env->features[FEAT_HYPERV_EBX] = c->ebx;
+            env->features[FEAT_HYPERV_EDX] = c->eax;
+        }
+        c = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
+        if (c) {
+            env->features[FEAT_HV_RECOMM_EAX] = c->eax;
+
+            /* hv-spinlocks may have been overriden */
+            if (cpu->hyperv_spinlock_attempts != HYPERV_SPINLOCK_NEVER_RETRY) {
+                c->ebx = cpu->hyperv_spinlock_attempts;
+            }
+        }
+        c = cpuid_find_entry(cpuid, HV_CPUID_NESTED_FEATURES, 0);
+        if (c) {
+            env->features[FEAT_HV_NESTED_EAX] = c->eax;
+        }
+    }
+
     /* Features */
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
+    r = hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TIME);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_CRASH);
@@ -1085,6 +1125,12 @@ static int hyperv_handle_properties(CPUState *cs,
         goto free;
     }
 
+    if (cpu->hyperv_passthrough) {
+        /* We already copied all feature words from KVM as is */
+        r = cpuid->nent;
+        goto free;
+    }
+
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
     if (!cpu->hyperv_vendor_id) {
@@ -1156,11 +1202,26 @@ free:
     return r;
 }
 
+static Error *hv_passthrough_mig_blocker;
+
 static int hyperv_init_vcpu(X86CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
+    Error *local_err = NULL;
     int ret;
 
+    if (cpu->hyperv_passthrough && hv_passthrough_mig_blocker == NULL) {
+        error_setg(&hv_passthrough_mig_blocker,
+                   "'hv-passthrough' CPU flag prevents migration, use explicit"
+                   " set of hv-* flags instead");
+        ret = migrate_add_blocker(hv_passthrough_mig_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(hv_passthrough_mig_blocker);
+            return ret;
+        }
+    }
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) && !hv_vpindex_settable) {
         /*
          * the kernel doesn't support setting vp_index; assert that its value
-- 
1.8.3.1



