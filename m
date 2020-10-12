Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F69C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7848C20776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWG8uj5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7848C20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRumt-0006to-Ac
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuc1-0001R8-8h
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubz-0002tW-K4
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so18461975wrq.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MXkPVd2aO8qnDLNyGp6W47ZEx+VHl+jUfpvG7Jg6mWc=;
 b=kWG8uj5CVJq0UUdFxBkQSCdGju9p13Sxx19mrHzoOQJNS/GooO239Br20eNNf1CPPW
 ERlFPx/nW0p4HnfvpGOLybQyxVF6K7+K6t75rH+MbB/50a7BoxZxt8YTbSKuhLli+fFz
 DTl8/hTb3NfcXb3mr/pTncOZ+sX5t3rvuj+RunfEFRm3AU7Jam7y9Kb0klhx7VTrXcVn
 bGMi3ghQYaLpewUr1+e8AXJJvq559xJ+b0hNSQMmLYU362pqsAYPJcouWkoJ2J03R8kO
 Wu7zyXvKVK5vnU09YSoT253TERCuJlwpFX6Jn3umDWB5W5QBl4dWkwjWpLGjlthzT+X/
 xgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MXkPVd2aO8qnDLNyGp6W47ZEx+VHl+jUfpvG7Jg6mWc=;
 b=k4sN0yrVG9C/6EEpYZ9VXMpZWNf6z/6bVeUQWgReNRj32qhk5HnLiEIAd7WASmEJtc
 xA8By85icqb3Vx7S/NO3JFUT347lbClZAIzpBLDYl+8TP8aRxG7iRWsvXFvfeRC/QjZS
 MtQe1Qm3UAAjy1QtB84VrbJx87WHQuSp0n4UwinwP+5fLFR4mBXMyUgcUpDoMmCvnkf1
 8ORcgkluveF798bA4manvRDCkI5ksvXYcZKlpAKcP5/T2dT1uAOYFnyOnEJHB0RcNfvZ
 4cV+UnfGoWqfWpX5/6H3VTIObi5KYaMe9IMtf/4z5uX/IU3V5CUMYbdblvuSCFP8sg6P
 0avg==
X-Gm-Message-State: AOAM5319w8sfmVhVdmHp79n3sQFjRfIhQfcuoBRzqAlGVezHkXM7Cxsh
 Dl4iCfgG5bKf/15Mp64+/JyWDf5lR2A=
X-Google-Smtp-Source: ABdhPJzXbfmfiiXt1SFn+K4dFVRj8kz2coFcKsyvelzPQV1ftK+7oHw9TdfMlEUAFZgr1CPcoRgBrg==
X-Received: by 2002:a05:6000:104c:: with SMTP id
 c12mr27933386wrx.133.1602496761825; 
 Mon, 12 Oct 2020 02:59:21 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d9sm21817241wmb.30.2020.10.12.02.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/21] hw/mips/mipssim: Correct CPU frequency
Date: Mon, 12 Oct 2020 11:57:58 +0200
Message-Id: <20201012095804.3335117-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

The MIPSsim machine CPU frequency is too fast running at 200 MHz,
while it should be 12 MHz for the 24K and 6 MHz for the 5K core.

Ref: Linux commit c78cbf49c4ed
("Support for MIPSsim, the cycle accurate MIPS simulator.")

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


