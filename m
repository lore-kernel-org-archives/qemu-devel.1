Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D16C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0167A204EC
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xgLGtE/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0167A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYI1-0003BT-7E
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEa-0005xb-1y
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEY-0004fQ-6O
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id g18so14079470wrm.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GNnYdzaF3r1xGcDpbFt33icK43InuylWrRKeXCca234=;
 b=xgLGtE/GGCPBsNxMCFIFDLanp2OeMp/Q8joY9oW7xxzMlNKbMmcv+w6ruOdE/IvrO1
 qYK+xhuIZkxNWqu3+z+rASUkaO6K69f9VmLfxww9eO++VSCBC3BsvTfL/85dIwInOq2H
 VgANrAJ1CeABGI47Z7ILyOtrmqkkZTtM4TNXWIJh+ZFEoM7Q8mYh5KUuxpMnJyFdVmVy
 u+dc181ohN6TaKtfIVssfi791LomhfBciglyOzVVVUuQmztO92GmZA9uSklqgs94gfS2
 0zD00J+5xeD4TN9Ohv39rfY4tyzC2498pYjxVjIycWXPA0wOrMvLZnNxCQuy8gh613xP
 hQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GNnYdzaF3r1xGcDpbFt33icK43InuylWrRKeXCca234=;
 b=hfjbcVqnJ9imVtZqSuXvIfBGq2u8uRnqxW2XYhvq6gh/HK/Vb3hQH2zNCSBSRQw1Im
 vfAuqjnqa0H900ZB2EkbVrbhouXOMpFzFt3Q3oiYmRy3w8502UCM0IuNc3CTUfJnMv7I
 oZG08pj67s5/hrAG95U+9+zVfHPRLva1HhJqi8FtGruJqrG6NseajBweDwgNXOjzZwJM
 HG7ZHeO+jmoKiix4ma49MzynzHCN1tRp6kNh1HOwEUZuYTsns2n1QYSEXW8wqKHmGxDq
 ttfz3fDnQdSwMDtDGeUYRQ4IGpU97o7NLv2yjtOLS/URNkXq/029fettB8HPVilndvj4
 UTdA==
X-Gm-Message-State: AOAM5335hTUE7yXsqkuEcPbvCVMiBnNK1dFXqk3UZmNOz7VcCJOktRYG
 0bI8Oyifmnoj51gOpvhQ0p90lg==
X-Google-Smtp-Source: ABdhPJz9KTyUbB5QVik12U//ZiCY0dNVF6Wdcpzcy9IcdEsRsJxGeGzLrZq2zxMMa3pTnjRxoseiqw==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr13472284wrt.191.1593354276958; 
 Sun, 28 Jun 2020 07:24:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/17] hw/arm/spitz: Keep pointers to scp0,
 scp1 in SpitzMachineState
Date: Sun, 28 Jun 2020 15:24:16 +0100
Message-Id: <20200628142429.17111-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep pointers to scp0, scp1 in SpitzMachineState, and just pass
that to spitz_scoop_gpio_setup().

(We'll want to use some of the other fields in SpitzMachineState
in that function in the next commit.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/spitz.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index f48e966c047..69bc2b3fa10 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -48,6 +48,8 @@ typedef struct {
     DeviceState *lcdtg;
     DeviceState *ads7846;
     DeviceState *max1111;
+    DeviceState *scp0;
+    DeviceState *scp1;
 } SpitzMachineState;
 
 #define TYPE_SPITZ_MACHINE "spitz-common"
@@ -845,22 +847,23 @@ static void spitz_out_switch(void *opaque, int line, int level)
 #define SPITZ_SCP2_BACKLIGHT_ON                 8
 #define SPITZ_SCP2_MIC_BIAS             9
 
-static void spitz_scoop_gpio_setup(PXA2xxState *cpu,
-                DeviceState *scp0, DeviceState *scp1)
+static void spitz_scoop_gpio_setup(SpitzMachineState *sms)
 {
-    qemu_irq *outsignals = qemu_allocate_irqs(spitz_out_switch, cpu, 8);
+    qemu_irq *outsignals = qemu_allocate_irqs(spitz_out_switch, sms->mpu, 8);
 
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_CHRG_ON, outsignals[0]);
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_JK_B, outsignals[1]);
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_LED_GREEN, outsignals[2]);
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_LED_ORANGE, outsignals[3]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_CHRG_ON, outsignals[0]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_JK_B, outsignals[1]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_GREEN, outsignals[2]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_ORANGE, outsignals[3]);
 
-    if (scp1) {
-        qdev_connect_gpio_out(scp1, SPITZ_SCP2_BACKLIGHT_CONT, outsignals[4]);
-        qdev_connect_gpio_out(scp1, SPITZ_SCP2_BACKLIGHT_ON, outsignals[5]);
+    if (sms->scp1) {
+        qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_CONT,
+                              outsignals[4]);
+        qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_ON,
+                              outsignals[5]);
     }
 
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
 }
 
 #define SPITZ_GPIO_HSYNC                22
@@ -943,7 +946,6 @@ static void spitz_common_init(MachineState *machine)
     SpitzMachineState *sms = SPITZ_MACHINE(machine);
     enum spitz_model_e model = smc->model;
     PXA2xxState *mpu;
-    DeviceState *scp0, *scp1 = NULL;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *rom = g_new(MemoryRegion, 1);
 
@@ -962,12 +964,14 @@ static void spitz_common_init(MachineState *machine)
 
     spitz_ssp_attach(sms);
 
-    scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
+    sms->scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
     if (model != akita) {
-        scp1 = sysbus_create_simple("scoop", 0x08800040, NULL);
+        sms->scp1 = sysbus_create_simple("scoop", 0x08800040, NULL);
+    } else {
+        sms->scp1 = NULL;
     }
 
-    spitz_scoop_gpio_setup(mpu, scp0, scp1);
+    spitz_scoop_gpio_setup(sms);
 
     spitz_gpio_setup(mpu, (model == akita) ? 1 : 2);
 
-- 
2.20.1


