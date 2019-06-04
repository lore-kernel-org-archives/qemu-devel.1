Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED40C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD609207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJobI6Gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD609207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGBN-0003RN-VZ
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:37:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8U-0001A2-IF
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8T-0004HB-BX
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:22 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8T-0004Gi-6l
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id b7so7252002otl.11
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=TkngbE1sypwzNw5h/VQnw7E5NCmBkYtpc+Uhii5AlrQ=;
	b=GJobI6GdOpbwAfuPyeym7Clk4GjX2Vx31FB2NEmuZkrJ4yQotula7TKIWsO1js+eLa
	RvTZcitUnsRXWZnDx1Q94lWUSffXSiTOrAs62PlKPVS7lQfHEd6Jk7kkgNo/7DpjCOrK
	T11ZJaibMe7d6g687A+HBCNFWpz2F1TdOn62ctDp/IbTL863fI5wleWcBt8fMdVabmMa
	g+ABxrQRFmC8fdKQXk6GQdZL/BabDw7Rv09lWHMDoabvmoWcnuTTg4ZuaFjcVslu91ox
	ekbYSXJaURvwExRIVN1iGhHYOD9QtnfOGv8X3m6Q3UgQheBm+GWo0L1aUNkkr6/U5FHp
	ZAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=TkngbE1sypwzNw5h/VQnw7E5NCmBkYtpc+Uhii5AlrQ=;
	b=ZzXUR8KkiXGoyqlk/ShpylAAbLT2oRpmYSNDTbmHKCq4Hk5TXO7RCgxzbB4DC0mdqp
	gQl/8kXuWmf2RL/SMBloSp9Emu0lUiP1s9A/N4gvwILR21FNgS02/hy/5a3fCVeOeSIz
	NFw8a+8H0Avpo7VyOV/x2+YXlEZgJiOzD7t5I1VK8VPTXg9mv/dIdBKnMwD4dK4o1ZBY
	hxxpz4h6CsyPUOWXkAvCcEohAw0vgVutzi7Z+5IzaLRE4N6wa950UEMR6GQMTji3zxUM
	EVFiL0h3y3CfNs8mNp7FvafDYB80L1vectO0TfjLgQGmOxrQCbm5qEHA9Kqs1cLDQMdT
	io9g==
X-Gm-Message-State: APjAAAVskf6cetX93UQ0KReFi8Jvib5Pue/Au9y1REzCrag+fgt7S19I
	XI2EqHY1KIv7iNgqyK1bt9SuthdhEseCYw==
X-Google-Smtp-Source: APXvYqz+ggfrvJU5LGP6ISY4hEOFbXI3NmR1elxd0XC5EiIqm7xgOCq19Mi48VADFpdAihet5ASwPg==
X-Received: by 2002:a9d:5e83:: with SMTP id f3mr1884658otl.90.1559680459991;
	Tue, 04 Jun 2019 13:34:19 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.18
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:27 -0500
Message-Id: <20190604203351.27778-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH v4 15/39] target/lm32: Use env_cpu, env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace lm32_env_get_cpu with env_archcpu.  The combination
CPU(lm32_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/lm32/cpu.h       |  5 -----
 target/lm32/helper.c    | 19 ++++++-------------
 target/lm32/op_helper.c |  6 +++---
 target/lm32/translate.c |  2 +-
 4 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index ad9452eb9f..7fb65fb4b6 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -195,11 +195,6 @@ struct LM32CPU {
     uint32_t features;
 };
 
-static inline LM32CPU *lm32_env_get_cpu(CPULM32State *env)
-{
-    return container_of(env, LM32CPU, env);
-}
-
 #define ENV_OFFSET offsetof(LM32CPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 8cd4840052..9f3b107474 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -58,28 +58,23 @@ hwaddr lm32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
 void lm32_breakpoint_insert(CPULM32State *env, int idx, target_ulong address)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
-
-    cpu_breakpoint_insert(CPU(cpu), address, BP_CPU,
+    cpu_breakpoint_insert(env_cpu(env), address, BP_CPU,
                           &env->cpu_breakpoint[idx]);
 }
 
 void lm32_breakpoint_remove(CPULM32State *env, int idx)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
-
     if (!env->cpu_breakpoint[idx]) {
         return;
     }
 
-    cpu_breakpoint_remove_by_ref(CPU(cpu), env->cpu_breakpoint[idx]);
+    cpu_breakpoint_remove_by_ref(env_cpu(env), env->cpu_breakpoint[idx]);
     env->cpu_breakpoint[idx] = NULL;
 }
 
 void lm32_watchpoint_insert(CPULM32State *env, int idx, target_ulong address,
                             lm32_wp_t wp_type)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
     int flags = 0;
 
     switch (wp_type) {
@@ -98,26 +93,24 @@ void lm32_watchpoint_insert(CPULM32State *env, int idx, target_ulong address,
     }
 
     if (flags != 0) {
-        cpu_watchpoint_insert(CPU(cpu), address, 1, flags,
-                &env->cpu_watchpoint[idx]);
+        cpu_watchpoint_insert(env_cpu(env), address, 1, flags,
+                              &env->cpu_watchpoint[idx]);
     }
 }
 
 void lm32_watchpoint_remove(CPULM32State *env, int idx)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
-
     if (!env->cpu_watchpoint[idx]) {
         return;
     }
 
-    cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[idx]);
+    cpu_watchpoint_remove_by_ref(env_cpu(env), env->cpu_watchpoint[idx]);
     env->cpu_watchpoint[idx] = NULL;
 }
 
 static bool check_watchpoints(CPULM32State *env)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
+    LM32CPU *cpu = env_archcpu(env);
     int i;
 
     for (i = 0; i < cpu->num_watchpoints; i++) {
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index be12b11b02..d184550a7b 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -16,7 +16,7 @@
 #if !defined(CONFIG_USER_ONLY)
 void raise_exception(CPULM32State *env, int index)
 {
-    CPUState *cs = CPU(lm32_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit(cs);
@@ -29,7 +29,7 @@ void HELPER(raise_exception)(CPULM32State *env, uint32_t index)
 
 void HELPER(hlt)(CPULM32State *env)
 {
-    CPUState *cs = CPU(lm32_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
@@ -39,7 +39,7 @@ void HELPER(hlt)(CPULM32State *env)
 void HELPER(ill)(CPULM32State *env)
 {
 #ifndef CONFIG_USER_ONLY
-    CPUState *cs = CPU(lm32_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     fprintf(stderr, "VM paused due to illegal instruction. "
             "Connect a debugger or switch to the monitor console "
             "to find out more.\n");
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index f0e0e7058e..b9f2f2c4a7 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1053,7 +1053,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPULM32State *env = cs->env_ptr;
-    LM32CPU *cpu = lm32_env_get_cpu(env);
+    LM32CPU *cpu = env_archcpu(env);
     struct DisasContext ctx, *dc = &ctx;
     uint32_t pc_start;
     uint32_t page_start;
-- 
2.17.1


