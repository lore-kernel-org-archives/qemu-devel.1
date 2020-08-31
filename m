Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E3F2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+k2ihij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E3F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmUH-0008PU-Up
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKD-00042l-Tc
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:29 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:35329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKC-0005xr-3V
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id g6so31883pjl.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=haB+kLrfuYUnX1QRhCRrExdmXpWhe0msojEhc/6IfBE=;
 b=Q+k2ihijyVPVWPtuvJ/wbicUttguv37ghqruVnOwXXEtxnNXmRf5wXaDKsvQHxvGBe
 ggBi+2QAJo05a+m08rnNA+52jv0W9eFZHop8Z16zVPyM0v+SEcMmbtEMqALrnIFkF4X6
 G22xvi7F7ZxL7+3EeHaKS3VDF1klgkSZraNYkoLS5217Vped4dtCT8u8aHXa03aDaXTg
 EJ8nMng8b2KapHZEejCo3oOpDI1e7ePje6fY2nU6r5j7bg9q/vF9NQse3Uniw8EkYVZP
 itl9Nh5/tJtX4vY9FccPck8TeRhv8YklCCESEmGNfqhfeaQ0vqo3XpspcSr15H7HOmk0
 1eBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=haB+kLrfuYUnX1QRhCRrExdmXpWhe0msojEhc/6IfBE=;
 b=AMZ8XWnSFxx9peKn4OzBpbpOowoi3MRnq54+HAXZrU22es73nK60JjuZGyOwsNfiGw
 GQsjoR4M68d9erc9+1MzEK58KZUoxbsHVgg3FSa686bgqPol3RgkQ5krbAxjwYQkHCl8
 G5gcWfCjPw12K0uSYp0JB9zJtd4Ft3F22rGuAR+MJqRqDrPYn2YhVrEed12hijpQO4Ov
 jpkyPH23s80LVGpfyDaz023JQ+n2rv+cko3ZzFfx7kd6qRlt+RknkkeNH1VCCi3VJAJZ
 ehOFTYY1cjT34ODEalfOt5mvBZtlOwil7VaI112r58eW1nrIT9wnE/qY2pEiPNC9xv+i
 CXcQ==
X-Gm-Message-State: AOAM530R8jCdFCLz1/KL7LLJt3uFOd5iYpaWkvo4OwK1cR0hJbuHnEiU
 A7XXmH7rwL6e48jAEE2s5TCiHzt8Fxu3bg==
X-Google-Smtp-Source: ABdhPJwhlinzqDCn05V6qfoBPN4IjdnoDHzGGPipwmfLWfR70chETlQOHTweapVJDpW3R0tX6V6gkg==
X-Received: by 2002:a17:90a:7e15:: with SMTP id
 i21mr57021pjl.175.1598889986167; 
 Mon, 31 Aug 2020 09:06:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/76] target/microblaze: Fix width of FSR
Date: Mon, 31 Aug 2020 09:05:01 -0700
Message-Id: <20200831160601.833692-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

The exception status register is only 32-bits wide.  Do not use a
64-bit type to represent it.  Since cpu_fsr is only used during
MSR and MTR instructions, we can just as easily use an explicit
load and store, so eliminate the variable.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/translate.c | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index aaac0c9a6c..34177f9b28 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -240,7 +240,7 @@ struct CPUMBState {
     uint32_t msr;
     uint64_t ear;
     uint32_t esr;
-    uint64_t fsr;
+    uint32_t fsr;
     uint64_t btr;
     uint64_t edr;
     float_status fp_status;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index f63aae6de9..3fc2feda3d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -59,7 +59,6 @@ static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
 static TCGv_i64 cpu_ear;
 static TCGv_i32 cpu_esr;
-static TCGv_i64 cpu_fsr;
 static TCGv_i64 cpu_btr;
 static TCGv_i64 cpu_edr;
 static TCGv_i32 env_imm;
@@ -542,7 +541,8 @@ static void dec_msr(DisasContext *dc)
                 tcg_gen_mov_i32(cpu_esr, cpu_R[dc->ra]);
                 break;
             case SR_FSR:
-                tcg_gen_extu_i32_i64(cpu_fsr, cpu_R[dc->ra]);
+                tcg_gen_st_i32(cpu_R[dc->ra],
+                               cpu_env, offsetof(CPUMBState, fsr));
                 break;
             case SR_BTR:
                 tcg_gen_extu_i32_i64(cpu_btr, cpu_R[dc->ra]);
@@ -583,7 +583,8 @@ static void dec_msr(DisasContext *dc)
                 tcg_gen_mov_i32(cpu_R[dc->rd], cpu_esr);
                 break;
             case SR_FSR:
-                tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_fsr);
+                tcg_gen_ld_i32(cpu_R[dc->rd],
+                               cpu_env, offsetof(CPUMBState, fsr));
                 break;
             case SR_BTR:
                 tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_btr);
@@ -1798,7 +1799,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IN: PC=%x %s\n",
                  env->pc, lookup_symbol(env->pc));
     qemu_fprintf(f, "rmsr=%x resr=%x rear=%" PRIx64 " "
-                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
+                 "debug=%x imm=%x iflags=%x fsr=%x "
                  "rbtr=%" PRIx64 "\n",
                  env->msr, env->esr, env->ear,
                  env->debug, env->imm, env->iflags, env->fsr,
@@ -1867,8 +1868,6 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
-    cpu_fsr =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
     cpu_btr =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr), "rbtr");
     cpu_edr =
-- 
2.25.1


