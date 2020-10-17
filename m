Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB68CC43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD8420657
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olCb6qdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD8420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn8C-0004yY-K4
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmp7-0002oC-01
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:41 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmp5-0003oM-Df
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id h7so6604146wre.4
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RVpDTlE+erpFb5VKlsMSt7Bi8xmM/yPxH3xBl9KpxtU=;
 b=olCb6qduyY2UmWFDxguyfTzByj/6QvaiOGVCBu865dPC+977VUl7fUVGoiawDwdrmW
 K1Bfp1QjlK4oSazp7MbC6Y+C9M+uDAhl3D7x73RM6V/ZJuewdkTnx6d80OOsIuqXyB3j
 wJ62YtXUPuR7MiDci2gYUuP59TFRf3kmtvKiqJ3Pp9S/fcnHkw7Z8xZ9TSfSOtnogj82
 EMEQWSzVAvLD1FdiMMwuzWKK5wRD+xgb5hmumLkvcN2E+kZH3LmwGJ4otE9loNp9qwkD
 3qkVy5BtPzmda1PFVVz7BKcV9k0284cEJ4N9edrj9oKLfVQxDYjrsPKmII9ruUkqAcZz
 f47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RVpDTlE+erpFb5VKlsMSt7Bi8xmM/yPxH3xBl9KpxtU=;
 b=r1q3YzPwPWrpgIQ1QKnyjxKIGIsc1yUwygE5Fad/1EC7umzcf4aGtzeBIPMy5RYBRJ
 Me2NPb9r6D6res/BIe7NemMsjvLBfhx0qqDShL8zG17Qyydid9pNsiHAnwCt9fR4ML/g
 ZutwpjLNHNm0zPBn59UqP2b8euElsfktKPiZiJafZNpDVG0QBIhzQojHkMBB0KART8ru
 lYDawc826ZxFz74eHwGVtiygiPfaI2MwiQGaYWUuOWRNSNOsuVnT44DVoGwZsu/IKfDY
 LFX3KM6WsTx8vwn7J4pX6s4sYlxc7vBn5eNr0AtL67+bf/qJS3jm//wTYWmNqyFZmSUN
 4cUw==
X-Gm-Message-State: AOAM530zF1Bucz+xjiD2JdEyGpQqZz6fm+B2/GAzu91cPmb1f4z+T1A1
 sjsx0OYGcdReejaGuyrka56H4houQc0=
X-Google-Smtp-Source: ABdhPJzd2DPD4PRYqXoc5mdju30MlEtlO79KZdouSZdk5Fqvu0EWZNaaFsacCDeiWyqDDClemqW2fg==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr10869289wrp.394.1602943477938; 
 Sat, 17 Oct 2020 07:04:37 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id t10sm7295832wmf.46.2020.10.17.07.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/44] hw/mips/mipssim: Correct CPU frequency
Date: Sat, 17 Oct 2020 16:02:23 +0200
Message-Id: <20201017140243.1078718-25-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
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

The MIPSsim machine CPU frequency is too fast running at 200 MHz,
while it should be 12 MHz for the 24K and 6 MHz for the 5K core.

Ref: Linux commit c78cbf49c4ed
("Support for MIPSsim, the cycle accurate MIPS simulator.")

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-16-f4bug@amsat.org>
---
 hw/mips/mipssim.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 5d4ad74828d..f0042f7f436 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "hw/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/char/serial.h"
@@ -150,13 +151,21 @@ mips_mipssim_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *isa = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
+    Clock *cpuclk;
     MIPSCPU *cpu;
     CPUMIPSState *env;
     ResetData *reset_info;
     int bios_size;
 
+    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
+#ifdef TARGET_MIPS64
+    clock_set_hz(cpuclk, 6000000); /* 6 MHz */
+#else
+    clock_set_hz(cpuclk, 12000000); /* 12 MHz */
+#endif
+
     /* Init CPUs. */
-    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
     env = &cpu->env;
 
     reset_info = g_malloc0(sizeof(ResetData));
-- 
2.26.2


