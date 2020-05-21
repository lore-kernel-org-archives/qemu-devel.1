Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D186C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2489D207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jw4Rv8VY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2489D207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboco-0002fQ-An
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIm-0003gp-KU
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:12 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIl-0006bt-Ej
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:12 -0400
Received: by mail-qt1-x842.google.com with SMTP id l1so5987283qtp.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DIHX0WJxTdy28I7CslaN2HbTZg9fiYXdvrHYT2rc2zE=;
 b=Jw4Rv8VYbT7MbaIHDAhN6osOQq0OX+uMEgUhQO5g5LTA/qyVMoGP5YYTwGPyQf3knH
 Zhtc8+OPY/rxgEENRsFIxDTRnN/OGJuKv2Q7jdQDR7SREBpwHv6ZdrUMAprwLSJpruaA
 bqDPRzDkT7TB8OqWVVk0jIWPLY3eSfoERHv1HsMYPQMUFFrkIqlMIbIG72cesI8iXHY2
 2t4kyDtUp6wv7WIrnu3NTSXYK2NFK0O3I21oub5x38UjVoE8sCRbuvirgahcYI62TNtY
 T/Z9QB9HP18GZgrUvHHNWRS5eLSRnlyH2+wjhZRpbPspnY6rkE3hvSb/j4vXCiRhNVMs
 3BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DIHX0WJxTdy28I7CslaN2HbTZg9fiYXdvrHYT2rc2zE=;
 b=g6XiWm8e7JVONM6wAqWkbMofGkYbi/YS6RbQaN5XPRFZYPQCTNfMzGq5GxplUruAR5
 qBMamKWXwUKkkZ6aj/2Z12negBKYLuMlkP76hJwDsSVTIwzqggV5vQjp6GfpfxtCCHI3
 E4p0PUcDi2n98oLY4TrDs4N5BK+2stDD3RwYnvbplCY3SaHrylc50ZTqjZ52z0jLlaTP
 I/vWxSBOOdFh/U4J8jRUYU3g5Y/Smy9E619zWqMgO0ag3bmk3WZayVmxLF1KGM4a+t2T
 jq8trzR+4WbzybeK2qZB6FMsfr+Qtt/LqqPT9UrutaliNFXqW3JEv/OTrgTu1FDYsNbe
 YfAA==
X-Gm-Message-State: AOAM532pgC6W+izm3Q3ztR3atBcLHlNf8BCqxa/YWGUi51XjNpfjcqgW
 i14e6JAUWAwAm8SIBjKAYPXEWuehYKJ3jg==
X-Google-Smtp-Source: ABdhPJyTy0CW101BwkgecrdUTiCmVzLzVJV7N+fsa0O+1YbP7oWUhLX0I9GwRpj7Os9bbTQn8tOxNg==
X-Received: by 2002:ac8:3594:: with SMTP id k20mr11840044qtb.381.1590079450083; 
 Thu, 21 May 2020 09:44:10 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:09 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 41/74] i386/kvm: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:38 -0400
Message-Id: <20200521164011.638-42-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/i386/kvm.c | 58 ++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2451840b36..9b0080a629 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3627,11 +3627,14 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
         events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);
         if (kvm_irqchip_in_kernel()) {
+            uint32_t interrupt_request;
+
             /* As soon as these are moved to the kernel, remove them
              * from cs->interrupt_request.
              */
-            events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
-            events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
+            interrupt_request = cpu_interrupt_request(cs);
+            events.smi.pending = interrupt_request & CPU_INTERRUPT_SMI;
+            events.smi.latched_init = interrupt_request & CPU_INTERRUPT_INIT;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
         } else {
             /* Keep these in cs->interrupt_request.  */
@@ -3989,14 +3992,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    uint32_t interrupt_request;
     int ret;
 
+    interrupt_request = cpu_interrupt_request(cpu);
     /* Inject NMI */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
-            qemu_mutex_lock_iothread();
+    if (interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
-            qemu_mutex_unlock_iothread();
             DPRINTF("injected NMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_NMI);
             if (ret < 0) {
@@ -4004,10 +4007,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
                         strerror(-ret));
             }
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
-            qemu_mutex_lock_iothread();
+        if (interrupt_request & CPU_INTERRUPT_SMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
-            qemu_mutex_unlock_iothread();
             DPRINTF("injected SMI\n");
             ret = kvm_vcpu_ioctl(cpu, KVM_SMI);
             if (ret < 0) {
@@ -4021,16 +4022,22 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
         qemu_mutex_lock_iothread();
     }
 
+    /*
+     * We might have cleared some bits in cpu->interrupt_request since reading
+     * it; read it again.
+     */
+    interrupt_request = cpu_interrupt_request(cpu);
+
     /* Force the VCPU out of its inner loop to process any INIT requests
      * or (for userspace APIC, but it is cheap to combine the checks here)
      * pending TPR access reports.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if ((interrupt_request & CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        if (interrupt_request & CPU_INTERRUPT_TPR) {
             cpu->exit_request = 1;
         }
     }
@@ -4038,7 +4045,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (!kvm_pic_in_kernel()) {
         /* Try to inject an interrupt if the guest can accept it */
         if (run->ready_for_interrupt_injection &&
-            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            (interrupt_request & CPU_INTERRUPT_HARD) &&
             (env->eflags & IF_MASK)) {
             int irq;
 
@@ -4062,7 +4069,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
          * interrupt, request an interrupt window exit.  This will
          * cause a return to userspace as soon as the guest is ready to
          * receive interrupts. */
-        if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
             run->request_interrupt_window = 1;
         } else {
             run->request_interrupt_window = 0;
@@ -4108,8 +4115,9 @@ int kvm_arch_process_async_events(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    uint32_t interrupt_request;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_MCE) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_MCE) {
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
@@ -4132,7 +4140,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         }
     }
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_init(cpu);
@@ -4142,20 +4150,21 @@ int kvm_arch_process_async_events(CPUState *cs)
         return 0;
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    interrupt_request = cpu_interrupt_request(cs);
+    if (((interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cs, 0);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (interrupt_request & CPU_INTERRUPT_SIPI) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_TPR) {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_TPR);
         kvm_cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
@@ -4169,10 +4178,13 @@ static int kvm_handle_halt(X86CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
+    uint32_t interrupt_request;
+
+    interrupt_request = cpu_interrupt_request(cs);
 
-    if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!((interrupt_request & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
-        !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !(interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cs, 1);
         return EXCP_HLT;
     }
-- 
2.17.1


