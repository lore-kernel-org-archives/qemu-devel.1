Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015BC4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568E620731
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Eyj06b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568E620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3E5-0008AO-Bi
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc36M-0007z6-Br
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:04:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc36K-0005In-Ob
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:04:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id 10so6450684wml.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4iA14pMte+lLwGaPb2y/KEmFhKOga8L8HWf/hgu+TMo=;
 b=K2Eyj06bf3tPKrM81ShncH+o9UPUrlfNh/gVA+0lHvDz4nGwvAjrLFm+EwlTJbJl9T
 hhwKJpQH1Mlh47ec1jkMdBGEjwOpLFTBNAhvNfuMujEJSLjk0hbdOReSC3IHMa/sdoV5
 OvIeOmDtJQaFiWdLBVh7uCJV7Ho0yzOafxAI5M5J5uvCThC6aKLAUO1m56bNJnl5i5rQ
 0WfVQd3g2nkw21oVGmZtLGNHAMngjFrgsJYDoH72++ufLYQzs2LvoENTPq/RJM1mel8Z
 1ujQVUIuNdH5U1sIrwM6L2GaPBu5YMx7eZwyz/BHZCNtp/8AET1ThOS8oC0R066M1hOY
 09GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4iA14pMte+lLwGaPb2y/KEmFhKOga8L8HWf/hgu+TMo=;
 b=aq+x0WDqDTYesNP08sy0KsF9H/yQ5A+zTOPacR+N1kwnMf3uRuhQ9tm8VPCsB+bKuZ
 C808dLd9CCnzrKDA7tx12Rr1CJzux7fKLiGlj7Sys9PV/LLws6zasfLzv127rQfYsLXH
 NxDDsltBHmmv77L3W0MrHeEqT4sW/p9t8jLgwImc3gjbrYWP+CDbVPz7jBg10mY7U5yT
 UpmnXjvCfqoYUI0qS3gDhqurk/shMHE8V4icNJ0PIRZB356U8NBSprSR8vRWCCg5aJdK
 a9YayT7wMD2N2bx7YmwTu6N++3+047Vcr8/C9nbauZo1JgykYEN1JDZj1ooDTgfykYg7
 8ptg==
X-Gm-Message-State: AOAM533a8IxfSC13BwtwbDXhVWKeUdZtxm3ycNsgMmEJdPKh35dVPs4Z
 KwbQNwFYmpUifYPhn0dyFCFrc3L9dbo=
X-Google-Smtp-Source: ABdhPJwkK9vDeSl0oD2yv3kQkwg9Uvw+UGDmoySB+VICWikI8scJa04k8TMlI3iOBmonFWBEZIqNEw==
X-Received: by 2002:a1c:4957:: with SMTP id w84mr13283993wma.84.1604912675079; 
 Mon, 09 Nov 2020 01:04:35 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id c6sm9331031wrh.74.2020.11.09.01.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:04:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 2/2] target/mips: Do not include CP0 helpers in
 user-mode emulation
Date: Mon,  9 Nov 2020 10:04:22 +0100
Message-Id: <20201109090422.2445166-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109090422.2445166-1-f4bug@amsat.org>
References: <20201109090422.2445166-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CP0 helpers are restricted to system-mode emulation.
Do not intent do build cp0_helper.c in user-mode (this
allows to simplify some #ifdef'ry).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cp0_helper.c | 4 ----
 target/mips/meson.build  | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index e8b9343ec9c..caaaefcc8ad 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -32,7 +32,6 @@
 #include "sysemu/kvm.h"
 
 
-#ifndef CONFIG_USER_ONLY
 /* SMP helpers.  */
 static bool mips_vpe_is_wfi(MIPSCPU *c)
 {
@@ -1667,10 +1666,8 @@ target_ulong helper_evpe(CPUMIPSState *env)
     }
     return prev;
 }
-#endif /* !CONFIG_USER_ONLY */
 
 /* R6 Multi-threading */
-#ifndef CONFIG_USER_ONLY
 target_ulong helper_dvp(CPUMIPSState *env)
 {
     CPUState *other_cs = first_cpu;
@@ -1709,4 +1706,3 @@ target_ulong helper_evp(CPUMIPSState *env)
     }
     return prev;
 }
-#endif /* !CONFIG_USER_ONLY */
diff --git a/target/mips/meson.build b/target/mips/meson.build
index fa1f024e782..681a5524c0e 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -1,6 +1,5 @@
 mips_ss = ss.source_set()
 mips_ss.add(files(
-  'cp0_helper.c',
   'cpu.c',
   'dsp_helper.c',
   'fpu_helper.c',
@@ -15,6 +14,7 @@
 
 mips_softmmu_ss = ss.source_set()
 mips_softmmu_ss.add(files(
+  'cp0_helper.c',
   'cp0_timer.c',
   'machine.c',
   'mips-semi.c',
-- 
2.26.2


