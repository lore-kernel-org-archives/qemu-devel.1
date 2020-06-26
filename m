Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1005DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C052C20702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjCspdTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C052C20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joq7p-0007wZ-W4
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3s-0001xu-Dd
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3o-0006Ea-BS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id l17so9180221wmj.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RSrZKYU6XiD6HydRIvmILFJ3Ak6gyAmjGgVo7fpGeB0=;
 b=fjCspdTVMVecu1GggGELeMmg0tDoca/7upHArLWlwjgNucnK7bTFLjHQbzS0hwojQv
 XFJbN+vdnVa+ex8DPiWTT9KRriJuqMoarnVMcN59pvr97pina4Xo8oJLKppJKb+sOode
 nOAJXlE4l5//bLDuVZx5/jOWjnyFmd9gk2cD0e9d5Fl6voqqcP+majVi1pijSQDPImE4
 IF3gfi8IWAmrTh4HVODIgmPieIIqWMLVcK9Vzm8dLw3BiD/YTmmi2ReDmBLv2HlKodqc
 ds4NuMAWpTcbUdD9yKphOwGHf0w4o/TNUWv0X8dAaJD+v9InF8eYo4slTAGQJXEH7ZNt
 Wj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RSrZKYU6XiD6HydRIvmILFJ3Ak6gyAmjGgVo7fpGeB0=;
 b=oxKhE+QJMHERQ9VUMhdnOgYZU9lw1usOyXTVtd0s+0hSG9T4P9JazbPvzbrQLIN7mE
 kP+vB5Z6oyR3g/3s+KCQ8YPP2bBkzUFzGiVISzPg2SAsEcc3VUdcFns5rUP8g94b2Eoc
 mNx06UyTqPEd2zTqy8crWFhcIosVjZE8IKww14h2okmRTHEX4sNNDjQOZoss3a2HK1xO
 zqKfTJg5uwitCYIT5O6z1Ubm+B4uRv9KROu72Hf5MBM0IU+9vmMCYI8QOVvATt49UEmL
 WLkNdzZeXAmksH5FfaZdnAM7y3tILKp0WP2Bue6pDlz5b9oigmdgIuqiV5YiG7xMw207
 zX5A==
X-Gm-Message-State: AOAM532FXQ9EVVRwnXTXOIl3e6LZidAc7+T5rMUr9zk22ZPmy1C5nkDQ
 fitH0g+eZ0ExHxylqbzQjkXTrEc1rZJiKQ==
X-Google-Smtp-Source: ABdhPJzRyoOSQitlmi9dXEiSBpS0gn/iublkvV5AYfntls0bSheVNQPwijuuOwfpqK4U2MeTPzN1yQ==
X-Received: by 2002:a05:600c:2202:: with SMTP id
 z2mr4154899wml.13.1593184473654; 
 Fri, 26 Jun 2020 08:14:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/57] hw/misc/pca9552: Rename generic code as pca955x
Date: Fri, 26 Jun 2020 16:13:33 +0100
Message-Id: <20200626151424.30117-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Various code from the PCA9552 device model is generic to the
PCA955X family. We'll split the generic code in a base class
in the next commit. To ease review, first do a dumb renaming.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/pca9552.h | 10 ++---
 hw/misc/pca9552.c         | 80 +++++++++++++++++++--------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index bc5ed310878..db527595a38 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -12,11 +12,11 @@
 #include "hw/i2c/i2c.h"
 
 #define TYPE_PCA9552 "pca9552"
-#define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
+#define PCA955X(obj) OBJECT_CHECK(PCA955xState, (obj), TYPE_PCA9552)
 
-#define PCA9552_NR_REGS 10
+#define PCA955X_NR_REGS 10
 
