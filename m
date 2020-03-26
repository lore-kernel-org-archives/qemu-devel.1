Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1734C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AEA20722
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIVwHgfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AEA20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYaE-0003Qo-Mf
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKK-0006qD-KK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKH-0001Zu-N8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:03 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKH-0001Zc-Ie
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:01 -0400
Received: by mail-qt1-x844.google.com with SMTP id i3so6517771qtv.8
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2nNesVLP0H+hSoPOCqRhlnWjlFx8aHtTYwidsNPlWBQ=;
 b=CIVwHgfPMvVCfjlVDh+xGO9CWtJeAa0bqfNWScau506K0zjFX0XLV0SFmt+6JBfFWS
 NBa9+yFeHH7R8/ZoX2CV+hXtCNfb+I+HAh02vV95NfegqgBa5/qCumPyfriKdG8JhbJ9
 h+L1bfyTCOIHOWKVqm0SoDIpbJUiFDR7Y71k1jTYYYj2mmo7LGXxb6wRhapxDhBVUyZr
 avVBhjxkB56ul+a6nO1pf4F//502Xt4LytkkN4OL3gNJfAtWlXpL9hBWF7a7UHBKm5wU
 tpIAXsry+VnyBdI5h5vAnk02SbNQnH4zkPjmZzRBmczOYQCml+cG4EoNJqJ4NbsnccD+
 txxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2nNesVLP0H+hSoPOCqRhlnWjlFx8aHtTYwidsNPlWBQ=;
 b=oSQtqxqqtGFgnNB90X06OmJfsLhWnoDElJmVw74qjm/BdWhgluQuo0uxIMda9iDxwy
 upJvHxfDX9ONH8KpWuv1yp8u202vhyP1AuFh5kOR/ieTC9Tgp44CbEcmiOJn3p4/oYXx
 9+xKQJX3vKFCoFWbjgG5XlAL8PoI7+OL+V/ghzJMoLDLYeuNODNGSKv3bu8Rmec21TGs
 DArtf/zlaQmNwUJr1EXLF1PkLo4RT7Vc1u4VhXt/2dq5k5hNEcVNYkT1FDgboMwf/T5d
 Hsa0VlSfm4m/Ht9A52DvslBAi1jmavyQKp8Pvc5P28Kpgc5P+i9Xk45zUFsIMwk9elr1
 HwEQ==
X-Gm-Message-State: ANhLgQ2DPz5RFoIAHeQr5+CSboYsk89cdCBbZ3je75uBm38+NCZy6p28
 lDPYHs8SDwgLw/2RcuHaoHxhySy5KWL3Uw==
X-Google-Smtp-Source: ADFU+vs6+pOyCjht/Tn8+Gyd0bWgHTEFtEddLJ9w16QzghOzMFIeVEUTA5Ye5ie2r6NA736d7/wVHA==
X-Received: by 2002:aed:2415:: with SMTP id r21mr1154374qtc.82.1585251480646; 
 Thu, 26 Mar 2020 12:38:00 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:00 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 21/74] i386: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:03 -0400
Message-Id: <20200326193156.4322-22-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Converted new code in i386/hax-all.c to cpu_halted]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/i386/cpu.c         |  2 +-
 target/i386/cpu.h         |  2 +-
 target/i386/hax-all.c     |  6 +++---
 target/i386/helper.c      |  4 ++--
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86hvf.c  |  4 ++--
 target/i386/kvm.c         | 10 +++++-----
 target/i386/misc_helper.c |  2 +-
 target/i386/whpx-all.c    |  6 +++---
 9 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 34b511f078..280da50abf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6107,7 +6107,7 @@ static void x86_cpu_reset(DeviceState *dev)
     /* We hard-wire the BSP to the first CPU. */
     apic_designate_bsp(cpu->apic_state, s->cpu_index == 0);
 
-    s->halted = !cpu_is_bsp(cpu);
+    cpu_halted_set(s, !cpu_is_bsp(cpu));
 
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cpu);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 60d797d594..03f3c66cc2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1864,7 +1864,7 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
                            sipi_vector << 12,
                            env->segs[R_CS].limit,
                            env->segs[R_CS].flags);
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
 }
 
 int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index f9c83fff25..25bf80b5f2 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -498,7 +498,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
     if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
         (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cpu->halted = 0;
+        cpu_halted_set(cpu, 0);
     }
 
     if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
@@ -516,7 +516,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         hax_vcpu_sync_state(env, 1);
     }
 
