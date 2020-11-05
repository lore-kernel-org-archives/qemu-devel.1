Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904B4C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F6B20735
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtUfeBaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F6B20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kammT-0005Ck-PU
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 16:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kamj8-0002nt-9r
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:23:26 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kamj5-0005Tf-A6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:23:26 -0500
Received: by mail-wr1-x443.google.com with SMTP id w14so3394714wrs.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 13:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U8KdOlXXLYO3hwpDlX+ZEhUYjGxzebIeovcN6OjRKh4=;
 b=JtUfeBafB1Saa9/5UUEgPDrfD2799oLlSmNOMBeYSAz74HfSB8tfhPR04akGHpy7cC
 PFukcOeLDahImogqLaaFxwdbGS7ySjtdrkuY9s7/JYFqG+pAd6mgZAbDp3tKiUHUphdX
 qf2FxhFt9kzUoqNLrIg+pRyK5N8svpznlCDCyDU78RCTglAN+3tGhNmQmZ/V22Vic56k
 7FtuzxG2pjgQF7UBHBMt0IQBgVRz79vli8KDpS0mHl3pnwlHpK/UepPoyPfeHxDJFFUy
 RQdPUS7gTWEKXiqq1jHy2txzjV1oUUyERUc3BI9ANAO0KQEgqSWii1oDdLLRMyjzV+x6
 VpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U8KdOlXXLYO3hwpDlX+ZEhUYjGxzebIeovcN6OjRKh4=;
 b=hYpVzJTlpiSWTWcHECOv4ZNpLc22fVNln/W2B7fxFwMtPt1jXpng4njUVOAeiUUaiC
 bphX1Fba8aB198DyuQTLlaiSIVzFQDjUEAcLfi3udce4gZWpIeue0e8bJ2PWXzZCz/cz
 u5wyvFpLGujWblgYVZKakDuTkfO9ph83qaobQEZxqIs3qyYMaqh0JUWCJu0JHEpF+QEY
 AWzaSu+OnHeEaZ/yvW9nVC6kebhibxpL+bWMkf1HZFiB8OhO3Lav5nx1hQzHA8bO3ZUf
 m9kEaqK47wV6z1oyM42yLtE7oKgn2vygQLuwbRoKNaCkm0coplyshZoZII3XR3ghhA1p
 0HDQ==
X-Gm-Message-State: AOAM531kil0Ml302Ihm4vMM93MhHpv6yshe95tdxuLUwIPuir2+dd9tY
 jGOyGkPXIxgGKCQhPXXQGXP6Q3MMF+53xw==
X-Google-Smtp-Source: ABdhPJxYpn23cpDQHJLVI9g4osRK6O5+iMy7YSc6U2tnsvTzpRFi7/CvMXIYzuyO/tn5kbrBpHGnPA==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr4613841wrr.364.1604611399675; 
 Thu, 05 Nov 2020 13:23:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e25sm4861587wrc.76.2020.11.05.13.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 13:23:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 2/3] linux-user/sparc: Correct set/get_context
 handling of fp and i7
Date: Thu,  5 Nov 2020 21:23:13 +0000
Message-Id: <20201105212314.9628-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105212314.9628-1-peter.maydell@linaro.org>
References: <20201105212314.9628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because QEMU's user-mode emulation just directly accesses guest CPU
state, for SPARC the guest register window state is not the same in
the sparc64_get_context() and sparc64_set_context() functions as it
is for the real kernel's versions of those functions.  Specifically,
for the kernel it has saved the user space state such that the O*
registers go into a pt_regs struct as UREG_I*, and the I* registers
have been spilled onto the userspace stack.  For QEMU, we haven't
done that, so the guest's O* registers are still in WREG_O* and the
I* registers in WREG_I*.

The code was already accessing the O* registers correctly for QEMU,
but had copied the kernel code for accessing the I* registers off the
userspace stack.  Replace this with direct accesses to fp and i7 in
the CPU state, and add a comment explaining why we differ from the
kernel code here.

This fix is sufficient to get bash to a shell prompt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm really pretty unsure about our handling of SPARC register
windows here. This fix works, but should we instead be
ensuring that the flush_windows() call cpu_loop() does
before handling this trap has written the I* regs to the
stack ???
---
 linux-user/sparc/signal.c | 47 ++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 57ea1593bfc..c315704b389 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -403,7 +403,6 @@ void sparc64_set_context(CPUSPARCState *env)
     struct target_ucontext *ucp;
     target_mc_gregset_t *grp;
     abi_ulong pc, npc, tstate;
-    abi_ulong fp, i7, w_addr;
     unsigned int i;
 
     ucp_addr = env->regwptr[WREG_O0];
