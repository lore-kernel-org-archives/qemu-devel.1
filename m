Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8C7C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2404C2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHC8jDSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2404C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGiA-00063N-1J
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGge-0004Tg-J9; Mon, 21 Sep 2020 03:56:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgc-0005th-I2; Mon, 21 Sep 2020 03:56:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id d4so11137889wmd.5;
 Mon, 21 Sep 2020 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JjzDLZKocLNXbXwLaMQHkkBQ+3Bkq4AUITFlMs6JsJw=;
 b=IHC8jDSZnQUPjMl9lRKd539CmVZ1hVNPFuEPK+oWYapd3NuIH7t8XLuxG0OTGJ66T9
 TNj9zMJ/zVqxfqF3TVzfQSXjH9nKYC4OMyZ7tgJOPFdGNaDYaWUQ95rcbmBN/G6qWlzO
 Q++ndGjzft3lNVaelaXKFFI87P9fPDrjOtutufoaSXYt+/P5E9okGouRE46kkZvpOdiz
 OnQbR6aTSoAm/skEB0Oly0+0prtcufibcp6ysZa3WV445AhOxoPfjzhQEgQyTICJ6xoJ
 8sNP7v7QeGqcR7CEtGkLBRES7Zjb1bVIoDXsoU46uaILClMz1RxJnlAzeu2w0fSL0Pzi
 tEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JjzDLZKocLNXbXwLaMQHkkBQ+3Bkq4AUITFlMs6JsJw=;
 b=WeSc4QtWS/+348uBRcVC5Z7uZpQEplsWvPMCKplY/Vz6Vl0AkocV3xBpRfX2l2/w0g
 0emfUcqtFCUwiq3jByMYH/FEVh3pCssyFffGcEKQQ2j5eyRxYLDKpP3yIlL81wnKHRyi
 9trZ19iMTpCWlOnI/4Qy23ilnT6I1rpyRVLpFGAWcQITTxXZo2nNvvzS7BKpWvTGbvVC
 C9u7omaO+0AbVAiKJsQQGle5d99fquPPGgPE8AgYFjWij9dESWzyD3PA68uXDR8+BcnK
 uAlTv8fyNvSgAGkd2ZSzGGuzuiy4zJ/NNEK8lLYAoQWNrRmY0X/LU3KG5YCQDwGnNEIR
 EKQw==
X-Gm-Message-State: AOAM533ZxHGmS6Y3x1XMmOdOmhKvx83+wvtjrAf6q3fuRITlNMT+qMZw
 dMyKGMyeGRz8DSBdDt45KnlBiCSQPf8=
X-Google-Smtp-Source: ABdhPJwkcsGzaGcAs3wJHX6D9hTJM8GvTCfkFXC82vZcZ+QO8TtLnWzbL/Na8lZQL4h2wHX7gawKKw==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr29369727wmd.95.1600674992712; 
 Mon, 21 Sep 2020 00:56:32 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm17807538wmh.29.2020.09.21.00.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 00:56:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] hw/arm/raspi: Load the firmware on the first core
Date: Mon, 21 Sep 2020 09:56:22 +0200
Message-Id: <20200921075628.466506-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075628.466506-1-f4bug@amsat.org>
References: <20200921075628.466506-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'first_cpu' is more a QEMU accelerator-related concept
than a variable the machine requires to use.
Since the machine is aware of its CPUs, directly use the
first one to load the firmware.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 46d9ed7f054..8716a80a75e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -205,6 +205,7 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
 
 static void setup_boot(MachineState *machine, int version, size_t ram_size)
 {
+    RaspiMachineState *s = RASPI_MACHINE(machine);
     static struct arm_boot_info binfo;
     int r;
 
@@ -253,7 +254,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
         binfo.firmware_loaded = true;
     }
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
+    arm_load_kernel(&s->soc.cpu[0].core, machine, &binfo);
 }
 
 static void raspi_machine_init(MachineState *machine)
-- 
2.26.2


