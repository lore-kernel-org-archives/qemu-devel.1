Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24493C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E277E206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSGx6BGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E277E206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfK5-0002uV-3X
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEJ-00089i-3p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEH-00054D-5X
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:46 -0400
Received: by mail-pf1-x443.google.com with SMTP id d22so737828pfn.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v5cOPITpAORhIDF2PS7d5r/AWbCGGzSRkZP2Jde8Lx4=;
 b=uSGx6BGpp5j/Yn57I1X47HsttAD19+mYAj7sfjJCjnRtz04XHE1ts2cDpRipt72Wi5
 l+WTGU0aE1Wp4GRrqFX8Y5hLbOzOXPlG//l2b2YJ3imJb15AC2+RH1xfntglZzmfgycq
 X7H7c1APmGDouqfQ7cY/aL2FDXQiUyoAMwAIjFyWe8++KTfVTu3xu8tawoCS6h6n1QD6
 kP9FpiySnpHSwrLa8THQIF4ryZ0ekHsTGjzBv+Y70HBCdb05P4bAAD1xtunRZv1NSs4X
 SCpWqxl2whKZjsEGSVL8uBlNtv3jBeZfqZlmMzLhhuNx9FYQUhbDjrWdz1iA1CYRD7ou
 DGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v5cOPITpAORhIDF2PS7d5r/AWbCGGzSRkZP2Jde8Lx4=;
 b=mYuner+8NYBcufgJC+IN4USH87YZPfyD9g2iwgQSYXGmNHcbiweeXPEbyj+Hw2KN29
 NrHSwR/cZ09N66F1xRbOvYN2KGVOFw1RwXUqJkD8hprbg88yhr65wOaBndkP1XUFfYI0
 I9lKK8TITqntMb0m+rz566f6eQJ+cDN9wMGP6jueByYKa4AQux/Habylvmc9UN1DKg0m
 guF4Xbx8RD8p5/hbeIv9rkkbmZ+Nozf/gC7UdYS2cxfZU0RAv38SNDA7QPUL01S5RVE/
 jvTXYc9lqFa/vk+/M4u5oF4vBB/q0SvTEUNFLvpR0qu2tmxGxr9sRIGJ84NNEXqfQEFV
 sv3w==
X-Gm-Message-State: AOAM5321+SF0GnPQfOe03HyIp9iovQCFgjvYoLla0UGyU4iiczDD7oW+
 2npWXYYTK15g9vukG3RI1V+ZGNhk/ydyHw==
X-Google-Smtp-Source: ABdhPJzbWnIzaDFr4LMXjI9e18NOec5M8AxdT2wv9jtMuDSfCZb1cv1FYJmMJ6bwKcsqorKuZJgsAw==
X-Received: by 2002:a65:6545:: with SMTP id a5mr1454011pgw.43.1598624383339;
 Fri, 28 Aug 2020 07:19:43 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/76] target/microblaze: Split out FSR from env->sregs
Date: Fri, 28 Aug 2020 07:18:22 -0700
Message-Id: <20200828141929.77854-10-richard.henderson@linaro.org>
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


