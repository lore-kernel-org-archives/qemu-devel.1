Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A484DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6ED2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5z5IR5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6ED2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfIu-0003um-Im
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDo-00039i-IF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:48 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDm-0008U7-Fu
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:48 -0400
Received: by mail-qk1-x742.google.com with SMTP id q8so3449651qkm.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rba7pljRMVc6wa2lS86kVUPY7O/d9hkT9SFA7+vY6nY=;
 b=R5z5IR5FLnMnMqf2RggbF8wnsY2icPxT3w46kmMuEmy69k/4Mr4UNe+RuR+WiEPvG3
 9c8CJRRyY7m6nltryWkmWziQvRZfYasj4SE4VArK46KiVyJ+gazqevXOxXuZqTuDay8U
 9X86q5vyz5COzSuzfdMrSntdJ3rZjYQt7Eq5Lt1dQttkcMCrcVV8Vo1J9H6x1Btp9rjo
 6Sr1nzX1mKh5hhoW25c15laX42Nri5JALP/VjoR4EXVD56IZn2Zv6dyI+FR9L/LqrxXz
 fbXETyMyprillHLMW8zUjP4+c2fyHOBDmvmInXSFqQ+yIOGH5Gtlr4YE5cLe6r/hZBmA
 uerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rba7pljRMVc6wa2lS86kVUPY7O/d9hkT9SFA7+vY6nY=;
 b=DZwubFykX9o+h2C337PtU/9T/36KpWMO3X7ToalaKP0eIIwKU1kmSJYQmIFI/UQbAG
 oAmXK/JGw0vbuVX8LzKjqvjeWaK7iqR9k2xIeIatvQGWQ90tZaQ19CBRTWwoi2+R2Ngm
 15a+CKq9g1faWAQPHQXUUOLFGUQke0x6DH7d5K1hux1/A15ilFS+HCcOvMUFvSqzbCc+
 Iovs6/ZiYVsySE0N99oG02Md1SAdq1mJr4gCLQFHZnADqGAm28xpybjhj0FaCaqRn1qw
 C75GSicr4ufQ2x7TEgpYFRBYqw+qn3CzzQUEsH8oI/vknpMYkY/j+S/x4uas8g4BuCld
 Icqw==
X-Gm-Message-State: AOAM530IJJI1jN5DVLN29GSFkH9B9LDYR1ZPU4w+tThKCScjsbwOqO++
 G4PU/NnbHaiT/iz8XjjlJ+gQw8HcUGpmhw==
X-Google-Smtp-Source: ABdhPJzZuLORD87VxHFuUa7rIS/eYuoX8SDFPbCz5s962zeXaI0xoYOVy9OxMVd8SVfCrJEKucANOw==
X-Received: by 2002:a37:9684:: with SMTP id y126mr589113qkd.348.1592427825231; 
 Wed, 17 Jun 2020 14:03:45 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:44 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 20/73] i386: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:38 -0400
Message-Id: <20200617210231.4393-21-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, "open list:X86 KVM CPUs" <kvm@vger.kernel.org>,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 cota@braap.org, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peter.puhov@linaro.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org,
 Eduardo Habkost <ehabkost@redhat.com>
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
index b1b311baa2..4d3ab0f3a2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6084,7 +6084,7 @@ static void x86_cpu_reset(DeviceState *dev)
     /* We hard-wire the BSP to the first CPU. */
     apic_designate_bsp(cpu->apic_state, s->cpu_index == 0);
 
-    s->halted = !cpu_is_bsp(cpu);
+    cpu_halted_set(s, !cpu_is_bsp(cpu));
 
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cpu);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7d77efd9e4..c618b90568 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1880,7 +1880,7 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
                            sipi_vector << 12,
                            env->segs[R_CS].limit,
                            env->segs[R_CS].flags);
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
 }
 
 int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index c93bb23a44..acfb7a6e10 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -511,7 +511,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
     if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
         (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cpu->halted = 0;
+        cpu_halted_set(cpu, 0);
     }
 
     if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
@@ -529,7 +529,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         hax_vcpu_sync_state(env, 1);
     }
 
-    if (cpu->halted) {
+    if (cpu_halted(cpu)) {
         /* If this vcpu is halted, we must not ask HAXM to run it. Instead, we
          * break out of hax_smp_cpu_exec() as if this vcpu had executed HLT.
          * That way, this vcpu thread will be trapped in qemu_wait_io_event(),
@@ -594,7 +594,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
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
index be016b951a..b3bd2285fa 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -709,7 +709,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         vmx_update_tpr(cpu);
 
         qemu_mutex_unlock_iothread();
-        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu->halted) {
+        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu_halted(cpu)) {
             qemu_mutex_lock_iothread();
             return EXCP_HLT;
         }
@@ -742,7 +742,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 (env->eflags & IF_MASK))
                 && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
-                cpu->halted = 1;
+                cpu_halted_set(cpu, 1);
                 ret = EXCP_HLT;
                 break;
             }
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 5cbcb32ab6..c09cf160ef 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -446,7 +446,7 @@ int hvf_process_events(CPUState *cpu_state)
     if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK)) ||
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
index b3c13cb898..eda51904dd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3594,7 +3594,7 @@ static int kvm_get_mp_state(X86CPU *cpu)
     }
     env->mp_state = mp_state.mp_state;
     if (kvm_irqchip_in_kernel()) {
-        cs->halted = (mp_state.mp_state == KVM_MP_STATE_HALTED);
+        cpu_halted_set(cs, mp_state.mp_state == KVM_MP_STATE_HALTED);
     }
     return 0;
 }
@@ -4152,7 +4152,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
         env->has_error_code = 0;
 
-        cs->halted = 0;
+        cpu_halted_set(cs, 0);
         if (kvm_irqchip_in_kernel() && env->mp_state == KVM_MP_STATE_HALTED) {
             env->mp_state = KVM_MP_STATE_RUNNABLE;
         }
@@ -4175,7 +4175,7 @@ int kvm_arch_process_async_events(CPUState *cs)
     if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
         (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cs->halted = 0;
+        cpu_halted_set(cs, 0);
     }
     if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
         kvm_cpu_synchronize_state(cs);
@@ -4188,7 +4188,7 @@ int kvm_arch_process_async_events(CPUState *cs)
                                       env->tpr_access_type);
     }
 
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 static int kvm_handle_halt(X86CPU *cpu)
@@ -4199,7 +4199,7 @@ static int kvm_handle_halt(X86CPU *cpu)
     if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
         !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         return EXCP_HLT;
     }
 
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index b6b1d41b14..c396b6c7b9 100644
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


