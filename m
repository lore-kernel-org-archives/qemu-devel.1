Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88BBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B7A2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E22g1j7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B7A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfS6-0003Qy-Kc
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE7-0003Gi-3A
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:07 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDu-0008Uh-B4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:06 -0400
Received: by mail-qk1-x744.google.com with SMTP id w3so3495306qkb.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Pwj8GypD7Z+8gMlM2oBcpPOEswoZuhb40JEwUc+M6A=;
 b=E22g1j7gZAOIPfrauv7unDiVj8oaEUe996v6ANRYFpjRygV8JeJp7JnHGJ9sQ3wzhW
 1BsMgIeaEStlO58KPdX4myJwvz4+OYjDEkwiXK5sRS4SJsa6YFA8L/VdJezBDtw8RlpZ
 fvjSmD4anJrNztLldX54PGIahyFY2fl05q/vbwTxJCl4v57DQi1MoSewIvTjlevG8fuy
 J0ijf9qp/gjHOIKpgTQlMXs1Iem/w3hHTfW9pT9xsvLbAY4B2pPyVDMadOZQ0w6Cp6NG
 kqPK1AAq/lF6kM/DP70rwv+ytPSS9TwG1DLBvFFXoZ6Y94mlOO4QPedKMvAjgear9e92
 QYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Pwj8GypD7Z+8gMlM2oBcpPOEswoZuhb40JEwUc+M6A=;
 b=MG/WZZNWDETqDIEDa9qKWb/osO4OtBRB0ZUJCpjf2EzZJ1fppSudIxMPwaF3mwYPrL
 80KpcUMkOrRXxWyJVYIXi0kI77/Fd51av1qQGjaq4XLszAPBWeOMgAQasyh86hAUXzEk
 /kpyqWnsY8wHthHyvmXQ7XVBBYpFJ3jBcqssXVTtI1XpPT2grKKVoNVUWEn/W/B//GJL
 U2QVUIwN3zD44Q6CqDmFMAoy/Syrk60wvb3QP3sMdsy7w4W6Ggs0SKYJsw24xyH5NgHK
 D9XVMnAzSicc1ZX3VXq/MAzj4koOzgKBJBp+eSSnpLfadguUxlb07YQg6PYh47FHQppX
 wu3g==
X-Gm-Message-State: AOAM5325I/BimmgTgxxK5zeAdVUHSrwQMiaBsj191Y+bIbvJSW/i1J24
 dlvJvTRw1ZrP3zjLM8lGS82lSkrYQeUYIg==
X-Google-Smtp-Source: ABdhPJzlKRp2NDu/gUXDi9F0/HaA3mZ3hM17T4JGipI3qmbNMkwikHPTCSbzlin/KWSydx932iAmbw==
X-Received: by 2002:a37:6813:: with SMTP id d19mr592483qkc.11.1592427832576;
 Wed, 17 Jun 2020 14:03:52 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:51 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 25/73] s390x: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:43 -0400
Message-Id: <20200617210231.4393-26-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x744.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, robert.foley@linaro.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 cota@braap.org, peter.puhov@linaro.org, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/intc/s390_flic.c        |  2 +-
 target/s390x/cpu.c         | 22 +++++++++++++++-------
 target/s390x/excp_helper.c |  2 +-
 target/s390x/kvm.c         |  2 +-
 target/s390x/sigp.c        |  8 ++++----
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index aacdb1bbc2..46ec8272c0 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -200,7 +200,7 @@ static void qemu_s390_flic_notify(uint32_t type)
         }
 
         /* we always kick running CPUs for now, this is tricky */
