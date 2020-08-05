Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3D8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CAA2084D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bhggd3ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CAA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Nzl-0005LL-7s
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyQ-0003g1-PK
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:10 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyP-0006Qg-3A
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:10 -0400
Received: by mail-pj1-x1041.google.com with SMTP id 2so5004791pjx.5
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Cw3yBPmbCJhRgO2KPinIHhC/h5HD4KqFIy/v1BHn1wY=;
 b=Bhggd3ulq5KNGlj9qpCKMy3jq1VNUUSfukireTCdkVoibCCIY95b4VB79aZSdtwkta
 IQphqe+Y8zJlBYWP8Ontj70VFnHgHVLEukWsgAuKbANEKPuqbW5Xem5jOq63FeGsImPt
 kwrE3vaqJfibhmU9on03gdaMugvoqLF8ndRAs0/cM26SsODxzlrEGKim/GyNwK0R0j1B
 Ts/yaV3Lk1BngITshCseGrUPK6qn3BWs7qNoWZk+BjIj2GMIGgUv/Bdl8b3B7N4s7C5l
 OZ43BmzdedN88BUQWPcyQZkp9gsgQbtfFcKfZrjXDqJYlqVOfvEtkjkb+TIqmoeAdSqM
 y5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Cw3yBPmbCJhRgO2KPinIHhC/h5HD4KqFIy/v1BHn1wY=;
 b=dNC+bfBlVPTPeslrjSYfM+ajoou9BS1UceSUQRWi55QebuLnArmuUBJMZQqSfX0OYE
 j4iktieSiWjLCwxI63wLrxQ7qQl86jGWErwMRN9HBakwfiJoEnenCyY4ufqakRcsAHtY
 euGe23wrGFAYMv1WgRz5NxjtqZ8BbbD2kMUCrEusf/6+hWJBLGG01W0EN2CEc7P0Z1aw
 uP56yUCGYggQ1JTTItm78wZXQjQ8vNHrJX+6x0UjbtKs3MuJjb9VnPa9P0bzrW96FW2x
 D2RpKWc/o0dEg8pjTzSl7OjVe7Jc5Skx88EYm3kLjvkvSlFTN1jxu/rTcYZNqT9AWmuV
 5Z1g==
X-Gm-Message-State: AOAM533l/aGQqOfmo6kJPm+LnYgDANlmA69qmT9B+nz6/+OTvYrqUN7v
 2A1vQv3ZiEhwtSF0tbJ/Kfn16jvWaSY=
X-Google-Smtp-Source: ABdhPJzWgLE7D3D0rQU2bBJ91EGPtUDBpTPkkmHseYYznGzyvdKE/6tsZY6NjjfGt3DZsQfwsyUGVw==
X-Received: by 2002:a17:902:834a:: with SMTP id
 z10mr4382242pln.5.1596651427371; 
 Wed, 05 Aug 2020 11:17:07 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:06 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/21] accel/tcg: Change interrupt/exception handling to
 remove implied BQL
Date: Wed,  5 Aug 2020 14:12:43 -0400
Message-Id: <20200805181303.7822-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 pbonzini@redhat.com, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change removes the implied BQL from the cpu_handle_interrupt,
and cpu_handle_exception paths. This BQL acquire is being pushed
down into the per arch implementation.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cpu-exec.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 80d0e649b2..8e2bfd97a1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -517,9 +517,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 #else
         if (replay_exception()) {
             CPUClass *cc = CPU_GET_CLASS(cpu);
-            qemu_mutex_lock_iothread();
             cc->do_interrupt(cpu);
-            qemu_mutex_unlock_iothread();
             cpu->exception_index = -1;
 
             if (unlikely(cpu->singlestep_enabled)) {
@@ -558,7 +556,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(cpu_interrupt_request(cpu))) {
         int interrupt_request;
 
-        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
         interrupt_request = cpu_interrupt_request(cpu);
         if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
             /* Mask out external interrupts for this step. */
@@ -567,7 +565,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         if (interrupt_request & CPU_INTERRUPT_DEBUG) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
             cpu->exception_index = EXCP_DEBUG;
-            qemu_mutex_unlock_iothread();
+            cpu_mutex_unlock(cpu);
             return true;
         }
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
@@ -577,13 +575,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
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
@@ -595,7 +595,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         else if (interrupt_request & CPU_INTERRUPT_RESET) {
             replay_interrupt();
             cpu_reset(cpu);
-            qemu_mutex_unlock_iothread();
+            cpu_mutex_unlock(cpu);
             return true;
         }
 #endif
@@ -604,7 +604,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
            True when it is, and we should restart on a new TB,
            and via longjmp via cpu_loop_exit.  */
         else {
+            cpu_mutex_unlock(cpu);
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
+                cpu_mutex_lock(cpu);
                 replay_interrupt();
                 /*
                  * After processing the interrupt, ensure an EXCP_DEBUG is
@@ -614,6 +616,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 cpu->exception_index =
                     (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
                 *last_tb = NULL;
+            } else {
+                cpu_mutex_lock(cpu);
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
              * reload the 'interrupt_request' value */
@@ -627,7 +631,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         }
 
         /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
-        qemu_mutex_unlock_iothread();
+        cpu_mutex_unlock(cpu);
     }
 
     /* Finally, check if we need to exit to the main loop.  */
@@ -691,7 +695,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 #endif
 }
-
 /* main execution loop */
 
 int cpu_exec(CPUState *cpu)
-- 
2.17.1


