Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC9C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF06206C9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKc2TIuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF06206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO34d-0006Jh-3g
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2nq-0006X7-Uz; Thu, 01 Oct 2020 13:55:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2nn-00081d-7R; Thu, 01 Oct 2020 13:55:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so6836969wrt.3;
 Thu, 01 Oct 2020 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M7t19Tqf063/zL/LgCE73iryE3zXZ+xrQJRxmqL2iCE=;
 b=kKc2TIuKF92KNBFSi2URXn92T85dgW2C8SiSZJ/RHPnyVPsl7jVgJFIyjIsQasMnuY
 ofmCFk0C2l1E4Fn5bICHm5J8gYcBsk0U/XOiXPdGwTUOl5lXsIXc3pLYhjyKqdqVI91x
 CR5E/tK0uLg2oDwgO2Yhy0CcptH4kIr7e/inmUsFSA/vfJfgHwYgiKIIAD/2ROcQcx5y
 CrO7d506C5pqz/4jwzVS6EpE2D/AUyItDeBBLW7z1bqUrA5f8p5oOzN13zy+RLK+FtGx
 HgaVw0FE3okAF3OITQNEtnbNh9CNNL21ih/htJQqhNWUemj20Iiy3Cs+rIPt3WHEglr4
 a3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=M7t19Tqf063/zL/LgCE73iryE3zXZ+xrQJRxmqL2iCE=;
 b=Oc6VKw3ilRrKLtCsh6oaV4r0kQuP0APwyRrSXIRL8Kevn/ru2T2j8YzCTCz8e2X9UB
 rAUkGQKHftof5R0hOGcKNiRFozvkQb/bpcY6Ed5nOoqR+SIuDQWCmEAieuE2QpAs/ZON
 2135BOaFJ7eWx6jB0GFkLkktZnfyOdejDpM67A+fR27JB0M7cgRuLJQo6M8fwPPwP+oe
 7Bd3Iikjcx1x+bPLPbOWQL9X34Zluqu1i3aBDrx44OjgbDyuMz5o/KBI1nPxp8/JxU75
 Gy0JNs7RU9QycQtS8WCqWx9foV5HE2kYyeVQpWD2q8NFhK+3XxcBDTuRnuSQ8tS1T4FF
 cWNw==
X-Gm-Message-State: AOAM530uMfTe053+Rx5WWPHac8H+Bj4miPL3wFwtfzer0vFOXqDhko/N
 lNH8DxRuw+KRdUcDinzBfWhwIwbaaVA=
X-Google-Smtp-Source: ABdhPJxoOib+QkZmeVBWkef8EGZKrstXlCvY0qmY/+U6AO/kYKPIz2PInu86qUIPOI4j+cub6vN3kg==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr10449649wrq.225.1601574933052; 
 Thu, 01 Oct 2020 10:55:33 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id i26sm1019315wmb.17.2020.10.01.10.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:55:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] cpus: Do not dump CPU state when calling hw_error()
Date: Thu,  1 Oct 2020 19:55:31 +0200
Message-Id: <20201001175531.1623361-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dumping the state of all CPUs is not helpful in any of the contexts
where hw_error() is used.
We already have cpu_abort() to dump CPU states and abort.

Restrict hw_error() to peripheral errors, hoping we can completely
remove it by proper functions from "error-report.h" in the future.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 softmmu/cpus.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index ac8940d52e..da45cbf989 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -913,16 +913,11 @@ static void stop_tcg_kick_timer(void)
 void hw_error(const char *fmt, ...)
 {
     va_list ap;
-    CPUState *cpu;
 
     va_start(ap, fmt);
     fprintf(stderr, "qemu: hardware error: ");
     vfprintf(stderr, fmt, ap);
     fprintf(stderr, "\n");
-    CPU_FOREACH(cpu) {
-        fprintf(stderr, "CPU #%d:\n", cpu->cpu_index);
-        cpu_dump_state(cpu, stderr, CPU_DUMP_FPU);
-    }
     va_end(ap);
     abort();
 }
-- 
2.26.2


