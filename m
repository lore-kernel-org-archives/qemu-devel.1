Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B6CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6D220878
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qz1tu9Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6D220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAr7-0000se-S3
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAdT-0008SM-0h; Mon, 26 Oct 2020 18:06:43 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAdQ-0005lZ-Gm; Mon, 26 Oct 2020 18:06:38 -0400
Received: by mail-ed1-x544.google.com with SMTP id v19so11290139edx.9;
 Mon, 26 Oct 2020 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rp+PT0DKslfkK4k99N9IovK0uPHrIUK2nuMArbsAM+E=;
 b=qz1tu9XjbMz5jQTmKqvIerLy11A/omROPUfKyVmtCtuVCvcAy8x7yVO85WvocIrNx+
 /128MWnsyb5SHxtGV5T5Zgkaaadwoq+W0RYmCiiL6AzrYQpOI+vvYR4h4Q1wyH5540l5
 t0dwyFYZVJr5l5w3Ggy11bmVF7ju7tEYc/oHtH0LhTVwS0SNqXxLEDWBgd3txj9zhyBP
 noYz9WrW2QvocPuyNimbpMpkE0E09CaNrU5iQfuoeU0RY/bNfny9HoH8TcukeH5y7lX7
 G/ZEljfnvtjMpXp9xWXffGY+xXaX/u4eLZav+925RX5aRMfEVGWtPra6Qksx6b0AdL4h
 63Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rp+PT0DKslfkK4k99N9IovK0uPHrIUK2nuMArbsAM+E=;
 b=LvDq5EnQCk5kTsG6Czr5FvTANPrU+4HeCFOUmAm+nKYzckOAoMwllxoXBVX7TW+h8g
 MOPyZSJscKeNjZ7KimNgMtgbwV1bre8EZP6BGuBBsohExjvgpJYqTeYT5Q4sCtDTpI4o
 doCpjqL1ab7Pj/R4mAWFoUUKP8bn8b+QFOpctpb31HP+hpr3VQ4DUn/IBVnwOPyTmWfH
 ZFWQ7eGcECgLj7X7TD3AZNGubtyBWKx9KWNyogCmQoLzUXQLpNiPBK8VyK8F5bUhVGGY
 J6VCzi9MK1v9X/AK4aqs1qq9l6ZxKHAHFMvKecp/HzqKIsHLOE0vK0KznsUFlvP4LUo+
 SwtQ==
X-Gm-Message-State: AOAM531xf6pHU5qqYb5uDezRQwcKqwyLzQ9jf/JSE3sC0ilDzAVFrpP1
 3Zx0ogsX/Ip0IglPRqgH2fXVwBwBKZM=
X-Google-Smtp-Source: ABdhPJyFYECewczaZ6w3tXITbgzxryHLD/LrkanichJCdHInM0QSjuG4Z5mGp6ChlcZGffnv4yWX5Q==
X-Received: by 2002:a05:6402:143d:: with SMTP id
 c29mr12995229edx.277.1603749993173; 
 Mon, 26 Oct 2020 15:06:33 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id ao17sm6696333ejc.18.2020.10.26.15.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 15:06:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] hw/misc/led: Add a LED device
Date: Mon, 26 Oct 2020 23:06:18 +0100
Message-Id: <20201026220624.60878-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026220624.60878-1-f4bug@amsat.org>
References: <20201026220624.60878-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a LED device which can be connected to a GPIO output.
They can also be dimmed with PWM devices. For now we do
not implement the dimmed mode, but in preparation of a
future implementation, we start using the LED intensity.

LEDs are limited to a fixed set of colors.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200912134041.946260-2-f4bug@amsat.org>
---
 include/hw/misc/led.h |  87 ++++++++++++++++++++++++++
 hw/misc/led.c         | 142 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS           |   6 ++
 hw/misc/Kconfig       |   3 +
 hw/misc/meson.build   |   1 +
 hw/misc/trace-events  |   3 +
 6 files changed, 242 insertions(+)
 create mode 100644 include/hw/misc/led.h
 create mode 100644 hw/misc/led.c

diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
new file mode 100644
index 00000000000..286d37c75c1
--- /dev/null
+++ b/include/hw/misc/led.h
@@ -0,0 +1,87 @@
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
+#include "qom/object.h"
+
+#define TYPE_LED "led"
+
+/**
+ * LEDColor: Color of a LED
+ *
+ * This set is restricted to physically available LED colors.
+ *
+ * LED colors from 'Table 1. Product performance of LUXEON Rebel Color
+ * Line' of the 'DS68 LUXEON Rebel Color Line' datasheet available at:
+ * https://www.lumileds.com/products/color-leds/luxeon-rebel-color/
+ */
+typedef enum {          /* Coarse wavelength range */
+    LED_COLOR_VIOLET,   /* 425 nm */
+    LED_COLOR_BLUE,     /* 475 nm */
+    LED_COLOR_CYAN,     /* 500 nm */
+    LED_COLOR_GREEN,    /* 535 nm */
+    LED_COLOR_AMBER,    /* 590 nm */
+    LED_COLOR_ORANGE,   /* 615 nm */
+    LED_COLOR_RED,      /* 630 nm */
+} LEDColor;
+
+struct LEDState {
+    /* Private */
+    DeviceState parent_obj;
+    /* Public */
+
+    uint8_t intensity_percent;
+
+    /* Properties */
+    char *description;
+    char *color;
+};
+typedef struct LEDState LEDState;
+DECLARE_INSTANCE_CHECKER(LEDState, LED, TYPE_LED)
+
+/**
+ * led_set_intensity: Set the intensity of a LED device
+ * @s: the LED object
+ * @intensity_percent: intensity as percentage in range 0 to 100.
+ */
+void led_set_intensity(LEDState *s, unsigned intensity_percent);
+
+/**
+ * led_get_intensity:
+ * @s: the LED object
+ *
+ * Returns: The LED intensity as percentage in range 0 to 100.
+ */
+unsigned led_get_intensity(LEDState *s);
+
+/**
+ * led_set_state: Set the state of a LED device
+ * @s: the LED object
+ * @is_emitting: boolean indicating whether the LED is emitting
+ *
+ * This utility is meant for LED connected to GPIO.
+ */
+void led_set_state(LEDState *s, bool is_emitting);
+
+/**
+ * led_create_simple: Create and realize a LED device
+ * @parentobj: the parent object
+ * @color: color of the LED
+ * @description: description of the LED (optional)
+ *
+ * Create the device state structure, initialize it, and
+ * drop the reference to it (the device is realized).
+ *
+ * Returns: The newly allocated and instantiated LED object.
+ */
+LEDState *led_create_simple(Object *parentobj,
+                            LEDColor color,
+                            const char *description);
+
+#endif /* HW_MISC_LED_H */
diff --git a/hw/misc/led.c b/hw/misc/led.c
new file mode 100644
index 00000000000..1e2f49c5710
--- /dev/null
+++ b/hw/misc/led.c
@@ -0,0 +1,142 @@
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
+#define LED_INTENSITY_PERCENT_MAX   100
+
+static const char * const led_color_name[] = {
+    [LED_COLOR_VIOLET]  = "violet",
+    [LED_COLOR_BLUE]    = "blue",
+    [LED_COLOR_CYAN]    = "cyan",
+    [LED_COLOR_GREEN]   = "green",
+    [LED_COLOR_AMBER]   = "amber",
+    [LED_COLOR_ORANGE]  = "orange",
+    [LED_COLOR_RED]     = "red",
+};
+
+static bool led_color_name_is_valid(const char *color_name)
+{
+    for (size_t i = 0; i < ARRAY_SIZE(led_color_name); i++) {
+        if (strcmp(color_name, led_color_name[i]) == 0) {
+            return true;
+        }
+    }
+    return false;
+}
+
+void led_set_intensity(LEDState *s, unsigned intensity_percent)
+{
+    if (intensity_percent > LED_INTENSITY_PERCENT_MAX) {
+        intensity_percent = LED_INTENSITY_PERCENT_MAX;
+    }
+    trace_led_set_intensity(s->description, s->color, intensity_percent);
+    s->intensity_percent = intensity_percent;
+}
+
+unsigned led_get_intensity(LEDState *s)
+{
+    return s->intensity_percent;
+}
+
+void led_set_state(LEDState *s, bool is_emitting)
+{
+    led_set_intensity(s, is_emitting ? LED_INTENSITY_PERCENT_MAX : 0);
+}
+
+static void led_reset(DeviceState *dev)
+{
+    LEDState *s = LED(dev);
+
+    led_set_state(s, false);
+}
+
+static const VMStateDescription vmstate_led = {
+    .name = TYPE_LED,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(intensity_percent, LEDState),
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
+    } else if (!led_color_name_is_valid(s->color)) {
+        error_setg(errp, "property 'color' invalid or not supported");
+        return;
+    }
+    if (s->description == NULL) {
+        s->description = g_strdup("n/a");
+    }
+}
+
+static Property led_properties[] = {
+    DEFINE_PROP_STRING("color", LEDState, color),
+    DEFINE_PROP_STRING("description", LEDState, description),
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
+LEDState *led_create_simple(Object *parentobj,
+                            LEDColor color,
+                            const char *description)
+{
+    g_autofree char *name = NULL;
+    DeviceState *dev;
+
+    dev = qdev_new(TYPE_LED);
+    qdev_prop_set_string(dev, "color", led_color_name[color]);
+    if (!description) {
+        static unsigned undescribed_led_id;
+        name = g_strdup_printf("undescribed-led-#%u", undescribed_led_id++);
+    } else {
+        qdev_prop_set_string(dev, "description", description);
+        name = g_ascii_strdown(description, -1);
+        name = g_strdelimit(name, " #", '-');
+    }
+    object_property_add_child(parentobj, name, OBJECT(dev));
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
+
+    return LED(dev);
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index ef6f5c73998..7e442b52472 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1967,6 +1967,12 @@ F: docs/specs/vmgenid.txt
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
index 31854561105..e4d059591ad 100644
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
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 793d45b1dc4..aa8ec3bca9b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -11,6 +11,7 @@
 softmmu_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
 softmmu_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 softmmu_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
+softmmu_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
 
 # ARM devices
 softmmu_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 6054f9adf35..2b6310dbe4b 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -223,6 +223,9 @@ via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size
 grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
 grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
 
+# led.c
+led_set_intensity(const char *color, const char *desc, uint8_t intensity_percent) "LED desc:'%s' color:%s intensity: %u%%"
+
 # pca9552.c
 pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
 pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
-- 
2.26.2