-typedef struct PCA9552State {
+typedef struct PCA955xState {
     /*< private >*/
     I2CSlave i2c;
     /*< public >*/
@@ -24,9 +24,9 @@ typedef struct PCA9552State {
     uint8_t len;
     uint8_t pointer;
 
-    uint8_t regs[PCA9552_NR_REGS];
+    uint8_t regs[PCA955X_NR_REGS];
     uint8_t max_reg;
     uint8_t pin_count;
-} PCA9552State;
+} PCA955xState;
 
 #endif
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 81da757a7ea..5681ff3b22d 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -25,7 +25,7 @@
 
 static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
 
-static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
+static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
 {
     uint8_t reg   = PCA9552_LS0 + (pin / 4);
     uint8_t shift = (pin % 4) << 1;
@@ -33,14 +33,14 @@ static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
     return extract32(s->regs[reg], shift, 2);
 }
 
-static void pca9552_update_pin_input(PCA9552State *s)
+static void pca955x_update_pin_input(PCA955xState *s)
 {
     int i;
 
     for (i = 0; i < s->pin_count; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
         uint8_t input_shift = (i % 8);
-        uint8_t config = pca9552_pin_get_config(s, i);
+        uint8_t config = pca955x_pin_get_config(s, i);
 
         switch (config) {
         case PCA9552_LED_ON:
@@ -58,7 +58,7 @@ static void pca9552_update_pin_input(PCA9552State *s)
     }
 }
 
-static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
+static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
 {
     switch (reg) {
     case PCA9552_INPUT0:
@@ -79,7 +79,7 @@ static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
     }
 }
 
-static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
+static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
 {
     switch (reg) {
     case PCA9552_PSC0:
@@ -94,7 +94,7 @@ static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
     case PCA9552_LS2:
     case PCA9552_LS3:
         s->regs[reg] = data;
-        pca9552_update_pin_input(s);
+        pca955x_update_pin_input(s);
         break;
 
     case PCA9552_INPUT0:
@@ -110,7 +110,7 @@ static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
  * after each byte is sent to or received by the device. The index
  * rollovers to 0 when the maximum register address is reached.
  */
-static void pca9552_autoinc(PCA9552State *s)
+static void pca955x_autoinc(PCA955xState *s)
 {
     if (s->pointer != 0xFF && s->pointer & PCA9552_AUTOINC) {
         uint8_t reg = s->pointer & 0xf;
@@ -120,12 +120,12 @@ static void pca9552_autoinc(PCA9552State *s)
     }
 }
 
-static uint8_t pca9552_recv(I2CSlave *i2c)
+static uint8_t pca955x_recv(I2CSlave *i2c)
 {
-    PCA9552State *s = PCA9552(i2c);
+    PCA955xState *s = PCA955X(i2c);
     uint8_t ret;
 
-    ret = pca9552_read(s, s->pointer & 0xf);
+    ret = pca955x_read(s, s->pointer & 0xf);
 
     /*
      * From the Specs:
@@ -143,40 +143,40 @@ static uint8_t pca9552_recv(I2CSlave *i2c)
                       __func__);
     }
 
-    pca9552_autoinc(s);
+    pca955x_autoinc(s);
 
     return ret;
 }
 
-static int pca9552_send(I2CSlave *i2c, uint8_t data)
+static int pca955x_send(I2CSlave *i2c, uint8_t data)
 {
-    PCA9552State *s = PCA9552(i2c);
+    PCA955xState *s = PCA955X(i2c);
 
     /* First byte sent by is the register address */
     if (s->len == 0) {
         s->pointer = data;
         s->len++;
     } else {
-        pca9552_write(s, s->pointer & 0xf, data);
+        pca955x_write(s, s->pointer & 0xf, data);
 
-        pca9552_autoinc(s);
+        pca955x_autoinc(s);
     }
 
     return 0;
 }
 
-static int pca9552_event(I2CSlave *i2c, enum i2c_event event)
+static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
 {
-    PCA9552State *s = PCA9552(i2c);
+    PCA955xState *s = PCA955X(i2c);
 
     s->len = 0;
     return 0;
 }
 
-static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
+static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
-    PCA9552State *s = PCA9552(obj);
+    PCA955xState *s = PCA955X(obj);
     int led, rc, reg;
     uint8_t state;
 
@@ -195,7 +195,7 @@ static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
      * reading the INPUTx reg
      */
     reg = PCA9552_LS0 + led / 4;
-    state = (pca9552_read(s, reg) >> (led % 8)) & 0x3;
+    state = (pca955x_read(s, reg) >> (led % 8)) & 0x3;
     visit_type_str(v, name, (char **)&led_state[state], errp);
 }
 
@@ -209,10 +209,10 @@ static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
                 ((state & 0x3) << (led_num << 1));
 }
 
-static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
+static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
-    PCA9552State *s = PCA9552(obj);
+    PCA955xState *s = PCA955X(obj);
     Error *local_err = NULL;
     int led, rc, reg, val;
     uint8_t state;
@@ -244,9 +244,9 @@ static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
     }
 
     reg = PCA9552_LS0 + led / 4;
-    val = pca9552_read(s, reg);
+    val = pca955x_read(s, reg);
     val = pca955x_ledsel(val, led % 4, state);
-    pca9552_write(s, reg, val);
+    pca955x_write(s, reg, val);
 }
 
 static const VMStateDescription pca9552_vmstate = {
@@ -254,17 +254,17 @@ static const VMStateDescription pca9552_vmstate = {
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT8(len, PCA9552State),
-        VMSTATE_UINT8(pointer, PCA9552State),
-        VMSTATE_UINT8_ARRAY(regs, PCA9552State, PCA9552_NR_REGS),
-        VMSTATE_I2C_SLAVE(i2c, PCA9552State),
+        VMSTATE_UINT8(len, PCA955xState),
+        VMSTATE_UINT8(pointer, PCA955xState),
+        VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
+        VMSTATE_I2C_SLAVE(i2c, PCA955xState),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static void pca9552_reset(DeviceState *dev)
 {
-    PCA9552State *s = PCA9552(dev);
+    PCA955xState *s = PCA955X(dev);
 
     s->regs[PCA9552_PSC0] = 0xFF;
     s->regs[PCA9552_PWM0] = 0x80;
@@ -275,15 +275,15 @@ static void pca9552_reset(DeviceState *dev)
     s->regs[PCA9552_LS2] = 0x55;
     s->regs[PCA9552_LS3] = 0x55;
 
-    pca9552_update_pin_input(s);
+    pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
     s->len = 0;
 }
 
-static void pca9552_initfn(Object *obj)
+static void pca955x_initfn(Object *obj)
 {
-    PCA9552State *s = PCA9552(obj);
+    PCA955xState *s = PCA955X(obj);
     int led;
 
     /* If support for the other PCA955X devices are implemented, these
@@ -297,7 +297,7 @@ static void pca9552_initfn(Object *obj)
         char *name;
 
         name = g_strdup_printf("led%d", led);
-        object_property_add(obj, name, "bool", pca9552_get_led, pca9552_set_led,
+        object_property_add(obj, name, "bool", pca955x_get_led, pca955x_set_led,
                             NULL, NULL);
         g_free(name);
     }
@@ -308,9 +308,9 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->event = pca9552_event;
-    k->recv = pca9552_recv;
-    k->send = pca9552_send;
+    k->event = pca955x_event;
+    k->recv = pca955x_recv;
+    k->send = pca955x_send;
     dc->reset = pca9552_reset;
     dc->vmsd = &pca9552_vmstate;
 }
@@ -318,14 +318,14 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pca9552_info = {
     .name          = TYPE_PCA9552,
     .parent        = TYPE_I2C_SLAVE,
-    .instance_init = pca9552_initfn,
-    .instance_size = sizeof(PCA9552State),
+    .instance_init = pca955x_initfn,
+    .instance_size = sizeof(PCA955xState),
     .class_init    = pca9552_class_init,
 };
 
-static void pca9552_register_types(void)
+static void pca955x_register_types(void)
 {
     type_register_static(&pca9552_info);
 }
 
-type_init(pca9552_register_types)
+type_init(pca955x_register_types)
-- 
2.20.1


