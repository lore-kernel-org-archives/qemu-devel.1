Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15199C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 21:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A392B207E8
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 21:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgzyldTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A392B207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLyH-0003Wr-Lb
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 17:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiS-0000pv-Jp
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiP-0007VU-C0
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id b8so948540wrn.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ek5SrDH4GE8Do53h6I6t8PT0loCihX0nSv8eh5BL3UU=;
 b=tgzyldTZBrMZ6q4KE0b1fVBtOQB3vg3/zLST3xio/0Da/pwWDWRLGxDAOuUmlnhQWf
 aiAdLyVmqbg0WxzPuy8LnwJyhN+tLAISFb8Gc92Q84CQlbPB8GNkwrsxjXYag1NMkQ1v
 bEwTjzTz0D7cA8MzfwvyRNmtRgHpMHLj08rdnMTxzQG8K8c3NToqUvGycNDh5rQA//un
 ks5dB3GLIjjZOQlkjWrhkXbqL7QdO2V3tRAALckRfnoTem5LrnH4+LkQMYis8H8vBa1J
 A4+GwQKvZlmdAp1qfXU8eEeUrIHH5NWgoiwVumIk9eFvDEpfqToff/T/wzFPyR9iDnRp
 q6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ek5SrDH4GE8Do53h6I6t8PT0loCihX0nSv8eh5BL3UU=;
 b=To8t7k+DssZrmIi40vnZhfHNyeU2oVspjO+gngZxLzireMJP762J+UIH9Xgmos37BL
 VGqQjiGA1iViQlLUoeddbN5bPg3OsK6B0sY+6x9JJcYOyNPNVyAzm/oJhz0+/BZaf9OO
 qhTWEg019b6I3DTzMAbR0gRK+9XNOsL5SI+PSVXCvBGeauIH7LUnV68zyD7OKDkIrFFV
 qY6Ir5OtAIJWlusBvwSPGa7sxmCfAxM6LIX+skZBPOCUPaN3RfTtN4kXZMqaSB25W/Gp
 0zmPp07P4ilPrmaPSvb8IY0JL1y/nj+AbTg4A5Hj3oZG8cc7xxHoKzDU5ftkR3lke0Yk
 3HSg==
X-Gm-Message-State: AOAM532ROyfHio5Rsdwl02jbHlRTCtIN/Cc5bU0WUV4heY7S/6FC0YuI
 vT/+NF/M3/Td2B3Uvvs89iO8nE9Z+hY=
X-Google-Smtp-Source: ABdhPJzd3Eocv9z7xJb0SLs+euBqVf8vP41aduHT+MDR5PYrLioCLVgABEwH7AYTyrcUSVcMllXc7g==
X-Received: by 2002:adf:f7c1:: with SMTP id a1mr15774281wrq.399.1602362619806; 
 Sat, 10 Oct 2020 13:43:39 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/20] hw/mips/fuloong2e: Set CPU frequency to 533 MHz
Date: Sat, 10 Oct 2020 22:43:12 +0200
Message-Id: <20201010204319.3119239-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

The CPU frequency is normally provided by the firmware in the
"cpuclock" environment variable. The 2E board can handles up
to 660MHz, but be conservative and take the same value used
by the Linux kernel: 533 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/fuloong2e.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index b000ed1d7f7..b25c3df19d0 100644
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
+    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+    clock_set_hz(cpuclk, 533080000); /* ~533 MHz */
+    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
+    qdev_realize(DEVICE(cpu), NULL, &error_abort);
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
-- 
2.26.2


