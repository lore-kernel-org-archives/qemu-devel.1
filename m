Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BBCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1B620738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fc68X0k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1B620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqiz-0008Vd-CM
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg4-00028M-JH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg3-0000PZ-Bs
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id k13so7795130wrx.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Loi0hc4iYGl2SyK0g+pxvj1MN6OhO1THWv4v9RyjhY0=;
 b=Fc68X0k4EGip3LE+FEvBpbmykkOCQD5j1w2EoV9dJyUwnDrDW4YJdU+CCyTCFT13qz
 1cp+deatGIrTOyXBser0iqsht4O/PxJNy5DGUfSWijzagCdk/J4S/hpaRvEU4wI/mgN9
 +M8OHmJZvliDyPu8SbhO/qfObw/K9AFjbGQPSN29CrqsHlwfjZ73sNgs4aUDFMMuWMqg
 /pYu/GwgimiOp7CBvBv/9GdMTg4XG9+fZ2mrrFNeQ7jtYI0/faVfET25BY0tTNYkGYZb
 z5F9VvpiAknqTl7Mxb0iTp2TX5FflMRHWEUwD9ceiVYZIo7i5VMgvHmLWlewnazoPmEx
 boAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Loi0hc4iYGl2SyK0g+pxvj1MN6OhO1THWv4v9RyjhY0=;
 b=kmC1vas30m3Cy10yfntL8CJIYjAGrAR28TNV8KNcW46wHg3XwBbsPM+f4UIYMSD9Kz
 VTxT66n3TX31PbMoHab21bFIxsfmQfrqmhEkoUqoXwE8ONx2CKmS/jsa16tP+hD7sYfc
 00dHIbah9p9fYuqxwbF+D8qBUjX+USEtlO/ooWSRtPkWpVnz7dkjKjAbQ6nmSR/E8OxV
 RNxoDWFKshRUFMdkFy4zeIec7ZhSlYg7gaP8yJgchub3EX0yB+fjGw6QNjmwtso8Iq/d
 en4/vgI3jnnP3egBHXhf+b8FZGdjIhbsse4AxHYYbrBBGb3UTBBVQFvf35XDhvL3JVnf
 Avlg==
X-Gm-Message-State: AOAM532My2t2SBM5jIeCffreHntkQQLqgShK0QdcRplVYMnDovsJ1KON
 AFu9N6JUHxSoMXF+uArrl0TJuJH09Efi9A==
X-Google-Smtp-Source: ABdhPJy40mmiW07Zae8LZmTWCuhmUGpMa/4emkoh7Xr8YDMfl2TwdVWSKppk/N32BXeB64jgV/3qmQ==
X-Received: by 2002:a5d:6401:: with SMTP id z1mr115794wru.226.1590088581598;
 Thu, 21 May 2020 12:16:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/29] linux-user/arm: BKPT should cause SIGTRAP,
 not be a syscall
Date: Thu, 21 May 2020 20:15:48 +0100
Message-Id: <20200521191610.10941-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

In linux-user/arm/cpu-loop.c we incorrectly treat EXCP_BKPT similarly
to EXCP_SWI, which means that if the guest executes a BKPT insn then
QEMU will perform a syscall for it (which syscall depends on what
value happens to be in r7...). The correct behaviour is that the
guest process should take a SIGTRAP.

This code has been like this (more or less) since commit
06c949e62a098f in 2006 which added BKPT in the first place.  This is
probably because at the time the same code path was used to handle
both Linux syscalls and semihosting calls, and (on M profile) BKPT
with a suitable magic number is used for semihosting calls.  But
these days we've moved handling of semihosting out to an entirely
different codepath, so we can fix this bug by simply removing this
handling of EXCP_BKPT and instead making it deliver a SIGTRAP like
EXCP_DEBUG (as we do already on aarch64).

Reported-by: <omerg681@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200420212206.12776-2-peter.maydell@linaro.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1873898
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/cpu_loop.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index cf618daa1ca..82d0dd3c312 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -295,32 +295,17 @@ void cpu_loop(CPUARMState *env)
             }
             break;
         case EXCP_SWI:
-        case EXCP_BKPT:
             {
                 env->eabi = 1;
                 /* system call */
-                if (trapnr == EXCP_BKPT) {
-                    if (env->thumb) {
-                        /* FIXME - what to do if get_user() fails? */
-                        get_user_code_u16(insn, env->regs[15], env);
-                        n = insn & 0xff;
-                        env->regs[15] += 2;
-                    } else {
-                        /* FIXME - what to do if get_user() fails? */
-                        get_user_code_u32(insn, env->regs[15], env);
-                        n = (insn & 0xf) | ((insn >> 4) & 0xff0);
-                        env->regs[15] += 4;
-                    }
+                if (env->thumb) {
+                    /* FIXME - what to do if get_user() fails? */
+                    get_user_code_u16(insn, env->regs[15] - 2, env);
+                    n = insn & 0xff;
                 } else {
-                    if (env->thumb) {
-                        /* FIXME - what to do if get_user() fails? */
-                        get_user_code_u16(insn, env->regs[15] - 2, env);
-                        n = insn & 0xff;
-                    } else {
-                        /* FIXME - what to do if get_user() fails? */
-                        get_user_code_u32(insn, env->regs[15] - 4, env);
-                        n = insn & 0xffffff;
-                    }
+                    /* FIXME - what to do if get_user() fails? */
+                    get_user_code_u32(insn, env->regs[15] - 4, env);
+                    n = insn & 0xffffff;
                 }
 
                 if (n == ARM_NR_cacheflush) {
@@ -396,6 +381,7 @@ void cpu_loop(CPUARMState *env)
             }
             break;
         case EXCP_DEBUG:
+        case EXCP_BKPT:
         excp_debug:
             info.si_signo = TARGET_SIGTRAP;
             info.si_errno = 0;
-- 
2.20.1


