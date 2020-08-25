Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82771C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4641D20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdYgUZe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4641D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAg9b-0000TI-HY
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg36-00075a-8n
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg33-0001fN-UG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id o13so7688493pgf.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v5cOPITpAORhIDF2PS7d5r/AWbCGGzSRkZP2Jde8Lx4=;
 b=pdYgUZe6lsB1pe/3gIVvPQOv5GC3Mqs9Pbpakba3p5aq/sFfxKlTowoIhVu5ZU2Dne
 rJeM0a2a7oZ5d5HI1lLYoMkbV3tYeAwoqF+/nA133px+lk/i59ApSc4kKUlRHh3sU0fB
 LBUucSGSRRW508uAh4vlrTkGYXXPrD0hIjO18vm3Vgd0lFz03Fd6BjdGZzmhZMk5AION
 5gJasLRTIKp59Y116jgacGKEsik+HFt+e/oN/CMRSq4ppPElhauEYm4Z3IABZ2Z2eMbD
 YEJOVN+Srbp0C2DcjhqH2e9TqqQkFZbq2sR1gqWlAKU6cFxcclUShdIgnMyjlSwJhEh7
 f5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v5cOPITpAORhIDF2PS7d5r/AWbCGGzSRkZP2Jde8Lx4=;
 b=J2zQ+ix7/d8Q5bSmGjFehTFKJnjcMGMUaYf/NkYh9KlRZEfhnfNRWmBQKbkZe88/Tm
 RctcRa7nvkEnu/9lsPYJxIG+bX3nclv16PurKKzeDp1Paq6zofJiwapFUcSb7ai7fexN
 aIufzBzZ1t0YDzS3MAMRKqz8DakHEaxhO2sLVUtD+m5x9rgT8uwt6Wg6VELGlDog9T73
 xR6TRbnGnx/DaXXncnwmfp5RtW/lTlsTFJHmNpu6q/FfBamglbvJtA0Gra3+FXi3LaoO
 6F5+yeWBeA9THIqe+dvh+LSo4QAFc/3dgfepTerS5kOBxspUAPn0P/wQnrVMl155zx75
 havg==
X-Gm-Message-State: AOAM530/lZ9mJ7bDzov4hrC8AjT3PtnSA5hEQ98YdJLGIpf2nKUQbdSH
 ZG34JmOwx4I0TJZcwIH8GgngcZGBgMmvGQ==
X-Google-Smtp-Source: ABdhPJwRp771g8bxWS9TE6h7ALsy/aBl8i8l5h6BKMIqAEBRq9XcrFqcn2qVGKvu1z9uFAaNm/uofg==
X-Received: by 2002:a62:7acb:: with SMTP id v194mr9400232pfc.302.1598389203993; 
 Tue, 25 Aug 2020 14:00:03 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/77] target/microblaze: Split out FSR from env->sregs
Date: Tue, 25 Aug 2020 13:58:42 -0700
Message-Id: <20200825205950.730499-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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

Continue eliminating the sregs array in favor of individual members.
Does not correct the width of FSR, yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h          | 1 +
 linux-user/microblaze/cpu_loop.c | 4 ++--
 target/microblaze/gdbstub.c      | 4 ++--
 target/microblaze/op_helper.c    | 8 ++++----
 target/microblaze/translate.c    | 6 ++++--
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 7d94af43ed..bcafef99b0 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -240,6 +240,7 @@ struct CPUMBState {
     uint64_t msr;
     uint64_t ear;
     uint64_t esr;
+    uint64_t fsr;
     uint64_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index c10e3e0261..da5e98b784 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -96,10 +96,10 @@ void cpu_loop(CPUMBState *env)
                 case ESR_EC_FPU:
                     info.si_signo = TARGET_SIGFPE;
                     info.si_errno = 0;
-                    if (env->sregs[SR_FSR] & FSR_IO) {
+                    if (env->fsr & FSR_IO) {
                         info.si_code = TARGET_FPE_FLTINV;
                     }
-                    if (env->sregs[SR_FSR] & FSR_DZ) {
+                    if (env->fsr & FSR_DZ) {
                         info.si_code = TARGET_FPE_FLTDIV;
                     }
                     info._sifields._sigfault._addr = 0;
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 05e22f233d..2634ce49fc 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -71,7 +71,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->esr;
         break;
     case GDB_FSR:
-        val = env->sregs[SR_FSR];
+        val = env->fsr;
         break;
     case GDB_BTR:
         val = env->sregs[SR_BTR];
@@ -127,7 +127,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->esr = tmp;
         break;
     case GDB_FSR:
-        env->sregs[SR_FSR] = tmp;
+        env->fsr = tmp;
         break;
     case GDB_BTR:
         env->sregs[SR_BTR] = tmp;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index f01cf9be64..ae57d45536 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -175,19 +175,19 @@ static void update_fpu_flags(CPUMBState *env, int flags)
     int raise = 0;
 
     if (flags & float_flag_invalid) {
-        env->sregs[SR_FSR] |= FSR_IO;
+        env->fsr |= FSR_IO;
         raise = 1;
     }
     if (flags & float_flag_divbyzero) {
-        env->sregs[SR_FSR] |= FSR_DZ;
+        env->fsr |= FSR_DZ;
         raise = 1;
     }
     if (flags & float_flag_overflow) {
-        env->sregs[SR_FSR] |= FSR_OF;
+        env->fsr |= FSR_OF;
         raise = 1;
     }
     if (flags & float_flag_underflow) {
-        env->sregs[SR_FSR] |= FSR_UF;
+        env->fsr |= FSR_UF;
         raise = 1;
     }
     if (raise
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 411c7b6e49..c58c49ea8f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1810,7 +1810,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
                  "rbtr=%" PRIx64 "\n",
                  env->msr, env->esr, env->ear,
-                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
+                 env->debug, env->imm, env->iflags, env->fsr,
                  env->sregs[SR_BTR]);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
                  "eip=%d ie=%d\n",
@@ -1877,8 +1877,10 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_SR[SR_ESR] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, esr), "resr");
+    cpu_SR[SR_FSR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
 
-    for (i = SR_ESR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
+    for (i = SR_FSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
         cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
-- 
2.25.1


