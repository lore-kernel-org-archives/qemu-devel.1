Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BBAC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07A520738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJMtl1ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07A520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRLf-0005d6-UM
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHE-0005PC-4U; Mon, 22 Jun 2020 14:34:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHC-00081R-7w; Mon, 22 Jun 2020 14:34:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id r15so525966wmh.5;
 Mon, 22 Jun 2020 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R6bhbFUFHwbjFV9VtVCbzeaqKXg8WCcxdY6HM2ZAe0c=;
 b=QJMtl1eaH8K4HoaLvK/EAmlOnhgKV0xNPF5XzYqxJUtxyyw60uDmjApvvr3zYyEiMH
 31ZrKSyAqL5x0MhgliC7qkZtudSXo4f5OL9PQqq44uiRR1U8E/WnSfJ0w6Jp20fsW+N3
 Kv4mLgd7WPQEEN67rGqLSPGU29oPGzMa3i2IrlhL5EMMqLA/dhytm4ge9tYrmGaPQG4o
 eHMmwAfSB2A5abmlmcxZ4ZeMdoufdV5t/CD0VAOl1VMzbHHbfgRNK6V42L7zbWJWjPyA
 aAk+i/6ixN6ZjcUw3QyTpbbv8Itxao0amxM3m1tI28XmmbzHIGErTwkC0Gx9W9qUSJz+
 TSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=R6bhbFUFHwbjFV9VtVCbzeaqKXg8WCcxdY6HM2ZAe0c=;
 b=nohfQQtLlmJQSNtXXkkgzCgtEs8hKHA+XUBHscQdDsuXGALtuA18xIuP4cPEagkO7a
 ceE0wgm1O4sK76tkg55SodJcfH95z1NN/h1IOs6v1mh9pPBiYxKk1uNgm/iSKlXk8L0p
 0ZkMX8Lr3WIfp1ZqJkjyixAq/PrFxD+ApYuiZZ/zjIIZ2faxZRV0bkxq8qk9QF9rzVv8
 9r8Sj1C7FylgQQE3ViDUbpfTy0GxE5s/aWjFZGwE8B05naXrPClrgn6i2Kqty9Sx17an
 oJ3brA3VVb0Wo4m8y8OoNcTyku0uvYz+KI/1wFyIDAWZ9qpYnI5C+IQiLq4bLJfJLEEb
 Nkww==
X-Gm-Message-State: AOAM530AysveJeCBHdvjoba85lZ05G00qRl7xcUvk2wdx/btklJIn+8p
 RVkH5jz6pkvInP0BFGF4uuHA4Abt
X-Google-Smtp-Source: ABdhPJw9bpt+xJcKoVgf/eaLpDENtTj23Z89xheedBmOP7cKrJ7XrzS7G2eAE9SqN6w3tRw4C3ew2g==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr19050559wmj.2.1592850876092;
 Mon, 22 Jun 2020 11:34:36 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h29sm20286161wrc.78.2020.06.22.11.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 11:34:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/9] hw/misc/pca9552: Add generic PCA955xClass,
 parent of TYPE_PCA9552
Date: Mon, 22 Jun 2020 20:34:23 +0200
Message-Id: <20200622183428.12255-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622183428.12255-1-f4bug@amsat.org>
References: <20200622183428.12255-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
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
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the code common to the PCA955x family in PCA955xClass,
keeping the PCA9552 specific parts into pca9552_class_init().
Remove the 'TODO' comment added in commit 5141d4158cf.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h |  6 ++--
 hw/misc/pca9552.c         | 72 ++++++++++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 20 deletions(-)

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
index 5681ff3b22..34062dbb69 100644
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
@@ -283,17 +303,10 @@ static void pca9552_reset(DeviceState *dev)
 
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
+    for (led = 0; led < k->pin_count; led++) {
         char *name;
 
         name = g_strdup_printf("led%d", led);
@@ -303,7 +316,14 @@ static void pca955x_initfn(Object *obj)
     }
 }
 
-static void pca9552_class_init(ObjectClass *klass, void *data)
+static void pca955x_realize(DeviceState *dev, Error **errp)
+{
+    PCA955xClass *k = PCA955X_GET_CLASS(dev);
+
+    assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
+}
+
+static void pca955x_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
@@ -311,20 +331,38 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
     k->event = pca955x_event;
     k->recv = pca955x_recv;
     k->send = pca955x_send;
+    dc->realize = pca955x_realize;
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


