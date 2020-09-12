Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A5CC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0922D20829
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uciR+5a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0922D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH5n1-0003Jm-2p
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 09:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lq-0001Ze-KW; Sat, 12 Sep 2020 09:40:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lo-0007pe-WC; Sat, 12 Sep 2020 09:40:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id g4so14104048wrs.5;
 Sat, 12 Sep 2020 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w8Eo5/7klXOolpStkbQL0lu8B2pZTUunJlMPyHZPBkE=;
 b=uciR+5a5X9kHY5AYZgFmM7NhPz72lwUQmpehWGgPBVPbW1sxTyBC17FhEFSbfsadde
 Zv7LFOoe82E/xIKzAtxSVdbFCCYyf1k9A08g7vnnbZ12O004xEUG7paM5skUrWn6EFq/
 f0BkNYYu6hMfj6pOM+mXd/rfsx0Wp7swL8CqGJmd8MWaCN3ce9UB38res5wB6TNFuFhM
 u61wsgZ2OmqeVyI6EcT2KRQ9FXvqhhj3KZLQ8BS46g3k8VHBlCD2dupHjNOfCAQjFx4v
 gkncRIMlVAs13S2oFqZjYhnb5NZq4TU/PJX70MJVDqqVgpk9CWqn3c5UQkPdZmE+cHrF
 z+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=w8Eo5/7klXOolpStkbQL0lu8B2pZTUunJlMPyHZPBkE=;
 b=jYgrb1fid2+Z3AYBfVdWGzz+fdRZGV+RELmSbUEEv0OTigbohrDR6pD9sK2uJVJ5cW
 xQ/w3c82k6JSUvYw0ildfjy6A/Dn+JXH8eWtSzWQ43u9gkJNKDPl66+ebJY0wbaluYg/
 4xmqdkyCFJi79y3xmfnThWEqZulDivpK5oV19Sb24Edpso9Wyb3vMzFCFBISIs/IiGoa
 qm45Gd9ukd4v3qI5uqo9VLfhdRlsETqzH5+7yEoDqq48x+ml4GwL7Y42jQUxoYssrv0r
 wvURp1P1xRN3XoFyK7yKLbKIGyW3sh9lgoud8eOyszK7HU7tiyH9yv81jG5EwjQJEnJB
 HS3A==
X-Gm-Message-State: AOAM532nBR2RW9xRtY1qhc+c6H58taU5MdFAm6JdTWPigbrhRPtw5o6U
 Vzy4t/T+90RIS/gnppSX9db7C+zezIM=
X-Google-Smtp-Source: ABdhPJxRA+UTEeWLXheVHVA4YGt++jvqhZ+BJpD3sXZWTdvLfh57eeW6G/nyVzRtyfGiG5A2dWg2Lw==
X-Received: by 2002:adf:f586:: with SMTP id f6mr6852900wro.299.1599918047130; 
 Sat, 12 Sep 2020 06:40:47 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm10309144wmg.44.2020.09.12.06.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 06:40:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/7] hw/misc/led: Allow connecting from GPIO output
Date: Sat, 12 Sep 2020 15:40:36 +0200
Message-Id: <20200912134041.946260-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912134041.946260-1-f4bug@amsat.org>
References: <20200912134041.946260-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some devices expose GPIO lines.

Add a GPIO qdev input to our LED device, so we can
connect a GPIO output using qdev_connect_gpio_out().

When used with GPIOs, the intensity can only be either
minium or maximum. This depends of the polarity of the
GPIO (which can be inverted).
Declare the GpioPolarity type to model the polarity.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/led.h  | 10 ++++++++++
 include/hw/qdev-core.h | 16 ++++++++++++++++
 hw/misc/led.c          | 17 ++++++++++++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
index 286d37c75c1..aa359b87c20 100644
--- a/include/hw/misc/led.h
+++ b/include/hw/misc/led.h
@@ -9,6 +9,7 @@
 #define HW_MISC_LED_H
 
 #include "qom/object.h"
+#include "hw/qdev-core.h"
 
 #define TYPE_LED "led"
 
