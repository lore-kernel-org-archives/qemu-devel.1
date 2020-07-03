Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86287C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53578208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLx+J7MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53578208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPHs-0006Pi-Jc
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxb-0005mc-Q2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxZ-0005pG-Mj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id s10so33384422wrw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WcP1RS8FiMepwE14qHYBXQBJblwCXUsUHB2p+oUgg94=;
 b=mLx+J7MRoxJqk0y/+oZmAvjX8UEmqG+RNxnxmpl90p6GLXLpuXqGz8Y/e+ma5PwTpo
 xgkRHTa3oxMb2at6UhpdTed+wc7kotvIH4vN3PAH4110Mw2BTPk6itORabWN7QC18bAz
 BeJR9mP0GLICYpJETdZcuwK/UjAVFYwLqReFlBjf0U4Y9grnUk3UJ3hUIoLAQz0+FNJz
 I4XbwyrV1G6f64iLYmoXvoac+Ayxk+yI4ATVHqUkcNKXu1niWQi3D7eMhNkhn57+jfHm
 ciZGo0M0tFt88+dZNsYbVnMQFxWeGy/mFLjiNm3BZjcFaAvc8m9R8IxdguS1g7wQ8+J6
 OUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WcP1RS8FiMepwE14qHYBXQBJblwCXUsUHB2p+oUgg94=;
 b=OyCghysgPg9TYmauusVHji9ttxLzQ5H9AcFzMRewqFwRobhPTOWBsi7mKihWh7I6Au
 0TH5nFGjk/kPOnoMRm9T/I63F89i9O7by+bRJzA+S3PEWlW0+8BeYjseisW14MSOwn5U
 I2pvteiVcmzTJYjSFNXXufoHeY4PQ7RR+LrPm3yhQb0Rv5PtaH5vsBP4kEgBXdpoPj30
 M+8+dmJ4jkBkHZ0Zw/o9vGTv57S4iKMVaEVn9lJ3qIm6UxPyIsTZSU1AvN+GL8TroMiZ
 7szfFcYXNvHXK/A+enXEvjD0Xun4NsxEILp5q7LUja+myfNmGrA3bIxYX7LBa+nOaKB5
 gKig==
X-Gm-Message-State: AOAM530DHYU4j1KoiUgGT9u8906qKXMBamP9MW3WLgF8Gj8sSQrCqg4q
 12ToY71f4Qbrrj6HiIIbYzySeSVf6QTniA==
X-Google-Smtp-Source: ABdhPJw6Qm1NNJtajlmzLpXcM2ctkBkTyJ9oKdqqMNsaDghRGEKf775iqsDwSubq9cLgOOf93Qo6rw==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr35718004wru.22.1593795284102; 
 Fri, 03 Jul 2020 09:54:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/34] hw/arm/spitz: Provide usual QOM macros for corgi-ssp and
 spitz-lcdtg
Date: Fri,  3 Jul 2020 17:54:03 +0100
Message-Id: <20200703165405.17672-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QOM types "spitz-lcdtg" and "corgi-ssp" are missing the
usual QOM TYPE and casting macros; provide and use them.

In particular, we can safely use the QOM cast macros instead of
FROM_SSI_SLAVE() because in both cases the 'ssidev' field of
the instance state struct is the first field in it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-17-peter.maydell@linaro.org
---
 hw/arm/spitz.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 49eae3fce4e..f020aff9747 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -579,6 +579,9 @@ static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
 #define LCDTG_PICTRL    0x06
 #define LCDTG_POLCTRL   0x07
 
