Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF01C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964AC2077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964AC2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLAs-0002L7-RA
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSL02-0003jQ-7R
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzw-0002zR-9f
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:26 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41317)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzv-0002yK-UV
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:20 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8onW-1hp8OK3Fmo-015qup; Wed, 06 Nov 2019 14:05:15 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/13] linux-user: Rename cpu_clone_regs to
 cpu_clone_regs_child
Date: Wed,  6 Nov 2019 14:04:53 +0100
Message-Id: <20191106130456.6176-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FXfcdPTd2hzC6VOsshb9jMT9yfOwVzfr9gIeb6tPyS5XZbhFj8i
 E6s1uG8HUp5pnGPe10DVMBV/BbcCWS0n0e2NhwXHT5F5oHYCm0vBMG0294vIa9jFWNi9iDc
 v1GFXtd7Cw2icEP9RoQplG9yPxHn9RWDWec2NDxrN7O/7bzB7w5mIvHmq7DDXApSf6XUd3K
 yK+HMCuVIoAlPpAXvOPHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GCjazRY0YoM=:GIaohiAJWF4AotEm0AI7Hq
 mv/4JR6FGcOExAfGrOGuMHayxL/qAR5XRCTH9qRmyuSrIi6hYZL+f39D79gRizRWBwP1cxM8N
 lvktmtcqeUkmS9Ia/8m2IhZckJUeuMr4WhEJpEaiXJeB9jRlHyALjNzggb640iEu/OyaqtmLT
 11U51XTBp5YbkGKyBS4kOqhxdBH4zsBgl4ytA5zZrUX/g/LnRE/ufC9kEbLnMd6m689Raq3D8
 JQjhCAuXgjJwpZUEt6HapNuwf7Hg+fLnb54t/mJtBwrXom4bIWRrfHQxazKC8f5Jv0NuUgyC3
 uhBsEBv2xILlPmVBPvORe1P7HovOf4mEMskroDVnyclxRSldinOn5fsJC8l/AYLBme5aOu2Rp
 EbsqtuWmS4yfIH85It6FkHyqsFl751Cf+d+oFw+1rZIzEVLLE3nqLLupRUAqNvIfDU9iJ5s4a
 fXtpoXX3ymqYC/AlZ5dEbLHj8/qgcWvVutK0RTOo0kxvy9yNlSnmp0hQDroLBz/F+1AscL+sq
 hglE+3RKOoGU9tpL735a71LV9ka2MyBTcaw+HgBoGkh1tW1ccxgVnoWn8RUB4qz7fqJTC86o6
 dKDLms1Kvq+75xCR33qGzOQ2STMDLZU82V+ih1znPm1J1Ui0Q68Gh7afJ4hTfj9rgh87UvgNE
 l/eJLchkqBccVBPCO68WpL/n7O6o7lb16gnERtLx8bitlwvMevH+K8m4qFX2vGrx0TYE9jNoK
 I+rCPAwwY21YtrK7IY0lmJShHGe1w5i4/TLx3WeIaFJU8lNrOXG1sUe3TJ/vC9/gaEczSRmJ+
 Jp6C81c5ssxzkidhfIL+uVyp/0TOqlnw/5NWXAGXqDZT4++LY/lqNuDgdiY7yxW1yxITP0fa/
 A9sc9Drc2yvhX8FTt+rA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We will need a target-specific hook for adjusting registers
in the parent during clone.  To avoid confusion, rename the
one we have to make it clear it affects the child.

At the same time, pass in the flags from the clone syscall.
We will need them for correct behaviour for Sparc.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191106113318.10226-10-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/target_cpu.h    | 3 ++-
 linux-user/alpha/target_cpu.h      | 3 ++-
 linux-user/arm/target_cpu.h        | 3 ++-
 linux-user/cris/target_cpu.h       | 3 ++-
 linux-user/hppa/target_cpu.h       | 3 ++-
 linux-user/i386/target_cpu.h       | 3 ++-
 linux-user/m68k/target_cpu.h       | 3 ++-
 linux-user/microblaze/target_cpu.h | 3 ++-
 linux-user/mips/target_cpu.h       | 3 ++-
 linux-user/nios2/target_cpu.h      | 3 ++-
 linux-user/openrisc/target_cpu.h   | 4 +++-
 linux-user/ppc/target_cpu.h        | 3 ++-
 linux-user/riscv/target_cpu.h      | 3 ++-
 linux-user/s390x/target_cpu.h      | 3 ++-
 linux-user/sh4/target_cpu.h        | 3 ++-
 linux-user/sparc/target_cpu.h      | 3 ++-
 linux-user/syscall.c               | 4 ++--
 linux-user/tilegx/target_cpu.h     | 3 ++-
 linux-user/xtensa/target_cpu.h     | 4 +++-
 19 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index a021c95fa418..cd012e0dc1c8 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef AARCH64_TARGET_CPU_H
 #define AARCH64_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->xregs[31] = newsp;
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index ac4d255ae752..37ba00cf41d1 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef ALPHA_TARGET_CPU_H
 #define ALPHA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUAlphaState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->ir[IR_SP] = newsp;
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 3f79356a07fc..6e2ba8ad4b8e 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -41,7 +41,8 @@ static inline unsigned long arm_max_reserved_va(CPUState *cs)
 }
 #define MAX_RESERVED_VA  arm_max_reserved_va
 
