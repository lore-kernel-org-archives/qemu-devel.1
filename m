Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B08C43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B57B20756
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEPscC/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B57B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn6g-0003HR-7W
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmp2-0002kB-Sv
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:55078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmp1-0003o1-6N
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id p15so6123471wmi.4
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2du0I+yb+HwbuymUy7ZKJilfZng7wrSnlIMlk5mAbJI=;
 b=iEPscC/Krn7YrA07zMjweZVyt0/W+ECwh9ZMJRBs2yXBAANa9yUZ6Hf2H+Ab3fWR0W
 oK+jne/InRQHMFjtMLRHAIXX5V82fJRj14ekuqSzzYg2uj1oLMOgJNHThBYjNpWwjc1N
 E1zbC9k1vy9DWuyyy9k5a/LPDb19nAXUV1zGJNxMETd1L9+6PYLiNv+xGlq/S6t8pMqr
 vmPhgzD6EzqPy29EtS04Fbb9++Ey4cBI+flF2vrUSKcj/whDZAyUfokz4lc3QRymgRnT
 2eLryTNVFUD7N88MUXd9KZ/bdogPy1DGKTK3aV9WuQzn0OT3rQubBv3MG3yWQL63vvMH
 zOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2du0I+yb+HwbuymUy7ZKJilfZng7wrSnlIMlk5mAbJI=;
 b=WLj64MmQ52/byVjgOF5+c+0D1pnkhdbAPbedpJ8+qloRC+hf3YsFoGvCR5uO8PqrBd
 NJVS3vlevqeVhWktu3Qyma8VXomqIFiiHSkBVN0y8v7dlojhA6o6KnL4yci6aMWR6nm9
 lIporh795s/l9jf5MC0ApwXdbFj7UbbYSiSHnwYDL9xYtp04GapAHUL5C3TMnSbpqRXY
 F3OTPkjVBn7lwAqQVlI2UO8ZGP1XHNptra1QpphZOJiEejLhoyAAqwn6c8OqKRsvb7bj
 c6bb2C9t66dW4+7z4M66X4jK46aa4xrWIIGlFSZd6DgvtGMRzpzMaB/BnEtvzp6yPE0f
 O0hw==
X-Gm-Message-State: AOAM533V6DdFajOicTmPI7LlCE3BO7mSiWmoCM2lCjiv6SOS54BzOV8r
 zFYgxmwPsilN1gRmpVN1OY42kK+3fp0=
X-Google-Smtp-Source: ABdhPJwJ6w2hjGX0HLJUBBmgfA1ehblMkszC93hdqLx70HXtb52c+i1jH/5ZIw+SVPzXwxhLZqleEA==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr8342558wmc.114.1602943473422; 
 Sat, 17 Oct 2020 07:04:33 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id i33sm9106111wri.79.2020.10.17.07.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/44] hw/mips/fuloong2e: Set CPU frequency to 533 MHz
Date: Sat, 17 Oct 2020 16:02:22 +0200
Message-Id: <20201017140243.1078718-24-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPU frequency is normally provided by the firmware in the
"cpuclock" environment variable. The 2E board can handles up
to 660MHz, but be conservative and take the same value used
by the Linux kernel: 533 MHz.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20201012095804.3335117-15-f4bug@amsat.org>
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