+#define TYPE_SPITZ_LCDTG "spitz-lcdtg"
+#define SPITZ_LCDTG(obj) OBJECT_CHECK(SpitzLCDTG, (obj), TYPE_SPITZ_LCDTG)
+
 typedef struct {
     SSISlave ssidev;
     uint32_t bl_intensity;
@@ -616,7 +619,7 @@ static inline void spitz_bl_power(void *opaque, int line, int level)
 
 static uint32_t spitz_lcdtg_transfer(SSISlave *dev, uint32_t value)
 {
-    SpitzLCDTG *s = FROM_SSI_SLAVE(SpitzLCDTG, dev);
+    SpitzLCDTG *s = SPITZ_LCDTG(dev);
     int addr;
     addr = value >> 5;
     value &= 0x1f;
@@ -645,7 +648,7 @@ static uint32_t spitz_lcdtg_transfer(SSISlave *dev, uint32_t value)
 
 static void spitz_lcdtg_realize(SSISlave *ssi, Error **errp)
 {
-    SpitzLCDTG *s = FROM_SSI_SLAVE(SpitzLCDTG, ssi);
+    SpitzLCDTG *s = SPITZ_LCDTG(ssi);
     DeviceState *dev = DEVICE(s);
 
     s->bl_power = 0;
@@ -664,6 +667,9 @@ static void spitz_lcdtg_realize(SSISlave *ssi, Error **errp)
 #define SPITZ_GPIO_MAX1111_CS   20
 #define SPITZ_GPIO_TP_INT       11
 
+#define TYPE_CORGI_SSP "corgi-ssp"
+#define CORGI_SSP(obj) OBJECT_CHECK(CorgiSSPState, (obj), TYPE_CORGI_SSP)
+
 /* "Demux" the signal based on current chipselect */
 typedef struct {
     SSISlave ssidev;
@@ -673,7 +679,7 @@ typedef struct {
 
 static uint32_t corgi_ssp_transfer(SSISlave *dev, uint32_t value)
 {
-    CorgiSSPState *s = FROM_SSI_SLAVE(CorgiSSPState, dev);
+    CorgiSSPState *s = CORGI_SSP(dev);
     int i;
 
     for (i = 0; i < 3; i++) {
@@ -702,7 +708,7 @@ static void corgi_ssp_gpio_cs(void *opaque, int line, int level)
 static void corgi_ssp_realize(SSISlave *d, Error **errp)
 {
     DeviceState *dev = DEVICE(d);
-    CorgiSSPState *s = FROM_SSI_SLAVE(CorgiSSPState, d);
+    CorgiSSPState *s = CORGI_SSP(d);
 
     qdev_init_gpio_in(dev, corgi_ssp_gpio_cs, 3);
     s->bus[0] = ssi_create_bus(dev, "ssi0");
@@ -714,10 +720,11 @@ static void spitz_ssp_attach(SpitzMachineState *sms)
 {
     void *bus;
 
-    sms->mux = ssi_create_slave(sms->mpu->ssp[CORGI_SSP_PORT - 1], "corgi-ssp");
+    sms->mux = ssi_create_slave(sms->mpu->ssp[CORGI_SSP_PORT - 1],
+                                TYPE_CORGI_SSP);
 
     bus = qdev_get_child_bus(sms->mux, "ssi0");
-    sms->lcdtg = ssi_create_slave(bus, "spitz-lcdtg");
+    sms->lcdtg = ssi_create_slave(bus, TYPE_SPITZ_LCDTG);
 
     bus = qdev_get_child_bus(sms->mux, "ssi1");
     sms->ads7846 = ssi_create_slave(bus, "ads7846");
@@ -1220,7 +1227,7 @@ static void corgi_ssp_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo corgi_ssp_info = {
-    .name          = "corgi-ssp",
+    .name          = TYPE_CORGI_SSP,
     .parent        = TYPE_SSI_SLAVE,
     .instance_size = sizeof(CorgiSSPState),
     .class_init    = corgi_ssp_class_init,
@@ -1249,7 +1256,7 @@ static void spitz_lcdtg_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo spitz_lcdtg_info = {
-    .name          = "spitz-lcdtg",
+    .name          = TYPE_SPITZ_LCDTG,
     .parent        = TYPE_SSI_SLAVE,
     .instance_size = sizeof(SpitzLCDTG),
     .class_init    = spitz_lcdtg_class_init,
-- 
2.20.1


