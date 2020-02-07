Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C09C35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41ED222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41ED222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iztBr-00038Y-0R
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvo-0006OH-6J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvj-0001Lm-G4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:44 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53168 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvj-00019q-3S
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B29181A20ED;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 79A1C1A20E9;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 25/32] hw/avr: Add limited support for some Arduino boards
Date: Fri,  7 Feb 2020 02:57:53 +0100
Message-Id: <1581040680-308-26-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

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
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Joaquin de Andres <me@xcancerberox.com.ar>
---
 hw/avr/arduino.c     | 151 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS          |   6 ++
 hw/Kconfig           |   1 +
 hw/avr/Kconfig       |   4 ++
 hw/avr/Makefile.objs |   1 +
 5 files changed, 163 insertions(+)
 create mode 100644 hw/avr/arduino.c

diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
new file mode 100644
index 0000000..00d67c9
--- /dev/null
+++ b/hw/avr/arduino.c
@@ -0,0 +1,151 @@
+/*
+ * QEMU Arduino boards
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
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
+        OBJECT_CLASS_CHECK(ArduinoMachineClass, (klass), TYPE_ARDUINO_MA=
CHINE)
+#define ARDUINO_MACHINE_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(ArduinoMachineClass, (obj), TYPE_ARDUINO_MACHIN=
E)
+
+static void arduino_machine_init(MachineState *machine)
+{
+    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_GET_CLASS(machine);
+    ArduinoMachineState *ams =3D ARDUINO_MACHINE(machine);
+
+    sysbus_init_child_obj(OBJECT(machine), "mcu", &ams->mcu, sizeof(ams-=
>mcu),
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
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    mc->init =3D arduino_machine_init;
+    mc->default_cpus =3D 1;
+    mc->min_cpus =3D mc->default_cpus;
+    mc->max_cpus =3D mc->default_cpus;
+    mc->no_floppy =3D 1;
+    mc->no_cdrom =3D 1;
+    mc->no_parallel =3D 1;
+}
+
+static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove */
+    mc->desc        =3D "Arduino Duemilanove (ATmega168)",
+    mc->alias       =3D "2009";
+    amc->mcu_type   =3D TYPE_ATMEGA168_MCU;
+    amc->xtal_hz    =3D 16 * 1000 * 1000;
+};
+
+static void arduino_uno_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://store.arduino.cc/arduino-uno-rev3 */
+    mc->desc        =3D "Arduino UNO (ATmega328P)";
+    mc->alias       =3D "uno";
+    amc->mcu_type   =3D TYPE_ATMEGA328_MCU;
+    amc->xtal_hz    =3D 16 * 1000 * 1000;
+};
+
+static void arduino_mega_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://www.arduino.cc/en/Main/ArduinoBoardMega */
+    mc->desc        =3D "Arduino Mega (ATmega1280)";
+    mc->alias       =3D "mega";
+    amc->mcu_type   =3D TYPE_ATMEGA1280_MCU;
+    amc->xtal_hz    =3D 16 * 1000 * 1000;
+};
+
+static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
+
+    /* https://store.arduino.cc/arduino-mega-2560-rev3 */
+    mc->desc        =3D "Arduino Mega 2560 (ATmega2560)";
+    mc->alias       =3D "mega2560";
+    amc->mcu_type   =3D TYPE_ATMEGA2560_MCU;
+    amc->xtal_hz    =3D 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
+};
+
+static const TypeInfo arduino_machine_types[] =3D {
+    {
+        .name          =3D MACHINE_TYPE_NAME("arduino-duemilanove"),
+        .parent        =3D TYPE_ARDUINO_MACHINE,
+        .class_init    =3D arduino_duemilanove_class_init,
+    }, {
+        .name          =3D MACHINE_TYPE_NAME("arduino-uno"),
+        .parent        =3D TYPE_ARDUINO_MACHINE,
+        .class_init    =3D arduino_uno_class_init,
+    }, {
+        .name          =3D MACHINE_TYPE_NAME("arduino-mega"),
+        .parent        =3D TYPE_ARDUINO_MACHINE,
+        .class_init    =3D arduino_mega_class_init,
+    }, {
+        .name          =3D MACHINE_TYPE_NAME("arduino-mega-2560-v3"),
+        .parent        =3D TYPE_ARDUINO_MACHINE,
+        .class_init    =3D arduino_mega2560_class_init,
+    }, {
+        .name           =3D TYPE_ARDUINO_MACHINE,
+        .parent         =3D TYPE_MACHINE,
+        .instance_size  =3D sizeof(ArduinoMachineState),
+        .class_size     =3D sizeof(ArduinoMachineClass),
+        .class_init     =3D arduino_machine_class_init,
+        .abstract       =3D true,
+    }
+};
+
+DEFINE_TYPES(arduino_machine_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 5eedee9..fae2bb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -925,6 +925,12 @@ F: hw/timer/avr_timer16.c
 F: include/hw/misc/avr_power.h
 F: hw/misc/avr_power.c
=20
+Arduino
+M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: hw/avr/arduino.c
+
 CRIS Machines
 -------------
 Axis Dev88
diff --git a/hw/Kconfig b/hw/Kconfig
index ecf491b..f80dff3 100644
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
index 9e6527e..d31298c 100644
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
index af0fdde..4dca064 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y +=3D boot.o
 obj-$(CONFIG_AVR_ATMEGA_MCU) +=3D atmega.o
+obj-$(CONFIG_ARDUINO) +=3D arduino.o
--=20
2.7.4


