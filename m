Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E29C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20E420771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKgtZQXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20E420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndMr-0001XD-Qc
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 03:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndLC-0007Eb-NH; Tue, 23 Jun 2020 03:27:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jndLA-00050L-PN; Tue, 23 Jun 2020 03:27:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id v3so11881996wrc.1;
 Tue, 23 Jun 2020 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KCHwaxYyWi98DHqVJvfrEmV3u3cTBhAdaTgioobGbeU=;
 b=VKgtZQXdsImSSiL7VOG24y3c+7Bddigd/4SKrOXBdzQ6i0UkTvery08nUAz45hkOyw
 1s/RQ1MeC22to0a2GlrvFhNU91ErQaAjL1w/xe8pzFetKzRF9d+37QVSjdyGdW5PIGRi
 w5fZqIKXvPRn3ux0Cy2oX8uWUskXTJBNzN9c1829/xMZkrvVMoZ4K2L7/LqFBseggj6o
 gqv6ctDQshvOzs1ASwl6XcGB0LRukVdp/L55PUVSCXdmdIvAbumHwJoj/o63JA7CvkQP
 7G3aRTAW+hCLZOKEndeUpCHHuEwGRT0qIS5e2whoO6FDKtQGEYpNxUYBbTiCohG9MbXb
 Ya2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KCHwaxYyWi98DHqVJvfrEmV3u3cTBhAdaTgioobGbeU=;
 b=TAl696DduKorKa/Q8K7abgWNCUgEVTre2750RP/RnQpMBP4ImSeqHMXKaek6fsWdeC
 d3x9Ik4QlxTubviZ+w88jiAQ6QX0i4EXNCA+S+JMqLdSQw19R3pxn0pepSArMkyx23vW
 G0d8JfuzxayREpLZzvTE63+i/4gYCOC12qcoyjV7kT6jpMfOZ5SCHY7x2v7Uc7toZWhJ
 kfcjUW/Q4N51Bosg8l39n8l4TlX+9I/2uKvXkfqJ6ojXnz9U8Zju+hk7KJmoKcSqh77w
 cJH0tTbDQ80bN9QQLFqxHB68Y3gCqUK1Y1V8XIbEFB52++Y0ARXLSagrWPe1FHPfyVuo
 ZeAw==
X-Gm-Message-State: AOAM530B0KfJGdzyG3uHAOEdVZpoZivcIE/X0CTIv43+TNQyNA1TMQeU
 wglQYExJhDCNHX89YSpE1xeHjEq8
X-Google-Smtp-Source: ABdhPJylDttJQKWYv+hPLX2gb04aBJvcQ/oMqjGXeNtkYZl8vNoPCjaGjB+opkYcK+f+WJhOPE8PNw==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr23217999wro.414.1592897250535; 
 Tue, 23 Jun 2020 00:27:30 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l14sm4200059wrn.18.2020.06.23.00.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 00:27:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/9] hw/misc/pca9552: Add generic PCA955xClass,
 parent of TYPE_PCA9552
Date: Tue, 23 Jun 2020 09:27:18 +0200
Message-Id: <20200623072723.6324-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623072723.6324-1-f4bug@amsat.org>
References: <20200623072723.6324-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the code common to the PCA955x family in PCA955xClass,
keeping the PCA9552 specific parts into pca9552_class_init().
Remove the 'TODO' comment added in commit 5141d4158cf.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h |  6 ++--
 hw/misc/pca9552.c         | 66 ++++++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index db527595a3..90843b03b8 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -12,9 +12,11 @@
 #include "hw/i2c/i2c.h"
 
 #define TYPE_PCA9552 "pca9552"
-#define PCA955X(obj) OBJECT_CHECK(PCA955xState, (obj), TYPE_PCA9552)
+#define TYPE_PCA955X "pca955x"
+#define PCA955X(obj) OBJECT_CHECK(PCA955xState, (obj), TYPE_PCA955X)
 
 #define PCA955X_NR_REGS 10
