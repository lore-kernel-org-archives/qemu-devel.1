Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD012C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F18720738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnvEJEVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F18720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqip-0008OU-J0
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg7-0002Gq-VJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg6-0000R3-O2
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id u12so2757713wmd.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jqyrlre26HzY4/EOKXLxmJgMpYAcEqSqJmnuoHIuFXE=;
 b=fnvEJEVbAtzKgzwdrXY3QzBVm37op7KWIJS9YimDHalAugt4KsOmYCGWJSEsDFrivw
 Sa055egmD1BffURhC7r+XPkP504MlCsMSL+f7i41ozZ80Q+e8Fh8+lnPuJLtq/sFBkW5
 sUBAwK1XeA++pUXSGw063Zofc7mbCm5L2IuhhGvR63dXvE4D9a5e4YNm6hsLm9Qok8Py
 TTCJPm8Z6pPiv+jSwJqAH9tx2paGDk/YE8kNg/9cvzjfPGzZs5vuA6kSIYxSyhwPL/VV
 feAfLBrAlALwvdxbt0s81mifO3HkZCHAg2kSgMbnkFqmWkKRDvh7+oiry4xjE0C5jkf/
 QZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jqyrlre26HzY4/EOKXLxmJgMpYAcEqSqJmnuoHIuFXE=;
 b=EZUv58eSTu8AQ2mvgcWhEq8jR4thLIbHs9RxS9FMhrJI0wDV+uub/4SrC+OPMHq7/E
 ivNLuzL0lC70odl2Y/2LXfZRUNsz706ltN3gaz4i49P2tWiCVlzV7OGPJ1XIpR65W89a
 l+YIPju3Gm8IU3Re2cQs5JtYcALO75Dp+/g16L/kmGBewtinL26BciSTw4C86QofMcN/
 MXjo0Db65a3ILk/v+0nUrSmtcm0fo+0lHmyqpOx8myVOaaIDt/oTqTQVQGL5dvBGo6e6
 8XK8M+1+0327Q3TBH8v3MFYKB9Ibu8ijhgOErJot0TXIhWgQLO70qcI+sGpjH+hvnRvw
 tpKQ==
X-Gm-Message-State: AOAM532Ks3IPO5MVzJ/qGnZFMxg9c2OtVvIZxuCVb8831M7VehC80BCS
 ipOFZ3ntj0z60VEEhDJ9pWC9RnsQr+zlFg==
X-Google-Smtp-Source: ABdhPJxvO2AVXP185g7ryFGfNXgIeonu0ml69KrXDk1GMOJbriCtvBHDjcisPLpnQjJLW0DucAAdVA==
X-Received: by 2002:a1c:6182:: with SMTP id v124mr10112288wmb.30.1590088584813; 
 Thu, 21 May 2020 12:16:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/29] linux-user/arm: Fix identification of syscall numbers
Date: Thu, 21 May 2020 20:15:51 +0100
Message-Id: <20200521191610.10941-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Our code to identify syscall numbers has some issues:
 * for Thumb mode, we never need the immediate value from the insn,
   but we always read it anyway
 * bad immediate values in the svc insn should cause a SIGILL, but we
   were abort()ing instead (via "goto error")

