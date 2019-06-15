Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DDCC46477
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C4A2183F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGtQ0JX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C4A2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbwql-0002Vq-1J
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60497)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmh-0000Wl-LD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmf-0004Hq-LK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hbwmd-0004CD-ME
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id g135so3953230wme.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VNC9SQjCObEeskesampTTSXTeg4IPSZcyOaU7eslfdw=;
 b=WGtQ0JX+Pi7tFUdPpGx+Tv8uoFYnuQAnMclcZ2UT5gFcgbeqnNvd4mkoN2R58v4/2x
 8UGNQjo1RAyP6OcT/C1PJEoqbmqKMdiL2mBDthngRPTO8VDUOXuufcNEF4Zk2CUIzsxq
 /Z1eFCjXXgSHHizfxxaV9Q8xadAqmtMpaGdwjibs/BWDGCZ6XSM/tLQnuU7N8i+ZO9p3
 HGIWJG83nVPipdLbu1+v3hy1OjgOGizfsZBhs0DioVxjk2+Zg0qncDgMef8afg9uMZsw
 AQXEn13MmFw41ssjkaEA8DK2Ryeaz6pHkYBDiYsyym0Y4MMEJakGeoL9i9tBXghFb+jP
 RA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VNC9SQjCObEeskesampTTSXTeg4IPSZcyOaU7eslfdw=;
 b=Hq6JO1IZ7XWSkO00jnIpkx5IOejuo21Rnyxn0O7VU6Lt/dSzUnm2j+lOHY8jDsHTAi
 k5DdPBtYBmT7CCT+c0RETXAet/vduREVam7pG1ZnygkllBb9W+EIhTtmY4xPfHExgyvO
 C70E4jeaz1DQvuAq6gAIsR4HTQm4mxXAunFLZHaH5hDmSnGfVNhGqBG4qui8HL2oDoA8
 Mk2a9Y7K4zsN3QP9MLL3oxnal6+vn4cYRdgJwccCCOJW+Rj7P2Ed/n1/e6FrUgb1U4S6
 15j2OezExByn+ffiLsDwCHljze80l5ZARqwI32P/DqKxJrmMcHAWC3eUpkcoWe5nmc6Y
 cHDw==
X-Gm-Message-State: APjAAAVuQhoU+ecYibLN7miTaCmftwOY2vew67YRJj6VY++w7I5jQS4B
 iIOUUgQCyoYM7Dr2CuSxNpH6CIPv
X-Google-Smtp-Source: APXvYqw9VXuvb35QNjxZWcVLuBw/HI2qe94FVfsU1Cxi8I0gkoI9w1dJjlswZ8AGvD7iSZPiOzF3zA==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr10354012wme.28.1560559381300; 
 Fri, 14 Jun 2019 17:43:01 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:1da0:213e:1763:a1a8])
 by smtp.gmail.com with ESMTPSA id m21sm3774234wmc.1.2019.06.14.17.43.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 17:43:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 02:42:55 +0200
Message-Id: <20190615004256.16367-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190615004256.16367-1-pbonzini@redhat.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 6/7] KVM: i386: Add support for save and
 restore nested state
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
Cc: liran.alon@oracle.com, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Kernel commit 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
introduced new IOCTLs to extract and restore KVM internal state used to
run a VM that is in VMX operation.

Utilize these IOCTLs to add support of migration of VMs which are
running nested hypervisors.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
[Simplified subsection needed functions and computation of
 kvm_min_nested_state_len(); adjusted for upstream kernel field
 names; fixed !CONFIG_KVM compilation. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c   |   8 ++
 include/sysemu/kvm.h  |   1 +
 target/i386/cpu.h     |   3 +
 target/i386/kvm.c     |  52 ++++++++++++
 target/i386/machine.c | 182 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 246 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e4ac3386cb..e1c6c067e8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -88,6 +88,7 @@ struct KVMState
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
+    uint32_t max_nested_state_len;
     int many_ioeventfds;
     int intx_set_mask;
     bool sync_mmu;
@@ -1677,6 +1678,8 @@ static int kvm_init(MachineState *ms)
     s->debugregs = kvm_check_extension(s, KVM_CAP_DEBUGREGS);
 #endif
 
+    s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
+
 #ifdef KVM_CAP_IRQ_ROUTING
     kvm_direct_msi_allowed = (kvm_check_extension(s, KVM_CAP_SIGNAL_MSI) > 0);
 #endif
@@ -2244,6 +2247,11 @@ int kvm_has_debugregs(void)
     return kvm_state->debugregs;
 }
 
