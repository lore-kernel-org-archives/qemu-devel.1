Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C013AC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D0C20675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTjGItOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D0C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSMY-0000va-DV
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:24:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHq-0005PW-5h
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHo-0007Js-IK
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:02 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHo-0007Ih-Ah
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id t22so5715991pgi.10
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rXfSo9Gy+xV7gUMCOu/4nLM098jgkgLPcgtIQzZJ9xs=;
	b=JTjGItOnSMUIYHEEx5LZcLs7Twjd7TMSj3wNUZ+d60cBs4W8wptlXMzptMdWdOtF4n
	ZuoNaPGwTftRP4fsqpL9HToIITohaOSgoWS/xtKJXmGB6tq/Ank+ff+G+OB4bpZ28ebS
	ayaDIgVw/SM6EDqCX2Rs5dLA0cF+kVAnS6uSTgaQ6YNzbPya4DLUJFrtNrJqZ3/xw7xg
	9fMDZDIXTdDeP2eLN3NdzvHgHS/VMWW3WRpJGThf+Ar3mO1LDGl6ZgSh0WzCed9tJd0V
	uXpBPIKwgc62LVdaC4AWght+LNHYtS69c4A9pbDvhLKuEIA+R0SVONZj2Jo/+eOvI1eb
	rxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=rXfSo9Gy+xV7gUMCOu/4nLM098jgkgLPcgtIQzZJ9xs=;
	b=H/N/7ZQniFA8ZlgR15JMWN02AZxaUoaFevFNyvdk/c6Xv7Zp2Fg5VM6wPp4H0dMLU+
	eL1DwamIsJjAVlkfHbShG5d2alMjUTGqejAY4ZmLOK1jn2IOt5wJQGavHr+/ZGkDh6N9
	f1SXJLKXLtpoi8gvho6cvyGB5l4ODjZFFmRS9aNL0pmpxrxnQ73Fr+A6GZ3PbyjyMpnD
	hjLLyb9Z3srMvm3FRnuKdrgcEpsdbMUI/2Pqi8Tba1iqguhg64f5MygGj6DZApOUKYRP
	HJJPy2u4BGdcww6l0e7Fobvk3pRYJH/416QISPYpSjS7gKYzrOoGCMlbuwtIVBOZlfiZ
	69Aw==
X-Gm-Message-State: APjAAAWk8gASfPMPYbnJstcKJDDrc8xbs0jEWJPBZUoRKaZtd20s/50z
	40rUdIabpDigGlk9o3Ti9vTJKWnt/Dc=
X-Google-Smtp-Source: APXvYqwTh9zthvi2YP2sgcRlrl12LpIWwGDP+nVwqZOIdUWsa3pQ30xvbksYCzmUnS6gH4vZiUyOPA==
X-Received: by 2002:a65:60d2:: with SMTP id r18mr24719608pgv.217.1558297198793;
	Sun, 19 May 2019 13:19:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.19.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:19:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:42 -0700
Message-Id: <20190519201953.20161-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 02/13] linux-user: Rename cpu_clone_regs to
 cpu_clone_regs_child
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

