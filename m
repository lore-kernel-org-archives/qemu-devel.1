Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F537C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88652245C
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7W5A0+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88652245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIjb-0005ka-JV
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdu-0000fh-0P
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdl-0003sA-VO
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id n6so13370272wrm.13
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hdRhjIayqSG6GvTVj0uTOvZjLJ71MQG8ccDZSx/sEYE=;
 b=E7W5A0+vN4b5dNUXbFoPH01zRB2oloLAteRqSP620JSSdj/8AEfRB6obLGc+tDkjDz
 0p3fhEnFFp7/4Ja+b9ZS4sC8y3eTvJnwpDlduODWZOHhxG6c1h3a9xbQgltGsA6485Fr
 8XMi5u82gf/QL0NOMgjqpWEwO4P3xDp7qHGucO5VTHZV44duaIAsnwSNglawkgGLpg7a
 lVhIio3khjUreETVkW4KDFhAma8OxS281G11xaRmbl5b4MPnU0AIP1VIqD7hmapKDtEa
 aIAQo1tR1rKFISY6gHwU4N58YW++QF/qXwES0LcJPROIdm8ulhuD7GbWxfJXC5/ouOmf
 w+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hdRhjIayqSG6GvTVj0uTOvZjLJ71MQG8ccDZSx/sEYE=;
 b=aRWu644D5aooja3qXGcnvSjuMeVK1V0YNN0ygfuSSXDkxPrwTwZsIVzul67i5W/Lvy
 M19cJ0clAtkoC/+nUUPNA9DMS0Z5afPOCPoFO/JU5U5iRoYO1ewwD+7+5JxTCvRVTJhu
 Ar9nLYKQtAKmILDCDP3jKs26e1VFsOYg6yZd3OUZcewCL3cze2OxNtFhNt7JEgDRXbKo
 mxTcmZcvKFEVVQHUYW0X36lPZL2b0nqcpbisM5hXLi6SOeYoiz42ZXyIRtRYEJkmzYWT
 GY73ZZGCNmBMxtKt7rYigKomA3Y1ybN281tD0q7zDgXBTOQDvxiqaVXhmS53mbQWCXZW
 unJg==
X-Gm-Message-State: AOAM531r8/45zeDOOkCZDkk5saON+JPmKg8ThHDU8JYTNPDrmBP+zBt/
 CHxMG4faCwQ2Bcz8BHY3YFvX44oelws=
X-Google-Smtp-Source: ABdhPJwR+hr544T154ZceUdAVG8hfgVOrrTVrIqCJwJdKvc6Xl1XCu5vvNnq623zJnM44KyzksIxaQ==
X-Received: by 2002:adf:8b85:: with SMTP id o5mr7239211wra.104.1602350799399; 
 Sat, 10 Oct 2020 10:26:39 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/20] hw/mips/mipssim: Correct CPU frequency
Date: Sat, 10 Oct 2020 19:26:11 +0200
Message-Id: <20201010172617.3079633-15-f4bug@amsat.org>
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

The MIPSsim machine CPU frequency is too fast running at 200 MHz,
while it should be 12 MHz for the 24K and 6 MHz for the 5K core.

Ref: Linux commit c78cbf49c4ed
("Support for MIPSsim, the cycle accurate MIPS simulator.")

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mipssim.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 5d4ad74828d..ded96a7868c 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -40,6 +40,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
@@ -152,11 +153,20 @@ mips_mipssim_init(MachineState *machine)
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     MIPSCPU *cpu;
     CPUMIPSState *env;
+    Clock *cpuclk;
     ResetData *reset_info;
     int bios_size;
 
     /* Init CPUs. */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = MIPS_CPU(object_new(machine->cpu_type));
+    cpuclk = clock_new(OBJECT(machine), "cpuclk-out");
+#ifdef TARGET_MIPS64
+    clock_set_hz(cpuclk, 6000000); /* 6 MHz */
+#else
+    clock_set_hz(cpuclk, 12000000); /* 12 MHz */
+#endif
+    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
-- 
2.26.2


