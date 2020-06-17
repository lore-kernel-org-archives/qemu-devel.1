Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DCA2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQ63kTM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DCA2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfTz-0006Vc-Sr
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEH-0003aT-N3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:17 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEF-00009C-J2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:17 -0400
Received: by mail-qk1-x743.google.com with SMTP id j68so140069qkb.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bMJDR0op9yYxk4Q3uQ7Lh3faQWxq/2pZw+Fv/nrXz+A=;
 b=RQ63kTM3AKz8TNyE0qqe3WkxI4DWPU9SoW1W8pf9NzcSXpE0kY0LeFIbtftZnxkj4x
 xZuG7uhNcOEJpQEDpXhvC4mN6Up5589I6u4feY9dRApjrGtw0jzbP/VS3RgTMf+3aBMs
 KTTbCR481jg527+8nsl8LO+Vk/i0cl2OV8eCwCMyefErmZD3bZ1vHgf1mAxZ2ABZZCPj
 fT0xXvOy6UqjOHQopPv8256ETNp9vw1p7oH/cVAr7hjf0NIgnlygj/9hIa6OTvoYpio8
 yEHxkxu+nZ+YVDtvv47ypap+qoRvdvBgWhM6O73KoW/1Uk32RfTR5O74JLUdSLiGrb3n
 Zk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bMJDR0op9yYxk4Q3uQ7Lh3faQWxq/2pZw+Fv/nrXz+A=;
 b=q2PgbqpYXAvRDQTXAWTocHCJI2PR9vhI3SCgp+QzpYKrGiBzYRy06Wqx+wCO/VX1Oi
 QwASCsbAK+YcofbJk4svNJCpvv1gaK+LFA27UEDjrVl280tS+6+n10iLoYUI5+MY/igU
 uxX6SFed/C6EcImdciZJBP54bQq1XuL28330oHjakB7YPOL7oaA1SWFsKIM27THYzPFR
 dthz5cUJXMxGY7IKt3LCJVuZ4nXmCt/l6vQHiw/JCEcSyjYk/1FV00h2yIJTFFpPLbFe
 cOXLFfN9+drd6sDSIxNO+rV4vygvDiyHCKUyVy9EK0Ugag1pCLsgrlSH3kiHrGpmW87e
 QrLg==
X-Gm-Message-State: AOAM533bj7LhLy9QAj0d2P2TWCnueGw+/iKJB/JjJrCuJ1MYom1coicA
 h1J3ZJDz7yfoHmFGG/XvED1/8Y2krRiQ2g==
X-Google-Smtp-Source: ABdhPJznqaLvi+9naqRjgbuk4+KNhEW9buBCGiCCF3iJ7TMvCWyNwsADfAY+cpYywUMGIYMeZlcjcA==
X-Received: by 2002:a37:5e07:: with SMTP id s7mr625733qkb.20.1592427854372;
 Wed, 17 Jun 2020 14:04:14 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:13 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 40/73] i386/kvm: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:01:58 -0400
Message-Id: <20200617210231.4393-41-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
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
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
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
index 8628fa9111..415a6d8114 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3653,11 +3653,14 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
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
@@ -4015,14 +4018,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
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
@@ -4030,10 +4033,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
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
@@ -4047,16 +4048,22 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
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
@@ -4064,7 +4071,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (!kvm_pic_in_kernel()) {
         /* Try to inject an interrupt if the guest can accept it */
         if (run->ready_for_interrupt_injection &&
-            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            (interrupt_request & CPU_INTERRUPT_HARD) &&
             (env->eflags & IF_MASK)) {
             int irq;
 
@@ -4088,7 +4095,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
          * interrupt, request an interrupt window exit.  This will
          * cause a return to userspace as soon as the guest is ready to
          * receive interrupts. */
-        if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
             run->request_interrupt_window = 1;
         } else {
             run->request_interrupt_window = 0;
@@ -4134,8 +4141,9 @@ int kvm_arch_process_async_events(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    uint32_t interrupt_request;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_MCE) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_MCE) {
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
@@ -4158,7 +4166,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         }
     }
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_init(cpu);
@@ -4168,20 +4176,21 @@ int kvm_arch_process_async_events(CPUState *cs)
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
@@ -4195,10 +4204,13 @@ static int kvm_handle_halt(X86CPU *cpu)
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


