Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFC5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5592245C
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVcaN6s1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5592245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIg7-0002Kf-U1
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdg-0000cK-A3
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIde-0003rX-P1
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id t9so13659164wrq.11
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yECX+EErgKEGGyu+fq5dcK6AG/+Tqf8z/yJst+0jRiM=;
 b=XVcaN6s1ekbIoxMOzRyexjdBVNgQqUDmrZGilTjRJ9csuAZ9xZW/97j4xjaS0fPc7y
 U4XDyEsosyQ/GFp/M8GPu0JUh7xSHtCuQm1gmTYw51RLV3QIhxAx7eYdqxCu4p02i7Kl
 UujcpIyQojYPoMqwt9y1vrsx2sWd5avmXhhKVXr5K9b1ASRPRY87SgU4HykMkgAFP8CT
 r+PTgBZiDDJ27BWeQRA33+NBYhGpDvwTG1gTLczgXZZBTc07g3Ia3oTsC3tbCX0ZoFN9
 AQaOmXDMB148gWobRg/qOUZEz0hEorN/EihdKz7Dy/DElz6uVw5Ww/0Eq4xvfb6fYR6c
 Hvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yECX+EErgKEGGyu+fq5dcK6AG/+Tqf8z/yJst+0jRiM=;
 b=My4PdVjYjgD/2xyWZ23/Vv/BR6b0bkuHEsyJ1H2gOUj8DjGxwSKeNWgyU80pXtO5rV
 87YGtE76hRz/iPOuEbwmpqesMF/ntII73Yk3ojWCUjEHtZjtzw2k2sPofF7iOfjffY6z
 hfp0LHIHVJFvx4GW3xAGTxQfqiiGkvWdJquPJZGMyFjzoyLVKriybsC4HUyxfn8mjhSh
 xLnbk/dSEfoO/g9aWZHgOJXhHM0T/bv+WGBYagGOxgm0fRN2a6oCPDMjUNmTeI5+gpdt
 nqiSOvPYUg4Ismz2OPGui9k41nBFmlCQuQomzwm9nX46dEQrIgq6G0QarBgq1/QSV0it
 U5JA==
X-Gm-Message-State: AOAM533iluqaUqVV3TscbgGt74VmhtWlQOk89FK9SaX3yMqs0sxbzbXA
 /mPyAebIjriQGXK1C9vtxXvczC5UTGY=
X-Google-Smtp-Source: ABdhPJzoT0ZoFIh4H6Sd9ODIjjxJZT/88YaHsrSpwIwGmsy/ytZJMmpUw7RDUumapV0As97c9Qf9LQ==
X-Received: by 2002:a5d:558e:: with SMTP id i14mr22144049wrv.40.1602350793216; 
 Sat, 10 Oct 2020 10:26:33 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/20] target/mips/cpu: Calculate the CP0 timer period
 using the CPU frequency
Date: Sat, 10 Oct 2020 19:26:06 +0200
Message-Id: <20201010172617.3079633-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CP0 timer period is a function of the CPU frequency.
Start using the default values, which will be replaced by
properties in the next commits.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 84b727fefa8..46188139b7b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -144,13 +144,13 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
  */
 #define CPU_FREQ_HZ_DEFAULT     200000000
 #define CP0_COUNT_RATE_DEFAULT  2
-#define TIMER_PERIOD_DEFAULT    10  /* 1 / (CPU_FREQ_HZ / CP0_COUNT_RATE) */
 
 static void mips_cp0_period_set(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-    env->cp0_count_ns = TIMER_PERIOD_DEFAULT;
+    env->cp0_count_ns = muldiv64(NANOSECONDS_PER_SECOND, CP0_COUNT_RATE_DEFAULT,
+                                 CPU_FREQ_HZ_DEFAULT);
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.26.2


