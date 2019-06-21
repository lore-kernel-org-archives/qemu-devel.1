Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47DCC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CDD2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEp1kIV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CDD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heHww-0003DS-0u
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49018)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkW-0000f2-FG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkT-0005Na-CR
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkT-0005L4-4a
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id u8so6232947wmm.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Qznel7g6fB8yvYmlOFOQWGexcJCqwQlz1eNoYvx8nfE=;
 b=XEp1kIV2RKEqVva3kHtsGlNrWGkhKrDoZfI6amrsfsYyGbp41lzu1CcbhW9Mt2GAxa
 MMrWwm07050bsvoRTATsx1iG2LfzwIbrVPj6KQVTsH9tlMusUq8v8mIx5WGd8Z1E5UWI
 t8LxpcT/Fa4XL/XRC2mkdIzSUoHCqXMgVRO8nLQyBXo1b8YtlPfDH6pBT0vpgmvcinZg
 /dnR9fOC8VIFC/rq7dETeyx+5LYGCxgstYCJin1S0NYsZ7Zn38rLZ4q7rajy6HungFeV
 U/82R6rwYkVhOYQ32TqwBL54LOgKNL314Bm8MuSeusp3PrcCaWT7QdSfVJUZC7pDQiF/
 LEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Qznel7g6fB8yvYmlOFOQWGexcJCqwQlz1eNoYvx8nfE=;
 b=jsFdMlIMOxXXE5D/6aMsPnKdsR2LSCpArncs5J2J0rOinnyf1peJ29yeJ2fUztC7PN
 2wg5mrKo8uBBI0O1SWHDMqDcSSOoX7pNK1Go0G7B4qvxJgzZSm67knIKH+rZ5sz/ckis
 +mW5urC8mb8cM4AKpR6afHe8iYqujlWW3m7LjFVU7P58tw3YANV1sKjuZ0NCS8bJxcVF
 KpfQa8PXD57fry26jrN6ObTucTBKQ+e0vMmTP6FTch6mBVgec6Meu29oPrYy5q7LyYOZ
 TS2oGHgB8ugLlo6FnfAgAbQmSdKqjjetS/cWbkRW1WSlJdl91tKHYBMcnbMelOW7sRB7
 F5Dw==
X-Gm-Message-State: APjAAAWJrK/oQsDrsbi9bXwWEjf8FHklLexN/p/Rhqd4gViTp9y7oHbG
 ZNymAkzBorBXcx90ZiTWZCTsZ0NO
X-Google-Smtp-Source: APXvYqyDcm3kg3tpN+lS35uSaqnBr6e3ENbqLZKcKdqZeNd3daF3XBVsFxrOVvE0TnDoHc2Fa4SOMQ==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr3810261wmc.91.1561116627720; 
 Fri, 21 Jun 2019 04:30:27 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:00 +0200
Message-Id: <1561116620-22245-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 05/25] i386/kvm: move Hyper-V CPUID filling to
 hyperv_handle_properties()
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

Let's consolidate Hyper-V features handling in hyperv_handle_properties().
The change is necessary to support 'hv-passthrough' mode as we'll be just
copying CPUIDs from KVM instead of filling them in.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190517141924.19024-4-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 163 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 90 insertions(+), 73 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index cd492d4..a041b4d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1013,13 +1013,25 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     return 0;
 }
 
-static int hyperv_handle_properties(CPUState *cs)
+/*
+ * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
+ * case of success, errno < 0 in case of failure and 0 when no Hyper-V
+ * extentions are enabled.
+ */
+static int hyperv_handle_properties(CPUState *cs,
+                                    struct kvm_cpuid_entry2 *cpuid_ent)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     struct kvm_cpuid2 *cpuid;
+    struct kvm_cpuid_entry2 *c;
+    uint32_t signature[3];
+    uint32_t cpuid_i = 0;
     int r = 0;
 
+    if (!hyperv_enabled(cpu))
+        return 0;
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
         uint16_t evmcs_version;
 
@@ -1068,9 +1080,80 @@ static int hyperv_handle_properties(CPUState *cs)
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
 
