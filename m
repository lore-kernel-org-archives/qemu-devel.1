Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D1C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67855206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvLWtPYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67855206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmSC-00054a-Ja
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKL-0004NJ-Tu
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:37 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:35652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKJ-0005zZ-Tt
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:37 -0400
Received: by mail-pf1-x429.google.com with SMTP id o68so816367pfg.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=392OYT6LHbH2eWUoF1akQuoZ1nr82ScpvX4flFh2VTg=;
 b=QvLWtPYiDmT/JFY+iWf7kBEhWERphk0tnv7rZxz1sh1y8oYKyAMRbmM43MuLX8FZli
 ejpBvfklhRwz71cdg9LU0UxnxjKF5slDWRhpiS9+no/PdvxMdIsnY99NsQU5z0t2w90g
 u3wIYMWh7vKSrPL14mKvlj4lA4ngqwM/uCYj73aTls6vCrmmzqEY3/JlsbRv3MDwjXbz
 RFvQk7tDCvq1+y8GoweUGJqFReF8m4qd3nurI42NcyrCSPDIlh+jjMfGVwPphtsLuAFW
 ALOpFx4IYQcdpot5v52fS43dNL+9Ur6YaIcN15OIq6v+EfpCiRzQBnvH9QPbNuu/7LHU
 SUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=392OYT6LHbH2eWUoF1akQuoZ1nr82ScpvX4flFh2VTg=;
 b=klzPCJhRfZ56AZWuRSn0tMtgBP3F1Uk7RgOKQmXAH75sRdHq2QBslvm2KCLnerkoFq
 6UqVBIcrMG22C1EMLZztjX1VarFozmYm4fUlrUTXSgwzp3aBji+sdn8HsW+DLifV6oMR
 f31FnCu+mf1pA4W1978inlPolNWXkKtOADmbjfGfMaz9Em7R4O2Q9E8iiPYYLPl4QzJx
 /YNPwhHpBr87bBBC6v2hsky+sVsWoC6OkRiqO+Wa0PoTKNMAcslGAhEtY8IR5bbRjbld
 /xEg1/OceYi3SCYCgWLl8nCmTj6t7rcDZ1dQuNX7yrdUNK7aS/tvmQ9BaaeA7w/tPpJQ
 p4dQ==
X-Gm-Message-State: AOAM531solpkcPg3fBz6mBS7txQJN0WuKT5DEhxRuGlnYApvSG0WT0Yb
 5ZOWw9SDBntF9YR9EdCgMnMQdxGKD8tM/Q==
X-Google-Smtp-Source: ABdhPJzH4uWXzHQpeG7zx9Zzx678DofsA+zYdAYwQ4TkVCtfZHTjcMKpA6m+aFhMqrwAcAtvDVmHAw==
X-Received: by 2002:a65:670d:: with SMTP id u13mr1761993pgf.280.1598889993678; 
 Mon, 31 Aug 2020 09:06:33 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/76] target/microblaze: Remove helper_debug and env->debug
Date: Mon, 31 Aug 2020 09:05:07 -0700
Message-Id: <20200831160601.833692-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is not used, and seems redundant with -d cpu.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  1 -
 target/microblaze/helper.h    |  1 -
 target/microblaze/op_helper.c | 23 -----------------------
 target/microblaze/translate.c | 16 ++--------------
 4 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b88acba12b..7708c9a3d3 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -229,7 +229,6 @@ typedef struct CPUMBState CPUMBState;
 #define STREAM_NONBLOCK  (1 << 4)
 
 struct CPUMBState {
-    uint32_t debug;
     uint32_t btaken;
     uint32_t btarget;
     uint32_t bimm;
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 820711366d..9309142f8d 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,5 +1,4 @@
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
-DEF_HELPER_1(debug, void, env)
 DEF_HELPER_FLAGS_3(carry, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(cmp, i32, i32, i32)
 DEF_HELPER_2(cmpu, i32, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index dc2bec0c99..d79202c3f8 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -71,29 +71,6 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-void helper_debug(CPUMBState *env)
-{
-    int i;
-
-    qemu_log("PC=%08x\n", env->pc);
-    qemu_log("rmsr=%x resr=%x rear=%" PRIx64 " "
-             "debug[%x] imm=%x iflags=%x\n",
-             env->msr, env->esr, env->ear,
-             env->debug, env->imm, env->iflags);
-    qemu_log("btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
-             env->btaken, env->btarget,
-             (env->msr & MSR_UM) ? "user" : "kernel",
-             (env->msr & MSR_UMS) ? "user" : "kernel",
-             (bool)(env->msr & MSR_EIP),
-             (bool)(env->msr & MSR_IE));
-    for (i = 0; i < 32; i++) {
-        qemu_log("r%2.2d=%8.8x ", i, env->regs[i]);
-        if ((i + 1) % 4 == 0)
-            qemu_log("\n");
-    }
-    qemu_log("\n\n");
-}
-
 static inline uint32_t compute_carry(uint32_t a, uint32_t b, uint32_t cin)
 {
     uint32_t cout = 0;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9a00a78b8a..ecfa6b86a4 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -53,7 +53,6 @@
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
 #define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
-static TCGv_i32 env_debug;
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
@@ -1675,13 +1674,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         tcg_gen_insn_start(dc->pc);
         num_insns++;
 
-#if SIM_COMPAT
-        if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)) {
-            tcg_gen_movi_i32(cpu_pc, dc->pc);
-            gen_helper_debug();
-        }
-#endif
-
         if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
             gen_raise_exception_sync(dc, EXCP_DEBUG);
             /* The address covered by the breakpoint must be included in
@@ -1824,10 +1816,9 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IN: PC=%x %s\n",
                  env->pc, lookup_symbol(env->pc));
     qemu_fprintf(f, "rmsr=%x resr=%x rear=%" PRIx64 " "
-                 "debug=%x imm=%x iflags=%x fsr=%x rbtr=%x\n",
+                 "imm=%x iflags=%x fsr=%x rbtr=%x\n",
                  env->msr, env->esr, env->ear,
-                 env->debug, env->imm, env->iflags, env->fsr,
-                 env->btr);
+                 env->imm, env->iflags, env->fsr, env->btr);
     qemu_fprintf(f, "btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
                  env->btaken, env->btarget,
                  (env->msr & MSR_UM) ? "user" : "kernel",
@@ -1857,9 +1848,6 @@ void mb_tcg_init(void)
 {
     int i;
 
-    env_debug = tcg_global_mem_new_i32(cpu_env,
-                    offsetof(CPUMBState, debug),
-                    "debug0");
     env_iflags = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, iflags),
                     "iflags");
-- 
2.25.1


