Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B052DC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72546204EC
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6yliv2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72546204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYG0-0007x9-Nm
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEZ-0005vZ-0A
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEX-0004eY-4b
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id g18so14079448wrm.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3ss6f23CNAuvklUxZG32njbzr6Gg86zxOuqDqmS/ynM=;
 b=T6yliv2ynCDkvif3fKCD2D6TcDFwvR3nL5zoN4cy8jL8Slw1Ter1/qy+X/TTKP4FqC
 Z+O8cQU6koLk9r3psOSOEUWOdLTN60y0mWzP9UjqPJnCLC98erBPt7BULi0rmnmOj4xg
 5U8z89ZUp9IAGSkPNC7QlNkStKMoHfBCodheRL2/wvlFGBGXP2mxE5SUdJXdLm6+0IB7
 RTV42W9+N6SN8KZrtgMekiNX+9RHkSjMJ46kMzSYmj79nKLGQ5gFZYhW8gCS11osht9a
 euaZN6y0EnXnSHDM4Fmomod8g8BLGNH7WWJQkHw8f3llI4FlciRjAU7gQlG1/1KlzjoJ
 dGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3ss6f23CNAuvklUxZG32njbzr6Gg86zxOuqDqmS/ynM=;
 b=bmEL/Jja5TNOcdGbl/mMPbqSUYgvLYE153I8dqbWCdvC902tLK5GIjp8vNXeUWV0Wz
 926zD7sbUZFIdaOcMJVQ4hAp4jey5bP3X0MacSidK0XI6PVHuamJODi8DkXXBzG7FQcE
 fnJ5mMOI78cuWnvWBhIr3MAgianuQA5kVFi1h1YzfFm5CPFEIuWl9iOYWZLfi1a/yU/z
 Rr1OwpTofkjPmj27t0BDpFEUOObjMhiq5QHNQh6PZWM/X+WwNQkMNAxHtxzs3zoHP5cw
 y57qmaMnMtzC8mJZkMXVqJGFmo67ZuwbklNL/A/gQSxBwyTKXGcZoDJMI2Hv4vA1/Fcd
 e94A==
X-Gm-Message-State: AOAM531VX7gOnNWmPQCV7gaAH14IdOJaPyzgAk0EiMQJCOfZ6gK6Fa68
 MZyycbyWUno3djEoMOizFX7ll17i4euXsA==
X-Google-Smtp-Source: ABdhPJzYhF34Q1FLOnavEsS4Xj+e4VnVCVeZCNIfkLZfLsfHp6V99sPzhLUhry7vjJGhbWPQjQTXbQ==
X-Received: by 2002:adf:8524:: with SMTP id 33mr12956847wrh.366.1593354275803; 
 Sun, 28 Jun 2020 07:24:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/17] hw/arm/spitz: Keep pointers to MPU and SSI devices in
 SpitzMachineState
Date: Sun, 28 Jun 2020 15:24:15 +0100
Message-Id: <20200628142429.17111-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Keep pointers to the MPU and the SSI devices in SpitzMachineState.
We're going to want to make GPIO connections between some of the
SSI devices and the SCPs, so we want to keep hold of a pointer to
those; putting the MPU into the struct allows us to pass just
one thing to spitz_ssp_attach() rather than two.

We have to retain the setting of the global "max1111" variable
for the moment as it is used in spitz_adc_temp_on(); later in
this series of commits we will be able to remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


