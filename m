Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276BFC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B13217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B13217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL4K-0000Sv-Rr
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzw-0003X6-5p
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzu-0002xq-Fx
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:20 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:48433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzu-0002x9-6O
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:18 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MXp1Q-1iRE1z0uZY-00YB7Z; Wed, 06 Nov 2019 14:05:11 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/13] linux-user/sparc: Begin using WREG constants in
 sparc/signal.c
Date: Wed,  6 Nov 2019 14:04:49 +0100
Message-Id: <20191106130456.6176-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:or0UTK77VSjZt9enkydS3C5H4YSLm8PPhqPV6TUFsKFu8RDy5Dc
 5h8x2PZX6TZr51+ISXC1Wmw+nPRlVj/A0gRnomYuhscIrTGk7y6MN3NI26Lx1a9tzC/zlYx
 loLSpz3GSjyh/zreRFBbjQ0ELLwwaculR0ej32vY1/Du1p/YApQW1m9Mp+tyQd866mrnEON
 hhzqAvLuL7N0fILPYrY6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QAsLTu2KgeM=:JOQUI1GUDx75A26tTNNLkl
 ZbunOi0HAHcr0+qSsAY7x1KDPQW/9lp6OqCj9UCMxS5B0QThAlYYnQdXyu3QFsgSyjR+b2AVt
 oSzAR/uruYa7N6EAQU0TpalhskuNdCzLnpx7+awTDt6BS3DKDO+kG2atTN2sygib7NIPYM9nT
 b5EXFG8hJLvgYRQDBP6KLT9yDD2Es01cx4OazC61im3eWu97sImTDOs+1a5vKZ5KzkG+ZthvO
 rMYUrI/DrukCGBnxSD+88oOzyqGDvE3Kd8B9bekxmzyxFU9aEdS1u/b56TtJ2gWhBtQmhNMKl
 kk5A1pVy/ASkALGmV6I24WBn3cbS+OmFFDyJ2/bpZvIuNvnE5Mui3rTcSAdpmi7OQ35yWm7r7
 VXM3LpmM31nWcOYFYcgbqHeluNkQ9WKsXrCTs30k8VRDYNdGQWcSA2DjjiAm+qBZ3GlJ9fXT8
 Iy0frLgGtKuYB8AchkMqn2HAV+UPeSkjdKaI5EFZtUg0gVKLMqqPstoS9inzfU4b+eWyf/AsT
 6IZwO02Oi7qSy78/JKYNnOqo3rqSGRGkFqtfYwmLSeEbzUYUBqNFxnGvom4XTvaogA3BJBLSI
 2fJwtSfR49rSDMs1OzY9wITC6rz4C+nwMoSzFTaeZnQBJG1nu/GI6/CylurdbzzuZ+6hsJWE5
 tGRkYsJE1zmSsYhJs6e3TgLAf+MFWenw45ZrZ9phpA8YN8PJ7KssULCUOOVcHprq9dEbJx80Y
 776oK4YM1h4TL0ldU5ug0sGfZLYIWxQiRQs/PEb7Sk8JsnkbA3huAblJz/2bJ9SgnUCXTzCG7
 N/32dutA4unKEBnyH4ipNFYW2f9CDfLstzIRyoyZ0snsNrVWIvgMIrk1hJg1VoFyBbX415noa
 puLARgXGgJA8a5PwbA7Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Message-Id: <20191106113318.10226-6-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 95 ++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 62 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index ead169fbaa26..aac37da239c1 100644
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
+        __put_user(env->regwptr[WREG_O0 + i], &si->si_regs.u_regs[i + 8]);
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
+        __get_user(env->regwptr[i + WREG_O0], &sf->info.si_regs.u_regs[i + 8]);
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
+    w_addr = TARGET_STACK_BIAS + env->regwptr[WREG_O6];
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
+    w_addr = TARGET_STACK_BIAS + env->regwptr[WREG_O6];
     fp = i7 = 0;
     if (get_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
                  abi_ulong) != 0) {
-- 
2.21.0


