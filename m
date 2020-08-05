Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74069C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4385F2084D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6OLKc6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4385F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3O17-0008EV-GW
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyV-0003nU-RY
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:15 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:37183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NyT-0006SL-Mr
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:15 -0400
Received: by mail-pj1-x1032.google.com with SMTP id mw10so1077769pjb.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sqXifhGhW3rwKZgyTrB18rperPby0ZelegDudFYBpjk=;
 b=E6OLKc6NLdUktyGjvvVvhPNt5dAd9K5VQRSXtUcMKl+kVkBqql3YZXUFHfGm9CwV49
 0BxYt4B/IiLbsZrGOPugnRpO1hjDejeDdnrSqt5ffAnk3LYzDAsCjMI0kqzSeaB4rV1q
 V67KJyzCvZrxhGdhS/HkAK8xm2GF4NPxaambIFdpjLPltmbU/0WuYQCjWBB5Zsro2YXv
 j5KKlZ/hQMU4OPIdjCp1fUixfigBWLyfUiS5xwlWJQEYjojhnoYDBn7rmG+BxDvtzu3i
 wjCD5KujPRw9tULzug78tBoyX79u5g2bBKFj9TiFlXHpb2FLTCN+Fo3Uuj3JxKPZ3jPE
 4tFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sqXifhGhW3rwKZgyTrB18rperPby0ZelegDudFYBpjk=;
 b=Vj9ReKVA8FpuEo41qtAv2FkAzQy/PcLogSgzAsN7T+i4cG5t8ATRnwWL1+Z49Llz20
 PMBdK5VynYO3bbz/T7oZxC8ajxEEgGgHYxCQ1CzgGiOlNk9jC/0tTwr2vn0g3QcQ4nV2
 OWDD6gHz3fNWRtYxOU6GbdX5LeoNOnD01oCyXZQPJOO5swVNrOIgwMyGeof+GehK0UC0
 itbIERswEWOy0OQB1SXd7CCb0L5lwOCHDkPVUXsAZQmuVV2ZdmJMZQ2MAJUDSvI6DU11
 R2Sn4LDx95fswpHj7XSmtNIcdg1ja6/9f79Pcdt+gxaE2fR0RsbrOvwbDiMEUHxjvKSt
 x3mg==
X-Gm-Message-State: AOAM530Ocrq2zjwpuL+Kb45RWJWJs55OfVJNrNouLK2q2JRWsTbn/iSD
 khVQqoySwHPuxN+WMMqfOAisu+6WxY8=
X-Google-Smtp-Source: ABdhPJw8Zx4kakl8T5S0K51cLOjK1lVkwtVj4Y/d4ewFjHh3mHAlt8DrxlBzFrsMeQLjxBlP30n+8Q==
X-Received: by 2002:a17:90b:46d3:: with SMTP id
 jx19mr4582194pjb.158.1596651431914; 
 Wed, 05 Aug 2020 11:17:11 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:11 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 03/21] target/arm: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:12:45 -0400
Message-Id: <20200805181303.7822-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1032.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, robert.foley@linaro.org,
 cota@braap.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 peter.puhov@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a series of changes to remove the implied BQL
from the common code of cpu_handle_interrupt and
cpu_handle_exception.  As part of removing the implied BQL
from the common code, we are pushing the BQL holding
down into the per-arch implementation functions of
do_interrupt and cpu_exec_interrupt.

The purpose of this set of changes is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

This approach was suggested by Paolo Bonzini.
For reference, here are two key posts in the discussion, explaining
the reasoning/benefits of this approach.
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/arm/cpu.c    | 13 ++++++++++---
 target/arm/helper.c | 17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 401832ea95..b8544f0f0a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -528,12 +528,17 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
     CPUARMState *env = cs->env_ptr;
-    uint32_t cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
-    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
+    uint32_t cur_el;
+    bool secure;
+    uint64_t hcr_el2;
     uint32_t target_el;
     uint32_t excp_idx;
 
+    qemu_mutex_lock_iothread();
+    cur_el = arm_current_el(env);
+    secure = arm_is_secure(env);
+    hcr_el2 = arm_hcr_el2_eff(env);
+
     /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
 
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
@@ -568,12 +573,14 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             goto found;
         }
     }
+    qemu_mutex_unlock_iothread();
     return false;
 
  found:
     cs->exception_index = excp_idx;
     env->exception.target_el = target_el;
     cc->do_interrupt(cs);
+    qemu_mutex_unlock_iothread();
     return true;
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c5ea2c25ea..3a22d40598 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9759,7 +9759,13 @@ void arm_cpu_do_interrupt(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    unsigned int new_el = env->exception.target_el;
+    unsigned int new_el;
+
+    bool bql = !qemu_mutex_iothread_locked();
+    if (bql) {
+        qemu_mutex_lock_iothread();
+    }
+    new_el = env->exception.target_el;
 
     assert(!arm_feature(env, ARM_FEATURE_M));
 
@@ -9776,6 +9782,9 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
+        if (bql) {
+            qemu_mutex_unlock_iothread();
+        }
         return;
     }
 
@@ -9787,6 +9796,9 @@ void arm_cpu_do_interrupt(CPUState *cs)
 #ifdef CONFIG_TCG
     if (cs->exception_index == EXCP_SEMIHOST) {
         handle_semihosting(cs);
+        if (bql) {
+            qemu_mutex_unlock_iothread();
+        }
         return;
     }
 #endif
@@ -9808,6 +9820,9 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (!kvm_enabled()) {
         cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
     }
+    if (bql) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.17.1


