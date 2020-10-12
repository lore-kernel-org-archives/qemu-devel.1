Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32CC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F5820776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSzzEjhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F5820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRunm-0008Ga-GF
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubw-0001Ky-4t
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubu-0002s9-O7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id q5so16936662wmq.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=apVjxDybnUJ2U2TEJYATAtdpZBtLB//EdpC/ZilWuQE=;
 b=nSzzEjhPctxe9QsUSyqylr7c3tpctrzNtfBHM9Pl8ydyfDKJ7yqCQgLnG24ISj/M9f
 9NtU4O9rbbUJkGBSkmchUcaGv5MPWSkh/eIxAyvueoRE+5UafBAIiCiuydWk5cpRXR1g
 XZjKMtLjppFinH7IhTfoCAPN67fKeq2XkPGye6IFHhC9cUAjaj/HgarABM34r3eWbF2+
 haOPKgv+cJaizCQdHM0eeJQkPjKWlMG0eNat1+kj2kkC+eRZcXOdpjZQw4Kpy386HF0p
 0QfbVkZi0Pek6KHC7tlMIYU+1OtHVKj3DAOmWxYZe0m6I3vhk990OaaEb/nunv5jLbn9
 PQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=apVjxDybnUJ2U2TEJYATAtdpZBtLB//EdpC/ZilWuQE=;
 b=ED0yJm3/m1ODZGJGIl8mjb9/eYRvnwm2BPlIUcj5Zu+3YDHDFLQmYWVBWdRUGv95xS
 vBMcZ1wk3761/vLuoZ8tfhPkXDiXlgjSvEG81GG61I8+Epl9vA2W0b4Gfv73CKtsKgIQ
 hGCdWqyhE5uJ5FCcA3P/r+GDAXfHiHglkHsORZcaLmhfstTrd/VUPwxCI20qdtZCza1H
 HNk5wkbazBUSQMp4C9hJ+bVDCv2CD9ANb6+dl4Qoy2243KgzmEgyzdhH6q91GyORKnpT
 Nm/6AVp2XCFP3NvgV16d88UOzEGJsY2tHreGgc8N4gov9rPlKUSomS2UX0w3JXhEcW+p
 V/pw==
X-Gm-Message-State: AOAM532r/F8g19ZWZqRGlu1kbqWzSU8lP6UHk/alb2hOQTbYJh4YZS1G
 iSCrRk9IeTxfAEgVJwhWKkR3PFE99UQ=
X-Google-Smtp-Source: ABdhPJxOaL+rCn+r5vVaBXVGmBBsLcYnWRpV8tN0xohvr7XSTDNWMyuI9Xkz3/7IRZIvqnndZAi03w==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr10020738wme.188.1602496757016; 
 Mon, 12 Oct 2020 02:59:17 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a199sm23646142wmd.8.2020.10.12.02.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/21] hw/mips/fuloong2e: Set CPU frequency to 533 MHz
Date: Mon, 12 Oct 2020 11:57:57 +0200
Message-Id: <20201012095804.3335117-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

The CPU frequency is normally provided by the firmware in the
"cpuclock" environment variable. The 2E board can handles up
to 660MHz, but be conservative and take the same value used
by the Linux kernel: 533 MHz.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/fuloong2e.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index b000ed1d7f7..b8234f61083 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -23,6 +23,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "hw/clock.h"
 #include "hw/intc/i8259.h"
 #include "hw/dma/i8257.h"
 #include "hw/isa/superio.h"
@@ -298,12 +299,16 @@ static void mips_fuloong2e_init(MachineState *machine)
     PCIBus *pci_bus;
     ISABus *isa_bus;
     I2CBus *smbus;
+    Clock *cpuclk;
     MIPSCPU *cpu;
     CPUMIPSState *env;
     DeviceState *dev;
 
+    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+    clock_set_hz(cpuclk, 533080000); /* ~533 MHz */
+
     /* init CPUs */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
     env = &cpu->env;
 
     qemu_register_reset(main_cpu_reset, cpu);
-- 
2.26.2


