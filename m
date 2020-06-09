Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD14C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8471E207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBijAd/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8471E207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidb8-00049j-Nh
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSj-0000Im-4F; Tue, 09 Jun 2020 08:34:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSY-00074L-Sc; Tue, 09 Jun 2020 08:34:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id q11so21138761wrp.3;
 Tue, 09 Jun 2020 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0srfxT0e6nUZFR6Iq4rRmoV3V4fYm5JRcQS2tAU0vxw=;
 b=hBijAd/46i+x7ednlZBvGseJgaQjQRWhOSbsj0oI54n58nUqF2S530xr6+XpaaxarS
 bSRcSx05lnubiKRWMMivA6eVzr33/6btMppdsbdwV9SPavLLyhXN71v5RWvJAcucMmKc
 1JzVJPalhJpkCLJwOJiRDoBvdWFZvnQuakM4NMjR39SX/ElSpjiYe1IL4BEemcUwbLup
 y7iyJO+d+cyBOyRjPKKbyGnOxiEJMYBP9tfT+C1S6rGmDhL5u3V+s/MDnY5i49TzERzx
 J/bYy6WCr/rWVGTVD+tSLOjvb67sphqTZyHta0/KKfmVjktOPuJVSSOoycQ0RofsWmHP
 0+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0srfxT0e6nUZFR6Iq4rRmoV3V4fYm5JRcQS2tAU0vxw=;
 b=nfq7/2pFUQvEYUbopx331ppKuebGJiil9Sv1XmEUlKskwHzf/OrvXAkHmz1Ek2SFoh
 Z/EzFO/qU10gc5smHvEirnjEMAoPgiDtvABgA1wRTrbLfvpIk5+0Y6/IC41E/PIxCB2a
 xMFWO1ezsTs2oILB0phf/2BpSoQMGCbh1KF5k+/NMlHBkt4YXZ+UUV+PkHLgnidAzDzF
 ILVuuCTQVs28rE0EW7knrwF6nsUe1BGuK0DPBY/t5cEcBaiblJ0oIYCZaWw5st8r0chJ
 KGmq2zXkt+XzSMQVcyO97Wp1nMbQD2wcmLz8eFWp7moDaEspRnm9hifCQsRHL/8JNadK
 n4XQ==
X-Gm-Message-State: AOAM531Cg7J98a9ZZ2dAeGcNeBj5+x/bSCiDfyQmBDZPNwWz/2EhS0GQ
 Dd4W14/2SSFpZAWbRo3IpPETW5Um
X-Google-Smtp-Source: ABdhPJy2WD9lDZkba//FSINYDayYvNVeUe+164Bn2+TAEAIOvjAyUjhRfNiYc3sWKed+xofFa7t8kQ==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr4167824wrs.100.1591706068136; 
 Tue, 09 Jun 2020 05:34:28 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c81sm2920931wmd.42.2020.06.09.05.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 05:34:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/5] hw/misc: Add a LED device
Date: Tue,  9 Jun 2020 14:34:21 +0200
Message-Id: <20200609123425.6921-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609123425.6921-1-f4bug@amsat.org>
References: <20200609123425.6921-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A LED device can be connected to a GPIO output.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/led.h | 30 ++++++++++++++++
 hw/misc/led.c         | 84 +++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS           |  6 ++++
 hw/misc/Kconfig       |  3 ++
 hw/misc/Makefile.objs |  1 +
 hw/misc/trace-events  |  3 ++
 6 files changed, 127 insertions(+)
 create mode 100644 include/hw/misc/led.h
 create mode 100644 hw/misc/led.c

diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
new file mode 100644
index 0000000000..427ca1418e
--- /dev/null
+++ b/include/hw/misc/led.h
@@ -0,0 +1,30 @@
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
+#include "hw/sysbus.h" /* FIXME remove */
+
+#define TYPE_LED "led"
+#define LED(obj) OBJECT_CHECK(LEDState, (obj), TYPE_LED)
+
+typedef struct LEDState {
+    /* Private */
+    SysBusDevice parent_obj; /* FIXME DeviceState */
+    /* Public */
+
+    qemu_irq irq;
+    uint8_t current_state;
+
+    /* Properties */
+    char *name;
+    uint8_t reset_state; /* TODO [GPIO_ACTIVE_LOW, GPIO_ACTIVE_HIGH] */
+} LEDState;
+
+#endif /* HW_MISC_LED_H */
diff --git a/hw/misc/led.c b/hw/misc/led.c
new file mode 100644
index 0000000000..dc61b11017
--- /dev/null
+++ b/hw/misc/led.c
@@ -0,0 +1,84 @@
+/*
+ * QEMU single LED device
+ *
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/led.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+static void led_set(void *opaque, int line, int new_state)
+{
+    LEDState *s = LED(opaque);
+
+    trace_led_set(s->name, s->current_state, new_state);
+
+    s->current_state = new_state;
+}
+
+static void led_reset(DeviceState *dev)
+{
+    LEDState *s = LED(dev);
+
+    s->current_state = s->reset_state;
+}
+
+static const VMStateDescription vmstate_led = {
+    .name = TYPE_LED,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(reset_state, LEDState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void led_realize(DeviceState *dev, Error **errp)
+{
+    LEDState *s = LED(dev);
+
+    if (s->name == NULL) {
+        error_setg(errp, "property 'name' not specified");
+        return;
+    }
+
+    qdev_init_gpio_in(DEVICE(s), led_set, 1);
+}
+
+static Property led_properties[] = {
+    DEFINE_PROP_STRING("name", LEDState, name),
+    DEFINE_PROP_UINT8("reset_state", LEDState, reset_state, 0),
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
+    .parent = TYPE_SYS_BUS_DEVICE, /* FIXME TYPE_DEVICE */
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..f873f0b94a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1864,6 +1864,12 @@ S: Maintained
 F: include/hw/misc/unimp.h
 F: hw/misc/unimp.c
 
+LED
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Maintained
+F: include/hw/misc/led.h
+F: hw/misc/led.c
+
 Standard VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
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
index 60a9d80b74..aae07033f9 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -90,3 +90,4 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+common-obj-$(CONFIG_LED) += led.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index a5862b2bed..55d7143f23 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -198,3 +198,6 @@ via1_rtc_cmd_pram_read(int addr, int value) "addr=%u value=0x%02x"
 via1_rtc_cmd_pram_write(int addr, int value) "addr=%u value=0x%02x"
 via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int value) "sector=%u offset=%u addr=%d value=0x%02x"
 via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "sector=%u offset=%u addr=%d value=0x%02x"
+
+# led.c
+led_set(const char *name, uint8_t old_state, uint8_t new_state) "led name:'%s' state %d -> %d"
-- 
2.21.3


