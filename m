Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562FBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B184A22247
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5EsVUbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B184A22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSvHa-0001Tq-OR
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 00:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSvFR-0006lj-Ut
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:52:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSvFQ-0003PU-1f
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:52:17 -0400
Received: by mail-pf1-x443.google.com with SMTP id c20so1231571pfr.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 21:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kFTYIO1Up7S0GLWDRygckRyd826G+thQsyNR6vulcYg=;
 b=o5EsVUbgtAVDimW3tyAndNtGBlB1t/x4yZPpxILxtWTtQSFP4lIdYjqG3+3sFflXL5
 Tn3Z4BiAmCuoWuYwXbEah9NPfWLjjL77ezMJTPsa/8zrJgktkJeJuBGFS24d9l1BCdiK
 s7DX05sMVMxkfsgtrmDBDZOAPySGDbGBDXVBozfA3t/5Foz8hZiDQfVrghgjSAC+lHBP
 eq4An+z4SsVTOATlzpsFxt/vb1WsdX0iwkSX0A11JGoDeNFcpPDqoO33Pzr59xO0Ya+l
 +Vi0sOvU1qJnjFrjEWXzvN61zaGT5BOlQ1nL4qYWJPEzu6FGuSQxBZ53cZWOkij7aJEk
 OV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kFTYIO1Up7S0GLWDRygckRyd826G+thQsyNR6vulcYg=;
 b=L074wsFr0vekYkKMGSebk7CWYIiloVALBaDo2GLBBvEI4P/X6yRk6o46mNtvqtPvgR
 nXAGtcVpeVOfdIfKqlV1pSF/V2iEeF13GZrIXiZEheiNTsr3hhMrrauMw+XbB4mfa9jP
 HfXxbUhFFsGogeU0zB4ScsMmuHzXcIJETs4zLG2/lYqqGOKmkurdmqUyWtFyG/WYpMVt
 wQ6SScGWcDrtnkeGj0odbsHfPWeUA/EmqIVyq0g9YZYSUcnafVpKFvWewW32QwH1kSoD
 mHO+3E5OJ5cc/xEEvJw6oUabeuyR+ju6Jdp/oLGr3tfkEiy6cvVXZ2PsCizBBqPqE1nu
 97VQ==
X-Gm-Message-State: AOAM531j0lT95XniBcEArQYFngK+Ny8dZzpiPxnvGeFxz222TqzXSxMG
 KFmS4OS0j6LoSIbreUoYQ07s4NqT52Kq5g==
X-Google-Smtp-Source: ABdhPJzo7TZhKmNBHwHyWctcJpnEIviKDD7ZDSbm2J8f3y9xQZ7eIPOQUn4L9yX51wcYW1KvHSprBg==
X-Received: by 2002:a62:8497:0:b029:155:9366:381b with SMTP id
 k145-20020a6284970000b02901559366381bmr2487384pfd.15.1602737534300; 
 Wed, 14 Oct 2020 21:52:14 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q66sm1407493pfc.109.2020.10.14.21.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 21:52:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] linux-user/microblaze: Remove non-rt signal frames
Date: Wed, 14 Oct 2020 21:52:08 -0700
Message-Id: <20201015045208.595044-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015045208.595044-1-richard.henderson@linaro.org>
References: <20201015045208.595044-1-richard.henderson@linaro.org>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The microblaze kernel does not support these, and uses
only rt style signal frames.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_signal.h |  1 -
 linux-user/microblaze/signal.c        | 97 +--------------------------
 2 files changed, 2 insertions(+), 96 deletions(-)

diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index 35efd5e928..08bcf24b9d 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -21,5 +21,4 @@ typedef struct target_sigaltstack {
 
 #include "../generic/signal.h"
 
-#define TARGET_ARCH_HAS_SETUP_FRAME
 #endif /* MICROBLAZE_TARGET_SIGNAL_H */
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index 3d316a22f1..cf0707b556 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -41,12 +41,6 @@ struct target_ucontext {
 };
 
 /* Signal frames. */
-struct target_signal_frame {
-    struct target_ucontext uc;
-    uint32_t extramask[TARGET_NSIG_WORDS - 1];
-    uint32_t tramp[2];
-};
-
 struct target_rt_sigframe {
     target_siginfo_t info;
     struct target_ucontext uc;
@@ -137,65 +131,6 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
     return ((sp - frame_size) & -8UL);
 }
 
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUMBState *env)
-{
-    struct target_signal_frame *frame;
-    abi_ulong frame_addr;
-    int i;
-
-    frame_addr = get_sigframe(ka, env, sizeof *frame);
-    trace_user_setup_frame(env, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
-        goto badframe;
-
-    /* Save the mask.  */
-    __put_user(set->sig[0], &frame->uc.tuc_mcontext.oldmask);
-
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __put_user(set->sig[i], &frame->extramask[i - 1]);
-    }
-
-    setup_sigcontext(&frame->uc.tuc_mcontext, env);
-
-    /* Set up to return from userspace. If provided, use a stub
-       already in userspace. */
-    /* minus 8 is offset to cater for "rtsd r15,8" offset */
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        env->regs[15] = ((unsigned long)ka->sa_restorer)-8;
-    } else {
-        uint32_t t;
-        /* Note, these encodings are _big endian_! */
-        /* addi r12, r0, __NR_sigreturn */
-        t = 0x31800000UL | TARGET_NR_sigreturn;
-        __put_user(t, frame->tramp + 0);
-        /* brki r14, 0x8 */
-        t = 0xb9cc0008UL;
-        __put_user(t, frame->tramp + 1);
-
-        /* Return from sighandler will jump to the tramp.
-           Negative 8 offset because return is rtsd r15, 8 */
-        env->regs[15] = frame_addr + offsetof(struct target_signal_frame, tramp)
-                                   - 8;
-    }
-
-    /* Set up registers for signal handler */
-    env->regs[1] = frame_addr;
-    /* Signal handler args: */
-    env->regs[5] = sig; /* Arg 0: signum */
-    env->regs[6] = 0;
-    /* arg 1: sigcontext */
-    env->regs[7] = frame_addr += offsetof(typeof(*frame), uc);
-
-    /* Offset of 4 to handle microblaze rtid r14, 0 */
-    env->pc = (unsigned long)ka->_sa_handler;
-
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-badframe:
-    force_sigsegv(sig);
-}
-
 void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPUMBState *env)
@@ -251,38 +186,10 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     unlock_user_struct(frame, frame_addr, 1);
 }
 
+
 long do_sigreturn(CPUMBState *env)
 {
-    struct target_signal_frame *frame;
-    abi_ulong frame_addr;
-    target_sigset_t target_set;
-    sigset_t set;
-    int i;
-
-    frame_addr = env->regs[R_SP];
-    trace_user_do_sigreturn(env, frame_addr);
-    /* Make sure the guest isn't playing games.  */
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1))
-        goto badframe;
-
-    /* Restore blocked signals */
-    __get_user(target_set.sig[0], &frame->uc.tuc_mcontext.oldmask);
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
-    }
-    target_to_host_sigset_internal(&set, &target_set);
-    set_sigmask(&set);
-
-    restore_sigcontext(&frame->uc.tuc_mcontext, env);
-    /* We got here through a sigreturn syscall, our path back is via an
-       rtb insn so setup r14 for that.  */
-    env->regs[14] = env->pc;
-
-    unlock_user_struct(frame, frame_addr, 0);
-    return -TARGET_QEMU_ESIGRETURN;
-badframe:
-    force_sig(TARGET_SIGSEGV);
-    return -TARGET_QEMU_ESIGRETURN;
+    return -TARGET_ENOSYS;
 }
 
 long do_rt_sigreturn(CPUMBState *env)
-- 
2.25.1


