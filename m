Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC6AC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905EB217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S47jwcoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905EB217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfHf-00075l-5K
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6y-0001lG-7k
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6w-0005xO-GM
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6w-0005x6-8z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:30 -0500
Received: by mail-wm1-x344.google.com with SMTP id b19so895938wmj.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4xAHcnSxuBMk7zb5fgFWAPZm2H9yAhWCBtvCp/qIRcY=;
 b=S47jwcoUWIorP6ILhuEt7LudW1yULyFZ7fRgv1SFT8bNRWB8zoVeIG8xGYctgFmWkX
 RLNymW1VXqKhub7OYPqin/7PolxjmcZ9R5HDSX0ZLAHXZ06TFpQXBQyDdLyvpZLbg48v
 B9Qv0NCFZOf+6RSLLbm1SW89BpPr7LDp3NC75/wfdyNNhl1F1xEFnKFl52WVbSMHVEHs
 yBFt2/mLltzndMRfws44FbSsfXag8omdVxzOhXU456NxuoTtUyIuODiIwYycXGRudOWI
 cih4u2+PF4664JL1NFVuLSFq55zKWDeVzWxnd8HFMZd19B9k7ZACfOogXVTaqV/pfUjh
 UlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4xAHcnSxuBMk7zb5fgFWAPZm2H9yAhWCBtvCp/qIRcY=;
 b=FsquTvU7l/IwXw3VJGdIYgoL6qYnjfBdE9uRTHPnc1IOGRsr64ro4ZZF1doYbtFY/S
 0btQaUUKexfSEWm1r08zDdbCyefiXhr+LU3wHurVqDtS/Z2gj3SbfXSl2ph+4D+k862+
 HyQGP4VAErTpy0DLABa0g9TGOWj3noe39a2KsQadKoPukXiydywsOCDY4TpkjE43gvRY
 Emv3ZBfQH0gYxtVNHsq5t5F+BWkpwWoFuqRFgltoNrDYjg6cr9dBAnfIKdtN00bAeqmF
 Gt2wn66VTH7Ck4724Efbwsf3S1CiiXzvEtcNvQ5puy9jzyf6NpMO1ZFK5YJbjbm7paAQ
 w4aw==
X-Gm-Message-State: APjAAAW1AKGJZuesy0wg8lzfdRsb27V5yhqpo19ArVZGK5FLKus7Pi2k
 4AICE1HiJ5gce5VueL0PVKfHjSs/
X-Google-Smtp-Source: APXvYqySrLZeQkzK6QtD4HF5Vc9VtxnoX9qmqpwFo3FLU3C8Os1SIJ8JAiNrS1LgmZq/ozwLdzVO8A==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr873448wmg.20.1579557689079; 
 Mon, 20 Jan 2020 14:01:29 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/18] hw/avr: Add some Arduino boards
Date: Mon, 20 Jan 2020 23:01:03 +0100
Message-Id: <20200120220107.17825-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
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
---
v4:
- Remove unused 'extram*' fields (Igor)

v2:
- Reword description adding more information (Aleksandar)
- Use DEFINE_TYPES (Igor)
---
 default-configs/avr-softmmu.mak |   1 +
 hw/avr/arduino.c                | 175 ++++++++++++++++++++++++++++++++
 hw/avr/Kconfig                  |   4 +
 hw/avr/Makefile.objs            |   1 +
 4 files changed, 181 insertions(+)
 create mode 100644 hw/avr/arduino.c

diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
index d1e1c28118..d8d1d8e6fe 100644
--- a/default-configs/avr-softmmu.mak
+++ b/default-configs/avr-softmmu.mak
@@ -2,4 +2,5 @@
 
 # Boards:
 #
+CONFIG_ARDUINO=y
 CONFIG_AVR_SAMPLE=y
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
new file mode 100644
index 0000000000..784246baba
--- /dev/null
+++ b/hw/avr/arduino.c
@@ -0,0 +1,175 @@
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
+#include "atmel_atmega.h"
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
+                          amc->mcu_type);
+    object_property_set_uint(OBJECT(&ams->mcu), amc->xtal_hz,
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
+    mc->is_default  = true;
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
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index 228eae7582..7907584ac7 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -4,6 +4,10 @@ config ATMEL_ATMEGA_MCU
     select ATMEL_USART
     select ATMEL_POWER
 
+config ARDUINO
+    select ATMEL_ATMEGA_MCU
+    select UNIMP
+
 config AVR_SAMPLE
     select ATMEL_ATMEGA_MCU
     select UNIMP
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index 696f855c74..b36ca77cf0 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ATMEL_ATMEGA_MCU) += atmel_atmega.o
+obj-$(CONFIG_ARDUINO) += arduino.o
 obj-$(CONFIG_AVR_SAMPLE) += sample.o
-- 
2.21.1


