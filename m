Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2114C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADAF5207ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4SyiRbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAF5207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjnuR-0008Ow-QO
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntN-0006h7-3z; Fri, 12 Jun 2020 13:55:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39151)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntL-0004Bk-Hp; Fri, 12 Jun 2020 13:55:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id k26so9060426wmi.4;
 Fri, 12 Jun 2020 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oF2pu4eIH0IdOMRtI6qyxe6R9jMEe4XzBzxqgQ2GpXQ=;
 b=C4SyiRbDbUubGZQbBGqIEn4bvaoqakz+H2dDx5mCh8lvpTXyUUbi/OKWzn4YyMjmvt
 F5zXCsHm4PxcDWv0deNtOjqZsHvpwQJea+h4tlMqaZQFE58toUwuqQsZM2SWOKhgs9es
 jRxnlzW2kOOXAFJh3oZXt2gWa0Y3XL7PtLRg/ku8n/2yYC4b+c3EthAkcNs9OzXczAs5
 S2pzL4zivZWDkaKeOGiACyhMEQs570/qtQWCmz3XhkTvlR+yvg8FMiBtG2CtQ5sSFGNX
 wnolCQZSeNm0HvziM8fiE3EOGlpxaRuyyuK3b8CIintz+YQ2hAkSgnDUJmDwTPbIR7hx
 SKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oF2pu4eIH0IdOMRtI6qyxe6R9jMEe4XzBzxqgQ2GpXQ=;
 b=iZt7pp+bTM8HFPLim9jxF3RwkVZQJX6gXzhkfCjEkOIwoMtUw26RRBMA3v/oNCcEyh
 6byTl6d2rmH4lx5GujcYKkaR5bCMBd7X4vQlwFXSX2U+dZ9gPXRmq1KA6vJyLAkiTY9B
 zoUPt29mG+P3A5LIuf1IZWFToN9hKmmSThLMDXq9ukzhauqquL3OmWaRJUF4dYZH0PdB
 /oggWoIe9RQfJZCAXu99xPSHDP/807oqy5vjXk/JLP8yY2TH7AnPY53pAGIrcvhfDzJ1
 gyuoV33kX7o02yvPSJzv4cS6c3I2WxodgX8AUBUAbZyG3doFYiXfmmSmWqowlLmE1gNb
 cYvQ==
X-Gm-Message-State: AOAM532V+dHBhWXilriuTz97K3JerRl1Tws1mOWSsCTM/ptV949sZ/4v
 G5vlB9IUm5ONgkA11ZgH2V9pqdmA
X-Google-Smtp-Source: ABdhPJwPlH/MLWtaHzN5PbDEHuPBCmwgv4dNVVAUNogj1wBY14iOP4zw94RrPKmi8EQmov0loGYrUQ==
X-Received: by 2002:a1c:63c2:: with SMTP id x185mr124234wmb.68.1591984485123; 
 Fri, 12 Jun 2020 10:54:45 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e12sm11288658wro.52.2020.06.12.10.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 10:54:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 1/5] hw/misc: Add a LED device
Date: Fri, 12 Jun 2020 19:54:36 +0200
Message-Id: <20200612175440.9901-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612175440.9901-1-f4bug@amsat.org>
References: <20200612175440.9901-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Esteban Bosse <estebanbosse@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
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
index 0000000000..1bae1a34c0
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
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/led.h"
+#include "hw/irq.h"
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
+    led_set(dev, 0, s->reset_state);
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
index 3abe3faa4e..10593863dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1857,6 +1857,12 @@ F: docs/specs/vmgenid.txt
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
index 5561746866..e15b7f7c81 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
 grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
+
+# led.c
+led_set(const char *name, uint8_t old_state, uint8_t new_state) "led name:'%s' state %d -> %d"
-- 
2.21.3


