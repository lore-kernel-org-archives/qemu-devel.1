Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D66EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C2A2071F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExVMW93q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C2A2071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia92v-00045F-0e
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xC-00066M-Ut
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xB-0004Qg-01
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8xA-0004OM-PP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:44 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so25954951wrt.6
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IfenfcTVCoFvmoP5t3zC9KPTOFcafxM1N4sFnXaSYhI=;
 b=ExVMW93qY2EA69/TeJjbrGPl4NZFi/wTt0blciufBU0KYkjEDJNK/L4ao5xS7ksMJS
 tKJNy1YMVA54fuZgu1J6nY0vWYoUxHh/5rx+pKAClhnq2ORHK4lqZxIm+uPXMLT6K578
 KXbhUMTRQ3r/o89pxKlMXGeNwK7b79Oh4ZKu1pdea09y0yInKqMhdAxR0cOTcQGdf72T
 NOn5Sawhaw6cD1Mr3zYAaXYVlZz0y5m1ITGBILNigBIBzeQX7ROWTIzg5FXjjTLGF5vu
 0komCtKY4zt4SpIzX5PI98ZGr7ofxAPAQgoM7zm3rGS5igBabFOnJDdgnm3UWRv86Hmx
 p5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IfenfcTVCoFvmoP5t3zC9KPTOFcafxM1N4sFnXaSYhI=;
 b=Jy00aUstsIKzugwAGwYKhWe7Z2xbSfeQY7Zx6DxEZA4P+cvXa209ZAcz9VbFdhHoeM
 Jsch+D3onCUIYWzgf46YobWxuEXx2DNkwVi8nr1b6BrHwiDAyrkHKddktQp04oENJEiT
 PL6o6wOxpFAaiFG+lvRauu5MwQhAAAWgckJw1lDDdIdohXg+s7PMFiUcjaiYfHOJ8HE5
 Oz4XAv/o+GcTl9Mtzo4HV23LXBiO7VNN8EC0JGa82irXnZXxbJb6viRbGGzybRSarEZy
 hRtRrCbO4/wgb48Hzl0XINaNvgW4l8Xn9s0t/Zvg9mj81rCL5ckwnX764RuDPapVv6ob
 tgDg==
X-Gm-Message-State: APjAAAWWXx8/x4kES1tHQzwpHfSd/v5oiEZo8eiTD83q+vqETId3f3Nv
 Uu8gXI2xSoXeo8TVpwDZ6x7ZKMCU
X-Google-Smtp-Source: APXvYqzufHnlEewaR+WvkclMGnLkP1hUDEWoENhRwbYvLVFIZjd86GUEQc2dUsiukUnQr4mNLnWpKQ==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr45504775wrc.175.1574905843626; 
 Wed, 27 Nov 2019 17:50:43 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH 07/10] hw/avr: Add few Arduino boards
Date: Thu, 28 Nov 2019 02:50:27 +0100
Message-Id: <20191128015030.27543-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add famous Arduino boards:

- Arduino Duemilanove
- Arduino Mega

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/avr/arduino.c     | 173 +++++++++++++++++++++++++++++++++++++++++++
 hw/avr/Makefile.objs |   1 +
 2 files changed, 174 insertions(+)
 create mode 100644 hw/avr/arduino.c

diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
new file mode 100644
index 0000000000..191193d614
--- /dev/null
+++ b/hw/avr/arduino.c
@@ -0,0 +1,173 @@
+/*
+ * QEMU Arduino boards
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPLv2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* TODO: Implement the use of EXTRAM */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "atmega.h"
+
+typedef struct ArduinoBoardConfig {
+    const char *name;
+    const char *desc;
+    const char *alias;
+    const char *mcu_type;
+    uint64_t xtal_hz;
+    size_t extram_size;
+    bool is_default;
+} ArduinoBoardConfig;
+
+static const ArduinoBoardConfig arduino_boards[] = {
+    {
+        /* https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove */
+        .name       = MACHINE_TYPE_NAME("arduino-duemilanove"),
+        .desc       = "Arduino Duemilanove (ATmega168)",
+        .alias      = "2009",
+        .mcu_type    = TYPE_ATMEGA168,
+        .xtal_hz    = 16 * 1000 * 1000,
+    }, {
+        /* https://store.arduino.cc/arduino-uno-rev3 */
+        .name       = MACHINE_TYPE_NAME("arduino-uno"),
+        .desc       = "Arduino Duemilanove (ATmega328P)",
+        .alias      = "UNO",
+        .mcu_type    = TYPE_ATMEGA328,
+        .xtal_hz    = 16 * 1000 * 1000,
+    }, {
+        /* https://www.arduino.cc/en/Main/ArduinoBoardMega */
+        .name       = MACHINE_TYPE_NAME("arduino-mega"),
+        .desc       = "Arduino Mega (ATmega1280)",
+        .alias      = "MEGA",
+        .mcu_type    = TYPE_ATMEGA1280,
+        .xtal_hz    = 16 * 1000 * 1000,
+    }, {
+        /* https://store.arduino.cc/arduino-mega-2560-rev3 */
+        .name       = MACHINE_TYPE_NAME("arduino-mega-2560-v3"),
+        .desc       = "Arduino Mega 2560 (ATmega2560)",
+        .alias      = "MEGA2560",
+        .mcu_type    = TYPE_ATMEGA2560,
+        .xtal_hz    = 16 * 1000 * 1000, /* CSTCE16M0V53-R0 */
+        .is_default = true,
+    },
+};
+
+typedef struct ArduinoMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
+    AtmegaState mcu;
+    MemoryRegion extram;
+} ArduinoMachineState;
+
+typedef struct ArduinoMachineClass {
+    /*< private >*/
+    MachineClass parent_class;
+    /*< public >*/
+    const ArduinoBoardConfig *config;
+} ArduinoMachineClass;
+
+#define TYPE_ARDUINO_MACHINE \
+        MACHINE_TYPE_NAME("arduino")
+#define ARDUINO_MACHINE(obj) \
+        OBJECT_CHECK(ArduinoMachineState, (obj), TYPE_ARDUINO_MACHINE)
+#define ARDUINO_MACHINE_CLASS(klass) \
+        OBJECT_CLASS_CHECK(ArduinoMachineClass, (klass), TYPE_ARDUINO_MACHINE)
+#define ARDUINO_MACHINE_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(ArduinoMachineClass, (obj), TYPE_ARDUINO_MACHINE)
+
+static void load_firmware(const char *firmware, uint64_t flash_size)
+{
+    const char *filename;
+    int bytes_loaded;
+
+    /* Load firmware (contents of flash) trying to auto-detect format */
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+    if (filename == NULL) {
+        error_report("Unable to find %s", firmware);
+        exit(1);
+    }
+
+    bytes_loaded = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL,
+                            0, EM_NONE, 0, 0);
+    if (bytes_loaded < 0) {
+        bytes_loaded = load_image_targphys(filename, OFFSET_CODE, flash_size);
+    }
+    if (bytes_loaded < 0) {
+        error_report("Unable to load firmware image %s as ELF or raw binary",
+                     firmware);
+        exit(1);
+    }
+}
+
+static void arduino_machine_init(MachineState *machine)
+{
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_GET_CLASS(machine);
+    ArduinoMachineState *ams = ARDUINO_MACHINE(machine);
+
+    sysbus_init_child_obj(OBJECT(machine), "mcu", &ams->mcu, sizeof(ams->mcu),
+                          amc->config->mcu_type);
+    object_property_set_uint(OBJECT(&ams->mcu), amc->config->xtal_hz,
+                             "xtal-frequency-hz", &error_abort);
+    object_property_set_bool(OBJECT(&ams->mcu), true, "realized",
+                             &error_abort);
+
+    if (machine->firmware) {
+        load_firmware(machine->firmware, memory_region_size(&ams->mcu.flash));
+    }
+}
+
+static void arduino_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+    const ArduinoBoardConfig *cfg = data;
+
+    mc->desc = cfg->desc;
+    mc->alias = cfg->alias;
+    mc->init = arduino_machine_init;
+    mc->default_cpus = 1;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_parallel = 1;
+    mc->is_default = cfg->is_default;
+    mc->default_ram_size = cfg->extram_size;
+    amc->config = cfg;
+}
+
+static const TypeInfo arduino_machine_type = {
+    .name = TYPE_ARDUINO_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(ArduinoMachineState),
+    .class_size = sizeof(ArduinoMachineClass),
+    .abstract = true,
+};
+
+static void arduino_machine_types(void)
+{
+    size_t i;
+
+    type_register_static(&arduino_machine_type);
+    for (i = 0; i < ARRAY_SIZE(arduino_boards); ++i) {
+        TypeInfo ti = {
+            .name       = arduino_boards[i].name,
+            .parent     = TYPE_ARDUINO_MACHINE,
+            .class_init = arduino_machine_class_init,
+            .class_data = (void *)&arduino_boards[i],
+        };
+        type_register(&ti);
+    }
+}
+
+type_init(arduino_machine_types)
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index 4b6b911820..39ee3c32b2 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y += sample.o
 obj-y += atmega.o
+obj-y += arduino.o
-- 
2.21.0


