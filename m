Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3B5C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEB520665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaanKXrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEB520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAg8z-0007Td-VG
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg33-00070P-JX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg31-0001d8-Au
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id m8so8305016pfh.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3AKOFIW3VCEZ6h4ggmUpiB5wdoa5LhPs+jftJ9b2SfM=;
 b=IaanKXrCmMh3H59/7HKhL+NTg2x+i1oQ/SdB8jMjmQ7pDB0alzia1+N5Pjcfjd/g/Z
 PIk4wwS1s4/STGg6A+aroQ1+WyF4469MKp/711grmjB8Lv3CjwYcWXOuXhdZ5l7BKMB/
 TYlaQiE9cRoYLSggK+ZORZkYfG9p+r7iuc7MPJ9HoVogaO3cQT4muSxYdkb2civ5Af1Z
 Dw9MlkI3c9ew/OzZb8Iur0i8vQ3eJ6AH8Uo8x9OTV1DRrrqrqe1XiJEEQ1NrqjEorMIl
 PztLWKHhLRszKeA+sqJGRNNKmSXCYH35SRXID22wjhe8k4tkyyREAN7YBIp9aEgMm4lt
 o57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3AKOFIW3VCEZ6h4ggmUpiB5wdoa5LhPs+jftJ9b2SfM=;
 b=dQYWWRCcDcL5fM/YzFmtsk5lDgat4v8voDJ2rSVIFS6PPYKkByz1JeOxbNiVP7XJCp
 eNOCFNuRmaysnRBYTc2HngGb6w643AvmliR4bjBRivdhbBR3aXGl3DLVLoiLGjLfg4b+
 Mi+YMmLOlV4HlOYEm1OhyABmIhpU/p5n+eyZOBQZU3cBNhUmyrKdcMGz4E/fQ6nLCBWr
 OV/SbqttdxGc+7nhg+Nm5usvRFkX8iWxQYo8mtzNzxwwXhGAyeZfoPDTctXn/d5z8TmC
 017V2b6qLiN9B2Q06lB/YkAva70S7n9v7OUMe4h+WnitbEgLyFFKxeQAxG9rsDdiSRM7
 pk0A==
X-Gm-Message-State: AOAM5301NNfxYZjA9XGII4RrarUZRZG2kvvjOcXu36sUMDszNmrBVvHj
 5imzylXjb1Hf8Q1rAe8ikEHmkI86JujxDg==
X-Google-Smtp-Source: ABdhPJxy71saGP8dnmh78ZXRtiQWs/WrK3AmA5qqqytpYq/iBa+Q4XpyxgOucSCML4gFLbeDAvyn9Q==
X-Received: by 2002:a62:8f51:: with SMTP id n78mr9374812pfd.74.1598389201475; 
 Tue, 25 Aug 2020 14:00:01 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/77] target/microblaze: Split out EAR from env->sregs
Date: Tue, 25 Aug 2020 13:58:40 -0700
Message-Id: <20200825205950.730499-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 1 +
 target/microblaze/gdbstub.c   | 4 ++--
 target/microblaze/helper.c    | 6 +++---
 target/microblaze/op_helper.c | 8 ++++----
 target/microblaze/translate.c | 6 ++++--
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 36de61d9f9..c9035b410e 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -238,6 +238,7 @@ struct CPUMBState {
     uint32_t regs[32];
     uint64_t pc;
     uint64_t msr;
+    uint64_t ear;
     uint64_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index e4c4936a7a..e33a613efe 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -65,7 +65,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->msr;
         break;
     case GDB_EAR:
-        val = env->sregs[SR_EAR];
+        val = env->ear;
         break;
     case GDB_ESR:
         val = env->sregs[SR_ESR];
@@ -121,7 +121,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->msr = tmp;
         break;
     case GDB_EAR:
-        env->sregs[SR_EAR] = tmp;
+        env->ear = tmp;
         break;
     case GDB_ESR:
         env->sregs[SR_ESR] = tmp;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a18314540f..afe9634781 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -85,7 +85,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "mmu=%d miss v=%" VADDR_PRIx "\n",
                   mmu_idx, address);
 
-    env->sregs[SR_EAR] = address;
+    env->ear = address;
     switch (lu.err) {
     case ERR_PROT:
         env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 17 : 16;
@@ -145,7 +145,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             qemu_log_mask(CPU_LOG_INT,
                           "hw exception at pc=%" PRIx64 " ear=%" PRIx64 " "
                           "esr=%" PRIx64 " iflags=%x\n",
-                          env->pc, env->sregs[SR_EAR],
+                          env->pc, env->ear,
                           env->sregs[SR_ESR], env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->iflags &= ~(IMM_FLAG | D_FLAG);
@@ -188,7 +188,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             qemu_log_mask(CPU_LOG_INT,
                           "exception at pc=%" PRIx64 " ear=%" PRIx64 " "
                           "iflags=%x\n",
-                          env->pc, env->sregs[SR_EAR], env->iflags);
+                          env->pc, env->ear, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             env->iflags &= ~(IMM_FLAG | D_FLAG);
             env->pc = cpu->cfg.base_vectors + 0x20;
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 3668382d36..5bacd29663 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -78,7 +78,7 @@ void helper_debug(CPUMBState *env)
     qemu_log("PC=%" PRIx64 "\n", env->pc);
     qemu_log("rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
              "debug[%x] imm=%x iflags=%x\n",
-             env->msr, env->sregs[SR_ESR], env->sregs[SR_EAR],
+             env->msr, env->sregs[SR_ESR], env->ear,
              env->debug, env->imm, env->iflags);
     qemu_log("btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
@@ -431,7 +431,7 @@ void helper_memalign(CPUMBState *env, target_ulong addr,
                           "unaligned access addr=" TARGET_FMT_lx
                           " mask=%x, wr=%d dr=r%d\n",
                           addr, mask, wr, dr);
-            env->sregs[SR_EAR] = addr;
+            env->ear = addr;
             env->sregs[SR_ESR] = ESR_EC_UNALIGNED_DATA | (wr << 10) \
                                  | (dr & 31) << 5;
             if (mask == 3) {
@@ -450,7 +450,7 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
         qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
                       TARGET_FMT_lx " %x %x\n",
                       addr, env->slr, env->shr);
-        env->sregs[SR_EAR] = addr;
+        env->ear = addr;
         env->sregs[SR_ESR] = ESR_EC_STACKPROT;
         helper_raise_exception(env, EXCP_HW_EXCP);
     }
@@ -488,7 +488,7 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
         return;
     }
 
-    env->sregs[SR_EAR] = addr;
+    env->ear = addr;
     if (access_type == MMU_INST_FETCH) {
         if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
             env->sregs[SR_ESR] = ESR_EC_INSN_BUS;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9f2dcd82cd..62747b02f3 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1809,7 +1809,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
                  "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
                  "rbtr=%" PRIx64 "\n",
-                 env->msr, env->sregs[SR_ESR], env->sregs[SR_EAR],
+                 env->msr, env->sregs[SR_ESR], env->ear,
                  env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
                  env->sregs[SR_BTR]);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
@@ -1873,8 +1873,10 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, pc), "rpc");
     cpu_SR[SR_MSR] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, msr), "rmsr");
+    cpu_SR[SR_EAR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
 
-    for (i = SR_MSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
+    for (i = SR_EAR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
         cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
-- 
2.25.1


