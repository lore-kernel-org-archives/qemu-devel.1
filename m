Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0066AC47420
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22FD207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBmsFGLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22FD207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwoN-0000rA-Nl
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwki-0004BL-Ot
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwke-0006LX-0u
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id b79so1928882wmb.4
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2cYhkegMVCWJx5AY//3ZiHazS6O2MiBS34TtiHWp2eM=;
 b=hBmsFGLPnT0vkfFJZl2x2Cff7H3OCLzyPCG4Smvz+YK5XS9L7yRu33Wq5POaDbIgxY
 83LEXlo5uRa7bEIzl7j1Ewej2LIwsVMBVvloWyrL3NjiEdG2NHtn2/b7//ktRGBHLJpQ
 mnafozIUFh5Fv7OutvCDar1ewUHwlqUehdvpQtilCqImqg/ny5KetLU1umb4xrE+RELI
 y68PnXq/1YYwJXshLtrZkm26P/Pi/T9lZrNS/nMbvE4XUxoW7wyu2Km4gDC/xrwqlTvb
 84vsGbBZ6SO9hPdAi7XaxBbgFqD1NHqJ+i5/mXTqF5tREIcLNf5QxKMQSMYYHt0vuL1t
 xqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2cYhkegMVCWJx5AY//3ZiHazS6O2MiBS34TtiHWp2eM=;
 b=VX+GNw5bAieKFKxNYDSEP8lPsoxD/xzDXqlXmmKtzvFYrh2MSu+eHQmCtiv7Vj6FY+
 mGApLRh+87r+mM3dsIw076VHNpRcdsDsujAuXY9ZbMEYhSTXW89IG+4MvkX4dc7SFOM1
 PDSryk1AJvEpgLtgTX86LgAqVZTmTw67BW9zqxF0I2o3slpv632dR0t5R2w0HKrHh898
 +25UW5sPC/B0M3n+0b/7TVL1p8BVVaIWySfyz5M+GWbRv/JsI6ZxMTPGXuRiUoIWY91m
 jyx9mLSw+ERCbyDEuKJs08lj0AMUt2pLkKtzEwmQ57/+DjGkD+yoc2/2SMJd1wrNiwGh
 PjWQ==
X-Gm-Message-State: AOAM531zPrNbFy1dGcszLPzqykC82yfw0dSAmB2Mg3HKXcItnVal+qqK
 Yr8FcV/o9xy/qSV9CW3idjZVc/IC4jU=
X-Google-Smtp-Source: ABdhPJwcX/2tzK7qBAUthfAlGDnkpGlZz46ahe7sj3kfWDWtu4Q+a+5C4tLuSHzfkdflDHuI/Umhng==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr168548wme.179.1601313346516; 
 Mon, 28 Sep 2020 10:15:46 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] target/mips/cp0_timer: Explicit unit in variable name
Date: Mon, 28 Sep 2020 19:15:26 +0200
Message-Id: <20200928171539.788309-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Name variables holding nanoseconds with the '_ns' suffix.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


