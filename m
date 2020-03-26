Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A61C2D0E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0DA2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGTmFyhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0DA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYkm-0005qz-Ag
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKq-0007L0-6j
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKo-0001uk-Sy
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:36 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:42627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKo-0001tv-80
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:34 -0400
Received: by mail-qt1-x841.google.com with SMTP id t9so6524345qto.9
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EcsY6TGhrUKNyVg3Ugjl3o+5XwjzyMO1Q9LTdSRFfVg=;
 b=LGTmFyhCP6cGKulmIWIURWcNhdogJy1JO62NVUnrl6TPTitgUxFoyWZtejzu2Zu2e3
 VRDWMq84SEMv1aqFjZj/VwzSuGjUCn/nwUmSLHI5XAB2cnK6+HD/qFeYKbqGFpPduy4d
 8nj7GgMEtITKqZ3QfPGmQxhHYqxDP6r4zCvDccp2hqZJYMt60175g24McmsQoK8R75Hu
 z2+QZRMhVy/TyHnZlcc407mKVnhTtoFjfe/yNGjYxd4QzZJ7gcmaAAQIsCe1bLgJ8V/M
 adpXT1LQfH1OcZRSWMKzUzeIBa2FcaVDU8Pd7TmROaOjIPzUwQwRLZmUJ9Qc94hypg0g
 856A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EcsY6TGhrUKNyVg3Ugjl3o+5XwjzyMO1Q9LTdSRFfVg=;
 b=NBP6QwiT2Lxv6cMiCxUowWrncBACnpmqXFA7chhwyh5bSybvKfiEts9/xzif7Otz5C
 aybX+WCua1TK0CMntklvljuA1nNPbiTHXF4Qzk31k72W2zyF+7zm8QhJVWWksAURqdOf
 mm0bhHukbMmQHzzDxrgy0AlrViixOL9heAUqjQ6GH3qc/2C6tgY6BKdnXFgNucgKHlUb
 JylHXzzIppmj8vUrQu7J5YotuxLWRUYOv5DmTWkUzMwwFv+JGMCIwSxhuAG9MhuZMhSa
 ZQxP/510353iUeIjpbCsbfMe5GrokqzEXRJsssvCVw8HXzVa6vXHrjjQFXmtTVWOusx4
 XbxQ==
X-Gm-Message-State: ANhLgQ1knyRCDukE2i+7mQLbmI/56epY+b+YXz1L0+i9xFNH8d3wQcw9
 7zKMzQW7pV8zCvGLAUHPDuPgBlAQiGBYTg==
X-Google-Smtp-Source: ADFU+vv0s2yA5m6vFbOLhIogGCjzLGztrIHz53hP+g0E7gFAeEoNf4sqJ6AvChU9JV6ltfYlq/4orw==
X-Received: by 2002:ac8:16b8:: with SMTP id r53mr10420260qtj.7.1585251513210; 
 Thu, 26 Mar 2020 12:38:33 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:32 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 43/74] i386/whpx-all: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:25 -0400
Message-Id: <20200326193156.4322-44-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
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


