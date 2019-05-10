Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197CFC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CCB2084A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0hnwXp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CCB2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwGP-00077P-1E
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:32:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBu-0002zm-AA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBs-0001S3-TV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:22 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBs-0001Rh-Lo
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:20 -0400
Received: by mail-pg1-x543.google.com with SMTP id h1so2280575pgs.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Ad7p0XpmVmGXkoTgniD57oGcto4g8MS55uU7nmfGDcA=;
	b=q0hnwXp9Tfw4d5QG11EwUDzE9zUw5uI0Lx0bbdh1ZLV/YfvOwwvjuBPieBDcf9GQhn
	pMgMZKZBLIYtvWB3BvOOg8KrPsB7dNADCc+7Jp0K0f0GLmtjdfKydLZTvz1oTB112DCP
	rGB14g8vUMD8tA6OLnxM9u5DfY75mKOItvD80QGk7AFP1IbkKgAWzS0L8T4BhTGEdEK7
	x8zP08o4ZS/a844dap/gyeDANVF4ZTf6hXo8kW9BCIZVK5IHY1QPBABUv7tVzXC65TWG
	2KIlDz8QK0D7b/Oviw40/7S7qFX098biMlm41YPDSPKlbWOJzIGfwwbbglvezOyGjZ9d
	wNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Ad7p0XpmVmGXkoTgniD57oGcto4g8MS55uU7nmfGDcA=;
	b=NNpiCP0/biSaqi6pQrnNfq0QnK0DZtGpzfomBzZfys1R2ME5zTIPfU1eXQHmGXXQJL
	+QjskRnXyT6wV5wHwzv08cutjDgRpd199oIyaAipdQBNjDYBXFxBouzvI353NJ85BG+A
	JgK/j4Enm1sKbHgQdlQ7gqHA31Iz9f4/wPTD30Mvs67LTSAfZfwDt5zufkX76PUGna++
	wvdizzbgwt9yY2Xzxvjxr8jepqeXWmfLOWT1kPd7fXsTehnIE4v9XRqJmsgTq5/b2+Fp
	u3RMVQJBow2d4Y3cRs8rGimkqlXp/5vYsjZ+gMg3xPI5T4RJ0E9glKbR5XvMrdxisxP/
	ehcw==
X-Gm-Message-State: APjAAAV5UDADh50HNIY7x4OnwfJKFdiSoQIYm7h2I2iUiEbJqyw91bI+
	dtbrQNszN4/CozWf6EONwVwVSJP+N0Q=
X-Google-Smtp-Source: APXvYqzGEkQlut5b0Raaz8TykR12mjwVrW4Zg+IC0C1Cy6hyTJATLgpMevUqgFU/lAFLC5/B/TyS/A==
X-Received: by 2002:aa7:82cd:: with SMTP id f13mr10522384pfn.203.1557458839287;
	Thu, 09 May 2019 20:27:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:07 -0700
Message-Id: <20190510032710.23910-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510032710.23910-1-richard.henderson@linaro.org>
References: <20190510032710.23910-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 5/8] linux-user/sparc: Use WREG constants in
 sparc/signal.c
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

Remove the incorrectly defined UREG constants.

Maddeningly, in some cases we used the correct constant getting
the env register wrong, and in other cases we used the incorrect
constant getting the env register right.

In the case of getcontext/setcontext, we are aided by the fact
that the "other" constant, e.g. SPARC_MC_O0, is correct.  So we
can easily guess that the WREG_* constant on the other side
should also be O0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/signal.c | 96 +++++++++++++--------------------------
 1 file changed, 32 insertions(+), 64 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index ead169fbaa..243f237528 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -104,20 +104,6 @@ struct target_rt_signal_frame {
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
-
 static inline abi_ulong get_sigframe(struct target_sigaction *sa, 
                                      CPUSPARCState *env,
                                      unsigned long framesize)
@@ -159,30 +145,12 @@ setup___siginfo(__siginfo_t *si, CPUSPARCState *env, abi_ulong mask)
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
@@ -221,20 +189,20 @@ void setup_frame(int sig, struct target_sigaction *ka,
     }
 
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + UREG_L0], &sf->ss.locals[i]);
+        __put_user(env->regwptr[i + WREG_L0], &sf->ss.locals[i]);
     }
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + UREG_I0], &sf->ss.ins[i]);
+        __put_user(env->regwptr[i + WREG_I0], &sf->ss.ins[i]);
     }
     if (err)
         goto sigsegv;
 
     /* 3. signal handler back-trampoline and parameters */
