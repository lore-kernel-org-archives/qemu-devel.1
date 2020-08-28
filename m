Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC549C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767E520639
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2uppks3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767E520639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfSa-0003GL-K7
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEa-0000Sf-Nb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:04 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEY-00056q-Fn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:04 -0400
Received: by mail-pf1-x443.google.com with SMTP id c142so665850pfb.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lL2TV9fvxAuHwerQiahLV44CD3Djc67HSq2e2+fPjhU=;
 b=h2uppks3xwpxy0Qhl+Zy4+9XnKx24TIktbuQqHcf6HqhMTz/3UKyZSw5JE/AgmRAtJ
 gIE67Kdgf9GNjlpuT/lp4RKDjVJAQYnUjAWjo5ebClujJiifUMAfAmlT5+L4jvGFr7Ns
 wlzONaiDg0n/UXDVsgdlF1qHcaj7cO0Wo83jxwWb3OAp5Y3r9+rR4WIU09pQsDQfOePx
 Q6KUXZw2LQKY2J4kHACfH32SAJccXpjPdQ1m6BqFHltXy8rBgMWr6HSePGS7ddRYMxBC
 L4/Bc8Gg5aLXWU5rEvZFaoIwjE1Fq+HwIgfs5Nv44LvxuPKa4VLKNe+mjrRMEDcxgM9R
 qwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lL2TV9fvxAuHwerQiahLV44CD3Djc67HSq2e2+fPjhU=;
 b=njCYbhvnn9jw1m7+PZuzawpkpkIRJE8PcA1WO27rZCmxiShEKmt5/cjPW3aUPn6Xli
 FuXG/JfOl4MwiO0/mnOBG+h2DS/EjtEw+DqCRIhfRWGfe9AhXnTF1uGssdBJY+YTNrVd
 6KeERiO80w+WzYyL0vrYfY2Ns1cLd1Zp7X2zAl9Q1MhSuuINpOFsPD2s2XLU1/VUXKCO
 DP5mfioL+d9QfyUXQfk2KpyvczRn6HbRs/hBk9KPrbNHUX8R3H3CKeR8j6/fl1jTM7/Z
 oSg5ZqPWBbBMBDF80X/JiR3Cdm9+PtVpKhL+fxSaQKiJhKzTZSXw8NkQyFhVbBTFKaSf
 M09g==
X-Gm-Message-State: AOAM530iPzeHwd2J4Rzx1Uuxx4mUZMZP66qxPFyj9IuZOnXJNNgI6UlS
 QcS48xOm4e+h/9aVAuW4ciIcvr0aJJeVEA==
X-Google-Smtp-Source: ABdhPJwn2x+bbDIUYpU+7ZbNV9fFwyXpdPGNczjYslNn5aDu9eOCK/3uPiHEIVK39J8II3b1Q7c39A==
X-Received: by 2002:a63:50c:: with SMTP id 12mr1426504pgf.173.1598624400550;
 Fri, 28 Aug 2020 07:20:00 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/76] target/microblaze: Remove helper_debug and env->debug
Date: Fri, 28 Aug 2020 07:18:35 -0700
Message-Id: <20200828141929.77854-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is not used, and seems redundant with -d cpu.

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


