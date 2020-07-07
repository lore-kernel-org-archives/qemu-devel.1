Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59892C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268C020675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzHyPr/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268C020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshOf-0007TC-CM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 02:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshNV-0005wB-2S
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:46:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshNT-0000cA-E0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 02:46:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so43767775wmf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 23:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vP24btoO2N26bkXvUhS4wjNttBxYNUYpNRsjcv1D964=;
 b=KzHyPr/cKIrdvveEuO2OAf7eUvo9MxJBWnn8fvSGVoYurYFhqMrb34vRqY3rEWAoLI
 V37cTqKovpX1epcBjM/UO6LxX0hHynQfCJx+g4QDV6yTMnJeBubZwSMQpP4rIXPvgXLT
 TJsRQhQd+zkjEhz6uBfYbNpwstlyJxNS2GWqeInbPqG/jfHJkKoB0ocx35dFzsmpnKP2
 9YFCePmpoNs3L/qxy4RT76Uc49+XLO2vWlH+Brvn8DWzz8lPIRKLUyB8A4bdi0uPYof2
 r8D9kAmBxjUkJFU9nadx6LzG8FMf77YGfpCOS1EX8Eexv17xcHXtpbYXdOZp6KFKJft0
 qBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vP24btoO2N26bkXvUhS4wjNttBxYNUYpNRsjcv1D964=;
 b=nzAxtNTd2V9A04yib5bHPLdTEZ4W8fK1EpKTulELKgelI53q0YiiBQo1zxiVg796kz
 RvrZd99k0DrdQcsOijxIcQf4qryfEhdVpNDmx9pPtae0dbr+w/KvlMQlqLY+UiKxxRAW
 AOfLZcaUPZ1FJ5CQO1vD/+JD42h30FEwmNiiqacUtB16CBnKN3T9ngYnVhvXadQgZxfj
 WagOXBZE0XoEC98EcdVBopD1HIwHwBjAN7flladsQ+Qzhc5UM7IJQyenfQ2uRd3uliAb
 Wa0b0fD5Wrcr03VAiWPqdlEeHX1/vMaJW35v1PTvyzDLoS2o8dNOZIso8TkRsVn4Dah0
 ZXnQ==
X-Gm-Message-State: AOAM533UshlmKbWWpPmvmuthHqYQDTgDl1bpDXPwcvgc/CzCCw6LRfMA
 QhWxzp9PDOs0qq5poGOqvW7rtOxy
X-Google-Smtp-Source: ABdhPJxLBh6XMrhAjGhjiI+BJza8VJpb0Gnuf4BQC4VdhDRc6FT6kZFtw8sxVBTY4EVhCRIf5yv7eA==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr2463826wma.129.1594104409883; 
 Mon, 06 Jul 2020 23:46:49 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 5sm2172545wmk.9.2020.07.06.23.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 23:46:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/avr: Drop tlb_flush() in avr_cpu_reset()
Date: Tue,  7 Jul 2020 08:46:44 +0200
Message-Id: <20200707064646.7603-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707064646.7603-1-f4bug@amsat.org>
References: <20200707064646.7603-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 1f5c00cfdb tlb_flush() is called from cpu_common_reset().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 4e4dd4f6aa..50fb1c378b 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -78,8 +78,6 @@ static void avr_cpu_reset(DeviceState *ds)
     env->skip = 0;
 
     memset(env->r, 0, sizeof(env->r));
-
-    tlb_flush(cs);
 }
 
 static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.21.3