-    env->regwptr[UREG_FP] = sf_addr;
-    env->regwptr[UREG_I0] = sig;
-    env->regwptr[UREG_I1] = sf_addr +
+    env->regwptr[WREG_FP] = sf_addr;
+    env->regwptr[WREG_I0] = sig;
+    env->regwptr[WREG_I1] = sf_addr +
             offsetof(struct target_signal_frame, info);
-    env->regwptr[UREG_I2] = sf_addr +
+    env->regwptr[WREG_I2] = sf_addr +
             offsetof(struct target_signal_frame, info);
 
     /* 4. signal handler */
@@ -242,11 +210,11 @@ void setup_frame(int sig, struct target_sigaction *ka,
     env->npc = (env->pc + 4);
     /* 5. return to kernel instructions */
     if (ka->ka_restorer) {
-        env->regwptr[UREG_I7] = ka->ka_restorer;
+        env->regwptr[WREG_I7] = ka->ka_restorer;
     } else {
         uint32_t val32;
 
-        env->regwptr[UREG_I7] = sf_addr +
+        env->regwptr[WREG_I7] = sf_addr +
                 offsetof(struct target_signal_frame, insns) - 2 * 4;
 
         /* mov __NR_sigreturn, %g1 */
@@ -284,7 +252,7 @@ long do_sigreturn(CPUSPARCState *env)
     sigset_t host_set;
     int i;
 
-    sf_addr = env->regwptr[UREG_FP];
+    sf_addr = env->regwptr[WREG_SP];
     trace_user_do_sigreturn(env, sf_addr);
     if (!lock_user_struct(VERIFY_READ, sf, sf_addr, 1)) {
         goto segv_and_exit;
@@ -316,7 +284,7 @@ long do_sigreturn(CPUSPARCState *env)
         __get_user(env->gregs[i], &sf->info.si_regs.u_regs[i]);
     }
     for (i=0; i < 8; i++) {
-        __get_user(env->regwptr[i + UREG_I0], &sf->info.si_regs.u_regs[i+8]);
+        __get_user(env->regwptr[i + WREG_O0], &sf->info.si_regs.u_regs[i+8]);
     }
 
     /* FIXME: implement FPU save/restore:
@@ -433,7 +401,7 @@ void sparc64_set_context(CPUSPARCState *env)
     abi_ulong fp, i7, w_addr;
     unsigned int i;
 
-    ucp_addr = env->regwptr[UREG_I0];
+    ucp_addr = env->regwptr[WREG_O0];
     if (!lock_user_struct(VERIFY_READ, ucp, ucp_addr, 1)) {
         goto do_sigsegv;
     }
@@ -443,7 +411,7 @@ void sparc64_set_context(CPUSPARCState *env)
     if ((pc | npc) & 3) {
         goto do_sigsegv;
     }
-    if (env->regwptr[UREG_I1]) {
+    if (env->regwptr[WREG_O1]) {
         target_sigset_t target_set;
         sigset_t set;
 
@@ -474,19 +442,19 @@ void sparc64_set_context(CPUSPARCState *env)
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
+    w_addr = TARGET_STACK_BIAS + env->regwptr[WREG_FP];
     if (put_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
                  abi_ulong) != 0) {
         goto do_sigsegv;
@@ -534,7 +502,7 @@ void sparc64_get_context(CPUSPARCState *env)
     target_sigset_t target_set;
     sigset_t set;
 
-    ucp_addr = env->regwptr[UREG_I0];
+    ucp_addr = env->regwptr[WREG_O0];
     if (!lock_user_struct(VERIFY_WRITE, ucp, ucp_addr, 0)) {
         goto do_sigsegv;
     }
@@ -580,16 +548,16 @@ void sparc64_get_context(CPUSPARCState *env)
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
+    __put_user(env->regwptr[WREG_O0], &((*grp)[SPARC_MC_O0]));
+    __put_user(env->regwptr[WREG_O1], &((*grp)[SPARC_MC_O1]));
+    __put_user(env->regwptr[WREG_O2], &((*grp)[SPARC_MC_O2]));
+    __put_user(env->regwptr[WREG_O3], &((*grp)[SPARC_MC_O3]));
+    __put_user(env->regwptr[WREG_O4], &((*grp)[SPARC_MC_O4]));
+    __put_user(env->regwptr[WREG_O5], &((*grp)[SPARC_MC_O5]));
+    __put_user(env->regwptr[WREG_O6], &((*grp)[SPARC_MC_O6]));
+    __put_user(env->regwptr[WREG_O7], &((*grp)[SPARC_MC_O7]));
 
-    w_addr = TARGET_STACK_BIAS+env->regwptr[UREG_I6];
+    w_addr = TARGET_STACK_BIAS + env->regwptr[WREG_FP];
     fp = i7 = 0;
     if (get_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
                  abi_ulong) != 0) {
-- 
2.17.1


