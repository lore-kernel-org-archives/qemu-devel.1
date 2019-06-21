Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD00C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD4E2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3rsz9fU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD4E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heI4M-0000kJ-Ct
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49197)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkl-0000t0-Rh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHki-00063m-KJ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHki-00061o-6c
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id c66so6035703wmf.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Qg8kQpqZzF9XETIfQB6QGbrUFX5sJufHSNIhV3GqhK0=;
 b=c3rsz9fUtBY9GlsdgFSgNr4/pw7g/1mOLrFxpa+pCwieqaIE9uBX8YXDFeTuDG8R80
 n6nte7a0EI0UoXH/oWT62pmk+d43bdkFOb3Z/aU4ytcO7W4HlejpC+vNr61J8aef8g6I
 jAZIZVCEM0slUbP2eb2jJmsn7Fpkyv3oqmEtiSo/rY35pikwl1Iykq8I3gLX6gw3zrbC
 XKEXcR0B9RBnVVwO2DXhTwDbhRGu2tDqDWD/84vtx8kDvJPR9dma0bHrAGT7dKHcLBMQ
 NVJuCor4333CucnSj2nIBV9TFeBEuZVDPS8uUsXb251m+pWAA2LY+yOur2GnrhbCl+9n
 zYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Qg8kQpqZzF9XETIfQB6QGbrUFX5sJufHSNIhV3GqhK0=;
 b=kALiz9lub3NuFCoGXekckLKVnhGnNQ1QYiNEeVm/HMr2h6zpIGkWpsgD8dPja2ZAtH
 FjUoaKK0Lo+bD7GYR1q3SJSy3WPd6z3ovytAyvNRJ6n+/sz5kLIjYxl688e8chv2HfyD
 zQEz9c5ihTH/rOrjmo3LN+thuY93O0tckeb6DH5Mw4IEv2oge9Faem1oPT/6hpbvn+GU
 CDFJCMoO/jw6EpMf8ulft3KAuBnWOZo2YobtZvCbDOzJRCIVKIgdhjPWwEy8v5JQ30JH
 d8bAFFPL/trnkPfg+5WwB258nFbGrOuWMbxjFIbECsV2d/bGx+ZUdJK/7iT9L8FpQVV4
 q/cA==
X-Gm-Message-State: APjAAAWKBnfm9sQWdhcOPp0gZeylVyo/Zw4ggqKTixojr+9GBrhPrTcm
 qDRPFa11d+wjcWxYUl7gvYLQ46qU
X-Google-Smtp-Source: APXvYqz1q2mHtUKho6Sc8TbQxSJoWtyREqoko3UeQ76I0WSlLVXAdlE9ps7yqmzcuB6LG0sq3MGByQ==
X-Received: by 2002:a1c:a483:: with SMTP id n125mr3751959wme.3.1561116642681; 
 Fri, 21 Jun 2019 04:30:42 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:15 +0200
Message-Id: <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 20/25] target/i386: kvm: Add support for save
 and restore nested state
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

Kernel commit 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
introduced new IOCTLs to extract and restore vCPU state related to
Intel VMX & AMD SVM.

Utilize these IOCTLs to add support for migration of VMs which are
running nested hypervisors.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Tested-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190619162140.133674-9-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c   |   8 ++
 include/sysemu/kvm.h  |   1 +
 target/i386/cpu.h     |   3 +
 target/i386/kvm.c     |  80 ++++++++++++++++++++
 target/i386/machine.c | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 290 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f0f5ab8..e3cf728 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -87,6 +87,7 @@ struct KVMState
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
+    int max_nested_state_len;
     int many_ioeventfds;
     int intx_set_mask;
     bool sync_mmu;
@@ -1681,6 +1682,8 @@ static int kvm_init(MachineState *ms)
     s->debugregs = kvm_check_extension(s, KVM_CAP_DEBUGREGS);
 #endif
 
+    s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
+
 #ifdef KVM_CAP_IRQ_ROUTING
     kvm_direct_msi_allowed = (kvm_check_extension(s, KVM_CAP_SIGNAL_MSI) > 0);
 #endif
@@ -2248,6 +2251,11 @@ int kvm_has_debugregs(void)
     return kvm_state->debugregs;
 }
 
