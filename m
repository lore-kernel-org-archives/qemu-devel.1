Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E99FC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C90207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfwaJNEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C90207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLqJ-0000a2-Ix
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiL-0000gH-Ka
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiK-0007Td-0b
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id n18so14171123wrs.5
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yECX+EErgKEGGyu+fq5dcK6AG/+Tqf8z/yJst+0jRiM=;
 b=GfwaJNExsizLquxriFCRHQzFaXkv6y2H5zsZT9gMWghchXib8taVWRuoAeHHsPZgTc
 EviPdKt7X8d8G0eLDSm83avfxKsEi/TQ3liJDtPKjj47dwyAHVV4MYGJGfeETeyfJp5c
 5Sd3lB2bdJHkjM7DL3vERUNVK8/uNXzCY/QNNktYwrih4bGEnJe6zBumWHM91xxyKvwK
 uT3fbE3fu5p9SsBT0WE/nuB2SuDXY3FbsHcuf18TDA+5Gkuar98kXWkBPtEKwwmJmqGL
 18iboMIhECZMXURaYAnGC87DwmCuQ83q7Q9s3BcmYjMeLVeWScNpAtAKmJrL5T1TBmAI
 lVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yECX+EErgKEGGyu+fq5dcK6AG/+Tqf8z/yJst+0jRiM=;
 b=Ei3kGEMZmcWC7DpwzpBit0zqts9GMG8Ei2GjWYyBrm3IuO/nBZ5cXqusOjTY4ZTTLR
 vAYpVj1SPVl8Ww7HEdVk1Zx46xdR7j/zEhla0rZyB/afqgTTMD030w8aNIMIdSA6y4r9
 SapU3LJwUv2iem6onfNibrEVdxG/aDhMT1tKTcXxV2XV7+2Ysnn7bPnOwkKpkNUgZBDS
 TfzZSHnVFBpIl2AGYgW17Ug0SpefgIccCKDoyW7iyoRBZAeTAa+yhdPFhxGZQUJ+aunD
 vol6K6/k9kRszsthgw3BRaAdMu2oRvM4LVxjsPWpjWnZUFI9UhLXgNkJPBGeK9jlh26m
 OaEA==
X-Gm-Message-State: AOAM5316m8Yw4mvgRzpHa6bK8N+kVhBU23dms8LHzKkhTBeOTp9HkvC6
 ex115LsUiosSim3YuxTj8I4YacuIj5I=
X-Google-Smtp-Source: ABdhPJzp6nhn+H1cCwDPQChnlEly5vTzmsjcfP/Mn9BoBGu2b50MvAgQJjvERPKU0sn857NTmunMxQ==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr9818042wrj.244.1602362614429; 
 Sat, 10 Oct 2020 13:43:34 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/20] target/mips/cpu: Calculate the CP0 timer period
 using the CPU frequency
Date: Sat, 10 Oct 2020 22:43:08 +0200
Message-Id: <20201010204319.3119239-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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


