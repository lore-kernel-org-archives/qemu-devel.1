Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261E0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA499214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwufXO6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA499214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueKT-0005Tb-PK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrN-0004yd-IY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrM-0003KF-7I
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrM-0003JC-0e; Thu, 23 Jan 2020 08:49:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id q6so3119522wro.9;
 Thu, 23 Jan 2020 05:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jY1ubrmRPI/N9e83it0SvGrTTTMW6ORYETMpVxkJm8s=;
 b=bwufXO6MzdcXkQkZ56t1PkveXG+D9Lqe9/6N6eQbIctpTi1JqTcgt2HqOgoHxIgaPC
 02hQAtW+qjx1ZuEkpDkIrJbgLb9PWHfNI+2nCHXGR7aSCrc+/+gNdzSs5+lR44ag7Msd
 AYknKJzVn8DGZn/JIZreokSTXVjoOa5KdpX7MXMz+IWwOMkGEIUDUIFD4admzu1KlrYQ
 dORHrkj2ups/dxcPCIZr03kRJP0LvSabVVPVMVYPDhsZ9/QxNUoS7/l0Oiam2NHRu96x
 0hW5TuxIX91V0KFSPOu9hffQiaPUXvN5VgzsSaG1xKGD444HyDnduJyBe5vjyXIfLkSA
 lWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=jY1ubrmRPI/N9e83it0SvGrTTTMW6ORYETMpVxkJm8s=;
 b=Jzxxq4LjMPa1msY3c/Ps9zPyCcsfLtV16mPOykieZcoPApmw9P6ePS+r5Af/jV7uEI
 DLwl4lj30LU8EsmnicByLEfWc9/GBpU2fHQSeEFq76I509OdjAE6hDrZFMtniHpx9hJJ
 jGoxcuSZjWws8mkNVbtwK/mj+CCDNroyqsKba25XlrVh4CRytT1Flk5fqbByfvUnml/C
 8bz57A8hxRLgXLuKP1h+DJHqG5JVhJA1fxAjPcTbWSE9lMPrPyIUM4wArJfNo4v0gGIh
 H/xT3DBVtDDPvDvvTEKwJXo/lFy9n3Vk22+9HA/wPsnJ6WoWG9/38cAAdFYo5/xMF6jG
 UUeg==
X-Gm-Message-State: APjAAAUpHaNWOzM8jt0RKn3mMnlwo/Wjo2+Fh2T7poFrHVLsWuf4j2L3
 +OsKBf0DPaaaeAFl3iacJSZ6U6Ob
X-Google-Smtp-Source: APXvYqxasHh3K0y8gIm5bu4HQN4KwTRjyocD4qsJ+vhwZKFBeAM4e1n45Q6dUWaTrGnQZW9LXBm6Kg==
X-Received: by 2002:adf:edc4:: with SMTP id v4mr17460405wro.336.1579787362779; 
 Thu, 23 Jan 2020 05:49:22 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/59] target/i386: kvm: initialize feature MSRs very early
Date: Thu, 23 Jan 2020 14:48:21 +0100
Message-Id: <1579787342-27146-19-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some read-only MSRs affect the behavior of ioctls such as
KVM_SET_NESTED_STATE.  We can initialize them once and for all
right after the CPU is realized, since they will never be modified
by the guest.

Reported-by: Qingua Cheng <qcheng@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1579544504-3616-2-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c      | 81 ++++++++++++++++++++++++++++++--------------------
 target/i386/kvm_i386.h |  1 +
 2 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7ee3202..f6dd6b7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -67,6 +67,8 @@
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
 
+static void kvm_init_msrs(X86CPU *cpu);
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
     KVM_CAP_INFO(EXT_CPUID),
@@ -1842,6 +1844,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_tsc_aux = false;
     }
 
+    kvm_init_msrs(cpu);
+
     r = hyperv_init_vcpu(cpu);
     if (r) {
         goto fail;
@@ -2660,11 +2664,53 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
                       VMCS12_MAX_FIELD_INDEX << 1);
 }
 
+static int kvm_buf_set_msrs(X86CPU *cpu)
+{
+    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (ret < cpu->kvm_msr_buf->nmsrs) {
+        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
+        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
+                     (uint32_t)e->index, (uint64_t)e->data);
+    }
+
+    assert(ret == cpu->kvm_msr_buf->nmsrs);
+    return 0;
+}
+
+static void kvm_init_msrs(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    kvm_msr_buf_reset(cpu);
+    if (has_msr_arch_capabs) {
+        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
+                          env->features[FEAT_ARCH_CAPABILITIES]);
+    }
+
+    if (has_msr_core_capabs) {
+        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
+                          env->features[FEAT_CORE_CAPABILITY]);
+    }
+
+    /*
+     * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
+     * all kernels with MSR features should have them.
+     */
+    if (kvm_feature_msrs && cpu_has_vmx(env)) {
+        kvm_msr_entry_add_vmx(cpu, env->features);
+    }
+
+    assert(kvm_buf_set_msrs(cpu) == 0);
+}
+
 static int kvm_put_msrs(X86CPU *cpu, int level)
 {
     CPUX86State *env = &cpu->env;
     int i;
-    int ret;
 
     kvm_msr_buf_reset(cpu);
 
@@ -2722,17 +2768,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     }
 #endif
 
-    /* If host supports feature MSR, write down. */
-    if (has_msr_arch_capabs) {
-        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
-                          env->features[FEAT_ARCH_CAPABILITIES]);
-    }
-
-    if (has_msr_core_capabs) {
-        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
-                          env->features[FEAT_CORE_CAPABILITY]);
-    }
-
     /*
      * The following MSRs have side effects on the guest or are too heavy
      * for normal writeback. Limit them to reset or full state updates.
@@ -2910,14 +2945,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
 
         /* Note: MSR_IA32_FEATURE_CONTROL is written separately, see
          *       kvm_put_msr_feature_control. */
-
-        /*
-         * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
-         * all kernels with MSR features should have them.
-         */
-        if (kvm_feature_msrs && cpu_has_vmx(env)) {
-            kvm_msr_entry_add_vmx(cpu, env->features);
-        }
     }
 
     if (env->mcg_cap) {
@@ -2933,19 +2960,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         }
     }
 
-    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (ret < cpu->kvm_msr_buf->nmsrs) {
-        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
-        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
-                     (uint32_t)e->index, (uint64_t)e->data);
-    }
-
-    assert(ret == cpu->kvm_msr_buf->nmsrs);
-    return 0;
+    return kvm_buf_set_msrs(cpu);
 }
 
 
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 7d0242f..00bde7a 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -46,4 +46,5 @@ bool kvm_enable_x2apic(void);
 bool kvm_has_x2apic_api(void);
 
 bool kvm_hv_vpindex_settable(void);
+
 #endif
-- 
1.8.3.1



