Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E97C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030952087C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEaY3oKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030952087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1UXp-0007QT-6B
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 08:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1UVp-0004zj-QG
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 08:51:49 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1UVo-0003ZB-1V
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 08:51:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id g19so4721069plq.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ipb1oAgBpsVkyVJgMH88juv5xGMCsNxuM8ef88OlKis=;
 b=IEaY3oKO6ud2Y+vPs/8S9DXBkK0olUh1MWc8txkG74ye+OYF1YKTpSNJC9w3zhH6oO
 7UCpZxiGQzXI+G4ie+N/4BT447ybEOj4QJCpy6DWTSAJci9ARoQTcQg3p7Ug+jLj7m2E
 UiptkvaqkWyhaKrVCuCCZFMd97CIqRHI8Vyarboa3U70zcY0uVbBM5NE/s9wdiNqhoiw
 pJrsM6kzyFb1+7tZVaqXzKMIQ5n3Et6RAqZ3dfXkq+kvcO9E/m96zOiNx3esIo2DxT7e
 2UyedhICWvp6ZiHEeNxwtuDRg+12o8sacthWtGUb2+IPjsdueZUh1ym+lJcbKPGk8vjg
 R1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ipb1oAgBpsVkyVJgMH88juv5xGMCsNxuM8ef88OlKis=;
 b=SRYpOQbyFJn/cEUfEph1LdEaU8dJcmebvZbeDFVSNBDLsOinuwVcvNgGGx+TqLz0wX
 fObQGVz3sgnArSPrCeNTAios2vop+VwCgeHQpS4rrU9LYW/XgAZKLcYMv5nYxR9bUZEX
 DcZqTMo/3c4YjH+L1k6yJ9hVLiX3CJRL6TI1PEEzNpVxx835avKBKg27Vwa/IEV9gUQ2
 YCMbLB7RJ0oMTDH0E5axPbK/bCQN1gazJtflrqB+xDuNq3DiNqCn0CAGhi/YnwIEW2xO
 LukCMgRyXMWVykSt+urL2K6da+CZO8+g3b/RXlPE2LdNSPBNgQoEgfXJhsWzZQiXtuwu
 FaJw==
X-Gm-Message-State: AOAM531FWycjSWvyCP0p3FtxCgz+ya4yVqdtZUSLKcCtvbUll3kQW1Yy
 zjcoSJ824zNmjjRdmQr5b2g+dDw7AfU=
X-Google-Smtp-Source: ABdhPJwHZ8MfRAg30crtYW4+GbsH3SfNb2hMVt6nejCYs9hEolI+462PgQeiuKC9PSvvRuynXK89IA==
X-Received: by 2002:a17:90a:36a4:: with SMTP id
 t33mr3569935pjb.152.1596199906484; 
 Fri, 31 Jul 2020 05:51:46 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id v11sm9733646pgs.22.2020.07.31.05.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 05:51:45 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] accel/tcg: interrupt/exception handling uses
 bql_interrupt flag
Date: Fri, 31 Jul 2020 08:51:27 -0400
Message-Id: <20200731125127.30866-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731125127.30866-1-robert.foley@linaro.org>
References: <20200731125127.30866-1-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, cota@braap.org, pbonzini@redhat.com,
 peter.puhov@linaro.org, alex.bennee@linaro.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change removes the implied BQL from the cpu_handle_interrupt,
and cpu_handle_exception paths. We can now select per-arch if
the BQL is needed or not by using the bql_interrupt flag.
By default, the core code holds the BQL.
One benefit of this change is that it leaves it up to the arch
to make the change to remove BQL when it makes sense.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cpu-exec.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 80d0e649b2..cde27ee0bf 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -517,9 +517,13 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 #else
         if (replay_exception()) {
             CPUClass *cc = CPU_GET_CLASS(cpu);
-            qemu_mutex_lock_iothread();
+            if (cc->bql_interrupt) {
+                qemu_mutex_lock_iothread();
+            }
             cc->do_interrupt(cpu);
-            qemu_mutex_unlock_iothread();
+            if (cc->bql_interrupt) {
+                qemu_mutex_unlock_iothread();
+            }
             cpu->exception_index = -1;
 
             if (unlikely(cpu->singlestep_enabled)) {
@@ -558,7 +562,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(cpu_interrupt_request(cpu))) {
         int interrupt_request;
 
-        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
         interrupt_request = cpu_interrupt_request(cpu);
         if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
             /* Mask out external interrupts for this step. */
@@ -567,7 +571,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         if (interrupt_request & CPU_INTERRUPT_DEBUG) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
             cpu->exception_index = EXCP_DEBUG;
-            qemu_mutex_unlock_iothread();
+            cpu_mutex_unlock(cpu);
             return true;
         }
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
@@ -577,13 +581,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
             cpu_halted_set(cpu, 1);
             cpu->exception_index = EXCP_HLT;
-            qemu_mutex_unlock_iothread();
+            cpu_mutex_unlock(cpu);
             return true;
         }
 #if defined(TARGET_I386)
         else if (interrupt_request & CPU_INTERRUPT_INIT) {
             X86CPU *x86_cpu = X86_CPU(cpu);
             CPUArchState *env = &x86_cpu->env;
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             replay_interrupt();
             cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
             do_cpu_init(x86_cpu);
@@ -595,7 +601,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         else if (interrupt_request & CPU_INTERRUPT_RESET) {
             replay_interrupt();
             cpu_reset(cpu);
-            qemu_mutex_unlock_iothread();
+            cpu_mutex_unlock(cpu);
             return true;
         }
 #endif
@@ -604,7 +610,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
            True when it is, and we should restart on a new TB,
            and via longjmp via cpu_loop_exit.  */
         else {
+            cpu_mutex_unlock(cpu);
+            if (cc->bql_interrupt) {
+                qemu_mutex_lock_iothread();
+            }
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
+                if (cc->bql_interrupt) {
+                    qemu_mutex_unlock_iothread();
+                }
+                cpu_mutex_lock(cpu);
                 replay_interrupt();
                 /*
                  * After processing the interrupt, ensure an EXCP_DEBUG is
@@ -614,6 +628,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 cpu->exception_index =
                     (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
                 *last_tb = NULL;
+            } else {
+                if (cc->bql_interrupt) {
+                    qemu_mutex_unlock_iothread();
+                }
+                cpu_mutex_lock(cpu);
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
              * reload the 'interrupt_request' value */
@@ -627,7 +646,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         }
 
         /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
-        qemu_mutex_unlock_iothread();
+        cpu_mutex_unlock(cpu);
     }
 
     /* Finally, check if we need to exit to the main loop.  */
@@ -691,7 +710,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 #endif
 }
-
 /* main execution loop */
 
 int cpu_exec(CPUState *cpu)
-- 
2.17.1