+int kvm_max_nested_state_length(void)
+{
+    return kvm_state->max_nested_state_len;
+}
+
 int kvm_has_many_ioeventfds(void)
 {
     if (!kvm_enabled()) {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 64f55e5..acd90ae 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -210,6 +210,7 @@ bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
+int kvm_max_nested_state_length(void);
 int kvm_has_pit_state2(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bf0c9c2..17116ef 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1360,6 +1360,9 @@ typedef struct CPUX86State {
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
     void *xsave_buf;
 #endif
+#if defined(CONFIG_KVM)
+    struct kvm_nested_state *nested_state;
+#endif
 #if defined(CONFIG_HVF)
     HVFX86EmulatorState *hvf_emul;
 #endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f9872f1..e924663 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1324,6 +1324,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     int kvm_base = KVM_CPUID_SIGNATURE;
+    int max_nested_state_len;
     int r;
     Error *local_err = NULL;
 
@@ -1658,6 +1659,24 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (has_xsave) {
         env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
     }
+
+    max_nested_state_len = kvm_max_nested_state_length();
+    if (max_nested_state_len > 0) {
+        assert(max_nested_state_len >= offsetof(struct kvm_nested_state, data));
+        env->nested_state = g_malloc0(max_nested_state_len);
+
+        env->nested_state->size = max_nested_state_len;
+
+        if (IS_INTEL_CPU(env)) {
+            struct kvm_vmx_nested_state_hdr *vmx_hdr =
+                &env->nested_state->hdr.vmx;
+
+            env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
+            vmx_hdr->vmxon_pa = -1ull;
+            vmx_hdr->vmcs12_pa = -1ull;
+        }
+    }
+
     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);
 
     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
@@ -1682,12 +1701,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
 int kvm_arch_destroy_vcpu(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
 
     if (cpu->kvm_msr_buf) {
         g_free(cpu->kvm_msr_buf);
         cpu->kvm_msr_buf = NULL;
     }
 
+    if (env->nested_state) {
+        g_free(env->nested_state);
+        env->nested_state = NULL;
+    }
+
     return 0;
 }
 
@@ -3411,6 +3436,52 @@ static int kvm_get_debugregs(X86CPU *cpu)
     return 0;
 }
 
+static int kvm_put_nested_state(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    int max_nested_state_len = kvm_max_nested_state_length();
+
+    if (max_nested_state_len <= 0) {
+        return 0;
+    }
+
+    assert(env->nested_state->size <= max_nested_state_len);
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_NESTED_STATE, env->nested_state);
+}
+
+static int kvm_get_nested_state(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    int max_nested_state_len = kvm_max_nested_state_length();
+    int ret;
+
+    if (max_nested_state_len <= 0) {
+        return 0;
+    }
+
+    /*
+     * It is possible that migration restored a smaller size into
+     * nested_state->hdr.size than what our kernel support.
+     * We preserve migration origin nested_state->hdr.size for
+     * call to KVM_SET_NESTED_STATE but wish that our next call
+     * to KVM_GET_NESTED_STATE will use max size our kernel support.
+     */
+    env->nested_state->size = max_nested_state_len;
+
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_NESTED_STATE, env->nested_state);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (env->nested_state->flags & KVM_STATE_NESTED_GUEST_MODE) {
+        env->hflags |= HF_GUEST_MASK;
+    } else {
+        env->hflags &= ~HF_GUEST_MASK;
+    }
+
+    return ret;
+}
+
 int kvm_arch_put_registers(CPUState *cpu, int level)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -3418,6 +3489,11 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    ret = kvm_put_nested_state(x86_cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_msr_feature_control(x86_cpu);
         if (ret < 0) {
@@ -3533,6 +3609,10 @@ int kvm_arch_get_registers(CPUState *cs)
     if (ret < 0) {
         goto out;
     }
+    ret = kvm_get_nested_state(cpu);
+    if (ret < 0) {
+        goto out;
+    }
     ret = 0;
  out:
     cpu_sync_bndcs_hflags(&cpu->env);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index a39ce7f..a6afdf8 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -231,6 +231,15 @@ static int cpu_pre_save(void *opaque)
         env->segs[R_SS].flags &= ~(env->segs[R_SS].flags & DESC_DPL_MASK);
     }
 
+#ifdef CONFIG_KVM
+    /* Verify we have nested virtualization state from kernel if required */
+    if (cpu_has_nested_virt(env) && !env->nested_state) {
+        error_report("Guest enabled nested virtualization but kernel "
+                "does not support saving of nested state");
+        return -EINVAL;
+    }
+#endif
+
     return 0;
 }
 
@@ -278,6 +287,16 @@ static int cpu_post_load(void *opaque, int version_id)
     env->hflags &= ~HF_CPL_MASK;
     env->hflags |= (env->segs[R_SS].flags >> DESC_DPL_SHIFT) & HF_CPL_MASK;
 
+#ifdef CONFIG_KVM
+    if ((env->hflags & HF_GUEST_MASK) &&
+        (!env->nested_state ||
+        !(env->nested_state->flags & KVM_STATE_NESTED_GUEST_MODE))) {
+        error_report("vCPU set in guest-mode inconsistent with "
+                     "migrated kernel nested state");
+        return -EINVAL;
+    }
+#endif
+
     env->fpstt = (env->fpus_vmstate >> 11) & 7;
     env->fpus = env->fpus_vmstate & ~0x3800;
     env->fptag_vmstate ^= 0xff;
@@ -851,6 +870,182 @@ static const VMStateDescription vmstate_tsc_khz = {
     }
 };
 
