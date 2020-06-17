Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01FAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E1C20FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0xaPLfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E1C20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfbD-0002B2-Of
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEK-0003je-ON
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:20 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:39820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEI-0000Er-Jf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:20 -0400
Received: by mail-qv1-xf42.google.com with SMTP id r16so1761705qvm.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EcsY6TGhrUKNyVg3Ugjl3o+5XwjzyMO1Q9LTdSRFfVg=;
 b=Y0xaPLfr7H0xD9RlJzFNKFZAocI3yNY1KGVZm1Ak4h7JEqbfrNfBfVWEouHU6oHRAi
 Gn6pPKMFCGxuq3rqqa/Am/DVlBNsJCTXTB8ZPF0OM2Vsw2VvreoBkWVOeuE0g6/DYf6V
 285nXjiwa8F7iFimgcYJQnEm58M6vlDm01M2ps4BIuTPhtrBVAsMTH5YaB6lKcYl6ufq
 lNHfCBbAqSRJBQBHd5qDfXpe4JYrb2SzBWQ0o6fd7JYJp3fjrbSIB20xAoOWGp2lpXPY
 eVK7f4Iuw0xcGV7HtZtCZYXfWtkIqfLoLIJnGpak6S8iy5rcF9H66vFkhXxpUtoXr1x1
 eRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EcsY6TGhrUKNyVg3Ugjl3o+5XwjzyMO1Q9LTdSRFfVg=;
 b=j4U7pgPtCryxUikHYj40C70dJ8xWiHOJqZ5sHKfkzM7Hx2YzkPvRqFXfjYi+8FfkF6
 Jhafb9DZyj6bH2/QOtQK8cjeqHktjnvjX4AH0vIsJH3/2jix4oaD3IuNZVZxrahxZ0lL
 RDKfzeKIx2bjdH0qcLIiT5fd3W3mZf1BdG7eErlY3pLVkqGxb0rtEDu1XzQrfxCQc61H
 5LAGOSO0AajhmieNN5jA+BVq+W8hgw37j+YxRJdnVk117ZtLyqD8Qh5v47OQ5bHH5CKh
 0G/ft4jxQwirfBgwH6ZqeoLVYBG14t+TTQwPQdxO/rZrBirUZuSCZtXudhsU6PG6X5hV
 vgjg==
X-Gm-Message-State: AOAM531D9ZZH+KFvPb4L5fAPps4w92yONVFBDK7WaAgIzbt+S44fFnPt
 iRG+ycW7hOfJX4Ywfz6A0DIF/B+9ATArhQ==
X-Google-Smtp-Source: ABdhPJz0dU2JrKR+YLEpyMswc/BOBYG3ZNtOke13elnzruKWb1F8SHzaox/w6GN5umYkPECShRer8w==
X-Received: by 2002:ad4:590d:: with SMTP id ez13mr558482qvb.177.1592427857405; 
 Wed, 17 Jun 2020 14:04:17 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:16 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 42/73] i386/whpx-all: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:00 -0400
Message-Id: <20200617210231.4393-43-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf42.google.com
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/i386/whpx-all.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index d5beb4a5e2..cb424f04a3 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -752,12 +752,14 @@ static int whpx_handle_portio(CPUState *cpu,
 static int whpx_handle_halt(CPUState *cpu)
 {
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
+    uint32_t interrupt_request;
     int ret = 0;
 
     qemu_mutex_lock_iothread();
-    if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    interrupt_request = cpu_interrupt_request(cpu);
+    if (!((interrupt_request & CPU_INTERRUPT_HARD) &&
           (env->eflags & IF_MASK)) &&
-        !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !(interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu_halted_set(cpu, true);
         ret = 1;
@@ -775,6 +777,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
     X86CPU *x86_cpu = X86_CPU(cpu);
     int irq;
+    uint32_t interrupt_request;
     uint8_t tpr;
     WHV_X64_PENDING_INTERRUPTION_REGISTER new_int;
     UINT32 reg_count = 0;
@@ -786,17 +789,19 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     qemu_mutex_lock_iothread();
 
+    interrupt_request = cpu_interrupt_request(cpu);
+
     /* Inject NMI */
     if (!vcpu->interruption_pending &&
-        cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
+        interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
             vcpu->interruptable = false;
             new_int.InterruptionType = WHvX64PendingNmi;
             new_int.InterruptionPending = 1;
             new_int.InterruptionVector = 2;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+        if (interrupt_request & CPU_INTERRUPT_SMI) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
         }
     }
@@ -805,12 +810,12 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
      * Force the VCPU out of its inner loop to process any INIT requests or
      * commit pending TPR access.
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
@@ -819,7 +824,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     if (!vcpu->interruption_pending &&
         vcpu->interruptable && (env->eflags & IF_MASK)) {
         assert(!new_int.InterruptionPending);
-        if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (interrupt_request & CPU_INTERRUPT_HARD) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
             irq = cpu_get_pic_interrupt(env);
             if (irq >= 0) {
@@ -849,7 +854,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Update the state of the interrupt delivery notification */
     if (!vcpu->window_registered &&
-        cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+        cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) {
         reg_values[reg_count].DeliverabilityNotifications.InterruptNotification
             = 1;
         vcpu->window_registered = 1;
@@ -902,31 +907,33 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    uint32_t interrupt_request;
 
-    if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         whpx_cpu_synchronize_state(cpu);
         do_cpu_init(x86_cpu);
         vcpu->interruptable = true;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
 
-    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    interrupt_request = cpu_interrupt_request(cpu);
+    if (((interrupt_request & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (interrupt_request & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cpu, false);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (interrupt_request & CPU_INTERRUPT_SIPI) {
         whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_TPR) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_TPR);
         whpx_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
@@ -1413,7 +1420,7 @@ static void whpx_memory_init(void)
 
 static void whpx_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.17.1