We will need a target-specific hook for adjusting registers
in the parent during clone.  To avoid confusion, rename the
one we have to make it clear it affects the child.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_cpu.h    | 2 +-
 linux-user/alpha/target_cpu.h      | 2 +-
 linux-user/arm/target_cpu.h        | 2 +-
 linux-user/cris/target_cpu.h       | 2 +-
 linux-user/hppa/target_cpu.h       | 2 +-
 linux-user/i386/target_cpu.h       | 2 +-
 linux-user/m68k/target_cpu.h       | 2 +-
 linux-user/microblaze/target_cpu.h | 2 +-
 linux-user/mips/target_cpu.h       | 2 +-
 linux-user/nios2/target_cpu.h      | 2 +-
 linux-user/openrisc/target_cpu.h   | 3 ++-
 linux-user/ppc/target_cpu.h        | 2 +-
 linux-user/riscv/target_cpu.h      | 2 +-
 linux-user/s390x/target_cpu.h      | 2 +-
 linux-user/sh4/target_cpu.h        | 2 +-
 linux-user/sparc/target_cpu.h      | 2 +-
 linux-user/tilegx/target_cpu.h     | 2 +-
 linux-user/xtensa/target_cpu.h     | 3 ++-
 linux-user/syscall.c               | 4 ++--
 19 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index a021c95fa4..abde35b104 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef AARCH64_TARGET_CPU_H
 #define AARCH64_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp)
 {
     if (newsp) {
         env->xregs[31] = newsp;
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index ac4d255ae7..dc02f2234c 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef ALPHA_TARGET_CPU_H
 #define ALPHA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUAlphaState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp)
 {
     if (newsp) {
         env->ir[IR_SP] = newsp;
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 8a3764919a..d35c997287 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -23,7 +23,7 @@
    See validate_guest_space in linux-user/elfload.c.  */
 #define MAX_RESERVED_VA  0xffff0000ul
 
-static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp)
 {
     if (newsp) {
         env->regs[13] = newsp;
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index 2309343979..9c847caaef 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -20,7 +20,7 @@
 #ifndef CRIS_TARGET_CPU_H
 #define CRIS_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUCRISState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp)
 {
     if (newsp) {
         env->regs[14] = newsp;
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 1c539bdbd6..b98e5a1cfe 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef HPPA_TARGET_CPU_H
 #define HPPA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp)
 {
     if (newsp) {
         env->gr[30] = newsp;
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index ece04d0966..e1c9e03490 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -20,7 +20,7 @@
 #ifndef I386_TARGET_CPU_H
 #define I386_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUX86State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUX86State *env, target_ulong newsp)
 {
     if (newsp) {
         env->regs[R_ESP] = newsp;
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index 7a26f3c3fc..7637a98cab 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -21,7 +21,7 @@
 #ifndef M68K_TARGET_CPU_H
 #define M68K_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUM68KState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUM68KState *env, target_ulong newsp)
 {
     if (newsp) {
         env->aregs[7] = newsp;
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index 73e139938c..526b80d54d 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef MICROBLAZE_TARGET_CPU_H
 #define MICROBLAZE_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUMBState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUMBState *env, target_ulong newsp)
 {
     if (newsp) {
         env->regs[R_SP] = newsp;
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 02cf5eeff7..c42660b047 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef MIPS_TARGET_CPU_H
 #define MIPS_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUMIPSState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUMIPSState *env, target_ulong newsp)
 {
     if (newsp) {
         env->active_tc.gpr[29] = newsp;
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index 5596c05c9c..bec2ea79c4 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -20,7 +20,7 @@
 #ifndef NIOS2_TARGET_CPU_H
 #define NIOS2_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUNios2State *env, target_ulong newsp)
 {
     if (newsp) {
         env->regs[R_SP] = newsp;
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index 32ff135089..d163ba2e26 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef OPENRISC_TARGET_CPU_H
 #define OPENRISC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUOpenRISCState *env,
+                                        target_ulong newsp)
 {
     if (newsp) {
         cpu_set_gpr(env, 1, newsp);
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index c4641834e7..34decf3876 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef PPC_TARGET_CPU_H
 #define PPC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUPPCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUPPCState *env, target_ulong newsp)
 {
     if (newsp) {
         env->gpr[1] = newsp;
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 90f9a4171e..d92153851c 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -1,7 +1,7 @@
 #ifndef RISCV_TARGET_CPU_H
 #define RISCV_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp)
 {
     if (newsp) {
         env->gpr[xSP] = newsp;
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index aa181ceaee..e0baa98e75 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef S390X_TARGET_CPU_H
 #define S390X_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUS390XState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUS390XState *env, target_ulong newsp)
 {
     if (newsp) {
         env->regs[15] = newsp;
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index b0be9a2c1b..854955aa5a 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef SH4_TARGET_CPU_H
 #define SH4_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUSH4State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUSH4State *env, target_ulong newsp)
 {
     if (newsp) {
         env->gregs[15] = newsp;
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 1ffc0ae9f2..8511fc3f6f 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -20,7 +20,7 @@
 #ifndef SPARC_TARGET_CPU_H
 #define SPARC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUSPARCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp)
 {
     if (newsp) {
         env->regwptr[22] = newsp;
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index d1aa5824f2..dfca8d9598 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -19,7 +19,7 @@
 #ifndef TILEGX_TARGET_CPU_H
 #define TILEGX_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUTLGState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUTLGState *env, target_ulong newsp)
 {
     if (newsp) {
         env->regs[TILEGX_R_SP] = newsp;
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index e31efe3ea0..f436b160c4 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -4,7 +4,8 @@
 #ifndef XTENSA_TARGET_CPU_H
 #define XTENSA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUXtensaState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUXtensaState *env,
+                                        target_ulong newsp)
 {
     if (newsp) {
         env->regs[1] = newsp;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f5ff6f5dc8..b9127a9601 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5534,7 +5534,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         /* we create a new CPU instance. */
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
-        cpu_clone_regs(new_env, newsp);
+        cpu_clone_regs_child(new_env, newsp);
         new_cpu = ENV_GET_CPU(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
@@ -5612,7 +5612,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ret = fork();
         if (ret == 0) {
             /* Child Process.  */
-            cpu_clone_regs(env, newsp);
+            cpu_clone_regs_child(env, newsp);
             fork_end(1);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
-- 
2.17.1


