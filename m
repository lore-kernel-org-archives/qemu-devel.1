Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA2C5DF61
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E598821882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E598821882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3MW-0002Tf-SV
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Iu-00061Y-3M
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Is-0004id-45
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:43 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:58463)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3Ir-0004hi-R8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:42 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7hrw-1hosme3EeY-014i2F; Tue, 05 Nov 2019 19:11:31 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/13] linux-user/sparc: Begin using WREG constants in
 sparc/signal.c
Date: Tue,  5 Nov 2019 19:11:12 +0100
Message-Id: <20191105181119.26779-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V+fMpwnoYzTTgf1onjGYlxWDzf33P6dvVgBz4B8DooybvGI5e6H
 kNtP6lOsnSCYzt2nCPtIeanq3z7AiQkbbyZTCa3XF9yHAamfCIBqTlMmAbXROzBB+Lpma1A
 kPKTeOPHm9WL4ts2nbK7uYubWkalZQUtZ2NTGApHVlrGmIwFdaya/ZkuQWw6wbdR1C1WBgg
 L7I/qBbVS6KgOJi4kjRBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D7QOHjf8zck=:FbdQF/mLE9fqalFLbQjpy9
 c791meJtH/G+8Hf9mhbtXPiNUga+gUzc7PGdIw5Jbzeq5BA7cD67HCZ/3/y8YEQKOuS+vdo1z
 yVte88frT9YgIq1Y8wl4oMdLrqB0vGCTgB104nfvhm0W4hESs0txGT1iHU+MtlI4HKGJq43jH
 xQMJU0XIT1bhhSt3s7G3steB/DSELsxqXi8fk8+MoOLF2cANyUQ98J8weWBYvFYZuw8gi95h9
 UYjB1uBK03QR5AO3o2L7nl8aESc0qo4/XIAyRIqlZ1SZdHW9LusiDXwlQ6KYu5caE6Qz0f8YS
 dZxg3d3KjDcW1K1PymzJFF9BjLsw+eLRRgvQcppNoN1iH2mestefQAJJe2Uw18peoIwkfbSUq
 ZzR7pnQp8ysEb6AmjGj5OFCAp7sHE8+/N0pyGxf7+Pq5KOIcHB/yOkUG/A8CXvBDhDVaJ094A
 AnHffhuq9bJ2PBFBj9SlCCDlYGYBR8yQVGUPYBclw9m4X5mipMyyQTRfetWEPY1nlpki1kpBb
 n825AKw52uFyiCOTClj/SwcBswxUJE6EGklZ88d5kaX9EEN3xKMuiwVkfG4ZOixw9I1YbzPAp
 FuUUd/idOY2Tv5oI3cvOa+LDC8XjZZGyIxKkkGRTGEtXH8vZYKW30Ve85IU+T724ly8NhRgip
 vLCAYhw8M/wpVNe1EdxEXphvQ1Unhr0GUF3EY8rgR7162/aPwQ/1niTbM9B2lz2ugjp1dH3WL
 k4jS03/wZ/w213gIna4NGjmI1eq/B+c+Dts/ZvETUXW65QTCHiA3ZlzoRYbsUSCoNTmAl3A2h
 H8qykL6zqCQwU9DHDaN8H0jPDS7/b8P7AUmeIJ1En9720yKi+/hMxewIfpohFMI8qWCLXEwgg
 mlQbuOCQJmiS26jMmeJQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This is non-obvious because the UREG constants are in fact wrong.

s/UREG_I/WREG_O/g
s/UREG_O/WREG_I/g
s/UREG_L/WREG_L/g

These substitutions have identical integer values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-6-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 95 ++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 62 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index ead169fbaa26..a967e2db7307 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -104,19 +104,8 @@ struct target_rt_signal_frame {
     qemu_siginfo_fpu_t  fpu_state;
 };
 
-#define UREG_O0        16
-#define UREG_O6        22
-#define UREG_I0        0
-#define UREG_I1        1
-#define UREG_I2        2
-#define UREG_I3        3
-#define UREG_I4        4
-#define UREG_I5        5
-#define UREG_I6        6
-#define UREG_I7        7
-#define UREG_L0        8
-#define UREG_FP        UREG_I6
-#define UREG_SP        UREG_O6
+#define UREG_FP        WREG_O6
+#define UREG_SP        WREG_I6
 
 static inline abi_ulong get_sigframe(struct target_sigaction *sa, 
                                      CPUSPARCState *env,
@@ -159,30 +148,12 @@ setup___siginfo(__siginfo_t *si, CPUSPARCState *env, abi_ulong mask)
         __put_user(env->gregs[i], &si->si_regs.u_regs[i]);
     }
     for (i=0; i < 8; i++) {
-        __put_user(env->regwptr[UREG_I0 + i], &si->si_regs.u_regs[i+8]);
+        __put_user(env->regwptr[WREG_O0 + i], &si->si_regs.u_regs[i+8]);
     }
     __put_user(mask, &si->si_mask);
     return err;
 }
 
