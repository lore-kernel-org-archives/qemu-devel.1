Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DAAC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E7020704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWEl5lH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E7020704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn19-0003q3-7E
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoU-0002EC-2n
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoR-0003lh-PJ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id f21so6138188wml.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aXyjLY13V+nekeG3vOBz5nLcikYdxrMvA83lBS/TJQg=;
 b=uWEl5lH+/ghH1iLYgNFh7PkEInKgeOE/u4LGKtFZmNaJrd8m8/jIgfuNaQNQlXrciV
 qHejafDKTKRq426DLhcNAEcCwaZ2DEiNpKojFndGqu8kckHBsckqu3v+UZFaIp68UGMq
 1wtNuAmVgps/ejYzU2UfEQzyuckzxDdrxtAy1Sit65yLVdF6haRsWMkPcdzgnvmtgqkg
 waMLAlgvwqinGT+YJefGdtfuVWLzJ6iSI6fMnvr5wpBLZYiDVMZRQrnM3/r+Csp6X1rf
 N+/fj02m9zCqC+sb4W7fcCiFxE7XwVnEdeU6r/Q7Ri0N4z7+RXdiA0FaKi9i0E3oR8qC
 f1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aXyjLY13V+nekeG3vOBz5nLcikYdxrMvA83lBS/TJQg=;
 b=cJv8NV96apQPpriBH9j/Mjcn9gJwqS/UujMPOOpsqv9W2EEG9L+hBoq5pFMKJybXqM
 hbd2aYp+SPKH7vB0YkXnxN/SZ7ZHcr1NJW9yyW0H+uaIld6974zruWwWyV7DmYmW33DO
 Sigm+jr3tPtSY5AtaI0FmXUBqi9RSGzulUKm8KRxyiR7ZXn60KF1xEFKdoHCoVSuhHiP
 7b/ltJMR1BYdeSa9FXeIy26LXwAoCKzNy3xYC+ARb/mhsSZ+m8yB1ohIsQp37TUSj8ca
 B0iXRR+YtHmzmwoi7boCN6YTwCJabfaiI3Cm96MNd2Vh6LyWFLa/309UyxNisQNgy8n9
 CraA==
X-Gm-Message-State: AOAM533ncmjaWCWlKKEE1E+Lo+mbwx6N2ByKS7XFcdcFpPadKrUqaUvL
 hB1SW4BttBx1vGUhdPuAe452KsCrU/0=
X-Google-Smtp-Source: ABdhPJzwhW4mVi+f5x9wTnteifaIaWY7KcxpRoe6uMfIps/QYOVtdq/BcMmkU6mlXFvML8NSqsAC1A==
X-Received: by 2002:a1c:7707:: with SMTP id t7mr9214439wmi.54.1602943435807;
 Sat, 17 Oct 2020 07:03:55 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id p9sm7542621wma.12.2020.10.17.07.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/44] target/mips/cp0_timer: Explicit unit in variable name
Date: Sat, 17 Oct 2020 16:02:14 +0200
Message-Id: <20201017140243.1078718-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Name variables holding nanoseconds with the '_ns' suffix.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20201012095804.3335117-7-f4bug@amsat.org>
---
 target/mips/cp0_timer.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index 9c38e9da1c8..5194c967ae3 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -32,13 +32,14 @@
 /* MIPS R4K timer */
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
-    uint64_t now, next;
+    uint64_t now_ns, next_ns;
     uint32_t wait;
 
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    wait = env->CP0_Compare - env->CP0_Count - (uint32_t)(now / TIMER_PERIOD);
-    next = now + (uint64_t)wait * TIMER_PERIOD;
-    timer_mod(env->timer, next);
+    now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    wait = env->CP0_Compare - env->CP0_Count -
+           (uint32_t)(now_ns / TIMER_PERIOD);
+    next_ns = now_ns + (uint64_t)wait * TIMER_PERIOD;
+    timer_mod(env->timer, next_ns);
 }
 
 /* Expire the timer.  */
@@ -56,16 +57,16 @@ uint32_t cpu_mips_get_count(CPUMIPSState *env)
     if (env->CP0_Cause & (1 << CP0Ca_DC)) {
         return env->CP0_Count;
     } else {
-        uint64_t now;
+        uint64_t now_ns;
 
-        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         if (timer_pending(env->timer)
-            && timer_expired(env->timer, now)) {
+            && timer_expired(env->timer, now_ns)) {
             /* The timer has already expired.  */
             cpu_mips_timer_expire(env);
         }
 
-        return env->CP0_Count + (uint32_t)(now / TIMER_PERIOD);
+        return env->CP0_Count + (uint32_t)(now_ns / TIMER_PERIOD);
     }
 }
 
-- 
2.26.2


