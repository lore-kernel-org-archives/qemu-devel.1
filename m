Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86659C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F2120707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E013q0/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F2120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCZF-0005XV-DW
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTq-0005Ms-Hv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTp-0002tC-3H
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:46 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTo-0002sS-SW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:45 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so4846097wrq.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CvOZoQCzaXRX99AzHkA3Ml/rAbedFDJt0FwyBDVaLOE=;
 b=E013q0/qPOgOKyzdgJtZXoHmQCNV4Q4G5NrBIXRfnGNaZ5sxY9kkG4ZUKA4fdqnmNv
 O6l9JT8UOfbBfYWkq1MJr7rI4EPR9t1j9nHZeFbTfACroz+qUSO1V2gspI63z4wK1yL7
 szUCR3QZ+LCrz7kUYWx4OcFvHc8fgPnEqgFI/furrFz8laBa0Dn9jTzQZtwVBwwgcKFL
 obJjnT8u0j95Aj3qL1F1853YezgbEvmIDw1MCLfqhaIXaLY9NUgQySYOa/IvRBwiXCgK
 YEk5Sn40z/X1dOelhU4JhoCD1fSn4sRAGElrx5GjmxtZy+4AFTKXxIfwSYwqZZjhk5gW
 Z2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CvOZoQCzaXRX99AzHkA3Ml/rAbedFDJt0FwyBDVaLOE=;
 b=JNrH3J4k1Q3hkUNEuI+6IBXnScSdcF6LWKbREeGK7C6JzJGg/KHsP5+rjRVWr5AiOd
 1WQtWow3nHiEMgPFYHIELCdlYRljd3Ux8SOVdWeKj5bs/4H7qcUbpydaCH/cARC5UHrk
 KXAnqj2uo2UbtBN+C3MFxYBl/cvDcM/GWL/fgkOozyN249hD6A0RwLkRKjIeZrputss0
 NE8W7h10+U+RDkGjZosdYpsiPRFN0dbmS1O65ST+aCQ85vehHlwRpF5iFmusKJtQopGo
 q1GrBhDvAibKXL5xDul4Xns3arKre8bgCqcoEsN3jBMz7zgJ1+9gh9RkwLoXqpB3G1kj
 QeuA==
X-Gm-Message-State: APjAAAWjlmi+/zh/Gs56b4fpmYVxOHfp+BWLQJdbl54TIqJlVXOhpErd
 cxhU7+840jKtjl5o+OStPcMfGb5c2/lRUw==
X-Google-Smtp-Source: APXvYqwwvm5IuGWANVot7LwX/btI7jVH7kMJ5vosTzDlNo7c4qrkGh2p5g8lFxI2k/ODeTieLmWNXA==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr6621185wrv.144.1580400943720; 
 Thu, 30 Jan 2020 08:15:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/26] misc/pca9552: Add qom set and get
Date: Thu, 30 Jan 2020 16:15:14 +0000
Message-Id: <20200130161533.8180-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Joel Stanley <joel@jms.id.au>

Following the pattern of the work recently done with the ASPEED GPIO
model, this adds support for inspecting and modifying the PCA9552 LEDs
from the monitor.

 (qemu) qom-set  /machine/unattached/device[17] led0 on
 (qemu) qom-set  /machine/unattached/device[17] led0 off
 (qemu) qom-set  /machine/unattached/device[17] led0 pwm0
 (qemu) qom-set  /machine/unattached/device[17] led0 pwm1

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200114103433.30534-6-clg@kaod.org
[clg: - removed the "qom-get" examples from the commit log
      - merged memory leak fixes from Joel ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/pca9552.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 73be28d9369..efd961e0414 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -15,12 +15,16 @@
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
 
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
 #define PCA9552_LED_PWM1 0x3
 
+static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
+
 static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
 {
     uint8_t reg   = PCA9552_LS0 + (pin / 4);
@@ -169,6 +173,82 @@ static int pca9552_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
+static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA9552State *s = PCA9552(obj);
+    int led, rc, reg;
+    uint8_t state;
+
+    rc = sscanf(name, "led%2d", &led);
+    if (rc != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (led < 0 || led > s->nr_leds) {
+        error_setg(errp, "%s invalid led %s", __func__, name);
+        return;
+    }
+    /*
+     * Get the LSx register as the qom interface should expose the device
+     * state, not the modeled 'input line' behaviour which would come from
+     * reading the INPUTx reg
+     */
+    reg = PCA9552_LS0 + led / 4;
+    state = (pca9552_read(s, reg) >> (led % 8)) & 0x3;
+    visit_type_str(v, name, (char **)&led_state[state], errp);
+}
+
+/*
+ * Return an LED selector register value based on an existing one, with
+ * the appropriate 2-bit state value set for the given LED number (0-3).
+ */
+static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
+{
+        return (oldval & (~(0x3 << (led_num << 1)))) |
+                ((state & 0x3) << (led_num << 1));
+}
+
+static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA9552State *s = PCA9552(obj);
+    Error *local_err = NULL;
+    int led, rc, reg, val;
+    uint8_t state;
+    char *state_str;
+
+    visit_type_str(v, name, &state_str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    rc = sscanf(name, "led%2d", &led);
+    if (rc != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (led < 0 || led > s->nr_leds) {
+        error_setg(errp, "%s invalid led %s", __func__, name);
+        return;
+    }
+
+    for (state = 0; state < ARRAY_SIZE(led_state); state++) {
+        if (!strcmp(state_str, led_state[state])) {
+            break;
+        }
+    }
+    if (state >= ARRAY_SIZE(led_state)) {
+        error_setg(errp, "%s invalid led state %s", __func__, state_str);
+        return;
+    }
+
+    reg = PCA9552_LS0 + led / 4;
+    val = pca9552_read(s, reg);
+    val = pca955x_ledsel(val, led % 4, state);
+    pca9552_write(s, reg, val);
+}
+
 static const VMStateDescription pca9552_vmstate = {
     .name = "PCA9552",
     .version_id = 0,
@@ -204,6 +284,7 @@ static void pca9552_reset(DeviceState *dev)
 static void pca9552_initfn(Object *obj)
 {
     PCA9552State *s = PCA9552(obj);
+    int led;
 
     /* If support for the other PCA955X devices are implemented, these
      * constant values might be part of class structure describing the
@@ -211,6 +292,15 @@ static void pca9552_initfn(Object *obj)
      */
     s->max_reg = PCA9552_LS3;
     s->nr_leds = 16;
+
+    for (led = 0; led < s->nr_leds; led++) {
+        char *name;
+
+        name = g_strdup_printf("led%d", led);
+        object_property_add(obj, name, "bool", pca9552_get_led, pca9552_set_led,
+                            NULL, NULL, NULL);
+        g_free(name);
+    }
 }
 
 static void pca9552_class_init(ObjectClass *klass, void *data)
-- 
2.20.1


