Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588F6207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzpyOZJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588F6207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqmk-0007bu-Dv
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg6-0002Cq-HF
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg5-0000Qt-DC
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so2390848wrp.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SO0tJgJgn/EVNKJE79ekFtYmNOY8AvESSw03LMos9hM=;
 b=fzpyOZJLlKmK5Yy561WQO4BU1pOaw0uW4dwrKR88etF5OV4L+0or4c7Y9C/1reZIcQ
 m8E42WjQ+wtcsVEi5SVPNa0eQMrkVacIGPSWZWGoLrMYss5DxLAmWDUxry0yOdxzhUKJ
 sAxddE7qPzUTTUINDeccQvk8lxD13mnyxeUeguQkx919rWd5Hljz3g8MAd9TWicmR+a9
 6dlXbEMRY52nqPWnlw3FOD/P6KQIDjHQhJGYyJdAntFLZEl5A50X8jeNJ8uJTrAyj3ig
 BQYFUg86XLeRQnOt++t/w3Is3R2wyFuTnE0MeR8esOJWQ5wMXGsE6rFJmG4wPhBJc02e
 mm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SO0tJgJgn/EVNKJE79ekFtYmNOY8AvESSw03LMos9hM=;
 b=f2Ai+9rq/N1Smto+Hi3FQ2r2m/o99nT+xM28mW1QIu2KizobdZ4S57vX0DDjHtGS70
 xtrygQpP0xWaWnS6LM6uvL30UUmVAp3zIyRIWlYhj7sTKERpnwRztpLYsnpJLTEHv0gJ
 eOc8eDL7bJ1eXMmIE3qxJ4mwQMIN27mCwC9QRE7gChO4gT0i9YyuamIOuHUIbESjlOa3
 +gmWS4z9aZEH1uI0xeF8dA/StfOnD+9vg07CSE+gtpH5y5YEXL0cE43OVxNarj4eNL94
 c2ulaMyrhFmAT+vPSKJZPs1DOY+Y2uobtcn0x+HjDX5zSa45PxP/dUyU8L7mTL/bzoqz
 mJAg==
X-Gm-Message-State: AOAM532QC8wo9l5eoh16pKp+sTIlQkqiDpT1C3E5nwEA7O/99d4G6eIb
 q5Uca3iDzQsRQq0frvR1O2oanoOBcUh0dQ==
X-Google-Smtp-Source: ABdhPJzr0Qo0h7vJug9tyT/R7iydg/VQNF6UcsyTZhplX9Qqkl1VBFqbn3idLwatunG2QSeoGF7UnA==
X-Received: by 2002:adf:f007:: with SMTP id j7mr101079wro.294.1590088583667;
 Thu, 21 May 2020 12:16:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/29] linux-user/arm: Handle invalid arm-specific syscalls
 correctly
Date: Thu, 21 May 2020 20:15:50 +0100
Message-Id: <20200521191610.10941-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The kernel has different handling for syscalls with invalid
numbers that are in the "arm-specific" range 0x9f0000 and up:
 * 0x9f0000..0x9f07ff return -ENOSYS if not implemented
 * other out of range syscalls cause a SIGILL
(see the kernel's arch/arm/kernel/traps.c:arm_syscall())

Implement this distinction. (Note that our code doesn't look
quite like the kernel's, because we have removed the
0x900000 prefix by this point, whereas the kernel retains
it in arm_syscall().)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200420212206.12776-4-peter.maydell@linaro.org
---
 linux-user/arm/cpu_loop.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 025887d6b86..df8b7b3fa96 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -332,10 +332,32 @@ void cpu_loop(CPUARMState *env)
                             env->regs[0] = cpu_get_tls(env);
                             break;
                         default:
-                            qemu_log_mask(LOG_UNIMP,
-                                          "qemu: Unsupported ARM syscall: 0x%x\n",
-                                          n);
-                            env->regs[0] = -TARGET_ENOSYS;
+                            if (n < 0xf0800) {
+                                /*
+                                 * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
+                                 * 0x9f07ff in OABI numbering) are defined
+                                 * to return -ENOSYS rather than raising
+                                 * SIGILL. Note that we have already
+                                 * removed the 0x900000 prefix.
+                                 */
+                                qemu_log_mask(LOG_UNIMP,
+                                    "qemu: Unsupported ARM syscall: 0x%x\n",
+                                              n);
+                                env->regs[0] = -TARGET_ENOSYS;
+                            } else {
+                                /* Otherwise SIGILL */
+                                info.si_signo = TARGET_SIGILL;
+                                info.si_errno = 0;
+                                info.si_code = TARGET_ILL_ILLTRP;
+                                info._sifields._sigfault._addr = env->regs[15];
+                                if (env->thumb) {
+                                    info._sifields._sigfault._addr -= 2;
+                                } else {
+                                    info._sifields._sigfault._addr -= 4;
+                                }
+                                queue_signal(env, info.si_signo,
+                                             QEMU_SI_FAULT, &info);
+                            }
                             break;
                         }
                     } else {
-- 
2.20.1


