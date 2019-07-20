Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DEFC76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F22E2084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAH9R5N2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F22E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hor8v-0007NB-1Z
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8P-0005n1-RE
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8O-00084S-8y
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8O-000841-13
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id a15so31256010wmj.5
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yiDc/TEXPQasznA1y4wzCBkJJW+skyq8/HgGa6nZqFY=;
 b=QAH9R5N2b0+/dYNyJgfXQW+rZ1D/yXMamb6cgawPaFOLgX2GY7XujvSzwYLyRHYKwj
 H6lSqNSeh9YV2DZ4xWyPSS4Dqvk7WlrFuf/kBg66xgXM2JaORwnxXoLscRGUPZXTzgR6
 7aOGjDonvzOvbyiJMBDoIWdqtoalWce5eTQYgubS4vT7LMHbg6Pfrd1ILzD9+HInmpKb
 fSwv/nXPxz7b15yr9v/lJjcx55cbPXUl7vUI91l4eRF6T5x6r2SMue1N8Vk8xtxdQoh8
 xzr1fnGkGl6cjrg/6mjYQ1LfLzBzC1tSZS/8DOV7JJM4B8VzXMGc9rJjSK6AcbYRyDmU
 VoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yiDc/TEXPQasznA1y4wzCBkJJW+skyq8/HgGa6nZqFY=;
 b=FvYzFz1uwqzhDJTQrGJXKnu9zFi8i83CJ7HOepvs2CwjNcjXpiTIAjV0GMXa+sBZTP
 ormzz/bRPyKXVm7/M+pOOBLjJ+7Ao2FdpQY68PLFax/UlGQZe9XUI3t1Qs51XDW1athp
 qEJ0FC/pzqyOyvmPfHlRn9Z2uILaRB02DSNJdaDMF9h0z3m2h4dn+r9ArhL00F89JPba
 JxxJCLVx9BlRYGpb8JT4eSPaQl9/4fizJE6C6D5dBHRTO0hYGcxSfwRQWgXGMXu5shyB
 5YDwZmBLXu5sbsfx8bEIz/J3C5mQkeIpAXsibhpg4F6hPH+VBWUcLZvtX5KRm8MtptPW
 jG7A==
X-Gm-Message-State: APjAAAWRVkXiSvgCR2B32MtWuit44nEQHbrHG3fqWjiXF3IWmERl6tvm
 OdESopsANURM0JoacI2QzxN+HzqdDvs=
X-Google-Smtp-Source: APXvYqypOoEvUqv1Jr8zQN4SuewT+AB1Mz7v7OrJLM2PpkxLZMoEJ3mCxTvNqtDhqb7u8iDZndfbWQ==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr56398553wml.124.1563635930626; 
 Sat, 20 Jul 2019 08:18:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:35 +0200
Message-Id: <20190720151846.7450-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 01/12] target/i386: kvm: Demand nested migration
 kernel capabilities only when vCPU may have enabled VMX
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
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Liran Alon <liran.alon@oracle.com>, Maran Wilson <maran.wilson@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Previous to this change, a vCPU exposed with VMX running on a kernel
without KVM_CAP_NESTED_STATE or KVM_CAP_EXCEPTION_PAYLOAD resulted in
adding a migration blocker. This was because when the code was written
it was thought there is no way to reliably know if a vCPU is utilising
VMX or not at runtime. However, it turns out that this can be known to
some extent:

In order for a vCPU to enter VMX operation it must have CR4.VMXE set.
Since it was set, CR4.VMXE must remain set as long as the vCPU is in
VMX operation. This is because CR4.VMXE is one of the bits set
in MSR_IA32_VMX_CR4_FIXED1.
There is one exception to the above statement when vCPU enters SMM mode.
When a vCPU enters SMM mode, it temporarily exits VMX operation and
may also reset CR4.VMXE during execution in SMM mode.
When the vCPU exits SMM mode, vCPU state is restored to be in VMX operation
and CR4.VMXE is restored to its original state of being set.
Therefore, when the vCPU is not in SMM mode, we can infer whether
VMX is being used by examining CR4.VMXE. Otherwise, we cannot
know for certain but assume the worse that vCPU may utilise VMX.

Summaring all the above, a vCPU may have enabled VMX in case
CR4.VMXE is set or vCPU is in SMM mode.

Therefore, remove migration blocker and check before migration
(cpu_pre_save()) if the vCPU may have enabled VMX. If true, only then
require relevant kernel capabilities.

While at it, demand KVM_CAP_EXCEPTION_PAYLOAD only when the vCPU is in
guest-mode and there is a pending/injected exception. Otherwise, this
kernel capability is not required for proper migration.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Tested-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h      | 22 ++++++++++++++++++++++
 target/i386/kvm.c      | 26 ++++++--------------------
 target/i386/kvm_i386.h |  1 +
 target/i386/machine.c  | 24 ++++++++++++++++++++----
 4 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 05393cf..8b3dc55 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1877,6 +1877,28 @@ static inline bool cpu_has_vmx(CPUX86State *env)
     return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
 }
 
