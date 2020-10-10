Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B1FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D018207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmbwK9TZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D018207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLpB-0007sN-Hk
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiJ-0000b6-Qd
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiH-0007T2-4Y
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id n18so14171058wrs.5
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BslzpywZz3mbJWKAE8qW6xsdeqX9i4THsloWKfBnQUU=;
 b=EmbwK9TZknnui4PQOgQRnw5vZMBRygMvlsFVsqpCk1KVMxkXBOJYLRE/UA9YqiHwkw
 E18r+J7lGucOVtL9uT8fUvHNd1M9U/7QAHSfsMBQ/Z2wcUaS9yHEazHEDBh3i/9aS9Nq
 pz+nGobjsQWDzwKx64m9OhPiwPK+WOyFuyYakVlYKLm1C/7atYj3pqdIQxLW0CQD+CD1
 BiVSSFzrYen0FLzhmozgDQBjGNtSLS7uug78jPwMU+9yNdfe7DmIyloBKErJEdrv30wD
 wF3I6sAtMKhjjUJpfEoywFXGp6xWPSNYWQaR9dMd4WTpEddDzTtR5TgwdrA4LGu6Nd0R
 HoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BslzpywZz3mbJWKAE8qW6xsdeqX9i4THsloWKfBnQUU=;
 b=BegHr5qH/E914MromGCH68MLGnASD8ywsABrDcIrskUbiqZQvNvUy7xOku3gtUBkeg
 2kB9LKGpFofl7iQoUtgfEMvo5mMV9wMzbOnonfZVMyFoFHy7UZWsN6cyEkCBW5Xistfu
 YAYFvHOe+jSRz6vSl0A+qHdAkrKhB3uAMknOoZJioaFEQLCbak95hqvUv+mynYrEFN8T
 yJEtxnhQxEBBXgb8Arqs/7+RFhgM18xrR/YLqxsNJcObaI90WaHqVjsityyH7M2PyYLX
 qIowWZWsNXYrTuIzE0Z3r+B64glsYNWd+Ad9upngHqjoBkkqFSedRM3MbHFFElEdAGv5
 HZ2g==
X-Gm-Message-State: AOAM532OMTdWkBu5bw30Kw3F2F5m7ocdSaqWbKvDASMLz2F88ZJG9Brf
 UT5efdTRLge5a8mdiTO24eitUBbQJMI=
X-Google-Smtp-Source: ABdhPJzxcI4inkXz91djExO+yIevY0gkOJ1BWFgYfjPAUqtmvqSef6nnp3lj6HJccHSQ2RAmVy5Puw==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr21979890wrm.423.1602362611760; 
 Sat, 10 Oct 2020 13:43:31 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/20] target/mips/cp0_timer: Document TIMER_PERIOD origin
Date: Sat, 10 Oct 2020 22:43:06 +0200
Message-Id: <20201010204319.3119239-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
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
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TIMER_PERIOD value of '10 ns' can be explained looking at
commit 6af0bf9c7c3doc, where the CPU frequency is 200 MHz
and CP0 default count rate is half the frequency of the
CPU. Document that.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cp0_timer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index 5194c967ae3..6fec5fe0ff7 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -27,7 +27,17 @@
 #include "sysemu/kvm.h"
 #include "internal.h"
 
-#define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
+/*
+ * Since commit 6af0bf9c7c3 this model assumes a CPU clocked at 200MHz
+ * and a CP0 timer running at half the clock of the CPU (cp0_count_rate = 2).
+ *
+ * TIMER_FREQ_HZ = CPU_FREQ_HZ / CP0_COUNT_RATE = 200 MHz / 2 = 100 MHz
+ *
+ * TIMER_PERIOD_NS = 1 / TIMER_FREQ_HZ = 10 ns
+ */
+#define CPU_FREQ_HZ_DEFAULT     200000000
+#define CP0_COUNT_RATE_DEFAULT  2
+#define TIMER_PERIOD            10  /* 1 / (CPU_FREQ_HZ / CP0_COUNT_RATE) */
 
 /* MIPS R4K timer */
 static void cpu_mips_timer_update(CPUMIPSState *env)
-- 
2.26.2


