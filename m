Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5168AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F2D20814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+EcMrVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2D20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbque-0000tl-4R
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgS-000345-31
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgR-0000VS-3e
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id u12so2758532wmd.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9kKd+uI5z6jR/8DRUg4wAhiNt2UeI3CInnSxtouYWeE=;
 b=p+EcMrVjRaowMi9Xukm6rJ5kDln3uw+DoHqlw4RKl3fneVQJMgnecx9knyGGJVguuX
 FMHP3a14Zp6zjcRVwlimPbTzGT9SBweDPTRVTq2dC9xySSf6HjUbr6/g+ps5zz/YU5ci
 IoWidifCr7Ex0yK+tq2MTR11sg1W8hbPNaAH0ti2m3oPDhnb3vdleZntC0LygyWgvtSZ
 RsCUGm24QPBu/D4SsmiGy7o7tpIMAIA5UThJUBgtvkyHCTxgFMqagYsMGD9qXhUg2HCU
 SvPDor1J4ApCg2oQLSTg7UNqA5nB9r+lyEPMxR+LxLJSRiI8/oo8QX4CyFjpAMeIqPiI
 J2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9kKd+uI5z6jR/8DRUg4wAhiNt2UeI3CInnSxtouYWeE=;
 b=gJAcYe0H/+BVrcg9RbY80tlXyCOtYwxKTqS4G0O6H2+QX3GUCTmaXOv/WIAv+SjTef
 tpM1THv/Fl0gL2Yn8DvVyxFK2ae6Dba4loq8IbUEEwoBVb13EaKBe6ZVG2Nda++3d2/N
 U1icqFwKFI03gEkibhZ9xDsv4XYx7EESslNjkNLU0chr+It8Pt+gxCw1vUj++vRU3Cx/
 R7MtEndMq7ZUttKpSDbPD2gwoke82KYVVxr2kIGOKRwGplRD5sVDQ3ycGDmeylu6eqCy
 u3xa1+QahJHEYph8MBU3BF8v8hOSe/R2SXsHNR8bRSVLAYlFgl6fnAP3o/wTRAQMuoFo
 GBaw==
X-Gm-Message-State: AOAM5321LE38mjP9Jb0iMCGFt8va5E6gqsZpy9mDb1CYoVEDQj6ojzwN
 zNuNdVbjI3jVB+9pdBWjE55jWgJe80d8aQ==
X-Google-Smtp-Source: ABdhPJxu9ut3355w7XQyjaOSM5bSpCHoSwDvl81S6POsawkAihH0lSjwrnbGUWv4m4Uw+csjnrz+iA==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr10671500wmc.137.1590088605504; 
 Thu, 21 May 2020 12:16:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/29] linux-user/arm: Reset CPSR_E when entering a signal
 handler
Date: Thu, 21 May 2020 20:16:09 +0100
Message-Id: <20200521191610.10941-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

From: Amanieu d'Antras <amanieu@gmail.com>

This fixes signal handlers running with the wrong endianness if the
interrupted code used SETEND to dynamically switch endianness.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200511131117.2486486-1-amanieu@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/signal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index 8020c80acb5..698985a647e 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -244,6 +244,11 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
     } else {
         cpsr &= ~CPSR_T;
     }
+    if (env->cp15.sctlr_el[1] & SCTLR_E0E) {
+        cpsr |= CPSR_E;
+    } else {
+        cpsr &= ~CPSR_E;
+    }
 
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         if (is_fdpic) {
@@ -287,7 +292,8 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
     env->regs[13] = frame_addr;
     env->regs[14] = retcode;
     env->regs[15] = handler & (thumb ? ~1 : ~3);
-    cpsr_write(env, cpsr, CPSR_IT | CPSR_T, CPSRWriteByInstr);
+    cpsr_write(env, cpsr, CPSR_IT | CPSR_T | CPSR_E, CPSRWriteByInstr);
+    arm_rebuild_hflags(env);
 
     return 0;
 }
-- 
2.20.1


