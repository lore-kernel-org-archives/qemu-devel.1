Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C229C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5231120675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPIP/XBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5231120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52941 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSNu-00028Z-EY
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:26:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHr-0005QA-Bw
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHp-0007LN-N3
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHp-0007KQ-FI
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:01 -0400
Received: by mail-pf1-x443.google.com with SMTP id y11so6141176pfm.13
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zw4bkjQURlIrIACI3Vx6Yhusz3QTf2Vu+wCw/S+ioOk=;
	b=ZPIP/XBVHL14gTd8DzkcGXeFHymuRsa1XzJo91HgZevi7HJ/izJQ/BsEm6C/iWa1qg
	TzAWe1I04qKgz2Q1eWu69NaRwaZ8LiG5j82XRwsGrshqCa0hAAsCIrVSJnz1v2aVZq/l
	LnP0PSOMsll0mZDJIBP/zjsJ6qdbJYVvKzaNR3jFaGfY5OB9DgV5K/z0nnqLWIpdX74b
	G2JI4jQmC5JS3NGHzhw13l+vzJgAKiSKVWvr5yADt6ioiBO78cGAhK6Zoef0SbYjUxH5
	aK6mHJAfpwI7579BsQUJ1/YxyXmLefh7XclYm3SqC/shUtr6kZXsl1B8lAM62wpoGxEs
	5kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zw4bkjQURlIrIACI3Vx6Yhusz3QTf2Vu+wCw/S+ioOk=;
	b=lbPg4GRUxPcacgYvnA5W5WZJOHfxY90jAdtAxADGfSOFmz1vQZcgujaXqhWQN3Qoyw
	//3EMeHQPuYi55mJ0BzrePxCsWn3ronWFBgGJG976oYQTXMLYq+JJYCezcPg4n2TrW+p
	Mt6TCBdM0IjesRSb5y/rNjFEKJh/yngBLqS5t2XW1NQw74DimtcOmr2jGH0JdeOovstX
	pWe8Ht65znQ/wJ4bf5p1oFgBD1hDCIc3z0MJuqHBGyArstbLT8XLVvB7HS8Pc6X/6vMb
	lXDGSZDcXmE/2qCk9K76+aihuPFkwz09+1v3nPhk4Co2EiiQrSCp49v0npOBwH6b5rZ6
	WOMw==
X-Gm-Message-State: APjAAAUXKS6xfQKpRvtrEOoZA9tAik4vAIlOrwP0hvhJbjICDB2xPHLz
	nv+rboCCQg/U/envznDeXH/pvShJctA=
X-Google-Smtp-Source: APXvYqxNXS7dkNPKfjWljNe+YNRBXhQS27Oiq7Ui/jxNyGTxkAM3gtZUFFQXPNEt2eUlqLxkC85zDA==
X-Received: by 2002:a63:7413:: with SMTP id p19mr69066270pgc.259.1558297200058;
	Sun, 19 May 2019 13:20:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.19.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:19:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:43 -0700
