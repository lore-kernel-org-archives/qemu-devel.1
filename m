Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FECC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B8F20870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="me84YcsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B8F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPG2-0003KB-Hc
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxM-0005AM-FA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxK-0005hk-HB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id f18so25360363wrs.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PQU0VMDoZFuJFaraom9TI5EU5C92z+9V7Vol+wly+Aw=;
 b=me84YcsNO+e/d2ilC8Fuhz7444zRvDy0bwTdafc/KntclJdT/dduHZWHK7vy37jBlz
 6UNSGQ/HrzPfjsb997foUgu2ofXVFWvUeITGogcp+8FMK/Ry9abFTn9LseL933GzV1Tg
 83qD71RLmDr0AGB2GptAj36po0X7YItTsfFCjg+mdHXoxhk2wu8bhWE82hMW3sHrfpxm
 jICKtAld+2yHNZfy6gMxh43tq4cMJ5B09qpQ4zr4Ypc4CWUdBeOSHxWl+kKEEgs4Qt5E
 dQOl3twO7yBtYPa9wHe7dV014JRvRBl9LiVXB7qK+pr3Tulaceq1GlcUniapVKl5XSK3
 Wylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PQU0VMDoZFuJFaraom9TI5EU5C92z+9V7Vol+wly+Aw=;
 b=Wof+HxnIMuNfE/+X/zFpzNzU0iz4aUe4AWXbo2F5XrUY1DlY0aWQlOEw0ar/Rh7C96
 tGDsvnFspeuFIKfBDX3/cHaD/rymaRtF02Osz2xKIuxboMzO3khbfQGsLj309/ANr7gt
 13exNtMdKEkZvoR0WceIeTzKosNwEmlvwCDYNJnIa3bVNh9IYlEyfQYak3EISc2eb1YH
 8726C6UD3hzpIN7qegL0uXmflU7ERCylbBIc2yJ3YBH+xTS6BK1JjCdEskThfITYqGv4
 xY74m630mDy50L+8hfYjqLUo246foc04ql/B6c/kSXE1FnTzk0lH+CRtwb3gx5Iq09SD
 PsbQ==
X-Gm-Message-State: AOAM533QnVNhGHa7MkkUoRay4Q+tY+6Khz40bxkLuxKzx8JPUbgQG3Lv
 yewvQ7zhph5LhMkknQ5LYUKftYpt7hjiNQ==
X-Google-Smtp-Source: ABdhPJy+8GOr99qRekcxaEVCa7C9jGl8B+G+MZaFZ82Q+oKFAOxgOU83nykaF03YcUZLlxIbXQ0Z7Q==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr37684497wrr.391.1593795268819; 
 Fri, 03 Jul 2020 09:54:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/34] hw/arm/spitz: Keep pointers to MPU and SSI devices in
 SpitzMachineState
Date: Fri,  3 Jul 2020 17:53:50 +0100
Message-Id: <20200703165405.17672-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep pointers to the MPU and the SSI devices in SpitzMachineState.
We're going to want to make GPIO connections between some of the
SSI devices and the SCPs, so we want to keep hold of a pointer to
those; putting the MPU into the struct allows us to pass just
one thing to spitz_ssp_attach() rather than two.

We have to retain the setting of the global "max1111" variable
for the moment as it is used in spitz_adc_temp_on(); later in
this series of commits we will be able to remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-4-peter.maydell@linaro.org
---
 hw/arm/spitz.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index c70e912a33d..f48e966c047 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -43,6 +43,11 @@ typedef struct {
 
 typedef struct {
     MachineState parent;
+    PXA2xxState *mpu;
+    DeviceState *mux;
+    DeviceState *lcdtg;
+    DeviceState *ads7846;
+    DeviceState *max1111;
 } SpitzMachineState;
 
 #define TYPE_SPITZ_MACHINE "spitz-common"
@@ -709,34 +714,33 @@ static void corgi_ssp_realize(SSISlave *d, Error **errp)
     s->bus[2] = ssi_create_bus(dev, "ssi2");
 }
 