+    if (r) {
+        r = -ENOSYS;
+        goto free;
+    }
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
+    if (!cpu->hyperv_vendor_id) {
+        memcpy(signature, "Microsoft Hv", 12);
+    } else {
+        size_t len = strlen(cpu->hyperv_vendor_id);
+
+        if (len > 12) {
+            error_report("hv-vendor-id truncated to 12 characters");
+            len = 12;
+        }
+        memset(signature, 0, 12);
+        memcpy(signature, cpu->hyperv_vendor_id, len);
+    }
+    c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
+        HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
+    c->ebx = signature[0];
+    c->ecx = signature[1];
+    c->edx = signature[2];
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_INTERFACE;
+    memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
+    c->eax = signature[0];
+    c->ebx = 0;
+    c->ecx = 0;
+    c->edx = 0;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_VERSION;
+    c->eax = 0x00001bbc;
+    c->ebx = 0x00060001;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_FEATURES;
+    c->eax = env->features[FEAT_HYPERV_EAX];
+    c->ebx = env->features[FEAT_HYPERV_EBX];
+    c->edx = env->features[FEAT_HYPERV_EDX];
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_ENLIGHTMENT_INFO;
+    c->eax = env->features[FEAT_HV_RECOMM_EAX];
+    c->ebx = cpu->hyperv_spinlock_attempts;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_IMPLEMENT_LIMITS;
+    c->eax = cpu->hv_max_vps;
+    c->ebx = 0x40;
+
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
+        __u32 function;
+
+        /* Create zeroed 0x40000006..0x40000009 leaves */
+        for (function = HV_CPUID_IMPLEMENT_LIMITS + 1;
+             function < HV_CPUID_NESTED_FEATURES; function++) {
+            c = &cpuid_ent[cpuid_i++];
+            c->function = function;
+        }
+
+        c = &cpuid_ent[cpuid_i++];
+        c->function = HV_CPUID_NESTED_FEATURES;
+        c->eax = env->features[FEAT_HV_NESTED_EAX];
+    }
+    r = cpuid_i;
+
+free:
     g_free(cpuid);
 
-    return r ? -ENOSYS : 0;
+    return r;
 }
 
 static int hyperv_init_vcpu(X86CPU *cpu)
@@ -1179,79 +1262,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     /* Paravirtualization CPUIDs */
-    if (hyperv_enabled(cpu)) {
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
-        if (!cpu->hyperv_vendor_id) {
-            memcpy(signature, "Microsoft Hv", 12);
-        } else {
-            size_t len = strlen(cpu->hyperv_vendor_id);
-
-            if (len > 12) {
-                error_report("hv-vendor-id truncated to 12 characters");
-                len = 12;
-            }
-            memset(signature, 0, 12);
-            memcpy(signature, cpu->hyperv_vendor_id, len);
-        }
-        c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
-            HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
-        c->ebx = signature[0];
-        c->ecx = signature[1];
-        c->edx = signature[2];
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_INTERFACE;
-        memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
-        c->eax = signature[0];
-        c->ebx = 0;
-        c->ecx = 0;
-        c->edx = 0;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_VERSION;
-        c->eax = 0x00001bbc;
-        c->ebx = 0x00060001;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_FEATURES;
-        r = hyperv_handle_properties(cs);
-        if (r) {
-            return r;
-        }
-        c->eax = env->features[FEAT_HYPERV_EAX];
-        c->ebx = env->features[FEAT_HYPERV_EBX];
-        c->edx = env->features[FEAT_HYPERV_EDX];
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_ENLIGHTMENT_INFO;
-
-        c->eax = env->features[FEAT_HV_RECOMM_EAX];
-        c->ebx = cpu->hyperv_spinlock_attempts;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_IMPLEMENT_LIMITS;
-
-        c->eax = cpu->hv_max_vps;
-        c->ebx = 0x40;
-
+    r = hyperv_handle_properties(cs, cpuid_data.entries);
+    if (r < 0) {
+        return r;
+    } else if (r > 0) {
+        cpuid_i = r;
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
-
-        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
-            __u32 function;
-
-            /* Create zeroed 0x40000006..0x40000009 leaves */
-            for (function = HV_CPUID_IMPLEMENT_LIMITS + 1;
-                 function < HV_CPUID_NESTED_FEATURES; function++) {
-                c = &cpuid_data.entries[cpuid_i++];
-                c->function = function;
-            }
-
-            c = &cpuid_data.entries[cpuid_i++];
-            c->function = HV_CPUID_NESTED_FEATURES;
-            c->eax = env->features[FEAT_HV_NESTED_EAX];
-        }
     }
 
     if (cpu->expose_kvm) {
-- 
1.8.3.1