@@ -37,10 +38,17 @@ struct LEDState {
     /* Public */
 
     uint8_t intensity_percent;
+    qemu_irq irq;
 
     /* Properties */
     char *description;
     char *color;
+    /*
+     * Determines whether a GPIO is using a positive (active-high)
+     * logic (when used with GPIO, the intensity at reset is related
+     * to the GPIO polarity).
+     */
+    bool gpio_active_high;
 };
 typedef struct LEDState LEDState;
 DECLARE_INSTANCE_CHECKER(LEDState, LED, TYPE_LED)
@@ -72,6 +80,7 @@ void led_set_state(LEDState *s, bool is_emitting);
 /**
  * led_create_simple: Create and realize a LED device
  * @parentobj: the parent object
+ * @gpio_polarity: GPIO polarity
  * @color: color of the LED
  * @description: description of the LED (optional)
  *
@@ -81,6 +90,7 @@ void led_set_state(LEDState *s, bool is_emitting);
  * Returns: The newly allocated and instantiated LED object.
  */
 LEDState *led_create_simple(Object *parentobj,
+                            GpioPolarity gpio_polarity,
                             LEDColor color,
                             const char *description);
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e025ba9653f..ec1f1efc37b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -423,6 +423,22 @@ void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
 void qdev_machine_creation_done(void);
 bool qdev_machine_modified(void);
 
+/**
+ * GpioPolarity: Polarity of a GPIO line
+ *
+ * GPIO lines use either positive (active-high) logic,
+ * or negative (active-low) logic.
+ *
+ * In active-high logic (%GPIO_POLARITY_ACTIVE_HIGH), a pin is
+ * active when the voltage on the pin is high (relative to ground);
+ * whereas in active-low logic (%GPIO_POLARITY_ACTIVE_LOW), a pin
+ * is active when the voltage on the pin is low (or grounded).
+ */
+typedef enum {
+    GPIO_POLARITY_ACTIVE_LOW,
+    GPIO_POLARITY_ACTIVE_HIGH
+} GpioPolarity;
+
 /**
  * qdev_get_gpio_in: Get one of a device's anonymous input GPIO lines
  * @dev: Device whose GPIO we want
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 1e2f49c5710..c5fa09a613a 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -10,6 +10,7 @@
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/led.h"
+#include "hw/irq.h"
 #include "trace.h"
 
 #define LED_INTENSITY_PERCENT_MAX   100
@@ -53,11 +54,19 @@ void led_set_state(LEDState *s, bool is_emitting)
     led_set_intensity(s, is_emitting ? LED_INTENSITY_PERCENT_MAX : 0);
 }
 
+static void led_set_state_gpio_handler(void *opaque, int line, int new_state)
+{
+    LEDState *s = LED(opaque);
+
+    assert(line == 0);
+    led_set_state(s, !!new_state != s->gpio_active_high);
+}
+
 static void led_reset(DeviceState *dev)
 {
     LEDState *s = LED(dev);
 
-    led_set_state(s, false);
+    led_set_state(s, s->gpio_active_high);
 }
 
 static const VMStateDescription vmstate_led = {
@@ -84,11 +93,14 @@ static void led_realize(DeviceState *dev, Error **errp)
     if (s->description == NULL) {
         s->description = g_strdup("n/a");
     }
+
+    qdev_init_gpio_in(DEVICE(s), led_set_state_gpio_handler, 1);
 }
 
 static Property led_properties[] = {
     DEFINE_PROP_STRING("color", LEDState, color),
     DEFINE_PROP_STRING("description", LEDState, description),
+    DEFINE_PROP_BOOL("gpio-active-high", LEDState, gpio_active_high, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -119,6 +131,7 @@ static void led_register_types(void)
 type_init(led_register_types)
 
 LEDState *led_create_simple(Object *parentobj,
+                            GpioPolarity gpio_polarity,
                             LEDColor color,
                             const char *description)
 {
@@ -126,6 +139,8 @@ LEDState *led_create_simple(Object *parentobj,
     DeviceState *dev;
 
     dev = qdev_new(TYPE_LED);
+    qdev_prop_set_bit(dev, "gpio-active-high",
+                      gpio_polarity == GPIO_POLARITY_ACTIVE_HIGH);
     qdev_prop_set_string(dev, "color", led_color_name[color]);
     if (!description) {
         static unsigned undescribed_led_id;
-- 
2.26.2


