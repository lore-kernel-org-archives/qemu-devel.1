Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C90C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1462245F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA7Rs5Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1462245F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIjm-0005z0-Eb
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdt-0000fe-53
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdk-0003ru-Bv
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id 13so12892024wmf.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KF4jlo0OyNqwMyy2jqY6Lx0uD1/IYTY4WjoEWyppwjE=;
 b=AA7Rs5VszEbANgkzAn984Y7CYBeIXauxkDnhEkkBTVfBr/+9tTV5pQ0RL+5lbtUzLv
 d6CnsGIVTPXRTnAloPfEVgGuQ4ct6tiuRAdYOTjDaEEsRromObO4mANlAh+BUFx/4tS2
 vEWpsxEB00pwttKsTeXCG5uy+A5GxaeDU0KI07UjBSoqHONF56ETHXzjRzKNDNscGqqx
 K9YOMv/H7Ov6mc3tfsUTFE5nf6qJhsYPK4tc0BMzRU+ReSKvNVmzSqHO+4o5RoWD8v9p
 Cwude9S6poYz23MrcCPz9bBCtQNSIZJHZDdsUImSCrL/kkfeVMj32ktgdhKrpzZJ7EgN
 +6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KF4jlo0OyNqwMyy2jqY6Lx0uD1/IYTY4WjoEWyppwjE=;
 b=Lf3lvU7hm3NR3tyDzA3kax/IE/L0m18JFQPrtpsBkLg2LfVZSukkbkofRHNOpmJO0o
 rE+4AQtn7nwFsOapr2D4aEDo6LyPeTUdIU2+tsmUBv7K+Qo+QGlmUX6lWA6tQ+7Ug4Ak
 804gcPcgd5vWu8CL5wad23+um54YIcEO2U093hpVV+XNDwD+pPrFpykB5NnexTzKH5W4
 RGR6waP2sSRziFjBQ1MqGamLoed+THemhk8ufx0JURVH+m2y/J51tIu4W4FBRpRJP52n
 cBnTakIGL4KjIxbXyBItUsrucfGShO2RATec9G4qb0Bi5kSw0Lus9uthJAaulBQWn3tg
 dTSA==
X-Gm-Message-State: AOAM5320JJxb0mXwTpnliezbZPR2YOnrjWma+yI+7f0dm35AHuynDh9H
 RCCZsnXQasgO66E96+Q/2cdoMNCP3gQ=
X-Google-Smtp-Source: ABdhPJwc/hpVyPeuspmmFd3J81GwX9JNKjOu0RSWP2/ZmBq4tbGH4ag07vLFSpHww+f4DIMlafRZRg==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3448063wmc.84.1602350796893; 
 Sat, 10 Oct 2020 10:26:36 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/20] hw/mips/r4k: Explicit CPU frequency is 200 MHz
Date: Sat, 10 Oct 2020 19:26:09 +0200
Message-Id: <20201010172617.3079633-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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

Since its introduction in commit 6af0bf9c7c3,
the 'r4k' machine runs at 200 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/r4k.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
index 3487013a4a1..6d550c637c6 100644
--- a/hw/mips/r4k.c
+++ b/hw/mips/r4k.c
@@ -37,6 +37,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "qemu/error-report.h"
+#include "hw/qdev-clock.h"
 
 #define MAX_IDE_BUS 2
 
@@ -184,6 +185,7 @@ void mips_r4k_init(MachineState *machine)
     int bios_size;
     MIPSCPU *cpu;
     CPUMIPSState *env;
+    Clock *cpuclk;
     ResetData *reset_info;
     int i;
     qemu_irq *i8259;
@@ -193,7 +195,11 @@ void mips_r4k_init(MachineState *machine)
     int be;
 
     /* init CPUs */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = MIPS_CPU(object_new(machine->cpu_type));
+    cpuclk = clock_new(OBJECT(machine), "cpuclk-out");
+    clock_set_hz(cpuclk, 200000000); /* 200 MHz */
+    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
-- 
2.26.2