-        if (cs->halted) {
+        if (cpu_halted(cs)) {
             /* don't check for subclasses, CPUs double check when waking up */
             if (type & FLIC_PENDING_SERVICE) {
                 if (!(cpu->env.psw.mask & PSW_MASK_EXT)) {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 08eb674d22..d7a98bd52b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -291,7 +291,7 @@ static void s390_cpu_initfn(Object *obj)
     S390CPU *cpu = S390_CPU(obj);
 
     cpu_set_cpustate_pointers(cpu);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
 #if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
@@ -318,8 +318,8 @@ static void s390_cpu_finalize(Object *obj)
 #if !defined(CONFIG_USER_ONLY)
 static bool disabled_wait(CPUState *cpu)
 {
-    return cpu->halted && !(S390_CPU(cpu)->env.psw.mask &
-                            (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
+    return cpu_halted(cpu) && !(S390_CPU(cpu)->env.psw.mask &
+                                (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
 }
 
 static unsigned s390_count_running_cpus(void)
@@ -345,10 +345,16 @@ unsigned int s390_cpu_halt(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
     trace_cpu_halt(cs->cpu_index);
 
-    if (!cs->halted) {
-        cs->halted = 1;
+    /*
+     * cpu_halted and cpu_halted_set acquire the cpu lock if it
+     * isn't already held, so acquire it first.
+     */
+    cpu_mutex_lock(cs);
+    if (!cpu_halted(cs)) {
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
     }
+    cpu_mutex_unlock(cs);
 
     return s390_count_running_cpus();
 }
@@ -358,10 +364,12 @@ void s390_cpu_unhalt(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
     trace_cpu_unhalt(cs->cpu_index);
 
-    if (cs->halted) {
-        cs->halted = 0;
+    cpu_mutex_lock(cs);
+    if (cpu_halted(cs)) {
+        cpu_halted_set(cs, 0);
         cs->exception_index = -1;
     }
+    cpu_mutex_unlock(cs);
 }
 
 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 3b58d10df3..db6640ba2c 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -537,7 +537,7 @@ try_deliver:
     if ((env->psw.mask & PSW_MASK_WAIT) || stopped) {
         /* don't trigger a cpu_loop_exit(), use an interrupt instead */
         cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
-    } else if (cs->halted) {
+    } else if (cpu_halted(cs)) {
         /* unhalt if we had a WAIT PSW somehwere in our injection chain */
         s390_cpu_unhalt(cpu);
     }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f2f75d2a57..f376c4a2f6 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1094,7 +1094,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return cs->halted;
+    return cpu_halted(cs);
 }
 
 static int s390_kvm_irq_to_interrupt(struct kvm_s390_irq *irq,
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index c604f17710..44d22ae3bf 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -115,7 +115,7 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     }
 
     /* disabled wait - sleeping in user space */
-    if (cs->halted) {
+    if (cpu_halted(cs)) {
         s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
     } else {
         /* execute the stop function */
@@ -131,7 +131,7 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     SigpInfo *si = arg.host_ptr;
 
     /* disabled wait - sleeping in user space */
-    if (s390_cpu_get_state(cpu) == S390_CPU_STATE_OPERATING && cs->halted) {
+    if (s390_cpu_get_state(cpu) == S390_CPU_STATE_OPERATING && cpu_halted(cs)) {
         s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
     }
 
@@ -313,7 +313,7 @@ static void sigp_cond_emergency(S390CPU *src_cpu, S390CPU *dst_cpu,
     }
 
     /* this looks racy, but these values are only used when STOPPED */
-    idle = CPU(dst_cpu)->halted;
+    idle = cpu_halted(CPU(dst_cpu));
     psw_addr = dst_cpu->env.psw.addr;
     psw_mask = dst_cpu->env.psw.mask;
     asn = si->param;
@@ -347,7 +347,7 @@ static void sigp_sense_running(S390CPU *dst_cpu, SigpInfo *si)
     }
 
     /* If halted (which includes also STOPPED), it is not running */
-    if (CPU(dst_cpu)->halted) {
+    if (cpu_halted(CPU(dst_cpu))) {
         set_sigp_status(si, SIGP_STAT_NOT_RUNNING);
     } else {
         si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
-- 
2.17.1


