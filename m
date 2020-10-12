Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D42C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F74D20776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2o77w4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F74D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuga-0006VC-H7
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubI-0000LF-OQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubH-0002oi-A2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id i1so12323885wro.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W69f1MWd6lsJIyf72MtAUNNqNrrt140PbQJ0VWAk4GE=;
 b=q2o77w4PonIUwOsZD1vKUPejn1owgAcjw6ECoTE/8+QbGSDdeda9Zxgpq0Ou00Nrgo
 9nPcELq+JiDLc5vPW7F051blAXDFGZimhEUCts2VYtVYji32vLtejqhyam1h9VPZ8XHP
 K1dMA7bWBxqNaGnRIwp27CAtOFGhZYbiqc89UdREvQbmyVo3otKIKLdjEhkkxQ2eeNUx
 lod7FU9H8z1hI/OSaiJ3VTlhVYaL3V0L2VfKAM93iLSafqgv064VS40SulQDs0a+LJND
 MtM1S4r2xcGDIEpyMFDcY7NniaXJchiH+1qEwx/k/gRrsQXoDAdPMJGl9jQUjFXYqyp3
 1eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W69f1MWd6lsJIyf72MtAUNNqNrrt140PbQJ0VWAk4GE=;
 b=c54RPYDhl7IT6uglslyZHA9IQi8iCiFq2jagxismnieRTtUv2tDFc3EyiHDIoUq7t/
 ytn0qVcpW1FGpfGwqtsZmN/lBMrhcSV9KtyUGf9tR+r9VyPNnH7VdI0lx3A5/MPV4WXs
 RAccEfKNST8764uKYrSeDUiUgfcW4wR31LevH1pjlnV09oOY+x32/z1Yklcw1TykVgMV
 38wvEaWzgVYnpXeHJ+NEJDVPvzKgB6cXVRd8Eb88MQRWbtU/q0r/WQPwngPRh1v6qQkw
 6K6e0nKXtgIDKwxz24T3ozkrdwgzcN60wKZyetXvwPiSxlPPTBwL398WqezEPy15Q19Y
 bNwA==
X-Gm-Message-State: AOAM533XMD8Y98+IVLq4lxaB3j1EmbwKdSmZswiGPamecQCS2eZvF8JC
 lqcvMHBpZtld0IlBqVUwc2m0hd75kRA=
X-Google-Smtp-Source: ABdhPJy1J0fwTHvZzL2PvVZuHpIQ6+1hkzG7l1VDGW1QGRwcjZUV+CVKWb45g4h7P/CUgS8BOEu3gg==
X-Received: by 2002:adf:912e:: with SMTP id j43mr28760542wrj.325.1602496717819; 
 Mon, 12 Oct 2020 02:58:37 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y66sm6111467wmd.14.2020.10.12.02.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:58:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/21] target/mips/cp0_timer: Explicit unit in variable name
Date: Mon, 12 Oct 2020 11:57:49 +0200
Message-Id: <20201012095804.3335117-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Name variables holding nanoseconds with the '_ns' suffix.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
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


