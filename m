Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA1DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E673F206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVWIK+fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E673F206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmSA-0004z4-Vq
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKC-0003yq-Gf
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:28 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKA-0005xO-Df
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id bh1so3226485plb.12
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L9xfsBjzirj6XKVdMLPG8wUDAQP5YXeed0MwjLYymYM=;
 b=ZVWIK+fJFijSS8zFQtk50sLCYQrStpVuJGsVnmZ7WtHESnSGHX8bOgkk4nQxFf7RCC
 w9bf0+MG07hn1GpH6yKrAZw8fzdZf36rExmpqvZBHmrRF6Q24OP2ceUwFVUgNg3KOMxF
 RhEhFBr9w02GVzBkVTmVwZBteZlsHRvtoF3snRDDnf1DdsnyLVwJEAPQEpcorSubQKhl
 Kw/96u6NBRyUHd5KzTJgss6QUbKPVoWzRoCUKuKYQPhjTFarxrbRdeGMhhIst4jc/dCp
 8MDh1aJgOxDf2PIIwwDc9d7yq8uhYDocGjh9G6kTQ7UbqwwuV8dFZ1ZFKTRoR/UVjv7f
 yHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L9xfsBjzirj6XKVdMLPG8wUDAQP5YXeed0MwjLYymYM=;
 b=nxrV4btx2vi/r0W8FyliBnTSlZbL7XNnvNPH8Byw4/FXF8EV6ib0ZxItSJ8Z5hfvav
 trdp10+x9C/yaHI7uA7YPb633SDSHhr5DD3aH440oGz0BIitGNbo8WNLZuJZqXDeFA5a
 DNqpn7RxXYnYrrBJXe7WrQX/XIansTgABqJ+VYK7bwKHwkEdHiDUtvpPEzZ+Juv3P2ZR
 M8GjfIrgB55sgdeNjuLjxeWEoR9WoRle1TEFra+WHpcJG4ezo04Uv4BNP60ZODN2j+sU
 IhkA7ZCajt4nhK656rNvrEFjZBckaGN6ckttJ9mkfaFKjWzOdg1uaLDnvmSZgXwcTjHy
 5vXw==
X-Gm-Message-State: AOAM531ods1Pa4nrLfy/cnTAorJs8OHimdfWfQ9HK0KbM0h2ciMZZ3Iu
 jRrGoSty0Td8yZW/W6k/lNLmHw0fp5Z0qg==
X-Google-Smtp-Source: ABdhPJx0/5WNk4ru/d1WJXHe5w5K+EN96SMg34hXJTH/NCM4bhzJIH2VeRbfGfY0j/NqEr/NzqZZhw==
X-Received: by 2002:a17:902:720a:: with SMTP id
 ba10mr1548099plb.41.1598889984647; 
 Mon, 31 Aug 2020 09:06:24 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/76] target/microblaze: Fix width of ESR
Date: Mon, 31 Aug 2020 09:05:00 -0700
Message-Id: <20200831160601.833692-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