@@ -447,6 +446,15 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(env->gregs[5], (&(*grp)[SPARC_MC_G5]));
     __get_user(env->gregs[6], (&(*grp)[SPARC_MC_G6]));
     __get_user(env->gregs[7], (&(*grp)[SPARC_MC_G7]));
+
+    /*
+     * Note that unlike the kernel, we didn't need to mess with the
+     * guest register window state to save it into a pt_regs to run
+     * the kernel. So for us the guest's O regs are still in WREG_O*
+     * (unlike the kernel which has put them in UREG_I* in a pt_regs)
+     * and the fp and i7 are still in WREG_I6 and WREG_I7 and don't
+     * need to be written back to userspace memory.
+     */
     __get_user(env->regwptr[WREG_O0], (&(*grp)[SPARC_MC_O0]));
     __get_user(env->regwptr[WREG_O1], (&(*grp)[SPARC_MC_O1]));
     __get_user(env->regwptr[WREG_O2], (&(*grp)[SPARC_MC_O2]));
@@ -456,18 +464,9 @@ void sparc64_set_context(CPUSPARCState *env)
     __get_user(env->regwptr[WREG_O6], (&(*grp)[SPARC_MC_O6]));
     __get_user(env->regwptr[WREG_O7], (&(*grp)[SPARC_MC_O7]));
 
-    __get_user(fp, &(ucp->tuc_mcontext.mc_fp));
-    __get_user(i7, &(ucp->tuc_mcontext.mc_i7));
+    __get_user(env->regwptr[WREG_FP], &(ucp->tuc_mcontext.mc_fp));
+    __get_user(env->regwptr[WREG_I7], &(ucp->tuc_mcontext.mc_i7));
 
-    w_addr = TARGET_STACK_BIAS + env->regwptr[WREG_O6];
-    if (put_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
-                 abi_ulong) != 0) {
-        goto do_sigsegv;
-    }
-    if (put_user(i7, w_addr + offsetof(struct target_reg_window, ins[7]),
-                 abi_ulong) != 0) {
-        goto do_sigsegv;
-    }
     /* FIXME this does not match how the kernel handles the FPU in
      * its sparc64_set_context implementation. In particular the FPU
      * is only restored if fenab is non-zero in:
@@ -501,7 +500,6 @@ void sparc64_get_context(CPUSPARCState *env)
     struct target_ucontext *ucp;
     target_mc_gregset_t *grp;
     target_mcontext_t *mcp;
-    abi_ulong fp, i7, w_addr;
     int err;
     unsigned int i;
     target_sigset_t target_set;
@@ -553,6 +551,15 @@ void sparc64_get_context(CPUSPARCState *env)
     __put_user(env->gregs[5], &((*grp)[SPARC_MC_G5]));
     __put_user(env->gregs[6], &((*grp)[SPARC_MC_G6]));
     __put_user(env->gregs[7], &((*grp)[SPARC_MC_G7]));
+
+    /*
+     * Note that unlike the kernel, we didn't need to mess with the
+     * guest register window state to save it into a pt_regs to run
+     * the kernel. So for us the guest's O regs are still in WREG_O*
+     * (unlike the kernel which has put them in UREG_I* in a pt_regs)
+     * and the fp and i7 are still in WREG_I6 and WREG_I7 and don't
+     * need to be fished out of userspace memory.
+     */
     __put_user(env->regwptr[WREG_O0], &((*grp)[SPARC_MC_O0]));
     __put_user(env->regwptr[WREG_O1], &((*grp)[SPARC_MC_O1]));
     __put_user(env->regwptr[WREG_O2], &((*grp)[SPARC_MC_O2]));
@@ -562,18 +569,8 @@ void sparc64_get_context(CPUSPARCState *env)
     __put_user(env->regwptr[WREG_O6], &((*grp)[SPARC_MC_O6]));
     __put_user(env->regwptr[WREG_O7], &((*grp)[SPARC_MC_O7]));
 
-    w_addr = TARGET_STACK_BIAS + env->regwptr[WREG_O6];
-    fp = i7 = 0;
-    if (get_user(fp, w_addr + offsetof(struct target_reg_window, ins[6]),
-                 abi_ulong) != 0) {
-        goto do_sigsegv;
-    }
-    if (get_user(i7, w_addr + offsetof(struct target_reg_window, ins[7]),
-                 abi_ulong) != 0) {
-        goto do_sigsegv;
-    }
-    __put_user(fp, &(mcp->mc_fp));
-    __put_user(i7, &(mcp->mc_i7));
+    __put_user(env->regwptr[WREG_FP], &(mcp->mc_fp));
+    __put_user(env->regwptr[WREG_I7], &(mcp->mc_i7));
 
     {
         uint32_t *dst = ucp->tuc_mcontext.mc_fpregs.mcfpu_fregs.sregs;
-- 
2.20.1