-static void spitz_ssp_attach(PXA2xxState *cpu)
+static void spitz_ssp_attach(SpitzMachineState *sms)
 {
-    DeviceState *mux;
-    DeviceState *dev;
     void *bus;
 
-    mux = ssi_create_slave(cpu->ssp[CORGI_SSP_PORT - 1], "corgi-ssp");
+    sms->mux = ssi_create_slave(sms->mpu->ssp[CORGI_SSP_PORT - 1], "corgi-ssp");
 
-    bus = qdev_get_child_bus(mux, "ssi0");
-    ssi_create_slave(bus, "spitz-lcdtg");
+    bus = qdev_get_child_bus(sms->mux, "ssi0");
+    sms->lcdtg = ssi_create_slave(bus, "spitz-lcdtg");
 
-    bus = qdev_get_child_bus(mux, "ssi1");
-    dev = ssi_create_slave(bus, "ads7846");
-    qdev_connect_gpio_out(dev, 0,
-                          qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_TP_INT));
+    bus = qdev_get_child_bus(sms->mux, "ssi1");
+    sms->ads7846 = ssi_create_slave(bus, "ads7846");
+    qdev_connect_gpio_out(sms->ads7846, 0,
+                          qdev_get_gpio_in(sms->mpu->gpio, SPITZ_GPIO_TP_INT));
 
-    bus = qdev_get_child_bus(mux, "ssi2");
-    max1111 = ssi_create_slave(bus, "max1111");
-    max111x_set_input(max1111, MAX1111_BATT_VOLT, SPITZ_BATTERY_VOLT);
-    max111x_set_input(max1111, MAX1111_BATT_TEMP, 0);
-    max111x_set_input(max1111, MAX1111_ACIN_VOLT, SPITZ_CHARGEON_ACIN);
+    bus = qdev_get_child_bus(sms->mux, "ssi2");
+    sms->max1111 = ssi_create_slave(bus, "max1111");
+    max1111 = sms->max1111;
+    max111x_set_input(sms->max1111, MAX1111_BATT_VOLT, SPITZ_BATTERY_VOLT);
+    max111x_set_input(sms->max1111, MAX1111_BATT_TEMP, 0);
+    max111x_set_input(sms->max1111, MAX1111_ACIN_VOLT, SPITZ_CHARGEON_ACIN);
 
-    qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_LCDCON_CS,
-                        qdev_get_gpio_in(mux, 0));
-    qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_ADS7846_CS,
-                        qdev_get_gpio_in(mux, 1));
-    qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_MAX1111_CS,
-                        qdev_get_gpio_in(mux, 2));
+    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_LCDCON_CS,
+                        qdev_get_gpio_in(sms->mux, 0));
+    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_ADS7846_CS,
+                        qdev_get_gpio_in(sms->mux, 1));
+    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_MAX1111_CS,
+                        qdev_get_gpio_in(sms->mux, 2));
 }
 
 /* CF Microdrive */
@@ -936,6 +940,7 @@ static struct arm_boot_info spitz_binfo = {
 static void spitz_common_init(MachineState *machine)
 {
     SpitzMachineClass *smc = SPITZ_MACHINE_GET_CLASS(machine);
+    SpitzMachineState *sms = SPITZ_MACHINE(machine);
     enum spitz_model_e model = smc->model;
     PXA2xxState *mpu;
     DeviceState *scp0, *scp1 = NULL;
@@ -945,6 +950,7 @@ static void spitz_common_init(MachineState *machine)
     /* Setup CPU & memory */
     mpu = pxa270_init(address_space_mem, spitz_binfo.ram_size,
                       machine->cpu_type);
+    sms->mpu = mpu;
 
     sl_flash_register(mpu, (model == spitz) ? FLASH_128M : FLASH_1024M);
 
@@ -954,7 +960,7 @@ static void spitz_common_init(MachineState *machine)
     /* Setup peripherals */
     spitz_keyboard_register(mpu);
 
-    spitz_ssp_attach(mpu);
+    spitz_ssp_attach(sms);
 
     scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
     if (model != akita) {
-- 
2.20.1


