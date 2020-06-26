Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAD820702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5NTZIdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAD820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joq7G-0006pi-3q
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3y-000238-GQ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3o-0006F1-FN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id f18so9718585wml.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1kBX+OtXDHcOxGLHMho84sZlThQbaHQb6QPwO/QBb5Q=;
 b=w5NTZIdVxQs62effb13gdKhtG4ksaoBsW7gwrS7MZ0IWpeE6N5jgVWQgFNx96Isk+t
 LNChWO0Y9S12yt44tKEFmmnVIXN6a2WcyDORYhnz0SwuYx3kfopfeniaL+gbjWzJMPrM
 iyhCpBxgQ0B8y4/ybu++Qdc/aRSNuXcj2Ed2q3BXPL+7nr0SFYoLE5HB4woe9lBeZHo8
 L3xrBfcfhj1Q8UNu6wDY1MLcMDUDTyH6InHf2/94LhK7k82e2udvDQY5y96Q0PhizN88
 3/81HF3voUthZbEa/HtiXY0TNQxMhItMg4UG/PAANXgQZVw8VlkBaPsR1MKkxxBGpPXx
 N4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1kBX+OtXDHcOxGLHMho84sZlThQbaHQb6QPwO/QBb5Q=;
 b=unusPaPjtV0p/KBf3M/p6JdOIr+7jOCAVYa5bmTVx9Exiihi/owSajHebxULO1fNTp
 SYwBkuZmaFqQfQk1biWOQwZiR+8YgixhHbg+r5Wrja5frIQt8MYM8tJ53+knxsuIRUwR
 KCAm0rLnG8WRNDGPWST8l9E7XDx9/csAPvb4Un4BRG5hvLhER828vmV/eRHgDq8cIr8B
 32msy4zobBs0JqVkrBfikQRywmPoPaNmR5wZRJfRKDxRnWLRc3xclgLSIPQhXR+fj6vn
 lFPJocw4TMnKWvpILKXGk7yaeh3RlXVgbCRDtEuxIYBK0/TMViifyHM1OvAKCqB0nJNK
 P8Ew==
X-Gm-Message-State: AOAM530W8LXvwPZLzd8S/rhTscNvsUKOxKhoPb95dkC3fDj1N2K5dtn5
 ZrHpT+YKv6qfBvzZeWlaoGQcqN6wTCnndw==
X-Google-Smtp-Source: ABdhPJxBEh2TSeJHxYPEYtFnj+F0LAP/9fShjh6LbPZ/3a03V0FNg4PV9qYoyPqYkEBTZXIuZ3C4Qw==
X-Received: by 2002:a1c:6887:: with SMTP id d129mr3886228wmc.179.1593184474795; 
 Fri, 26 Jun 2020 08:14:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/57] hw/misc/pca9552: Add generic PCA955xClass,
 parent of TYPE_PCA9552
Date: Fri, 26 Jun 2020 16:13:34 +0100
Message-Id: <20200626151424.30117-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Extract the code common to the PCA955x family in PCA955xClass,
keeping the PCA9552 specific parts into pca9552_class_init().
Remove the 'TODO' comment added in commit 5141d4158cf.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/pca9552.h |  6 ++--
 hw/misc/pca9552.c         | 66 ++++++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index db527595a38..90843b03b8a 100644
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
index 5681ff3b22d..4de57dbe2e2 100644
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
2.20.1