-#if 0
-static int
-setup_sigcontext(struct target_sigcontext *sc, /*struct _fpstate *fpstate,*/
-                 CPUSPARCState *env, unsigned long mask)
-{
-    int err = 0;
-
-    __put_user(mask, &sc->sigc_mask);
-    __put_user(env->regwptr[UREG_SP], &sc->sigc_sp);
-    __put_user(env->pc, &sc->sigc_pc);
-    __put_user(env->npc, &sc->sigc_npc);
-    __put_user(env->psr, &sc->sigc_psr);
-    __put_user(env->gregs[1], &sc->sigc_g1);
-    __put_user(env->regwptr[UREG_O0], &sc->sigc_o0);
-
-    return err;
-}
-#endif
 #define NF_ALIGNEDSZ  (((sizeof(struct target_signal_frame) + 7) & (~7)))
 
 void setup_frame(int sig, struct target_sigaction *ka,
@@ -221,20 +192,20 @@ void setup_frame(int sig, struct target_sigaction *ka,
     }
 
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + UREG_L0], &sf->ss.locals[i]);
+        __put_user(env->regwptr[i + WREG_L0], &sf->ss.locals[i]);
     }
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + UREG_I0], &sf->ss.ins[i]);
+        __put_user(env->regwptr[i + WREG_O0], &sf->ss.ins[i]);
     }
     if (err)
         goto sigsegv;
 
     /* 3. signal handler back-trampoline and parameters */
     env->regwptr[UREG_FP] = sf_addr;
-    env->regwptr[UREG_I0] = sig;
-    env->regwptr[UREG_I1] = sf_addr +
+    env->regwptr[WREG_O0] = sig;
+    env->regwptr[WREG_O1] = sf_addr +
             offsetof(struct target_signal_frame, info);
-    env->regwptr[UREG_I2] = sf_addr +
+    env->regwptr[WREG_O2] = sf_addr +
             offsetof(struct target_signal_frame, info);
 
     /* 4. signal handler */
