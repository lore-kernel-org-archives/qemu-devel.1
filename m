Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5B7206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StUHDNaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5B7206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssMr-000301-NJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAI-0000E8-Gd
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:58 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAG-0002xE-Cw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id o11so46280665wrv.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gj3/OQNSfP7RfDddlBh6T9Majt1IKib5G1iswXgeCvw=;
 b=StUHDNaFfB8+lrvurQKhnzD+tuDpk6Tjkt5nPM4R/as+WunXFl8RIz3oSnTIgAOvma
 EBy+x4lmf/sJ8bVFvlpv1Z/FmhQRavGJOK0IMjjaGdVJBEOjzeNu3z+KrqKb/wdyvVtI
 mYrjc23Z8MTX5F7yhnN5dyc6pyoGmXucE57pJwpRjPCfcyl1xQ1jIUmBcQV+FOkz/iYW
 w2Sh6PTaGzRes0hFRVUMUSNzxH8IZWkLymeEPODCvEBHCdWEsAmyQ7J89eZAdVtVGnwx
 h1amtGZI+R8XdifyyKxHhwKlW2ri2tmSxOfc4N3xPHdihxocXB0CR7yesN7ijILgZ8sO
 xRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Gj3/OQNSfP7RfDddlBh6T9Majt1IKib5G1iswXgeCvw=;
 b=gkAS7jC4Zi9q3IHMgmVPRh0SDPdjRxpNLcpuWr3WoyF0KMvur/BBSq39UqFHSt2Sz4
 g49XPVtiiO6NbDCrSPdFEvDAE6EQfuR+PueojJxPGKv4Ij02c2Nd2qRZ5GDAR1SwpZdF
 I3SWrYvoRPzUvRYeK2ZMQCzdRRKYGcU9B2ZblqgY5yhY1ECWMs9MsGa3OcdQX7lwH0OU
 PnMBJ85O417PwJ+kRdpeJneBu9msCuTWR91Ii7joFHNpbbQzkAJ7GAdLnCIc6gas2IUU
 0u3S+Oky+qIYiZ3eeH8tFcjcMWWhrCtnPhlCYRkEeQKFkLbKlalQil/gz6am5O9Knx+h
 tHGA==
X-Gm-Message-State: AOAM532SkkmNn3TFVcxLlg0j82kw4eRBT5yE7MjeQVSGGe51lMaQfLqA
 l28u8Q+4JG6bmwFMeVNhKgocbu8B
X-Google-Smtp-Source: ABdhPJzBBHN50wV9CnGECgB81XJ45qPVHKC2vYTEhj6SPX7nKvHcqT0svxkr2v0CmzMfbwPA6lf2Ng==
X-Received: by 2002:adf:f546:: with SMTP id j6mr54390906wrp.167.1594145874638; 
 Tue, 07 Jul 2020 11:17:54 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] hw/avr: Add limited support for some Arduino boards
Date: Tue,  7 Jul 2020 20:17:04 +0200
Message-Id: <20200707181710.30950-27-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Arduino boards are build with AVR chipsets. Add some of these
boards:

  - Arduino Duemilanove
  - Arduino Uno
  - Arduino Mega

For more information:
  https://www.arduino.cc/en/Main/Products
  https://store.arduino.cc/arduino-genuino/most-popular

[AM: Remove word 'Atmel' from filenames and all elements of code]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Joaquin de Andres <me@xcancerberox.com.ar>
[thuth: sysbus_init_child_obj() ==> object_initialize_child()]
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-26-huth@tuxfamily.org>
---
 default-configs/avr-softmmu.mak |   4 +
 hw/avr/arduino.c                | 149 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |   6 ++
 hw/Kconfig                      |   1 +
 hw/avr/Kconfig                  |   4 +
 hw/avr/Makefile.objs            |   1 +
 6 files changed, 165 insertions(+)
 create mode 100644 hw/avr/arduino.c

diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
index ca94aad4e1..80218add98 100644
--- a/default-configs/avr-softmmu.mak
+++ b/default-configs/avr-softmmu.mak
@@ -1 +1,5 @@
 # Default configuration for avr-softmmu
+
+# Boards:
+#
+CONFIG_ARDUINO=y
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
new file mode 100644
index 0000000000..aeaf2afb82
--- /dev/null
+++ b/hw/avr/arduino.c
@@ -0,0 +1,149 @@
+/*
+ * QEMU Arduino boards
+ *
+ * Copyright (c) 2019-2020 Philippe Mathieu-Daudé
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
+#include "atmega.h"
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
+    object_initialize_child(OBJECT(machine), "mcu", &ams->mcu, amc->mcu_type);
+    object_property_set_uint(OBJECT(&ams->mcu), amc->xtal_hz,
+                             "xtal-frequency-hz", &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&ams->mcu), &error_abort);
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
index a78d4e56ff..eba91ae406 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -991,6 +991,12 @@ F: hw/timer/avr_timer16.c
 F: include/hw/misc/avr_power.h
 F: hw/misc/avr_power.c
 
+Arduino
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: hw/avr/arduino.c
+
 CRIS Machines
 -------------
 Axis Dev88
diff --git a/hw/Kconfig b/hw/Kconfig
index 62f9ebdc22..4de1797ffd 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -43,6 +43,7 @@ source watchdog/Kconfig
 # arch Kconfig
 source arm/Kconfig
 source alpha/Kconfig
+source avr/Kconfig
 source cris/Kconfig
 source hppa/Kconfig
 source i386/Kconfig
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index 9e6527e1f3..d31298c3cc 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -3,3 +3,7 @@ config AVR_ATMEGA_MCU
     select AVR_TIMER16
     select AVR_USART
     select AVR_POWER
+
+config ARDUINO
+    select AVR_ATMEGA_MCU
+    select UNIMP
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index af0fddeb13..4dca064bfc 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y += boot.o
 obj-$(CONFIG_AVR_ATMEGA_MCU) += atmega.o
+obj-$(CONFIG_ARDUINO) += arduino.o
-- 
2.21.3


