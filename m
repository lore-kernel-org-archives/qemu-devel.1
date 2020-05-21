Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59827C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3A8207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxGBjI4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3A8207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqwS-0004k9-AJ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgU-0003AY-MA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgS-0000Vh-5c
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so3528180wru.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JGi0kam4Hb96tw8QLNp1XZzN02TvAsgq8rt91AU8qsU=;
 b=dxGBjI4+plqULDMi3VU0ejpviQu07Pr1yDT8h6IUcv26CGVkMUYqjCJ23Tl4sQffVt
 o0KUYqha4+zgYyUYBVxRTxbn3hvNici6EPlGxIW5bXygjnIvWl2ByQF1OsHj4k2efz7d
 qQTyvjIHWGjqHK2V9/x3eJKogVHDe0ocx455urGHXxAklvPwgLRGLP07d2jzIkpJ8wt8
 75b0lZKUqQjXEQGNxUqoyET/JKJYjwlByXGYhIK6Fh2LxnzMZrshvswotPpdXDJmnJUp
 FO/A0VT9TBBeGhrae7PIynDKZ/QE66/4Vb9tBEjncnflX8SBUTm0FgAZMJrCSF0FP8qf
 gvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JGi0kam4Hb96tw8QLNp1XZzN02TvAsgq8rt91AU8qsU=;
 b=qEXCHywuPssSQs12vK9jXx5qtljct/jNfxdp+HdKOBHLIm8gwu9QDyAi7Y3VOJbqFF
 9+D9iXOeP+5OKzxnMn+CiNpQGq+PJwAjUZ+oEuFBgGog9xy1ZFEofGbrdT3nGBZ2Xxsv
 kMiYLw/+mnlS6OIJ1PnKWOvcPwxjHZJLwyuR5fFK3uIP77SRsFMlJpqNDeNane5AbsjH
 0BCLTTKRtyKIrLdm6EfPX8aN5pthXVfLQjPqfHp+h+MTxVci1o/ymRpsEu/b3b4tjPIV
 DhgnnR30sjIi4t76FYvnEJmnbfHNnlLprmbTSBkGOJV2dhY1SqBYr+PB5QBHNA9PHfRz
 +hIw==
X-Gm-Message-State: AOAM532oPKee8Og9X6lpTg3aWjaZ3gvgGKgpO6eUTs6gPqeIBHD/GFdr
 i/L3y/2HzKDLxYEACWoB35VGvFPVtv27iA==
X-Google-Smtp-Source: ABdhPJzcELP+isSbNzjyyoYS1XlzfuKRDK9QcW6U5TdVMCaBch7zXhiI+SZ2KOTTWkspE8YsMH8TZQ==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr108524wri.342.1590088606527; 
 Thu, 21 May 2020 12:16:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32
Date: Thu, 21 May 2020 20:16:10 +0100
Message-Id: <20200521191610.10941-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Arm signal-handling code has some parts ifdeffed with a
TARGET_CONFIG_CPU_32, which is always defined. This is a leftover
from when this code's structure was based on the Linux kernel
signal handling code, where it was intended to support 26-bit
Arm CPUs. The kernel dropped its CONFIG_CPU_32 in kernel commit
4da8b8208eded0ba21e3 in 2009.

QEMU has never had 26-bit CPU support and is unlikely to ever
add it; we certainly aren't going to support 26-bit Linux
binaries via linux-user mode. The ifdef is just unhelpful
noise, so remove it entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200518143014.20689-1-peter.maydell@linaro.org
---
 linux-user/arm/signal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index 698985a647e..f21d1535e4d 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -126,8 +126,6 @@ struct rt_sigframe_v2
     abi_ulong retcode[4];
 };
 
-#define TARGET_CONFIG_CPU_32 1
-
 /*
  * For ARM syscalls, we encode the syscall number into the instruction.
  */
@@ -187,9 +185,7 @@ setup_sigcontext(struct target_sigcontext *sc, /*struct _fpstate *fpstate,*/
     __put_user(env->regs[13], &sc->arm_sp);
     __put_user(env->regs[14], &sc->arm_lr);
     __put_user(env->regs[15], &sc->arm_pc);
-#ifdef TARGET_CONFIG_CPU_32
     __put_user(cpsr_read(env), &sc->arm_cpsr);
-#endif
 
     __put_user(/* current->thread.trap_no */ 0, &sc->trap_no);
     __put_user(/* current->thread.error_code */ 0, &sc->error_code);
@@ -549,11 +545,9 @@ restore_sigcontext(CPUARMState *env, struct target_sigcontext *sc)
     __get_user(env->regs[13], &sc->arm_sp);
     __get_user(env->regs[14], &sc->arm_lr);
     __get_user(env->regs[15], &sc->arm_pc);
-#ifdef TARGET_CONFIG_CPU_32
     __get_user(cpsr, &sc->arm_cpsr);
     cpsr_write(env, cpsr, CPSR_USER | CPSR_EXEC, CPSRWriteByInstr);
     arm_rebuild_hflags(env);
-#endif
 
     err |= !valid_user_regs(env);
 
-- 
2.20.1


