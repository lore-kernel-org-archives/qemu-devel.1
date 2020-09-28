Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85ACC47423
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533BB207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf/Bt2MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533BB207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwoO-0000rd-EJ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwko-0004D1-II
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkm-0006Mr-HD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id c18so2190362wrm.9
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6OmfazZDAU1jqH5hop+ugOyeziIPqUJ/0u91dBdRy2M=;
 b=Cf/Bt2MUD7CUtRp+CGf5HpM/cHjfw2yXNF8cxqD1Jyf2t9Kg9t6K5asVbjOURD4N3G
 V2lEHwj5x3zR0cmQ4AWLHMbNKmQq+2B73fqHIByAyWZ+BkMRii4BXY30wnagySCXbqfv
 xhUqnLypLy2i6wlUNstaAAmQLEb7QCieprmncH8NP5LJSEYCk0hHqdL9lgf1YIobSCdY
 qcZpvkFoKM2s4lulXyzspvobVRABr17fdijAR40B7iJbD2sr3CoYYV1CfLEDBbaeavZM
 WwuUgXMhr9wyiam3Cr1DcqxV1qbal9QtY6HaTrh4b07shJW3BxQk31OHcKxhIt0xPZcy
 1xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6OmfazZDAU1jqH5hop+ugOyeziIPqUJ/0u91dBdRy2M=;
 b=ugVKB6CqjfA6gUqGANejREjNFBx+Ynqg+CugFRHTZGlyFLNjc74Cs1sXkMYcgIJx90
 Mg+5Tk+Li8MoC2P5+2fUzsH8l3Ypi0r/356iI27+cZvcYbU3/BhLzc6A1yMZ20IIK4Ms
 bQGe7LUnEkd04XAahjWrbw6GCwoBTJ3fxMNNPgg72MjvdKQzsnJmUpqQ0tDI879X22z/
 qyHFYUsFI3bUCjTsvQRXMzSriOzdbY+PRYQFZoHMhx+LH6WamjLJlxXbx/wZVw9UQGmj
 a+HCYcClbeHxRpZOObw02D/0qo/YZ4x2eQisBEBXct64Ijx74a0KFa5wGt1XPoZ7DP+E
 FTHA==
X-Gm-Message-State: AOAM531gE188hGHioAYW2fUujRuiDFJBbB6qCsI9CQn7nRQaXZg0ezlu
 STquM+V+mZeMYE+gKBV0igROim1hDHA=
X-Google-Smtp-Source: ABdhPJwPjTlwNwQjNQ/Jh02/STpx11zAFr0lQ+kegjfvIm4+/ONqN9ZG76jyYTg0UsQeJJt6SY/ZaA==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr2717046wrs.186.1601313354921; 
 Mon, 28 Sep 2020 10:15:54 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] hw/mips/fuloong2e: Set CPU frequency to 533 MHz
Date: Mon, 28 Sep 2020 19:15:31 +0200
Message-Id: <20200928171539.788309-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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

The CPU frequency is normally provided by the firmware in the
"cpuclock" environment variable. The 2E board can handles up
to 660MHz, but be conservative and take the same value used
by the Linux kernel: 533 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/fuloong2e.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index f28609976bf..1a925dcc201 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -28,6 +28,7 @@
 #include "hw/isa/superio.h"
 #include "net/net.h"
 #include "hw/boards.h"
+#include "hw/qdev-clock.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/block/flash.h"
 #include "hw/mips/mips.h"
@@ -300,10 +301,15 @@ static void mips_fuloong2e_init(MachineState *machine)
     I2CBus *smbus;
     MIPSCPU *cpu;
     CPUMIPSState *env;
+    Clock *cpuclk;
     DeviceState *dev;
 
     /* init CPUs */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = MIPS_CPU(object_new(machine->cpu_type));
+    cpuclk = qdev_init_clock_out(DEVICE(cpu), "cpuclk");
+    clock_set_hz(cpuclk, 533080000); /* ~533 MHz */
+    qdev_connect_clock_in(DEVICE(cpu), "clk", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
-- 
2.26.2