We can fix both these things by refactoring the code that identifies
the syscall number to more closely follow the kernel COMPAT_OABI code:
 * for Thumb it is always r7
 * for Arm, if the immediate value is 0, then this is an EABI call
   with the syscall number in r7
 * otherwise, we XOR the immediate value with 0x900000
   (ARM_SYSCALL_BASE for QEMU; __NR_OABI_SYSCALL_BASE in the kernel),
   which converts valid syscall immediates into the desired value,
   and puts all invalid immediates in the range 0x100000 or above
 * then we can just let the existing "value too large, deliver
   SIGILL" case handle invalid numbers, and drop the 'goto error'

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200420212206.12776-5-peter.maydell@linaro.org
---
 linux-user/arm/cpu_loop.c | 143 ++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 66 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index df8b7b3fa96..13629ee1f6a 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -299,85 +299,96 @@ void cpu_loop(CPUARMState *env)
                 env->eabi = 1;
                 /* system call */
                 if (env->thumb) {
-                    /* FIXME - what to do if get_user() fails? */
-                    get_user_code_u16(insn, env->regs[15] - 2, env);
-                    n = insn & 0xff;
+                    /* Thumb is always EABI style with syscall number in r7 */
+                    n = env->regs[7];
                 } else {
+                    /*
+                     * Equivalent of kernel CONFIG_OABI_COMPAT: read the
+                     * Arm SVC insn to extract the immediate, which is the
+                     * syscall number in OABI.
+                     */
                     /* FIXME - what to do if get_user() fails? */
                     get_user_code_u32(insn, env->regs[15] - 4, env);
                     n = insn & 0xffffff;
-                }
-
-                if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
-                    /* linux syscall */
-                    if (env->thumb || n == 0) {
+                    if (n == 0) {
+                        /* zero immediate: EABI, syscall number in r7 */
                         n = env->regs[7];
                     } else {
-                        n -= ARM_SYSCALL_BASE;
+                        /*
+                         * This XOR matches the kernel code: an immediate
+                         * in the valid range (0x900000 .. 0x9fffff) is
+                         * converted into the correct EABI-style syscall
+                         * number; invalid immediates end up as values
+                         * > 0xfffff and are handled below as out-of-range.
+                         */
+                        n ^= ARM_SYSCALL_BASE;
                         env->eabi = 0;
                     }
-                    if ( n > ARM_NR_BASE) {
-                        switch (n) {
-                        case ARM_NR_cacheflush:
-                            /* nop */
-                            break;
-                        case ARM_NR_set_tls:
-                            cpu_set_tls(env, env->regs[0]);
-                            env->regs[0] = 0;
-                            break;
-                        case ARM_NR_breakpoint:
-                            env->regs[15] -= env->thumb ? 2 : 4;
-                            goto excp_debug;
-                        case ARM_NR_get_tls:
-                            env->regs[0] = cpu_get_tls(env);
-                            break;
-                        default:
-                            if (n < 0xf0800) {
-                                /*
-                                 * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
-                                 * 0x9f07ff in OABI numbering) are defined
-                                 * to return -ENOSYS rather than raising
-                                 * SIGILL. Note that we have already
-                                 * removed the 0x900000 prefix.
-                                 */
-                                qemu_log_mask(LOG_UNIMP,
-                                    "qemu: Unsupported ARM syscall: 0x%x\n",
-                                              n);
-                                env->regs[0] = -TARGET_ENOSYS;
+                }
+
+                if (n > ARM_NR_BASE) {
+                    switch (n) {
+                    case ARM_NR_cacheflush:
+                        /* nop */
+                        break;
+                    case ARM_NR_set_tls:
+                        cpu_set_tls(env, env->regs[0]);
+                        env->regs[0] = 0;
+                        break;
+                    case ARM_NR_breakpoint:
+                        env->regs[15] -= env->thumb ? 2 : 4;
+                        goto excp_debug;
+                    case ARM_NR_get_tls:
+                        env->regs[0] = cpu_get_tls(env);
+                        break;
+                    default:
+                        if (n < 0xf0800) {
+                            /*
+                             * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
+                             * 0x9f07ff in OABI numbering) are defined
+                             * to return -ENOSYS rather than raising
+                             * SIGILL. Note that we have already
+                             * removed the 0x900000 prefix.
+                             */
+                            qemu_log_mask(LOG_UNIMP,
+                                "qemu: Unsupported ARM syscall: 0x%x\n",
+                                          n);
+                            env->regs[0] = -TARGET_ENOSYS;
+                        } else {
+                            /*
+                             * Otherwise SIGILL. This includes any SWI with
+                             * immediate not originally 0x9fxxxx, because
+                             * of the earlier XOR.
+                             */
+                            info.si_signo = TARGET_SIGILL;
+                            info.si_errno = 0;
+                            info.si_code = TARGET_ILL_ILLTRP;
+                            info._sifields._sigfault._addr = env->regs[15];
+                            if (env->thumb) {
+                                info._sifields._sigfault._addr -= 2;
                             } else {
-                                /* Otherwise SIGILL */
-                                info.si_signo = TARGET_SIGILL;
-                                info.si_errno = 0;
-                                info.si_code = TARGET_ILL_ILLTRP;
-                                info._sifields._sigfault._addr = env->regs[15];
-                                if (env->thumb) {
-                                    info._sifields._sigfault._addr -= 2;
-                                } else {
-                                    info._sifields._sigfault._addr -= 4;
-                                }
-                                queue_signal(env, info.si_signo,
-                                             QEMU_SI_FAULT, &info);
+                                info._sifields._sigfault._addr -= 4;
                             }
-                            break;
-                        }
-                    } else {
-                        ret = do_syscall(env,
-                                         n,
-                                         env->regs[0],
-                                         env->regs[1],
-                                         env->regs[2],
-                                         env->regs[3],
-                                         env->regs[4],
-                                         env->regs[5],
-                                         0, 0);
-                        if (ret == -TARGET_ERESTARTSYS) {
-                            env->regs[15] -= env->thumb ? 2 : 4;
-                        } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                            env->regs[0] = ret;
+                            queue_signal(env, info.si_signo,
+                                         QEMU_SI_FAULT, &info);
                         }
+                        break;
                     }
                 } else {
-                    goto error;
+                    ret = do_syscall(env,
+                                     n,
+                                     env->regs[0],
+                                     env->regs[1],
+                                     env->regs[2],
+                                     env->regs[3],
+                                     env->regs[4],
+                                     env->regs[5],
+                                     0, 0);
+                    if (ret == -TARGET_ERESTARTSYS) {
+                        env->regs[15] -= env->thumb ? 2 : 4;
+                    } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                        env->regs[0] = ret;
+                    }
                 }
             }
             break;
-- 
2.20.1