+uint32_t kvm_max_nested_state_length(void)
+{
+    return kvm_state->max_nested_state_len;
+}
+
 int kvm_has_many_ioeventfds(void)
 {
     if (!kvm_enabled()) {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd190f..5eb79b594c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -210,6 +210,7 @@ bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_has_robust_singlestep(void);
 int kvm_has_debugregs(void);
+uint32_t kvm_max_nested_state_length(void);
 int kvm_has_pit_state2(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bbeb7a9521..550d397807 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1355,6 +1355,9 @@ typedef struct CPUX86State {
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
index dca76830ec..d48fafa22b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -968,6 +968,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     int kvm_base = KVM_CPUID_SIGNATURE;
+    uint32_t nested_state_len;
     int r;
     Error *local_err = NULL;
 
@@ -1368,6 +1369,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (has_xsave) {
         env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
     }
+
+    nested_state_len = kvm_max_nested_state_length();
+    if (nested_state_len > 0) {
+        assert(nested_state_len >= offsetof(struct kvm_nested_state, data));
+        env->nested_state = g_malloc0(nested_state_len);
+    }
+
     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);
 
     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
@@ -3125,6 +3133,41 @@ static int kvm_get_debugregs(X86CPU *cpu)
     return 0;
 }
 
+static int kvm_put_nested_state(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    uint32_t nested_state_len = kvm_max_nested_state_length();
+
+    if (nested_state_len == 0) {
+        return 0;
+    }
+
+    assert(env->nested_state->size <= nested_state_len);
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_NESTED_STATE, env->nested_state);
+}
+
+static int kvm_get_nested_state(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    uint32_t nested_state_len = kvm_max_nested_state_length();
+
+    if (nested_state_len == 0) {
+        return 0;
+    }
+
+    /*
+     * It is possible that migration restored a smaller size into
+     * nested_state->size than what our kernel supports.
+     * We preserve migration origin nested_state->size for
+     * the call to KVM_SET_NESTED_STATE but wish that our next call
+     * to KVM_GET_NESTED_STATE will use the maximum size supported by
+     * the kernel we're running on.
+     */
+    env->nested_state->size = nested_state_len;
+
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_GET_NESTED_STATE, env->nested_state);
+}
+
 int kvm_arch_put_registers(CPUState *cpu, int level)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -3132,6 +3175,11 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    ret = kvm_put_nested_state(x86_cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_msr_feature_control(x86_cpu);
         if (ret < 0) {
@@ -3247,6 +3295,10 @@ int kvm_arch_get_registers(CPUState *cs)
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
index 41460be54b..45dbae6054 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -246,6 +246,15 @@ static int cpu_pre_save(void *opaque)
         env->segs[R_SS].flags &= ~(env->segs[R_SS].flags & DESC_DPL_MASK);
     }
 
+#ifdef CONFIG_KVM
+    /* Verify we have nested virtualization state from kernel if required */
+    if (is_nested_virt_enabled(env) && !env->nested_state) {
+        error_report("Guest enabled nested virtualization but kernel "
+                     "do not support saving nested state");
+        return -EINVAL;
+    }
+#endif
+
     return 0;
 }
 
@@ -909,6 +918,176 @@ static const VMStateDescription vmstate_tsc_khz = {
     }
 };
 
+#ifdef CONFIG_KVM
+static bool vmx_vmcs12_needed(void *opaque)
+{
+    struct kvm_nested_state *nested_state = opaque;
+    return (nested_state->size > offsetof(struct kvm_nested_state,
+                                          vmx.data[0].vmcs12));
+}
+
+static const VMStateDescription vmstate_vmx_vmcs12_state = {
+	.name = "cpu/kvm_nested_state/vmx/vmcs12",
+	.version_id = 1,
+	.minimum_version_id = 1,
+	.needed = vmx_vmcs12_needed,
+	.fields = (VMStateField[]) {
+	    VMSTATE_UINT8_ARRAY(vmx.data[0].vmcs12,
+	                        struct kvm_nested_state, 0x1000),
+	    VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vmx_shadow_vmcs12_needed(void *opaque)
+{
+    struct kvm_nested_state *nested_state = opaque;
+    return (nested_state->size > offsetof(struct kvm_nested_state,
+                                          vmx.data[0].shadow_vmcs12));
+}
+
+static const VMStateDescription vmstate_vmx_shadow_vmcs12_state = {
+	.name = "cpu/kvm_nested_state/vmx/shadow_vmcs12",
+	.version_id = 1,
+	.minimum_version_id = 1,
+	.needed = vmx_shadow_vmcs12_needed,
+	.fields = (VMStateField[]) {
+	    VMSTATE_UINT8_ARRAY(vmx.data[0].shadow_vmcs12,
+	                        struct kvm_nested_state, 0x1000),
+	    VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool vmx_nested_state_needed(void *opaque)
+{
+    struct kvm_nested_state *nested_state = opaque;
+
+    return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
+            (nested_state->vmx.vmxon_pa != -1ull));
+}
+
+static const VMStateDescription vmstate_vmx_nested_state = {
+	.name = "cpu/kvm_nested_state/vmx",
+	.version_id = 1,
+	.minimum_version_id = 1,
+	.needed = vmx_nested_state_needed,
+	.fields = (VMStateField[]) {
+	    VMSTATE_U64(vmx.vmxon_pa, struct kvm_nested_state),
+	    VMSTATE_U64(vmx.vmcs_pa, struct kvm_nested_state),
+	    VMSTATE_U16(vmx.smm.flags, struct kvm_nested_state),
+	    VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_vmx_vmcs12_state,
+        &vmstate_vmx_shadow_vmcs12_state,
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
+	.name = "cpu/kvm_nested_state/svm",
+	.version_id = 1,
+	.minimum_version_id = 1,
+	.needed = svm_nested_state_needed,
+	.fields = (VMStateField[]) {
+	    VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool nested_state_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return (is_vmx_enabled(env) && vmx_nested_state_needed(env->nested_state)) ||
+           (is_svm_enabled(env) && svm_nested_state_needed(env->nested_state));
+}
+
+static int nested_state_post_load(void *opaque, int version_id)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+    struct kvm_nested_state *nested_state = env->nested_state;
+    uint32_t min_nested_state_len = offsetof(struct kvm_nested_state, data);
+    uint32_t max_nested_state_len = kvm_max_nested_state_length();
+
+    /*
+     * If our kernel don't support setting nested state
+     * and we have received nested state from migration stream,
+     * we need to fail migration
+     */
+    if (max_nested_state_len == 0) {
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
+                               vmstate_kvm_nested_state,
+                               struct kvm_nested_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 static bool mcg_ext_ctl_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1148,6 +1327,9 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_intel_pt,
         &vmstate_msr_virt_ssbd,
         &vmstate_svm_npt,
+#ifdef CONFIG_KVM
+        &vmstate_nested_state,
+#endif
         NULL
     }
 };
-- 
2.21.0



