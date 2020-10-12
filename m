Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB71C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2D220776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWG18BDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2D220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRugi-0006lK-JW
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubX-0000po-O2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubW-0002pr-9t
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id k18so16938272wmj.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5dM1prX3X04GapBDfDTo/Yh6oDCmLyBdhUwYpLbSa6w=;
 b=oWG18BDpdc04Bx/JDKi6avBzZAJMrSZDk7qquAXpLo+hStIui+sdSaDJhd3OJZaefK
 SJogdUUyF52NApSt2PLDtdMfes7jY39VFVnlfwohEO39wOc67dDnuCrMY4/80I658uav
 W7cQKmRmy3VkiV/S7Ql33vIO09j2sSwo97tlwbySMmR1fpaOD9N0RPuDLhF6YtykgHpe
 n7jQDZ0cfsRE7aqJuyFaWApyZtUnbLeBQdLtSCjO/YinZ3f9rGBkjGczJ8b9zF75oFc5
 jmXk0oVls/peqal2WnpoIHy7ID8A2fwmu9DPpO6y2U7JCpwvoITKM/PFVNZZza2W0RGP
 RzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5dM1prX3X04GapBDfDTo/Yh6oDCmLyBdhUwYpLbSa6w=;
 b=dGM4c6VIYcijLofmm7uYtIbk4qbvfADPdMlFXPc7XUgg5lfPgo+f6kMwZ41JAJ5Mpo
 Ec5CWFI69MJI+v7a78Cu2sTZQ71ZfB9VvtDjSAJ/N35sgs8Mrjwn6GdI/ZMiP9vl6tG7
 UAbA3GJc+kBXic7sOiE6zt3mALr8GsNjwXl1El28dR93r+t7SDqF4UjXeMV3PXbOjDxb
 1nv5DF28JbKhSBl7I6QcczDWM5ymLUVtCmmVswNH/d2YDzNsUB8bnqFB+xN51pCN3eur
 wbInOkl080RPJ7/Fnp9Fom7q0DWh6jVV1xfMt+Tbj67WAKAFJIqUS/mxX7g9+2n4Z28v
 aoKg==
X-Gm-Message-State: AOAM533Lg4aHSjfZ9HCYKDgsRf96/Gy5wAyTBQ2hkwTOkSlGoV06Ju6g
 z8VYtFnlrs2Bj5saYqHjq6Ia1DAFiF0=
X-Google-Smtp-Source: ABdhPJyBM5GPazNhKDCAInhdt12GfOgErmbGcZmW/Ev96kd/1MTPVrSBH/Vc5VuVrgNh6HpuucEakQ==
X-Received: by 2002:a1c:e089:: with SMTP id x131mr10479209wmg.78.1602496732821; 
 Mon, 12 Oct 2020 02:58:52 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y66sm6112296wmd.14.2020.10.12.02.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:58:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/21] target/mips/cpu: Calculate the CP0 timer period
 using the CPU frequency
Date: Mon, 12 Oct 2020 11:57:52 +0200
Message-Id: <20201012095804.3335117-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CP0 timer period is a function of the CPU frequency.
Start using the default values, which will be replaced by
properties in the next commits.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
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


