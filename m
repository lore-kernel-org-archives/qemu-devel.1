Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D1FC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF02920675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ycep4bsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF02920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAIk-00007D-1a
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:19:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA71-0007R6-MX
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6z-0006dm-Dm
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:07 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA6z-0006Y9-13
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:05 -0400
Received: by mail-pf1-x442.google.com with SMTP id 13so9180822pfw.9
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=8034jzCVs92p3t1Cj9h6YTQMTvv/hneNRlejGBwNMBw=;
	b=Ycep4bswe7gF6An7iSgmJlG87ZhRohddalS1qpmYJVmP9GinhWluDSS6ic9OB490JG
	T2CXi/XvCy075KYcLsBjq1POXawaa86sbNHxxemqpYdeIh6RcbFOarq4Efgj8LiIWCDC
	e4i7O8mpb3VWB1jqBT8PAEdOqvSldCqNCirvK5HpgbcFKO6p2ocDMaBAGsWQmwP1WaGC
	RrU6Gqt/fIa+WIQlb3586d7aVvP0J776fwdgDNCnAH9FzR2AoIf5nt3nVFR3m6OUJqAY
	UnTimOGV6XMW0+5qGa4pD9gpD6Pf6MbnVJFzixVvxOeC/8U4h6b8+vjUqNyj01tb7yVu
	Xggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=8034jzCVs92p3t1Cj9h6YTQMTvv/hneNRlejGBwNMBw=;
	b=clOvq7VwfOmpYyWjnxUBu4pjRYciukXagzeY16vAtnRP8g1O9bx9BncJDfEPr6LEsr
	b2nX2huZbt4Tv4g3hrqRV9q+FeIweVeMbPmeDbiAFr3RTlrdTK+DUVaR3I2hPjZ8/PI9
	DplGstLV2sq4I8oq8azW3OGZZmPKNxXsD8EB3ADS0T9tUhQhY4dvpwBybiUpMUPxa46Z
	XTiykjkJBUmRqiTMTvd5PxZvqYVCMCIGaFrI/HqoWuxDShz/r1TolpNgwmzDkOhX8iKf
	ACi12c85hH85zR3FIuXFdDDK9Zl6Stu6J51ly43TNq/y+ua7JqOiIB+v3Wth8TwWV4N6
	++bw==
X-Gm-Message-State: APjAAAV0IlRl30tRerSqrnOyuiZHKrfG+zNPbj087HKHf8ANhLWV5rRu
	UzEhXsr+r9alceRhI5D1Dxxa0HwVa7o=
X-Google-Smtp-Source: APXvYqyv1yLpvrHgRqFqMhCPEMsjI+cMuQWGhRTALpzvx7P+3oIxkf+vizaVDcYBvzoVWQCqWibFwA==
X-Received: by 2002:a63:208:: with SMTP id 8mr35081976pgc.14.1557274022735;
	Tue, 07 May 2019 17:07:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:17 -0700
Message-Id: <20190508000641.19090-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 15/39] target/lm32: Use env_cpu, env_archcpu
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/lm32/cpu.h       |  5 -----
 target/lm32/helper.c    | 19 ++++++-------------
 target/lm32/op_helper.c |  6 +++---
 target/lm32/translate.c |  2 +-
 4 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index c6b252f90a..8e7b70a275 100644
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
index a039a993ff..674cbd7fe4 100644
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
index 234d55e056..ebff4c4518 100644
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