Message-Id: <20190519201953.20161-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 03/13] linux-user: Introduce
 cpu_clone_regs_parent
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an empty inline function for each target, and invoke it
from the proper places.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_cpu.h    | 4 ++++
 linux-user/alpha/target_cpu.h      | 4 ++++
 linux-user/arm/target_cpu.h        | 4 ++++
 linux-user/cris/target_cpu.h       | 4 ++++
 linux-user/hppa/target_cpu.h       | 4 ++++
 linux-user/i386/target_cpu.h       | 4 ++++
 linux-user/m68k/target_cpu.h       | 4 ++++
 linux-user/microblaze/target_cpu.h | 4 ++++
 linux-user/mips/target_cpu.h       | 4 ++++
 linux-user/nios2/target_cpu.h      | 4 ++++
 linux-user/openrisc/target_cpu.h   | 4 ++++
 linux-user/ppc/target_cpu.h        | 4 ++++
 linux-user/riscv/target_cpu.h      | 4 ++++
 linux-user/s390x/target_cpu.h      | 4 ++++
 linux-user/sh4/target_cpu.h        | 4 ++++
 linux-user/sparc/target_cpu.h      | 4 ++++
 linux-user/tilegx/target_cpu.h     | 4 ++++
 linux-user/xtensa/target_cpu.h     | 4 ++++
 linux-user/syscall.c               | 2 ++
 19 files changed, 74 insertions(+)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index abde35b104..0182bfca07 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp)
     env->xregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUARMState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
 {
     /* Note that AArch64 Linux keeps the TLS pointer in TPIDR; this is
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index dc02f2234c..140a459f73 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp)
     env->ir[IR_A3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUAlphaState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
 {
     env->unique = newtls;
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index d35c997287..3e66d5b106 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -31,6 +31,10 @@ static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp)
     env->regs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUARMState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
 {
     if (access_secure_reg(env)) {
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index 9c847caaef..4da074b4fd 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp)
     env->regs[10] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUCRISState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUCRISState *env, target_ulong newtls)
 {
     env->pregs[PR_PID] = (env->pregs[PR_PID] & 0xff) | newtls;
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index b98e5a1cfe..6b323297af 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -31,6 +31,10 @@ static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp)
     env->iaoq_b = env->gr[31] + 4;
 }
 
+static inline void cpu_clone_regs_parent(CPUHPPAState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
 {
     env->cr[27] = newtls;
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index e1c9e03490..6dbb856c52 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUX86State *env, target_ulong newsp)
     env->regs[R_EAX] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUX86State *env)
+{
+}
+
 #if defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr);
 
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index 7637a98cab..f1a53cdee5 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUM68KState *env, target_ulong newsp)
     env->dregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUM68KState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
 {
     CPUState *cs = CPU(m68k_env_get_cpu(env));
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index 526b80d54d..5e285e9211 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUMBState *env, target_ulong newsp)
     env->regs[3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUMBState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUMBState *env, target_ulong newtls)
 {
     env->regs[21] = newtls;
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index c42660b047..d0e0b1bac0 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUMIPSState *env, target_ulong newsp)
     env->active_tc.gpr[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUMIPSState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
 {
     env->active_tc.CP0_UserLocal = newtls;
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index bec2ea79c4..01725ba004 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUNios2State *env, target_ulong newsp)
     env->regs[R_RET0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUNios2State *env)
+{
+}
+
 static inline void cpu_set_tls(CPUNios2State *env, target_ulong newtls)
 {
     /*
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index d163ba2e26..6586951c5b 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUOpenRISCState *env,
     cpu_set_gpr(env, 11, 0);
 }
 
+static inline void cpu_clone_regs_parent(CPUOpenRISCState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
 {
     cpu_set_gpr(env, 10, newtls);
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index 34decf3876..00c9f5eb86 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUPPCState *env, target_ulong newsp)
     env->gpr[3] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUPPCState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUPPCState *env, target_ulong newtls)
 {
 #if defined(TARGET_PPC64)
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index d92153851c..4ef1b23b4f 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -10,6 +10,10 @@ static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp)
     env->gpr[xA0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPURISCVState *env)
+{
+}
+
 static inline void cpu_set_tls(CPURISCVState *env, target_ulong newtls)
 {
     env->gpr[xTP] = newtls;
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index e0baa98e75..18e290ece8 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUS390XState *env, target_ulong newsp)
     env->regs[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUS390XState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
 {
     env->aregs[0] = newtls >> 32;
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index 854955aa5a..b0e4ab23a7 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUSH4State *env, target_ulong newsp)
     env->gregs[0] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUSH4State *env)
+{
+}
+
 static inline void cpu_set_tls(CPUSH4State *env, target_ulong newtls)
 {
   env->gbr = newtls;
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 8511fc3f6f..52c9d8c7db 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -36,6 +36,10 @@ static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp)
 #endif
 }
 
+static inline void cpu_clone_regs_parent(CPUSPARCState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
 {
     env->gregs[7] = newtls;
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index dfca8d9598..9577462821 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUTLGState *env, target_ulong newsp)
     env->regs[TILEGX_R_RE] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUTLGState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUTLGState *env, target_ulong newtls)
 {
     env->regs[TILEGX_R_TP] = newtls;
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index f436b160c4..42e66211cf 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -15,6 +15,10 @@ static inline void cpu_clone_regs_child(CPUXtensaState *env,
     env->regs[2] = 0;
 }
 
+static inline void cpu_clone_regs_parent(CPUXtensaState *env)
+{
+}
+
 static inline void cpu_set_tls(CPUXtensaState *env, target_ulong newtls)
 {
     env->uregs[THREADPTR] = newtls;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9127a9601..f960556bf8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5535,6 +5535,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
         cpu_clone_regs_child(new_env, newsp);
+        cpu_clone_regs_parent(env);
         new_cpu = ENV_GET_CPU(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
@@ -5630,6 +5631,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
             if (flags & CLONE_CHILD_CLEARTID)
                 ts->child_tidptr = child_tidptr;
         } else {
+            cpu_clone_regs_parent(env);
             fork_end(0);
         }
     }
-- 
2.17.1


