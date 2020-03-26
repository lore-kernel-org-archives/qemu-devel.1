Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ACDC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB95206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2SVjf/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB95206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYTF-0006Ie-Hg
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKo-0007Jj-Us
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKn-0001tQ-3j
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:34 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKm-0001sG-Up
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:33 -0400
Received: by mail-qk1-x742.google.com with SMTP id b62so8195705qkf.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=idzaW9AuHO1pDNIc/RVr+K6qO48ZZyYm6VEdm3wlJ3c=;
 b=d2SVjf/oFVzu9txF36Fidwy3HrI1jly0M3OTnLkvltpSppg+aW8f6iPS3CFbDiUrwU
 CjxExPwTxt9+WLA8Y2r1b7CNcJ+cLi0AEp17HsGSEq/GxNaH4yihaTSRHqrkwMArji+m
 mcmBDKQPwDT2r97+ufONvZaacG5KJX+SvnbDwQNFJW+ZMNl+otbdpMRo//uwkMKd3bPd
 hxpqvv3Fhf3j6C8rxtCxuziKHNOtDmShLKpdq+NGYmpOJ+Cor/xZYrvntUj9Crw9z6/T
 6ZqiE/KpFwMAxOECG/wqZ6jPyZM8vR6aopnjGrZJTdkMmTiJqj7jC0CPpQzMWy3TkJK7
 Bamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=idzaW9AuHO1pDNIc/RVr+K6qO48ZZyYm6VEdm3wlJ3c=;
 b=fcyiw1DxBiFyNWdPQQCBGSLzhrQNFgk7H8kUAOivC5Lz/EnIixkS2bdnwtPJ7Etvb8
 NHNxIR4403AWxJmd8LdyjS/GpfyHH79SJTRVpVjWxJRU8wOX/WpcrjtwOcYAE+gY061X
 oWK2rZwxVfpjHpqV1Jf7cvkMVU3OBAaaYuZxXVZECAkcIb9HaFF/56TKjBQO5NtzyR7Z
 yaergBsSPetR0RTmvwSjjjafZpUrYiIMDdjy6dqsx9axQ0djeIpnzfwncv34cLXS4w78
 4X3EFnjfj1mwPzX3p83qrTKq38IhfdZSnO9mOLik0onupmf4QH2vqYecoTAqVouO911j
 txyQ==
X-Gm-Message-State: ANhLgQ15x+TvcH7eP++6cY8S4kwuWUoW1CUtee0zcSEFsEFn+KLSscbI
 NI0KcdCuAKghXxMCOKWNZtXs2HdsHjUhJA==
X-Google-Smtp-Source: ADFU+vtw+lO5Uy/nNsHTzzzwNDY4oMqwtBSTbrWuP1pCHwb6CbyLcxTO0csT3qwg9YaEhLoxM58QaA==
X-Received: by 2002:ae9:ef87:: with SMTP id
 d129mr10610543qkg.329.1585251510616; 
 Thu, 26 Mar 2020 12:38:30 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:30 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 41/74] i386/kvm: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:23 -0400
Message-Id: <20200326193156.4322-42-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/i386/kvm.c | 58 ++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 44a4d45980..e733e112ee 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3652,11 +3652,14 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
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
@@ -4014,14 +4017,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
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
@@ -4029,10 +4032,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
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
@@ -4046,16 +4047,22 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
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
@@ -4063,7 +4070,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
     if (!kvm_pic_in_kernel()) {
         /* Try to inject an interrupt if the guest can accept it */
         if (run->ready_for_interrupt_injection &&
-            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            (interrupt_request & CPU_INTERRUPT_HARD) &&
             (env->eflags & IF_MASK)) {
             int irq;
 
@@ -4087,7 +4094,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
          * interrupt, request an interrupt window exit.  This will
          * cause a return to userspace as soon as the guest is ready to
          * receive interrupts. */
-        if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
             run->request_interrupt_window = 1;
         } else {
             run->request_interrupt_window = 0;
@@ -4133,8 +4140,9 @@ int kvm_arch_process_async_events(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    uint32_t interrupt_request;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_MCE) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_MCE) {
         /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
         assert(env->mcg_cap);
 
@@ -4157,7 +4165,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         }
     }
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         kvm_cpu_synchronize_state(cs);
         do_cpu_init(cpu);
@@ -4167,20 +4175,21 @@ int kvm_arch_process_async_events(CPUState *cs)
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
@@ -4194,10 +4203,13 @@ static int kvm_handle_halt(X86CPU *cpu)
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