+#ifdef CONFIG_KVM
+
+static bool vmx_vmcs12_needed(void *opaque)
+{
+    struct kvm_nested_state *nested_state = opaque;
+    return (nested_state->size >
+            offsetof(struct kvm_nested_state, data.vmx[0].vmcs12));
+}
+
+static const VMStateDescription vmstate_vmx_vmcs12 = {
+    .name = "cpu/kvm_nested_state/vmx/vmcs12",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmx_vmcs12_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(data.vmx[0].vmcs12,
+                            struct kvm_nested_state,
+                            KVM_STATE_NESTED_VMX_VMCS_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vmx_shadow_vmcs12_needed(void *opaque)
+{
+    struct kvm_nested_state *nested_state = opaque;
+    return (nested_state->size >
+            offsetof(struct kvm_nested_state, data.vmx[0].shadow_vmcs12));
+}
+
+static const VMStateDescription vmstate_vmx_shadow_vmcs12 = {
+    .name = "cpu/kvm_nested_state/vmx/shadow_vmcs12",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmx_shadow_vmcs12_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(data.vmx[0].shadow_vmcs12,
+                            struct kvm_nested_state,
+                            KVM_STATE_NESTED_VMX_VMCS_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vmx_nested_state_needed(void *opaque)
+{
+    struct kvm_nested_state *nested_state = opaque;
+
+    return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
+            ((nested_state->hdr.vmx.vmxon_pa != -1ull) ||
+             (nested_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON)));
+}
+
+static const VMStateDescription vmstate_vmx_nested_state = {
+    .name = "cpu/kvm_nested_state/vmx",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmx_nested_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_U64(hdr.vmx.vmxon_pa, struct kvm_nested_state),
+        VMSTATE_U64(hdr.vmx.vmcs12_pa, struct kvm_nested_state),
+        VMSTATE_U16(hdr.vmx.smm.flags, struct kvm_nested_state),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_vmx_vmcs12,
+        &vmstate_vmx_shadow_vmcs12,
+        NULL,
+    }
+};
+
+static bool svm_nested_state_needed(void *opaque)
+{
+    struct kvm_nested_state *nested_state = opaque;
+
+    return (nested_state->format == KVM_STATE_NESTED_FORMAT_SVM);
+}
+
+static const VMStateDescription vmstate_svm_nested_state = {
+    .name = "cpu/kvm_nested_state/svm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = svm_nested_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool nested_state_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return (env->nested_state &&
+            (vmx_nested_state_needed(env->nested_state) ||
+             svm_nested_state_needed(env->nested_state)));
+}
+
+static int nested_state_post_load(void *opaque, int version_id)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+    struct kvm_nested_state *nested_state = env->nested_state;
+    int min_nested_state_len = offsetof(struct kvm_nested_state, data);
+    int max_nested_state_len = kvm_max_nested_state_length();
+
+    /*
+     * If our kernel don't support setting nested state
+     * and we have received nested state from migration stream,
+     * we need to fail migration
+     */
+    if (max_nested_state_len <= 0) {
+        error_report("Received nested state when kernel cannot restore it");
+        return -EINVAL;
+    }
+
+    /*
+     * Verify that the size of received nested_state struct
+     * at least cover required header and is not larger
+     * than the max size that our kernel support
+     */
+    if (nested_state->size < min_nested_state_len) {
+        error_report("Received nested state size less than min: "
+                     "len=%d, min=%d",
+                     nested_state->size, min_nested_state_len);
+        return -EINVAL;
+    }
+    if (nested_state->size > max_nested_state_len) {
+        error_report("Recieved unsupported nested state size: "
+                     "nested_state->size=%d, max=%d",
+                     nested_state->size, max_nested_state_len);
+        return -EINVAL;
+    }
+
+    /* Verify format is valid */
+    if ((nested_state->format != KVM_STATE_NESTED_FORMAT_VMX) &&
+        (nested_state->format != KVM_STATE_NESTED_FORMAT_SVM)) {
+        error_report("Received invalid nested state format: %d",
+                     nested_state->format);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_kvm_nested_state = {
+    .name = "cpu/kvm_nested_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_U16(flags, struct kvm_nested_state),
+        VMSTATE_U16(format, struct kvm_nested_state),
+        VMSTATE_U32(size, struct kvm_nested_state),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_vmx_nested_state,
+        &vmstate_svm_nested_state,
+        NULL
+    }
+};
+
+static const VMStateDescription vmstate_nested_state = {
+    .name = "cpu/nested_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = nested_state_needed,
+    .post_load = nested_state_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_POINTER(env.nested_state, X86CPU,
+                vmstate_kvm_nested_state,
+                struct kvm_nested_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#endif
+
 static bool mcg_ext_ctl_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1113,6 +1308,9 @@ VMStateDescription vmstate_x86_cpu = {
 #ifndef TARGET_X86_64
         &vmstate_efer32,
 #endif
+#ifdef CONFIG_KVM
+        &vmstate_nested_state,
+#endif
         NULL
     }
 };
-- 
1.8.3.1



