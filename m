Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29DEC35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7832071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 01:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdUtDPZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7832071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunLF-0003oG-Q0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 20:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCz-0002i9-SZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCy-0005fv-2I
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:25 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCx-0005ek-RX; Thu, 23 Jan 2020 19:52:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so90970wrr.1;
 Thu, 23 Jan 2020 16:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sLoFhPRTsuQW0YnaNUatCV3smyi2QhBP5JRij1kuWcA=;
 b=QdUtDPZi7Mq5jPI3IMXwK/f302XolF+ZplVhL1Pa0Sz0m09yfm98Ke55GvfmSIbnSV
 gbeBa6BGaCzqUVVzlauoUa51/eMeqw0h7Zs9tT0H6wUJK1bk1fJ60W2avNb0chl/w4SJ
 DdJ6hXs+cJzCjxFkENsaFyeqL1GKfrymblDyTzZ7diush5/OoqN/mYfxQS6XdqlyG5QE
 U/OfwQb99R4WQ5lp2Z1Z0hYx20niFp3Rg2pGbK3O5YPivCKqQYV2a2v81ng+VHPIGbHE
 Gxe06DIu9940venz9yw/hjq/H653tLQECpUIB3OdUoAebLDAiK+f7nZekcK0tBvev5nh
 aLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sLoFhPRTsuQW0YnaNUatCV3smyi2QhBP5JRij1kuWcA=;
 b=Sgg7bHUOPelb+ZiR1XGQoE6W2mYJBckomB2o12z4kqazPzstK5ARriwy1brfwRH1OV
 lmv1o+Rz7Mu5jtgVt0HjNJVQGL1RFIHrg5K7ReO+H7ebKS2HrJj3ZCi3qyEnG8VY6fMU
 2H738In/apsaoLQvDAQw6hT/B4R++JHIc/zFq4nR0W2fquLGTjMX20jZZzVa43iEvliZ
 6sEfjSrmWNFHoo7UGxrwCL3xqlJw48o9zJCmOKEHOahxsWzovQBVn/AjqUqffvl0b9Cw
 j9IgQHnUp39MmzFtS7XZJvG2V6GAhs454Eh1/yXog9u+BMEz6A46f/yXQOmRM1up/Nsz
 SPWw==
X-Gm-Message-State: APjAAAWogbDkJJSQVys5sROeeA7Trx1Rn3ofsfeAXKPCsxcSK6HAMiwF
 KPhEO25asE+0jm6aVC+9bQ0HdpHL
X-Google-Smtp-Source: APXvYqzCGtGqYfoPHmtcJYNvZ7E8CpUJ0DeRZhcvTLFIaBr/0ohOtOq+5hq2t3LhnlXlRbW+sT2hNA==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr893224wrw.246.1579827142619; 
 Thu, 23 Jan 2020 16:52:22 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 21/25] hw/avr: Add some Arduino boards
Date: Fri, 24 Jan 2020 01:51:27 +0100
Message-Id: <20200124005131.16276-22-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Arduino boards are build with AVR chipsets.
Add some of the popular boards:

- Arduino Duemilanove
- Arduino Uno
- Arduino Mega

For more information:
  https://www.arduino.cc/en/Main/Products
  https://store.arduino.cc/arduino-genuino/most-popular

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200120220107.17825-15-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
rc2:
- Use avr_load_firmware (Aleksandar)
- No default machine on AVR (Richard)
- Add entry in MAINTAINERS (Michael is still the maintainer of hw/avr/)
---
 hw/avr/arduino.c     | 151 +++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |   6 ++
 hw/avr/Kconfig       |   4 ++
 hw/avr/Makefile.objs |   1 +
 4 files changed, 162 insertions(+)
 create mode 100644 hw/avr/arduino.c

diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
new file mode 100644
index 0000000000..2fb2e96ffe
--- /dev/null
+++ b/hw/avr/arduino.c
@@ -0,0 +1,151 @@
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
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "atmel_atmega.h"
+#include "boot.h"
+
+typedef struct ArduinoMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
+    AtmegaMcuState mcu;
+} ArduinoMachineState;
+
+typedef struct ArduinoMachineClass {
+    /*< private >*/
+    MachineClass parent_class;
+    /*< public >*/
+    const char *mcu_type;
+    uint64_t xtal_hz;
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
+static void arduino_machine_init(MachineState *machine)
+{
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_GET_CLASS(machine);
+    ArduinoMachineState *ams = ARDUINO_MACHINE(machine);
+
+    sysbus_init_child_obj(OBJECT(machine), "mcu", &ams->mcu, sizeof(ams->mcu),
+                          amc->mcu_type);
+    object_property_set_uint(OBJECT(&ams->mcu), amc->xtal_hz,
+                             "xtal-frequency-hz", &error_abort);
+    object_property_set_bool(OBJECT(&ams->mcu), true, "realized",
+                             &error_abort);
+
+    if (machine->firmware) {
+        if (!avr_load_firmware(&ams->mcu.cpu, machine,
+                               &ams->mcu.flash, machine->firmware)) {
+            exit(1);
+        }
+    }
+}
+
+static void arduino_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = arduino_machine_init;
+    mc->default_cpus = 1;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->no_parallel = 1;
+}
+
+static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove */
+    mc->desc        = "Arduino Duemilanove (ATmega168)",
+    mc->alias       = "2009";
+    amc->mcu_type   = TYPE_ATMEGA168_MCU;
+    amc->xtal_hz    = 16 * 1000 * 1000;
+};
+
+static void arduino_uno_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://store.arduino.cc/arduino-uno-rev3 */
+    mc->desc        = "Arduino UNO (ATmega328P)";
+    mc->alias       = "uno";
+    amc->mcu_type   = TYPE_ATMEGA328_MCU;
+    amc->xtal_hz    = 16 * 1000 * 1000;
+};
+
+static void arduino_mega_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://www.arduino.cc/en/Main/ArduinoBoardMega */
+    mc->desc        = "Arduino Mega (ATmega1280)";
+    mc->alias       = "mega";
+    amc->mcu_type   = TYPE_ATMEGA1280_MCU;
+    amc->xtal_hz    = 16 * 1000 * 1000;
+};
+
+static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://store.arduino.cc/arduino-mega-2560-rev3 */
+    mc->desc        = "Arduino Mega 2560 (ATmega2560)";
+    mc->alias       = "mega2560";
+    amc->mcu_type   = TYPE_ATMEGA2560_MCU;
+    amc->xtal_hz    = 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
+};
+
+static const TypeInfo arduino_machine_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("arduino-duemilanove"),
+        .parent        = TYPE_ARDUINO_MACHINE,
+        .class_init    = arduino_duemilanove_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("arduino-uno"),
+        .parent        = TYPE_ARDUINO_MACHINE,
+        .class_init    = arduino_uno_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("arduino-mega"),
+        .parent        = TYPE_ARDUINO_MACHINE,
+        .class_init    = arduino_mega_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("arduino-mega-2560-v3"),
+        .parent        = TYPE_ARDUINO_MACHINE,
+        .class_init    = arduino_mega2560_class_init,
+    }, {
+        .name           = TYPE_ARDUINO_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(ArduinoMachineState),
+        .class_size     = sizeof(ArduinoMachineClass),
+        .class_init     = arduino_machine_class_init,
+        .abstract       = true,
+    }
+};
+
+DEFINE_TYPES(arduino_machine_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 066515ac8e..07c8912489 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -904,6 +904,12 @@ F: hw/misc/atmel_power.c
 F: include/hw/misc/atmel_power.h
 F: tests/acceptance/machine_avr6.py
 
+Arduino
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Maintained
+F: hw/avr/arduino.c
+F: hw/avr/atmel_atmega.*
+
 CRIS Machines
 -------------
 Axis Dev88
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index da3b10afec..59d9649d27 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -3,3 +3,7 @@ config ATMEL_ATMEGA_MCU
     select ATMEL_TIMER16
     select ATMEL_USART
     select ATMEL_POWER
+
+config ARDUINO
+    select ATMEL_ATMEGA_MCU
+    select UNIMP
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index 1f73fd5469..c8a131923c 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y += boot.o
 obj-$(CONFIG_ATMEL_ATMEGA_MCU) += atmel_atmega.o
+obj-$(CONFIG_ARDUINO) += arduino.o
-- 
2.21.1