+/*
+ * In order for a vCPU to enter VMX operation it must have CR4.VMXE set.
+ * Since it was set, CR4.VMXE must remain set as long as vCPU is in
+ * VMX operation. This is because CR4.VMXE is one of the bits set
+ * in MSR_IA32_VMX_CR4_FIXED1.
+ *
+ * There is one exception to above statement when vCPU enters SMM mode.
+ * When a vCPU enters SMM mode, it temporarily exit VMX operation and
+ * may also reset CR4.VMXE during execution in SMM mode.
+ * When vCPU exits SMM mode, vCPU state is restored to be in VMX operation
+ * and CR4.VMXE is restored to it's original value of being set.
+ *
+ * Therefore, when vCPU is not in SMM mode, we can infer whether
+ * VMX is being used by examining CR4.VMXE. Otherwise, we cannot
+ * know for certain.
+ */
+static inline bool cpu_vmx_maybe_enabled(CPUX86State *env)
+{
+    return cpu_has_vmx(env) &&
+           ((env->cr[4] & CR4_VMXE_MASK) || (env->hflags & HF_SMM_MASK));
+}
+
 /* fpu_helper.c */
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ec7870c..4542f0f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -128,6 +128,11 @@ bool kvm_has_adjust_clock_stable(void)
     return (ret == KVM_CLOCK_TSC_STABLE);
 }
 
+bool kvm_has_exception_payload(void)
+{
+    return has_exception_payload;
+}
+
 bool kvm_allows_irq0_override(void)
 {
     return !kvm_irqchip_in_kernel() || kvm_has_gsi_routing();
@@ -1342,7 +1347,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
 
 static Error *invtsc_mig_blocker;
-static Error *nested_virt_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -1653,22 +1657,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
-    if (cpu_has_vmx(env) && !nested_virt_mig_blocker &&
-        ((kvm_max_nested_state_length() <= 0) || !has_exception_payload)) {
-        error_setg(&nested_virt_mig_blocker,
-                   "Kernel do not provide required capabilities for "
-                   "nested virtualization migration. "
-                   "(CAP_NESTED_STATE=%d, CAP_EXCEPTION_PAYLOAD=%d)",
-                   kvm_max_nested_state_length() > 0,
-                   has_exception_payload);
-        r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            error_free(nested_virt_mig_blocker);
-            return r;
-        }
-    }
-
     if (env->mcg_cap & MCG_LMCE_P) {
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
@@ -1683,7 +1671,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             if (local_err) {
                 error_report_err(local_err);
                 error_free(invtsc_mig_blocker);
-                goto fail2;
+                return r;
             }
         }
     }
@@ -1752,8 +1740,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
  fail:
     migrate_del_blocker(invtsc_mig_blocker);
- fail2:
-    migrate_del_blocker(nested_virt_mig_blocker);
 
     return r;
 }
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 3057ba4..06fe06b 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -35,6 +35,7 @@
 bool kvm_allows_irq0_override(void);
 bool kvm_has_smm(void);
 bool kvm_has_adjust_clock_stable(void);
+bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 704ba6d..ac2d1d1 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -7,6 +7,7 @@
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
 #include "hyperv.h"
+#include "kvm_i386.h"
 
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
@@ -232,10 +233,25 @@ static int cpu_pre_save(void *opaque)
     }
 
 #ifdef CONFIG_KVM
-    /* Verify we have nested virtualization state from kernel if required */
-    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
-        error_report("Guest enabled nested virtualization but kernel "
-                "does not support saving of nested state");
+    /*
+     * In case vCPU may have enabled VMX, we need to make sure kernel have
+     * required capabilities in order to perform migration correctly:
+     *
+     * 1) We must be able to extract vCPU nested-state from KVM.
+     *
+     * 2) In case vCPU is running in guest-mode and it has a pending exception,
+     * we must be able to determine if it's in a pending or injected state.
+     * Note that in case KVM don't have required capability to do so,
+     * a pending/injected exception will always appear as an
+     * injected exception.
+     */
+    if (kvm_enabled() && cpu_vmx_maybe_enabled(env) &&
+        (!env->nested_state ||
+         (!kvm_has_exception_payload() && (env->hflags & HF_GUEST_MASK) &&
+          env->exception_injected))) {
+        error_report("Guest maybe enabled nested virtualization but kernel "
+                "does not support required capabilities to save vCPU "
+                "nested state");
         return -EINVAL;
     }
 #endif
-- 
1.8.3.1



