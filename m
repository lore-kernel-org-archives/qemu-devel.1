Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1666F20658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj7IU0pV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1666F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Ssg-0005CL-8y
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sqw-000302-Pl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:45679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sqs-0001xJ-Et
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:26 -0400
Received: by mail-pf1-x432.google.com with SMTP id f193so12103557pfa.12
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b36LToa8onboShJxNgr5dtEez/ahyl1YS9GUjcjS5dw=;
 b=yj7IU0pVpDgjXCaaQ2W7EM9QAeAgM0LVS+5aLtXkYydFI0pfs8D1d79ExlErngQvIk
 if2nBttd6FGKtxjRgi93elMvGvUvd1KCPONZRrA+TduuSHfRHPzOZCHoNpRwCWhsTGyR
 3PbTCBCcACHwF7QroasUjuxBWhwsMXKU9UJPX5avk4ctJWgMrEhbNL5XNCxTMR0erZPE
 Dzoj9bQv1eqmeghcNU86diDecU/kmWNjXN/at4seFQLPf7ZM2IHBMEEbT7LbvLH8VvS8
 Lv1EaiapVLB0/n55noHyt0ZyGtMLpDA4ISrmZPEYy7mnPtvWV6Vp9mhJzqL4JfJwcu1V
 e7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b36LToa8onboShJxNgr5dtEez/ahyl1YS9GUjcjS5dw=;
 b=o8sf3OuSFbulVTAbkqjW6VzOm8Qt91r0AoFU17KDmHf3S3CrB7kdeYXSnYszDhaJv0
 9/Y1MHlSrL6U22kjaJnuaMraCCWnUh0O+gbk7oAvj7i2YJtOVVLLfH9ZZe23MBiwszN8
 Y6BJIcZN5Sn6q7yNuk5E3bh6r4prmOc92bB451C6Wt0yzKF1vCIFJs+y/O/vw2wcC9kn
 +TTGg/oXFa/9v2PJscyzQa8h1u3i7dHC8OvvuFo69J1lpXYW/fybAGC6qgbp1rxqgq7o
 +3OioMISfoFMD/FHZUEehjyDqreUsv/ulbk4x6iMfH2n5gEke+xSSWqoaXiqqtwxzrEb
 O9Eg==
X-Gm-Message-State: AOAM531Pa/PiP+FoDImWfDzOC+R6RN1uxC2UhBJ7eZLvvsNHXnpQ9JXA
 58CX/spM0jTgynN68fsdfjlhrZJqj92Q+2q4
X-Google-Smtp-Source: ABdhPJySqzms+YW3n5yMjw1ask2U+sAVdA0GegWJ8e3S1hzoJDlwU2b2m6yxjMTkoRbr/7vQ04syOA==
X-Received: by 2002:a63:4c57:: with SMTP id m23mr16973935pgl.77.1597861820774; 
 Wed, 19 Aug 2020 11:30:20 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id p20sm220766pjg.44.2020.08.19.11.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 11:30:19 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] target/arm: add ARMCPUClass->do_interrupt_locked
Date: Wed, 19 Aug 2020 14:28:51 -0400
Message-Id: <20200819182856.4893-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819182856.4893-1-robert.foley@linaro.org>
References: <20200819182856.4893-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, peter.puhov@linaro.org,
 pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding ->do_interrupt_locked to ARMCPUClass is preparation for
pushing the BQL down into the per-arch implementation of ->do_interrupt.

This is needed since ARM's *_cpu_exec_interrupt calls to *_do_interrupt.
With the push down of the BQL into *_cpu_exec_interrupt and
*_do_interrupt, *_cpu_exec_interrupt will call to ->do_interrupt
with lock held.  Since ->do_interrupt also has the lock, we need a way
to allow cpu_exec_interrupt to call do_interrupt with lock held.
This patch solves this issue of *_cpu_exec_interrupt needing
to call do_interrupt with lock held.

This patch is part of a series of transitions to move the
BQL down into the do_interrupt per arch functions.  This set of
transitions is needed to maintain bisectability.

This approach was suggested by Paolo Bonzini.
For reference, here are two key posts in the discussion, explaining
the reasoning/benefits of this approach.
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/arm/cpu-qom.h | 3 +++
 target/arm/cpu.c     | 5 +++--
 target/arm/cpu_tcg.c | 5 +++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 56395b87f6..264280194c 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -48,6 +48,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info);
  * ARMCPUClass:
  * @parent_realize: The parent class' realize handler.
  * @parent_reset: The parent class' reset handler.
+ * @do_interrupt_locked: Handler for interrupts (lock already held).
  *
  * An ARM CPU model.
  */
@@ -59,6 +60,8 @@ typedef struct ARMCPUClass {
     const ARMCPUInfo *info;
     DeviceRealize parent_realize;
     DeviceReset parent_reset;
+
+    void (*do_interrupt_locked)(CPUState *cpu);
 } ARMCPUClass;
 
 typedef struct ARMCPU ARMCPU;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 46c1d92080..d15b459399 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -526,7 +526,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(cs);
     CPUARMState *env = cs->env_ptr;
     uint32_t cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
@@ -573,7 +573,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
  found:
     cs->exception_index = excp_idx;
     env->exception.target_el = target_el;
-    cc->do_interrupt(cs);
+    acc->do_interrupt_locked(cs);
     return true;
 }
 
@@ -2225,6 +2225,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->do_interrupt = arm_cpu_do_interrupt_locked;
+    acc->do_interrupt_locked = arm_cpu_do_interrupt_locked;
     cc->get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug;
     cc->asidx_from_attrs = arm_asidx_from_attrs;
     cc->vmsd = &vmstate_arm_cpu;
diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
index 2fc7a29340..caf0d54c2c 100644
--- a/target/arm/cpu_tcg.c
+++ b/target/arm/cpu_tcg.c
@@ -17,7 +17,7 @@
 
 static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(cs);
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     bool ret = false;
@@ -33,7 +33,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & CPU_INTERRUPT_HARD
         && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
         cs->exception_index = EXCP_IRQ;
-        cc->do_interrupt(cs);
+        acc->do_interrupt_locked(cs);
         ret = true;
     }
     return ret;
@@ -602,6 +602,7 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
     acc->info = data;
 #ifndef CONFIG_USER_ONLY
     cc->do_interrupt = arm_v7m_cpu_do_interrupt_locked;
+    acc->do_interrupt_locked = arm_v7m_cpu_do_interrupt_locked;
 #endif
 
     cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
-- 
2.17.1