+#define PCA955X_PIN_COUNT_MAX 16
 
 typedef struct PCA955xState {
     /*< private >*/
@@ -25,8 +27,6 @@ typedef struct PCA955xState {
     uint8_t pointer;
 
     uint8_t regs[PCA955X_NR_REGS];
-    uint8_t max_reg;
-    uint8_t pin_count;
 } PCA955xState;
 
 #endif
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 5681ff3b22..4de57dbe2e 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -4,6 +4,7 @@
  *     https://www.nxp.com/docs/en/application-note/AN264.pdf
  *
  * Copyright (c) 2017-2018, IBM Corporation.
+ * Copyright (c) 2020 Philippe Mathieu-Daudé
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or
  * later. See the COPYING file in the top-level directory.
@@ -18,6 +19,20 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 
+typedef struct PCA955xClass {
+    /*< private >*/
+    I2CSlaveClass parent_class;
+    /*< public >*/
+
+    uint8_t pin_count;
+    uint8_t max_reg;
+} PCA955xClass;
+
+#define PCA955X_CLASS(klass) \
+    OBJECT_CLASS_CHECK(PCA955xClass, (klass), TYPE_PCA955X)
+#define PCA955X_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(PCA955xClass, (obj), TYPE_PCA955X)
+
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
@@ -35,9 +50,10 @@ static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
 
 static void pca955x_update_pin_input(PCA955xState *s)
 {
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
     int i;
 
-    for (i = 0; i < s->pin_count; i++) {
+    for (i = 0; i < k->pin_count; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
         uint8_t input_shift = (i % 8);
         uint8_t config = pca955x_pin_get_config(s, i);
@@ -112,10 +128,12 @@ static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
  */
 static void pca955x_autoinc(PCA955xState *s)
 {
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+
     if (s->pointer != 0xFF && s->pointer & PCA9552_AUTOINC) {
         uint8_t reg = s->pointer & 0xf;
 
-        reg = (reg + 1) % (s->max_reg + 1);
+        reg = (reg + 1) % (k->max_reg + 1);
         s->pointer = reg | PCA9552_AUTOINC;
     }
 }
@@ -176,6 +194,7 @@ static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
 static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
+    PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int led, rc, reg;
     uint8_t state;
@@ -185,7 +204,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > s->pin_count) {
+    if (led < 0 || led > k->pin_count) {
         error_setg(errp, "%s invalid led %s", __func__, name);
         return;
     }
@@ -212,6 +231,7 @@ static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
 static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
+    PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     Error *local_err = NULL;
     int led, rc, reg, val;
@@ -228,7 +248,7 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > s->pin_count) {
+    if (led < 0 || led > k->pin_count) {
         error_setg(errp, "%s invalid led %s", __func__, name);
         return;
     }
@@ -283,17 +303,11 @@ static void pca9552_reset(DeviceState *dev)
 
 static void pca955x_initfn(Object *obj)
 {
-    PCA955xState *s = PCA955X(obj);
+    PCA955xClass *k = PCA955X_GET_CLASS(obj);
     int led;
 
-    /* If support for the other PCA955X devices are implemented, these
-     * constant values might be part of class structure describing the
-     * PCA955X device
-     */
-    s->max_reg = PCA9552_LS3;
-    s->pin_count = 16;
-
-    for (led = 0; led < s->pin_count; led++) {
+    assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
+    for (led = 0; led < k->pin_count; led++) {
         char *name;
 
         name = g_strdup_printf("led%d", led);
@@ -303,28 +317,44 @@ static void pca955x_initfn(Object *obj)
     }
 }
 
-static void pca9552_class_init(ObjectClass *klass, void *data)
+static void pca955x_class_init(ObjectClass *klass, void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
     k->event = pca955x_event;
     k->recv = pca955x_recv;
     k->send = pca955x_send;
+}
+
+static const TypeInfo pca955x_info = {
+    .name          = TYPE_PCA955X,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_init = pca955x_initfn,
+    .instance_size = sizeof(PCA955xState),
+    .class_init    = pca955x_class_init,
+    .abstract      = true,
+};
+
+static void pca9552_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCA955xClass *pc = PCA955X_CLASS(oc);
+
     dc->reset = pca9552_reset;
     dc->vmsd = &pca9552_vmstate;
+    pc->max_reg = PCA9552_LS3;
+    pc->pin_count = 16;
 }
 
 static const TypeInfo pca9552_info = {
     .name          = TYPE_PCA9552,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_init = pca955x_initfn,
-    .instance_size = sizeof(PCA955xState),
+    .parent        = TYPE_PCA955X,
     .class_init    = pca9552_class_init,
 };
 
 static void pca955x_register_types(void)
 {
+    type_register_static(&pca955x_info);
     type_register_static(&pca9552_info);
 }
 
-- 
2.21.3


