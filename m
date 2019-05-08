Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1D3C04AAB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842B720675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ih/utePT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842B720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOABi-0002la-Kw
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:11:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6w-0007JK-4F
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6u-0006Pd-WF
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:02 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA6u-0006NL-QE
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:00 -0400
Received: by mail-pl1-x642.google.com with SMTP id a59so8962778pla.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=bsBvgkjLp0ir6Bx0e+Ug5zY9yKjm3Gk42ZlTiG9RLWY=;
	b=ih/utePTSB4D4lO+CyQSOod8ybvtckx3m4y2J0UhKokwdWnEdxo8mTauI5xLl1Gcps
	z91ZjYynzPk9mC/JCKHOibBgR0zZNvWWIViocWs4yJuUE34FYrdCoi+KH3QTtcSKAgiA
	Yj+NlmgbTk0DYh8rrOhL6LbVTovvYJzH83DQuVz+uhpM1oZyFZukecs4+jpKwdqBOvUa
	QXNQaKrIqShBrcS6JkGsbxf/Alnjj8G6z3BrWAqh0OxI9XLi22rb+HQPQb6+7kpzTeup
	RfEbfCb4/3Z/kAZZFf8zJrSz+4CI1IVdvXTsy8IqI7l672UW+yCr5s0X+Tu0dp50qbyS
	x/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=bsBvgkjLp0ir6Bx0e+Ug5zY9yKjm3Gk42ZlTiG9RLWY=;
	b=AYRhwdgczhiGVPUdfzYUgtjIBu8QJOEJ1Yh3nzcuQOtp7s/b+O4D+I9AWUKAAFXQib
	rlDpDWXVzL3+MviIqmcQwHHOqIbHVA/92uGopJRSqsMjKqXC4OJWZD2kyZlqShld5d6l
	/notvxFJlWB2Hjv7BhyLy1A2dFcX1y5eNuoSzZV4wR1cUY36wrgeBc/PZme9HavnYe2r
	6RMzKQyj3TDPQQgYSq1gnsW4mOtTSUiOxOiyywkOqGcxi7jySsESOUodFBlEp4ZsixDe
	PELlkD6WwJKIZuERH+GXeU5w5OaHnzAY7oVjlWxXKxtC0OaxSlk333VnfYTxNhOvbqeA
	7x2A==
X-Gm-Message-State: APjAAAVrb1hfixfgsIsYv5kNtM9qlpB8SsJmUn1QS6BiVM1oPwiMUcvZ
	sl4iHqZgsoyPKev52frxSjCn0g3AmGo=
X-Google-Smtp-Source: APXvYqzFDC/UiDGnW5c4zcxWe8M1ve6NCaSZ9q+2qbRA95REKf8IInB+HCh9CyDlieHtF/wM5thFoQ==
X-Received: by 2002:a17:902:9a03:: with SMTP id
	v3mr44946134plp.27.1557274019496; 
	Tue, 07 May 2019 17:06:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.06.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:06:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:14 -0700
Message-Id: <20190508000641.19090-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3 12/39] target/cris: Use env_cpu, env_archcpu
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
 target/cris/cpu.h          |  5 -----
 linux-user/cris/cpu_loop.c |  2 +-
 target/cris/mmu.c          |  3 +--
 target/cris/op_helper.c    | 10 +++-------
 target/cris/translate.c    |  2 +-
 5 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 883799b463..7f244ad545 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -183,11 +183,6 @@ struct CRISCPU {
     CPUCRISState env;
 };
 
-static inline CRISCPU *cris_env_get_cpu(CPUCRISState *env)
-{
-    return container_of(env, CRISCPU, env);
-}
-
 #define ENV_OFFSET offsetof(CRISCPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index 7ec36cb0b5..86e711108d 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUCRISState *env)
 {
-    CPUState *cs = CPU(cris_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr, ret;
     target_siginfo_t info;
     
diff --git a/target/cris/mmu.c b/target/cris/mmu.c
index 9cb73bbfec..2acbcfd1c7 100644
--- a/target/cris/mmu.c
+++ b/target/cris/mmu.c
@@ -288,7 +288,6 @@ static int cris_mmu_translate_page(struct cris_mmu_result *res,
 
 void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
 {
-    CRISCPU *cpu = cris_env_get_cpu(env);
     target_ulong vaddr;
     unsigned int idx;
     uint32_t lo, hi;
@@ -312,7 +311,7 @@ void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
                 if (tlb_v && !tlb_g && (tlb_pid == pid)) {
                     vaddr = tlb_vpn << TARGET_PAGE_BITS;
                     D_LOG("flush pid=%x vaddr=%x\n", pid, vaddr);
-                    tlb_flush_page(CPU(cpu), vaddr);
+                    tlb_flush_page(env_cpu(env), vaddr);
                 }
             }
         }
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index d4479167a5..0e323c1dd7 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -67,7 +67,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
 
 void helper_raise_exception(CPUCRISState *env, uint32_t index)
 {
-    CPUState *cs = CPU(cris_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit(cs);
@@ -86,8 +86,7 @@ void helper_tlb_flush_pid(CPUCRISState *env, uint32_t pid)
 void helper_spc_write(CPUCRISState *env, uint32_t new_spc)
 {
 #if !defined(CONFIG_USER_ONLY)
-    CRISCPU *cpu = cris_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     tlb_flush_page(cs, env->pregs[PR_SPC]);
     tlb_flush_page(cs, new_spc);
@@ -100,9 +99,6 @@ void helper_spc_write(CPUCRISState *env, uint32_t new_spc)
 
 void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
 {
-#if !defined(CONFIG_USER_ONLY)
-    CRISCPU *cpu = cris_env_get_cpu(env);
-#endif
     uint32_t srs;
     srs = env->pregs[PR_SRS];
     srs &= 3;
@@ -140,7 +136,7 @@ void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
             D_LOG("tlb flush vaddr=%x v=%d pc=%x\n",
                   vaddr, tlb_v, env->pc);
             if (tlb_v) {
-                tlb_flush_page(CPU(cpu), vaddr);
+                tlb_flush_page(env_cpu(env), vaddr);
             }
         }
     }
diff --git a/target/cris/translate.c b/target/cris/translate.c
index b005a5c20e..c0af9665fc 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3104,7 +3104,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
      * delayslot, like in real hw.
      */
     pc_start = tb->pc & ~1;
-    dc->cpu = cris_env_get_cpu(env);
+    dc->cpu = env_archcpu(env);
     dc->tb = tb;
 
     dc->is_jmp = DISAS_NEXT;
-- 
2.17.1