The exception status register is only 32-bits wide.
Do not use a 64-bit type to represent it.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h          |  2 +-
 linux-user/microblaze/cpu_loop.c |  2 +-
 target/microblaze/helper.c       |  2 +-
 target/microblaze/op_helper.c    |  2 +-
 target/microblaze/translate.c    | 16 ++++++++--------
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 019e5dfa26..aaac0c9a6c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -239,7 +239,7 @@ struct CPUMBState {
     uint32_t pc;
     uint32_t msr;
     uint64_t ear;
-    uint64_t esr;
+    uint32_t esr;
     uint64_t fsr;
     uint64_t btr;
     uint64_t edr;
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index da5e98b784..3de99ea311 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -106,7 +106,7 @@ void cpu_loop(CPUMBState *env)
                     queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
                     break;
                 default:
-                    fprintf(stderr, "Unhandled hw-exception: 0x%" PRIx64 "\n",
+                    fprintf(stderr, "Unhandled hw-exception: 0x%x\n",
                             env->esr & ESR_EC_MASK);
                     cpu_dump_state(cs, stderr, 0);
                     exit(EXIT_FAILURE);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index af79091fd2..b2373f6a23 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -144,7 +144,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
 
             qemu_log_mask(CPU_LOG_INT,
                           "hw exception at pc=%x ear=%" PRIx64 " "
-                          "esr=%" PRIx64 " iflags=%x\n",
+                          "esr=%x iflags=%x\n",
                           env->pc, env->ear,
                           env->esr, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index a7f6cb71f1..dc2bec0c99 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -76,7 +76,7 @@ void helper_debug(CPUMBState *env)
     int i;
 
     qemu_log("PC=%08x\n", env->pc);
-    qemu_log("rmsr=%x resr=%" PRIx64 " rear=%" PRIx64 " "
+    qemu_log("rmsr=%x resr=%x rear=%" PRIx64 " "
              "debug[%x] imm=%x iflags=%x\n",
              env->msr, env->esr, env->ear,
              env->debug, env->imm, env->iflags);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0e71e7ed01..f63aae6de9 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -58,7 +58,7 @@ static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
 static TCGv_i64 cpu_ear;
-static TCGv_i64 cpu_esr;
+static TCGv_i32 cpu_esr;
 static TCGv_i64 cpu_fsr;
 static TCGv_i64 cpu_btr;
 static TCGv_i64 cpu_edr;
@@ -182,7 +182,7 @@ static bool trap_illegal(DisasContext *dc, bool cond)
 {
     if (cond && (dc->tb_flags & MSR_EE_FLAG)
         && dc->cpu->cfg.illegal_opcode_exception) {
-        tcg_gen_movi_i64(cpu_esr, ESR_EC_ILLEGAL_OP);
+        tcg_gen_movi_i32(cpu_esr, ESR_EC_ILLEGAL_OP);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return cond;
@@ -198,7 +198,7 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     bool cond_user = cond && mem_index == MMU_USER_IDX;
 
     if (cond_user && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_i64(cpu_esr, ESR_EC_PRIVINSN);
+        tcg_gen_movi_i32(cpu_esr, ESR_EC_PRIVINSN);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return cond_user;
@@ -539,7 +539,7 @@ static void dec_msr(DisasContext *dc)
                 tcg_gen_extu_i32_i64(cpu_ear, cpu_R[dc->ra]);
                 break;
             case SR_ESR:
-                tcg_gen_extu_i32_i64(cpu_esr, cpu_R[dc->ra]);
+                tcg_gen_mov_i32(cpu_esr, cpu_R[dc->ra]);
                 break;
             case SR_FSR:
                 tcg_gen_extu_i32_i64(cpu_fsr, cpu_R[dc->ra]);
@@ -580,7 +580,7 @@ static void dec_msr(DisasContext *dc)
                 }
                 break;
             case SR_ESR:
-                tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_esr);
+                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_esr);
                 break;
             case SR_FSR:
                 tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_fsr);
@@ -1399,7 +1399,7 @@ static void dec_rts(DisasContext *dc)
 static int dec_check_fpuv2(DisasContext *dc)
 {
     if ((dc->cpu->cfg.use_fpu != 2) && (dc->tb_flags & MSR_EE_FLAG)) {
-        tcg_gen_movi_i64(cpu_esr, ESR_EC_FPU);
+        tcg_gen_movi_i32(cpu_esr, ESR_EC_FPU);
         t_gen_raise_exception(dc, EXCP_HW_EXCP);
     }
     return (dc->cpu->cfg.use_fpu == 2) ? PVR2_USE_FPU2_MASK : 0;
@@ -1797,7 +1797,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
     qemu_fprintf(f, "IN: PC=%x %s\n",
                  env->pc, lookup_symbol(env->pc));
-    qemu_fprintf(f, "rmsr=%x resr=%" PRIx64 " rear=%" PRIx64 " "
+    qemu_fprintf(f, "rmsr=%x resr=%x rear=%" PRIx64 " "
                  "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
                  "rbtr=%" PRIx64 "\n",
                  env->msr, env->esr, env->ear,
@@ -1866,7 +1866,7 @@ void mb_tcg_init(void)
     cpu_ear =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, esr), "resr");
+        tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
     cpu_fsr =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
     cpu_btr =
-- 
2.25.1


