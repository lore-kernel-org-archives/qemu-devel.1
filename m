Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0AAC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0128920658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvHWAeRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0128920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8SuR-0000Yu-8A
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sr9-0003Kn-Ed
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sr2-0001zL-Km
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id bh1so11223642plb.12
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XjhVxP3wZMY8P1ZnNKA41CTeGCb1P/lneTETgUSsKQY=;
 b=XvHWAeRw70TR0A1bl6pSaHwu4I4e4P7XH0xB+PR4yWp7m2N5gl4Dn9vQgRJ1xBAD5o
 hfwy4oP+j13lWmnuYY4dAMqUm3nQaq7BmoodAu5MMP/rCle2gvT883c6y5H7osgt0X0Q
 k46xng0htrR4MgIH1yYwEtHiLHBU8QInaGDCPOqibudpaOiUQd5mKRozv8uHrmIO72c5
 LuUUsXMDcnncmEhu6T9Q6wWYEqpDYzXUCjUBoX9IBTO0h4Yf8ikcRFmxRzTDHKFTPhMQ
 C/pS4abEgxpdUYd+Y6+rBJ4QOXV83TlGKUtnbVQHdCdBMoHQ72WYW7FLJM7XiWGDQB3q
 1IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XjhVxP3wZMY8P1ZnNKA41CTeGCb1P/lneTETgUSsKQY=;
 b=JoYD50xQMTwj0fUwKWcMk1fdDmJmpFgaM1w/zjHxd+wj+TqTUEXbneOFAQJPoFVRpG
 fFdp2O5zuEWsO5J6MaAZSAxHxyVkdyvHLUNReZ+KUwJuVxDOt6AxHJcs6Q4VxLRZD+Hd
 mBxURBPMvXji77+Tbjz1Wszk/2zznDdRJUc3d5N86ZeUTwE4gjAKEySHl289AhFmrSu3
 ug0grw35ifGgFU72vvhm8TSUeGBoIVgH+RNCAbywWnHAW7TC2Reb/cLOlHWuZ1ECJcdz
 E2gp54HOdrJcZ4Ap0soRUPONGGRpvW76bjIdzEG5DQX3vPRe0JdYpWFSGN1zdsTPZTil
 +6zw==
X-Gm-Message-State: AOAM530YAq6Sk+g45NolI8jF4YAS5wqAGykFm06i/A9oBUQ6nhiAyEaz
 piquEtXcUjs20KfDc10lSpMQ+3YXbvN5/xu5
X-Google-Smtp-Source: ABdhPJxmi/XK+zKiwPRcOdRDnzEdolWeWcNDThIpgSnQc8DLWwLbsA3CT7xOMfDNbK9wZOFp+T72yg==
X-Received: by 2002:a17:90a:ea82:: with SMTP id
 h2mr5005878pjz.75.1597861830959; 
 Wed, 19 Aug 2020 11:30:30 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id p20sm220766pjg.44.2020.08.19.11.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 11:30:30 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] accel/tcg: Change BQL critical section in
 cpu_handle_interrupt
Date: Wed, 19 Aug 2020 14:28:54 -0400
Message-Id: <20200819182856.4893-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819182856.4893-1-robert.foley@linaro.org>
References: <20200819182856.4893-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are changing the critical section from being around
the majority of the cpu_handle_interrupt to instead
be around just the call to ->cpu_exec_interrupt.

This is in preparation for pushing down the BQL into the
per arch implementation.

We should mention that we discussed these changes as well as
some open questions here:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01189.html
With the main open question being:
BQL is clearly needed to protect the critical section around the call to
->cpu_exec_interrupt.  What else is the BQL protecting in cpu_handle_interrupt
that we need to consider?  Are we missing anything here?

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cpu-exec.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e661635f06..499a8bdc5e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -556,7 +556,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(cpu_interrupt_request(cpu))) {
         int interrupt_request;
 
-        qemu_mutex_lock_iothread();
         interrupt_request = cpu_interrupt_request(cpu);
         if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
             /* Mask out external interrupts for this step. */
@@ -565,7 +564,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         if (interrupt_request & CPU_INTERRUPT_DEBUG) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
             cpu->exception_index = EXCP_DEBUG;
-            qemu_mutex_unlock_iothread();
             return true;
         }
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
@@ -575,13 +573,13 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
             cpu_halted_set(cpu, 1);
             cpu->exception_index = EXCP_HLT;
-            qemu_mutex_unlock_iothread();
             return true;
         }
 #if defined(TARGET_I386)
         else if (interrupt_request & CPU_INTERRUPT_INIT) {
             X86CPU *x86_cpu = X86_CPU(cpu);
             CPUArchState *env = &x86_cpu->env;
+            qemu_mutex_lock_iothread();
             replay_interrupt();
             cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
             do_cpu_init(x86_cpu);
@@ -593,7 +591,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         else if (interrupt_request & CPU_INTERRUPT_RESET) {
             replay_interrupt();
             cpu_reset(cpu);
-            qemu_mutex_unlock_iothread();
             return true;
         }
 #endif
@@ -602,6 +599,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
            True when it is, and we should restart on a new TB,
            and via longjmp via cpu_loop_exit.  */
         else {
+            qemu_mutex_lock_iothread();
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
                 replay_interrupt();
                 /*
@@ -616,6 +614,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* The target hook may have updated the 'cpu->interrupt_request';
              * reload the 'interrupt_request' value */
             interrupt_request = cpu_interrupt_request(cpu);
+            qemu_mutex_unlock_iothread();
         }
         if (interrupt_request & CPU_INTERRUPT_EXITTB) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);
@@ -625,7 +624,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         }
 
         /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
-        qemu_mutex_unlock_iothread();
     }
 
     /* Finally, check if we need to exit to the main loop.  */
-- 
2.17.1


