Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D556C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5288520738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vobbvPS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5288520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgID-0005n2-GN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3O-0007cB-Qv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:26 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3K-0001iW-It
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:25 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mt12so119517pjb.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lL2TV9fvxAuHwerQiahLV44CD3Djc67HSq2e2+fPjhU=;
 b=vobbvPS8Lr8CuEEcFozCZKfdB0nFRULGiyoAIkT2Ccu0Ca3mOrZ8F9XzOfTa6hFxNN
 +uqkHKb4BKBk9ebjE0opYYWH3NrMRLN0XEAF22dURu8xC8fR2JLgMvpfp/dkm7wJcisq
 +jiI1qVXxyKPWRPYqWSr6Rzi6O/hyK/VHSwWYMD4pP7qYOo9m8O9uiy3Vf8lpxgSqV2O
 kXynAbDB9dTaY9Bf+BUMec+FPeEx1sTMqnQeYjY672I6fiDRg0kv7Ai75XBSY0GgFFnm
 JoqKc2dqecsLhdLarCrHMkKC3b3zdYSpqvqdVnO2NiN0r8IfPXtDrB5SYg1upuIiFGrO
 wIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lL2TV9fvxAuHwerQiahLV44CD3Djc67HSq2e2+fPjhU=;
 b=YqgMFpIFiLDlszHAZfv4GOejKiNoZZDVASjxIkjI6BKO6/AZwM1aJ4Zzo3aB2JNoQ4
 oD4QNsEO0lZgsCXIwXcfPuyymj61OEMsitVrCj3DWRBsPMhHljw989eIfPPYjWDmZ+fX
 rw9fqc3HMotw4Aq/7Kc6/kXQ3WffK1z+Ql877ngwNZKLJ4HVsMDTf5oS+w/1jfNo2SE9
 L4JNNqhKmGEtXsuHDrit8vd7yCWCS9yGohx/K9lmIhXplxqj1wQQGYNWqFMuiEQ1rPQp
 093gs9v2UUBCyimL+e0KirQxn1f+4smyo6Ze8JucYUIu6BATdPZsU8lj3i+HPdt5SB3n
 2NTg==
X-Gm-Message-State: AOAM532yH7tmJ+Yo5ShhgxTxn4mmm5rLS3wP2KHQRsX0K2BJFXmZFibK
 EJ0Lr22y4wQfrJc5OhbLAJM1trp+OryeAw==
X-Google-Smtp-Source: ABdhPJxLwHZKodMPz4KsyvNNxODqt7+U8jKrCxlOze4y/mVT02JeAYIItC2wxXirotz7JIhV3LuZ9A==
X-Received: by 2002:a17:90a:d34b:: with SMTP id
 i11mr3104435pjx.125.1598389220666; 
 Tue, 25 Aug 2020 14:00:20 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/77] target/microblaze: Remove helper_debug and env->debug
Date: Tue, 25 Aug 2020 13:58:55 -0700
Message-Id: <20200825205950.730499-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: edgar.iglesias@gmail.com
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


