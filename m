Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF35C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0982070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcoY2zFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0982070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he99j-0007Jp-QD
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a7-0006gO-4o
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a3-0006fN-JL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8a2-0006Ly-RI
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id a15so4783763wmj.5
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jcz8Kl2eMkWbOjfqltPmtGPE3+YHm3y2OunQ4bM4BqY=;
 b=JcoY2zFT9zydt62h0pV6ZNhwCgiwOMQfXkaF5d8wPtDr5uyu0rtwSHSBOx0tkQNTzx
 CrrZbD7kjwmDmYXuPf1UU4tXcpawUpsfcl1PAaSEVudYMSrvDnbPUQMx364iJWvqLGL4
 TXRgWGv3ns/m1c1wMkXcPqfIpDXBNvlSZexaLEC8yjid3YqBptM3MYQmxa+GDMAUH+28
 9+O5SgIhY+ZdWOZqasW/7OkI5eiafJLR7s10C4fZL8BiMeEOwfuZS3scmtA7Vh0rc1wS
 UEJDNcq0Od0td9r/KHOUJO6bV7PR0v8+TmcwA2ZTKxztO67tXSFGS/2dRqN2/Vl7lMsx
 7yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=jcz8Kl2eMkWbOjfqltPmtGPE3+YHm3y2OunQ4bM4BqY=;
 b=j3Hl0itYZR8WemZ1VnCFCpwY4swVbXEwYl2Ad6oFYYyJIJMm5+9ZoXBE+xS58f1ci5
 Nf6qiAyNiMpqmp16q1QjrCFuA1XfQV7Aj/jS1qvAKkxpzwp25QBGc4DTBeAilIJQC33I
 aRGDXDopw2kteAvCzSDu9rzmXLriGLVhNbIEN42X9BONZ7CLeoZmHfhhwp2fdqxSqAoX
 JxMppdEAOEBlxanXigNGcq4SLiOS0awZvHVDfF0jQ0/bz6HrhF0HWgLFUTUtHKtaB7Oi
 IzSmqYSu5Hbr9cMeFvYsvi5+1lnBI1Wf84pyosK3r9DMUn5M5F0msgGEUcFnRf7+6lq8
 TqLA==
X-Gm-Message-State: APjAAAXBMi/xpCzqUUqOr854IAV9NTuBG2Fyq1sz2wQlOFg8bmxw3Peo
 MNbwfULBB+1rKMYytbF5pfWDeszp
X-Google-Smtp-Source: APXvYqyuElKYczP/eQLYpwxJkA/qA2rQEIk+rDkWTE8/F1qrRRW3kN7Jpj5QAZ237S5bzOQg44Fwhw==
X-Received: by 2002:a05:600c:291:: with SMTP id
 17mr1494901wmk.32.1561081369968; 
 Thu, 20 Jun 2019 18:42:49 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:22 +0200
Message-Id: <1561081350-3723-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 17/25] target/i386: kvm: Block migration for
 vCPUs exposed with nested virtualization
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Commit d98f26073beb ("target/i386: kvm: add VMX migration blocker")
added a migration blocker for vCPU exposed with Intel VMX.
However, migration should also be blocked for vCPU exposed with
AMD SVM.

Both cases should be blocked because QEMU should extract additional
vCPU state from KVM that should be migrated as part of vCPU VMState.
E.g. Whether vCPU is running in guest-mode or host-mode.

Fixes: d98f26073beb ("target/i386: kvm: add VMX migration blocker")
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190619162140.133674-6-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c |  6 ------
 target/i386/cpu.h | 22 ++++++++++++++++++++++
 target/i386/kvm.c | 14 +++++++-------
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c330fd9..61e44cb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5215,12 +5215,6 @@ static int x86_cpu_filter_features(X86CPU *cpu)
     return rv;
 }
 
-#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
-                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
-                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
-#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
-                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
-                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f48136..4ae4145 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -722,6 +722,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
 
+#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
+                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
+                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
+#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
+                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
+                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
 
@@ -1848,6 +1855,21 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
     }
 }
 
+static inline bool cpu_has_vmx(CPUX86State *env)
+{
+    return (env->features[FEAT_1_ECX] & CPUID_EXT_VMX);
+}
+
+static inline bool cpu_has_svm(CPUX86State *env)
+{
+    return (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM);
+}
+
+static inline bool cpu_has_nested_virt(CPUX86State *env)
+{
+    return (cpu_has_vmx(env) || cpu_has_svm(env));
+}
+
 /* fpu_helper.c */
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9864aa0..f9872f1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1299,7 +1299,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
 
 static Error *invtsc_mig_blocker;
-static Error *vmx_mig_blocker;
+static Error *nested_virt_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -1597,13 +1597,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
-    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
-        error_setg(&vmx_mig_blocker,
-                   "Nested VMX virtualization does not support live migration yet");
-        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
+    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
+        error_setg(&nested_virt_mig_blocker,
+                   "Nested virtualization does not support live migration yet");
+        r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
         if (local_err) {
             error_report_err(local_err);
-            error_free(vmx_mig_blocker);
+            error_free(nested_virt_mig_blocker);
             return r;
         }
     }
@@ -1674,7 +1674,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
  fail:
     migrate_del_blocker(invtsc_mig_blocker);
  fail2:
-    migrate_del_blocker(vmx_mig_blocker);
+    migrate_del_blocker(nested_virt_mig_blocker);
 
     return r;
 }
-- 
1.8.3.1



