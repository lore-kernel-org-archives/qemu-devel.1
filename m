Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CC1C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0552474A
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGg8rQyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0552474A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmce-0003A6-07
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmma7-0006y0-Jl; Sat, 20 Jun 2020 19:07:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmma5-0002M6-PS; Sat, 20 Jun 2020 19:07:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so3579615wme.5;
 Sat, 20 Jun 2020 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uy+mvISrtHvQu5hNX7wJEHS7Ifd/2AZK2mIPsLbgTkA=;
 b=JGg8rQyiBhYfEhkOhiF5taHN0lhmvxsp1hH/zfjri8ttF6SdQGQs8EF7SfzSum0pdk
 V7jBwyH5iHPyUAFgC8q4q2xyomY+x9Ic4i6LF3JfRIHaC3AXRoYKSWjm2OwTcx3sCSRG
 rTqhBZQ16AFybOIIlgtBdAt4EIgFftzTV/XKLyzn7zoiDgS4K8zLNOY2li4yKI4HnWtT
 ZOrzE0LyaW1D8hSra8QT4QBKjDE+rIO6Kjvk/3aFj8MVkjkTFIg+8SXqOcno5q3ENvu9
 FtTbPiLx+IRh80Rld86asfC2G9wRbN68v1AaxCiISDzAHA0/yyqk2eXEY891kcv9axrm
 xwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Uy+mvISrtHvQu5hNX7wJEHS7Ifd/2AZK2mIPsLbgTkA=;
 b=SxUMZabXK866wSYQXDXPmXe0VrM6X7eS7sO/T6TK/g0GGHiBFhDrwOIBBFkN6DHIBU
 fa/wOETpd3f7We1V+No3roOGDFQHiu8006/tA2a0HvIFOyCj6bcFkUg6Z0ebqFqcn/M5
 MUsPQim/sUGnyGeU/zaXDDONjaRixRE3sVSbngB4+Xz6MVKDN3x6bAX9jLAdx5u/DhHP
 viG6Tn7N+DlTKxPr+6RBrt+vVDvwQ8RoVDftDLC8VJPusvDHag1fiYd/oU66bYnD8HIf
 h2p3ee4S4GSPVb4Xc41bhsLqYWnLXeZfo5AV9CtZy8jVmqgYGVrq35c7beNZblTPZmFA
 TsOw==
X-Gm-Message-State: AOAM530t77W4gbKv3WYtZI5Gv0GqZUAgqd0uHc6gNdH6c54ccOKFnAQ3
 2CWMlrvnQngujWZfzdehb3b80pXS
X-Google-Smtp-Source: ABdhPJxRfZEQgcTTNvzDDBuQrNyJ7CQogaYSRlj4BJA+fP15KLt2lzfWYcHkllFZKol2wRKlwzmTcg==
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr10423246wml.70.1592694443322; 
 Sat, 20 Jun 2020 16:07:23 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o82sm11455037wmo.40.2020.06.20.16.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 16:07:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] hw/misc: Add a LED device
Date: Sun, 21 Jun 2020 01:07:13 +0200
Message-Id: <20200620230719.32139-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620230719.32139-1-f4bug@amsat.org>
References: <20200620230719.32139-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a LED device which can be connected to a GPIO output.
LEDs are limited to a set of colors.
They can also be dimmed with PWM devices. For now we do
not implement the dimmed mode, but in preparation of a
future implementation, we start using the LED intensity.
When used with GPIOs, the intensity can only be either
minium or maximum. This depends of the polarity of the
GPIO.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/led.h |  79 +++++++++++++++++++++++++++
 hw/misc/led.c         | 121 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS           |   6 +++
 hw/misc/Kconfig       |   3 ++
 hw/misc/Makefile.objs |   1 +
 hw/misc/trace-events  |   3 ++
 6 files changed, 213 insertions(+)
 create mode 100644 include/hw/misc/led.h
 create mode 100644 hw/misc/led.c

diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
new file mode 100644
index 0000000000..821ee1247d
--- /dev/null
+++ b/include/hw/misc/led.h
@@ -0,0 +1,79 @@
+/*
+ * QEMU single LED device
+ *
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MISC_LED_H
+#define HW_MISC_LED_H
+
+#include "hw/qdev-core.h"
+
+#define TYPE_LED "led"
+#define LED(obj) OBJECT_CHECK(LEDState, (obj), TYPE_LED)
+
+typedef enum {
+    LED_COLOR_UNKNOWN,
+    LED_COLOR_RED,
+    LED_COLOR_ORANGE,
+    LED_COLOR_AMBER,
+    LED_COLOR_YELLOW,
+    LED_COLOR_GREEN,
+    LED_COLOR_BLUE,
+    LED_COLOR_VIOLET, /* PURPLE */
+    LED_COLOR_WHITE,
+    LED_COLOR_COUNT
+} LEDColor;
+
+/* Definitions useful when a LED is connected to a GPIO */
+#define LED_RESET_INTENSITY_ACTIVE_LOW  UINT16_MAX
+#define LED_RESET_INTENSITY_ACTIVE_HIGH 0U
+
+typedef struct LEDState {
+    /* Private */
+    DeviceState parent_obj;
+    /* Public */
+
+    /* Properties */
+    char *description;
+    char *color;
+    /*
+     * When used with GPIO, the intensity at reset is related to GPIO polarity
+     */
+    uint16_t reset_intensity;
+} LEDState;
+
+/**
+ * led_set_intensity: set the intensity of a LED device
+ * @s: the LED object
+ * @intensity: new intensity
+ *
+ * This utility is meant for LED connected to PWM.
+ */
+void led_set_intensity(LEDState *s, uint16_t intensity);
+
+/**
+ * led_set_intensity: set the state of a LED device
+ * @s: the LED object
+ * @is_on: boolean indicating whether the LED is emitting
+ *
+ * This utility is meant for LED connected to GPIO.
+ */
+void led_set_state(LEDState *s, bool is_on);
+
+/**
+ * create_led: create and LED device
+ * @parent: the parent object
+ * @color: color of the LED
+ * @description: description of the LED (optional)
+ * @reset_intensity: LED intensity at reset
+ *
+ * This utility function creates a LED object.
+ */
+DeviceState *create_led(Object *parentobj,
+                        LEDColor color,
+                        const char *description,
+                        uint16_t reset_intensity);
+
+#endif /* HW_MISC_LED_H */
diff --git a/hw/misc/led.c b/hw/misc/led.c
new file mode 100644
index 0000000000..e55ed7dbc4
--- /dev/null
+++ b/hw/misc/led.c
@@ -0,0 +1,121 @@
+/*
+ * QEMU single LED device
+ *
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/led.h"
+#include "trace.h"
+
+static const char *led_color(LEDColor color)
+{
+    static const char *color_name[LED_COLOR_COUNT] = {
+        [LED_COLOR_RED] = "red",
+        [LED_COLOR_ORANGE] = "orange",
+        [LED_COLOR_AMBER] = "amber",
+        [LED_COLOR_YELLOW] = "yellow",
+        [LED_COLOR_GREEN] = "green",
+        [LED_COLOR_BLUE] = "blue",
+        [LED_COLOR_VIOLET] = "violet", /* PURPLE */
+        [LED_COLOR_WHITE] = "white",
+    };
+    return color_name[color] ? color_name[color] : "unknown";
+}
+
+void led_set_intensity(LEDState *s, uint16_t new_intensity)
+{
+    trace_led_set_intensity(s->description ? s->description : "n/a",
+                            s->color, new_intensity);
+    s->current_intensity = new_intensity;
+}
+
+void led_set_state(LEDState *s, bool is_on)
+{
+    led_set_intensity(s, is_on ? UINT16_MAX : 0);
+}
+
+static void led_reset(DeviceState *dev)
+{
+    LEDState *s = LED(dev);
+
+    led_set_intensity(s, s->reset_intensity);
+}
+
+static const VMStateDescription vmstate_led = {
+    .name = TYPE_LED,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void led_realize(DeviceState *dev, Error **errp)
+{
+    LEDState *s = LED(dev);
+
+    if (s->color == NULL) {
+        error_setg(errp, "property 'color' not specified");
+        return;
+    }
+}
+
+static Property led_properties[] = {
+    DEFINE_PROP_STRING("color", LEDState, color),
+    DEFINE_PROP_STRING("description", LEDState, description),
+    DEFINE_PROP_UINT16("reset_intensity", LEDState, reset_intensity, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void led_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "LED";
+    dc->vmsd = &vmstate_led;
+    dc->reset = led_reset;
+    dc->realize = led_realize;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    device_class_set_props(dc, led_properties);
+}
+
+static const TypeInfo led_info = {
+    .name = TYPE_LED,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(LEDState),
+    .class_init = led_class_init
+};
+
+static void led_register_types(void)
+{
+    type_register_static(&led_info);
+}
+
+type_init(led_register_types)
+
+DeviceState *create_led(Object *parentobj,
+                        LEDColor color,
+                        const char *description,
+                        uint16_t reset_intensity)
+{
+    DeviceState *dev;
+    char *name;
+
+    assert(description);
+    dev = qdev_new(TYPE_LED);
+    qdev_prop_set_uint16(dev, "reset_intensity", reset_intensity);
+    qdev_prop_set_string(dev, "color", led_color(color));
+    qdev_prop_set_string(dev, "description", description);
+    name = g_ascii_strdown(description, -1);
+    name = g_strdelimit(name, " #", '-');
+    object_property_add_child(parentobj, name, OBJECT(dev));
+    g_free(name);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
+
+    return dev;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..0fb8896b43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1863,6 +1863,12 @@ F: docs/specs/vmgenid.txt
 F: tests/qtest/vmgenid-test.c
 F: stubs/vmgenid.c
 
+LED
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Maintained
+F: include/hw/misc/led.h
+F: hw/misc/led.c
+
 Unimplemented device
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daudé <f4bug@amsat.org>
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index bdd77d8020..f60dce694d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -126,6 +126,9 @@ config AUX
 config UNIMP
     bool
 
+config LED
+    bool
+
 config MAC_VIA
     bool
     select MOS6522
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 5aaca8a039..9efa3c941c 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -91,3 +91,4 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+common-obj-$(CONFIG_LED) += led.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 805d2110e0..f58853d367 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -207,6 +207,9 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
 grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
 grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
 
+# led.c
+led_set_intensity(const char *color, const char *desc, uint16_t intensity) "LED desc:'%s' color:%s intensity: 0x%04"PRIx16
+
 # pca9552.c
 pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
 pca9552_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
-- 
2.21.3