-static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[13] = newsp;
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index 23093439790c..eacc4d8d13e9 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef CRIS_TARGET_CPU_H
 #define CRIS_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUCRISState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[14] = newsp;
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 1c539bdbd6e9..f25077079088 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef HPPA_TARGET_CPU_H
 #define HPPA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->gr[30] = newsp;
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index ece04d096675..1fadbf57c367 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef I386_TARGET_CPU_H
 #define I386_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUX86State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUX86State *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[R_ESP] = newsp;
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index bc7446fbafdd..57b647bc0753 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -21,7 +21,8 @@
 #ifndef M68K_TARGET_CPU_H
 #define M68K_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUM68KState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUM68KState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->aregs[7] = newsp;
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index 73e139938cc6..e9bc0fce6547 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef MICROBLAZE_TARGET_CPU_H
 #define MICROBLAZE_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUMBState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUMBState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[R_SP] = newsp;
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 02cf5eeff7c2..8601f712e086 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef MIPS_TARGET_CPU_H
 #define MIPS_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUMIPSState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUMIPSState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->active_tc.gpr[29] = newsp;
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index 5596c05c9c0f..fe5de7a9e3c7 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef NIOS2_TARGET_CPU_H
 #define NIOS2_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUNios2State *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[R_SP] = newsp;
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index 32ff135089e0..309cf3eeb73e 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -20,7 +20,9 @@
 #ifndef OPENRISC_TARGET_CPU_H
 #define OPENRISC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUOpenRISCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUOpenRISCState *env,
+                                        target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         cpu_set_gpr(env, 1, newsp);
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index c4641834e794..028b28312c51 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef PPC_TARGET_CPU_H
 #define PPC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUPPCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUPPCState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->gpr[1] = newsp;
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 90f9a4171ee7..26dcafab1c77 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -1,7 +1,8 @@
 #ifndef RISCV_TARGET_CPU_H
 #define RISCV_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->gpr[xSP] = newsp;
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index aa181ceaee83..0b19e42f758b 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef S390X_TARGET_CPU_H
 #define S390X_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUS390XState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUS390XState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[15] = newsp;
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index b0be9a2c1bb0..857af43ee3aa 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef SH4_TARGET_CPU_H
 #define SH4_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUSH4State *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUSH4State *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->gregs[15] = newsp;
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index b30fbc72c43b..029b0fc5475a 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -20,7 +20,8 @@
 #ifndef SPARC_TARGET_CPU_H
 #define SPARC_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUSPARCState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regwptr[22] = newsp;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 247883292ce5..245ed315c834 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5820,7 +5820,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         /* we create a new CPU instance. */
         new_env = cpu_copy(env);
         /* Init regs that differ from the parent.  */
-        cpu_clone_regs(new_env, newsp);
+        cpu_clone_regs_child(new_env, newsp, flags);
         new_cpu = env_cpu(new_env);
         new_cpu->opaque = ts;
         ts->bprm = parent_ts->bprm;
@@ -5899,7 +5899,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ret = fork();
         if (ret == 0) {
             /* Child Process.  */
-            cpu_clone_regs(env, newsp);
+            cpu_clone_regs_child(env, newsp, flags);
             fork_end(1);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index d1aa5824f292..0523dc414cc5 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -19,7 +19,8 @@
 #ifndef TILEGX_TARGET_CPU_H
 #define TILEGX_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUTLGState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUTLGState *env, target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[TILEGX_R_SP] = newsp;
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index e31efe3ea090..84f67d469ec0 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -4,7 +4,9 @@
 #ifndef XTENSA_TARGET_CPU_H
 #define XTENSA_TARGET_CPU_H
 
-static inline void cpu_clone_regs(CPUXtensaState *env, target_ulong newsp)
+static inline void cpu_clone_regs_child(CPUXtensaState *env,
+                                        target_ulong newsp,
+                                        unsigned flags)
 {
     if (newsp) {
         env->regs[1] = newsp;
-- 
2.21.0