-    if (cpu->halted) {
+    if (cpu_halted(cpu)) {
         /* If this vcpu is halted, we must not ask HAXM to run it. Instead, we
          * break out of hax_smp_cpu_exec() as if this vcpu had executed HLT.
          * That way, this vcpu thread will be trapped in qemu_wait_io_event(),
@@ -581,7 +581,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
                 !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
                 /* hlt instruction with interrupt disabled is shutdown */
                 env->eflags |= IF_MASK;
-                cpu->halted = 1;
+                cpu_halted_set(cpu, 1);
                 cpu->exception_index = EXCP_HLT;
                 ret = 1;
             }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c3a6e4fabe..058de4073d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -450,7 +450,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
                      (env->a20_mask >> 20) & 1,
                      (env->hflags >> HF_SMM_SHIFT) & 1,
-                     cs->halted);
+                    cpu_halted(cs));
     } else
 #endif
     {
@@ -477,7 +477,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
                      (env->a20_mask >> 20) & 1,
                      (env->hflags >> HF_SMM_SHIFT) & 1,
-                     cs->halted);
+                    cpu_halted(cs));
     }
 
     for(i = 0; i < 6; i++) {
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d72543dc31..bf60ce9d66 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -704,7 +704,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         vmx_update_tpr(cpu);
 
         qemu_mutex_unlock_iothread();
-        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu->halted) {
+        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu_halted(cpu)) {
             qemu_mutex_lock_iothread();
             return EXCP_HLT;
         }
@@ -738,7 +738,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 (EFLAGS(env) & IF_MASK))
                 && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
-                cpu->halted = 1;
+                cpu_halted_set(cpu, 1);
                 ret = EXCP_HLT;
                 break;
             }
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index edefe5319a..cbb2144724 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -446,7 +446,7 @@ int hvf_process_events(CPUState *cpu_state)
     if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
         (EFLAGS(env) & IF_MASK)) ||
         (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cpu_state->halted = 0;
+        cpu_halted_set(cpu_state, 0);
     }
     if (cpu_state->interrupt_request & CPU_INTERRUPT_SIPI) {
         hvf_cpu_synchronize_state(cpu_state);
@@ -458,5 +458,5 @@ int hvf_process_events(CPUState *cpu_state)
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
-    return cpu_state->halted;
+    return cpu_halted(cpu_state);
 }
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 69eb43d796..9f1e28387f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3593,7 +3593,7 @@ static int kvm_get_mp_state(X86CPU *cpu)
     }
     env->mp_state = mp_state.mp_state;
     if (kvm_irqchip_in_kernel()) {
-        cs->halted = (mp_state.mp_state == KVM_MP_STATE_HALTED);
+        cpu_halted_set(cs, mp_state.mp_state == KVM_MP_STATE_HALTED);
     }
     return 0;
 }
@@ -4151,7 +4151,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
         env->has_error_code = 0;
 
-        cs->halted = 0;
+        cpu_halted_set(cs, 0);
         if (kvm_irqchip_in_kernel() && env->mp_state == KVM_MP_STATE_HALTED) {
             env->mp_state = KVM_MP_STATE_RUNNABLE;
         }
@@ -4174,7 +4174,7 @@ int kvm_arch_process_async_events(CPUState *cs)
     if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
         (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cs->halted = 0;
+        cpu_halted_set(cs, 0);
     }
     if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
         kvm_cpu_synchronize_state(cs);
@@ -4187,7 +4187,7 @@ int kvm_arch_process_async_events(CPUState *cs)
                                       env->tpr_access_type);
     }
 
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 static int kvm_handle_halt(X86CPU *cpu)
@@ -4198,7 +4198,7 @@ static int kvm_handle_halt(X86CPU *cpu)
     if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
         !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         return EXCP_HLT;
     }
 
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 7d61221024..dace1956a0 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -558,7 +558,7 @@ static void do_hlt(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
 
     env->hflags &= ~HF_INHIBIT_IRQ_MASK; /* needed if sti is just before */
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     cpu_loop_exit(cs);
 }
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index c78baac6df..efc2d88810 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -759,7 +759,7 @@ static int whpx_handle_halt(CPUState *cpu)
           (env->eflags & IF_MASK)) &&
         !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
-        cpu->halted = true;
+        cpu_halted_set(cpu, true);
         ret = 1;
     }
     qemu_mutex_unlock_iothread();
@@ -918,7 +918,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
         (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cpu->halted = false;
+        cpu_halted_set(cpu, false);
     }
 
     if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
@@ -944,7 +944,7 @@ static int whpx_vcpu_run(CPUState *cpu)
     int ret;
 
     whpx_vcpu_process_async_events(cpu);
-    if (cpu->halted) {
+    if (cpu_halted(cpu)) {
         cpu->exception_index = EXCP_HLT;
         atomic_set(&cpu->exit_request, false);
         return 0;
-- 
2.17.1


