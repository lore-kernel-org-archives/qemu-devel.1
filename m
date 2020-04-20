Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C669C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53891207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJBIHjOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53891207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdvA-000303-HC
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 17:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdrs-0006pk-Ja
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdrq-0006uo-R3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:15 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQdrq-0006qg-9R
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id u16so1230081wmc.5
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yNdZAQTtVSGKFWzXSVWtiZmV8YVbig1mvz+Yew2q/QA=;
 b=pJBIHjOPTCCxVZgGAqqUME2UvWSREYhZe0N+VyuBRBuJ3hAx1gVgSShcObaBxmKpcN
 Pn/2oZC+pvZeWktQ60y0GDZWrTvT6zbZ6u9CujrLX3mieCwzVwbW9HICx2xU+0YQZnI+
 tdfUseBXjk1DvkslHbNIge9LMbxRszIA3AMa2y4dFzhTLuIdx1YxbrkBa1/Ycbbeg6Q+
 7uJ/yFMPTALjY33rMdeucWBSzhY5oxV6tGlWPTskNXx+Rdn04E58XR9XKWXEhP2h3yKL
 zGirdf3JpUyV0qcDhXFZ868RVjGN/TZHyJWv0Nz7iMgFyVw2ZaN6Hdw0mICKsBZ/NZfs
 zxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yNdZAQTtVSGKFWzXSVWtiZmV8YVbig1mvz+Yew2q/QA=;
 b=QLiTR4TF470y9I1beYHAZUKULA21Tm9EJNn2ZST9RUoaGJgIzfedhH27wBblIVOAfT
 YU2REN99Mk73oU/MqpGMd4vRKxBeuj2Xqo6SHtoC62zOHMmDiBWR2If0e0Mzc5sSuq+u
 lnmRMba3WHF78fLWWgY+H8gW+UXQ+YJ7pg7XNoKDMuY4eQHyVTMCUrpxRRXVm4IJ+/oL
 00zjIHmrvNceTKvDSEGeO7KT60NdnXB/pUQr+4sPScTMO4Db3RcVZpG5U3XbFjD36ysq
 e8/a+I1poF54ATBSBC8Km6cGnWlcHVa6eAnToQ5TcJkoiMlANIoMG/FQMqMhI2E/ChUm
 ZtxQ==
X-Gm-Message-State: AGi0PubWyu3omJ5IEls4Y1j6ZyH0j707sTBnmlcXlf9InMN4LwjoCJTZ
 Grs9L+SJ5W18UwSuPURfkkL8PQ==
X-Google-Smtp-Source: APiQypJ60am4+p0+Six+R+on2YVmfCRRdF/feU7VEj4DOdd12CdcsXLvHz3rQ/F4wx5WTWnTZyoA1A==
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr1343790wmm.15.1587417732839; 
 Mon, 20 Apr 2020 14:22:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j10sm823663wmi.18.2020.04.20.14.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 14:22:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] linux-user/arm: Handle invalid arm-specific syscalls
 correctly
Date: Mon, 20 Apr 2020 22:22:05 +0100
Message-Id: <20200420212206.12776-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420212206.12776-1-peter.maydell@linaro.org>
References: <20200420212206.12776-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: omerg681@gmail.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
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
---
 linux-user/arm/cpu_loop.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 025887d6b86..f042108b0be 100644
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
+                                    info._sifields._sigfault._addr -= 2;
+                                }
+                                queue_signal(env, info.si_signo,
+                                             QEMU_SI_FAULT, &info);
+                            }
                             break;
                         }
                     } else {
-- 
2.20.1