@@ -242,11 +213,11 @@ void setup_frame(int sig, struct target_sigaction *ka,
     env->npc = (env->pc + 4);
     /* 5. return to kernel instructions */
     if (ka->ka_restorer) {
-        env->regwptr[UREG_I7] = ka->ka_restorer;
+        env->regwptr[WREG_O7] = ka->ka_restorer;
     } else {
         uint32_t val32;
 
-        env->regwptr[UREG_I7] = sf_addr +
+        env->regwptr[WREG_O7] = sf_addr +
                 offsetof(struct target_signal_frame, insns) - 2 * 4;
 
         /* mov __NR_sigreturn, %g1 */
@@ -316,7 +287,7 @@ long do_sigreturn(CPUSPARCState *env)
         __get_user(env->gregs[i], &sf->info.si_regs.u_regs[i]);
     }
     for (i=0; i < 8; i++) {
-        __get_user(env->regwptr[i + UREG_I0], &sf->info.si_regs.u_regs[i+8]);
+        __get_user(env->regwptr[i + WREG_O0], &sf->info.si_regs.u_regs[i+8]);
     }
 
     /* FIXME: implement FPU save/restore:
@@ -433,7 +404,7 @@ void sparc64_set_context(CPUSPARCState *env)
     abi_ulong fp, i7, w_addr;
     unsigned int i;
 
-    ucp_addr = env->regwptr[UREG_I0];
+    ucp_addr = env->regwptr[WREG_O0];
     if (!lock_user_struct(VERIFY_READ, ucp, ucp_addr, 1)) {
         goto do_sigsegv;
     }
@@ -443,7 +414,7 @@ void sparc64_set_context(CPUSPARCState *env)
     if ((pc | npc) & 3) {
         goto do_sigsegv;
     }
-    if (env->regwptr[UREG_I1]) {
+    if (env->regwptr[WREG_O1]) {
         target_sigset_t target_set;
         sigset_t set;
 
@@ -474,19 +445,19 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(env->gregs[5], (&(*grp)[SPARC_MC_G5]));
     __get_user(env->gregs[6], (&(*grp)[SPARC_MC_G6]));
     __get_user(env->gregs[7], (&(*grp)[SPARC_MC_G7]));
-    __get_user(env->regwptr[UREG_I0], (&(*grp)[SPARC_MC_O0]));
-    __get_user(env->regwptr[UREG_I1], (&(*grp)[SPARC_MC_O1]));
-    __get_user(env->regwptr[UREG_I2], (&(*grp)[SPARC_MC_O2]));
-    __get_user(env->regwptr[UREG_I3], (&(*grp)[SPARC_MC_O3]));
-    __get_user(env->regwptr[UREG_I4], (&(*grp)[SPARC_MC_O4]));
-    __get_user(env->regwptr[UREG_I5], (&(*grp)[SPARC_MC_O5]));
-    __get_user(env->regwptr[UREG_I6], (&(*grp)[SPARC_MC_O6]));
-    __get_user(env->regwptr[UREG_I7], (&(*grp)[SPARC_MC_O7]));
+    __get_user(env->regwptr[WREG_O0], (&(*grp)[SPARC_MC_O0]));
+    __get_user(env->regwptr[WREG_O1], (&(*grp)[SPARC_MC_O1]));
+    __get_user(env->regwptr[WREG_O2], (&(*grp)[SPARC_MC_O2]));
+    __get_user(env->regwptr[WREG_O3], (&(*grp)[SPARC_MC_O3]));
+    __get_user(env->regwptr[WREG_O4], (&(*grp)[SPARC_MC_O4]));
+    __get_user(env->regwptr[WREG_O5], (&(*grp)[SPARC_MC_O5]));
+    __get_user(env->regwptr[WREG_O6], (&(*grp)[SPARC_MC_O6]));
+    __get_user(env->regwptr[WREG_O7], (&(*grp)[SPARC_MC_O7]));
 
     __get_user(fp, &(ucp->tuc_mcontext.mc_fp));
     __get_user(i7, &(ucp->tuc_mcontext.mc_i7));
 
-    w_addr = TARGET_STACK_BIAS+env->regwptr[UREG_I6];
+    w_addr = TARGET_STACK_BIAS+env->regwptr[WREG_O6];
     if (put_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
                  abi_ulong) != 0) {
         goto do_sigsegv;
@@ -534,7 +505,7 @@ void sparc64_get_context(CPUSPARCState *env)
     target_sigset_t target_set;
     sigset_t set;
 
-    ucp_addr = env->regwptr[UREG_I0];
+    ucp_addr = env->regwptr[WREG_O0];
     if (!lock_user_struct(VERIFY_WRITE, ucp, ucp_addr, 0)) {
         goto do_sigsegv;
     }
@@ -580,16 +551,16 @@ void sparc64_get_context(CPUSPARCState *env)
     __put_user(env->gregs[5], &((*grp)[SPARC_MC_G5]));
     __put_user(env->gregs[6], &((*grp)[SPARC_MC_G6]));
     __put_user(env->gregs[7], &((*grp)[SPARC_MC_G7]));
-    __put_user(env->regwptr[UREG_I0], &((*grp)[SPARC_MC_O0]));
-    __put_user(env->regwptr[UREG_I1], &((*grp)[SPARC_MC_O1]));
-    __put_user(env->regwptr[UREG_I2], &((*grp)[SPARC_MC_O2]));
-    __put_user(env->regwptr[UREG_I3], &((*grp)[SPARC_MC_O3]));
-    __put_user(env->regwptr[UREG_I4], &((*grp)[SPARC_MC_O4]));
-    __put_user(env->regwptr[UREG_I5], &((*grp)[SPARC_MC_O5]));
-    __put_user(env->regwptr[UREG_I6], &((*grp)[SPARC_MC_O6]));
-    __put_user(env->regwptr[UREG_I7], &((*grp)[SPARC_MC_O7]));
-
-    w_addr = TARGET_STACK_BIAS+env->regwptr[UREG_I6];
+    __put_user(env->regwptr[WREG_O0], &((*grp)[SPARC_MC_O0]));
+    __put_user(env->regwptr[WREG_O1], &((*grp)[SPARC_MC_O1]));
+    __put_user(env->regwptr[WREG_O2], &((*grp)[SPARC_MC_O2]));
+    __put_user(env->regwptr[WREG_O3], &((*grp)[SPARC_MC_O3]));
+    __put_user(env->regwptr[WREG_O4], &((*grp)[SPARC_MC_O4]));
+    __put_user(env->regwptr[WREG_O5], &((*grp)[SPARC_MC_O5]));
+    __put_user(env->regwptr[WREG_O6], &((*grp)[SPARC_MC_O6]));
+    __put_user(env->regwptr[WREG_O7], &((*grp)[SPARC_MC_O7]));
+
+    w_addr = TARGET_STACK_BIAS+env->regwptr[WREG_O6];
     fp = i7 = 0;
     if (get_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
                  abi_ulong) != 0) {
-- 
2.21.0


