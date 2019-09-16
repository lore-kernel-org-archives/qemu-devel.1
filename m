Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2596C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BAA2184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BAA2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9two-0000BQ-Dg
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9tGV-0000Gy-Qn
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9tGT-0001qf-7C
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:50:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i9tGO-0001nB-A8; Mon, 16 Sep 2019 11:50:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CC80307CB3F;
 Mon, 16 Sep 2019 15:50:03 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-115.brq.redhat.com [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 266B519C4F;
 Mon, 16 Sep 2019 15:49:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 17:48:37 +0200
Message-Id: <20190916154847.28936-4-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-1-philmd@redhat.com>
References: <20190916154847.28936-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 16 Sep 2019 15:50:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 03/13] hw: Move MC146818 device from hw/timer/
 to hw/rtc/ subdirectory
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MC146818 is a Real Time Clock, not a timer.
Move it under the hw/rtc/ subdirectory.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                                  |  4 +--
 hw/alpha/dp264.c                             |  2 +-
 hw/hppa/machine.c                            |  2 +-
 hw/i386/acpi-build.c                         |  2 +-
 hw/i386/pc.c                                 |  2 +-
 hw/i386/pc_q35.c                             |  2 +-
 hw/mips/mips_fulong2e.c                      |  2 +-
 hw/mips/mips_jazz.c                          |  2 +-
 hw/mips/mips_malta.c                         |  2 +-
 hw/mips/mips_r4k.c                           |  2 +-
 hw/ppc/pnv.c                                 |  2 +-
 hw/ppc/prep.c                                |  2 +-
 hw/rtc/Kconfig                               |  3 ++
 hw/rtc/Makefile.objs                         |  1 +
 hw/{timer =3D> rtc}/mc146818rtc.c              |  2 +-
 hw/timer/Kconfig                             |  3 --
 hw/timer/Makefile.objs                       |  2 --
 hw/timer/hpet.c                              |  2 +-
 include/hw/rtc/mc146818rtc.h                 | 38 ++++++++++++++++++++
 include/hw/{timer =3D> rtc}/mc146818rtc_regs.h |  1 +
 include/hw/timer/mc146818rtc.h               | 14 --------
 tests/rtc-test.c                             |  2 +-
 22 files changed, 59 insertions(+), 35 deletions(-)
 rename hw/{timer =3D> rtc}/mc146818rtc.c (99%)
 create mode 100644 include/hw/rtc/mc146818rtc.h
 rename include/hw/{timer =3D> rtc}/mc146818rtc_regs.h (98%)
 delete mode 100644 include/hw/timer/mc146818rtc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5562d2c6d0..481f2318cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1263,7 +1263,7 @@ F: hw/misc/debugexit.c
 F: hw/misc/pc-testdev.c
 F: hw/timer/hpet*
 F: hw/timer/i8254*
-F: hw/timer/mc146818rtc*
+F: hw/rtc/mc146818rtc*
 F: hw/watchdog/wdt_ib700.c
 F: hw/watchdog/wdt_i6300esb.c
 F: include/hw/display/vga.h
@@ -1275,7 +1275,7 @@ F: include/hw/isa/i8259_internal.h
 F: include/hw/isa/superio.h
 F: include/hw/timer/hpet.h
 F: include/hw/timer/i8254*
-F: include/hw/timer/mc146818rtc*
+F: include/hw/rtc/mc146818rtc*
=20
 Machine core
 M: Eduardo Habkost <ehabkost@redhat.com>
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 51feee8558..51b3cf7a61 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -14,7 +14,7 @@
 #include "alpha_sys.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
 #include "hw/isa/superio.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2736ce835e..6598e2469d 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -12,7 +12,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e54e571a75..44a8073507 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -45,7 +45,7 @@
 #include "hw/acpi/vmgenid.h"
 #include "hw/boards.h"
 #include "sysemu/tpm_backend.h"
-#include "hw/timer/mc146818rtc_regs.h"
+#include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "sysemu/numa.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bad866fe44..beef7a992d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -42,7 +42,7 @@
 #include "elf.h"
 #include "migration/vmstate.h"
 #include "multiboot.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/dma/i8257.h"
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d4e8a1cb9f..a976af9a2a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -33,7 +33,7 @@
 #include "hw/loader.h"
 #include "sysemu/arch_init.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
 #include "kvm_i386.h"
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index cf537dd7e6..03a27e1767 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -39,7 +39,7 @@
 #include "hw/ide.h"
 #include "elf.h"
 #include "hw/isa/vt82c686.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index c967b97d80..2811a4bd90 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -39,7 +39,7 @@
 #include "hw/scsi/esp.h"
 #include "hw/mips/bios.h"
 #include "hw/loader.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
 #include "hw/display/vga.h"
 #include "hw/audio/pcspk.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 4d9c64b36a..c1c8810e71 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -45,7 +45,7 @@
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"             /* SysBusDevice */
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index bc0be26544..70024235ae 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -28,7 +28,7 @@
 #include "hw/ide.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/input/i8042.h"
 #include "hw/timer/i8254.h"
 #include "exec/address-spaces.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3f08db7b9e..4b2649d95b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -48,7 +48,7 @@
 #include "hw/isa/isa.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
=20
 #include <libfdt.h>
=20
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 4f3c6bf190..3a51536e1a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -40,7 +40,7 @@
 #include "hw/ide.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
 #include "hw/net/ne2000-isa.h"
 #include "sysemu/arch_init.h"
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 8a4383bca9..7ffd702268 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -1,2 +1,5 @@
 config PL031
     bool
+
+config MC146818RTC
+    bool
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 3e1eb42563..3cac0d5a63 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -1 +1,2 @@
 common-obj-$(CONFIG_PL031) +=3D pl031.o
+obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
diff --git a/hw/timer/mc146818rtc.c b/hw/rtc/mc146818rtc.c
similarity index 99%
rename from hw/timer/mc146818rtc.c
rename to hw/rtc/mc146818rtc.c
index 6cb378751b..ced15f764f 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -34,7 +34,7 @@
 #include "sysemu/replay.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 27c5dce09e..af415c8ef8 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -35,9 +35,6 @@ config ALTERA_TIMER
     bool
     select PTIMER
=20
-config MC146818RTC
-    bool
-
 config ALLWINNER_A10_PIT
     bool
     select PTIMER
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 9f64f6e11e..b0159189cf 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -35,8 +35,6 @@ common-obj-$(CONFIG_SH4) +=3D sh_timer.o
 common-obj-$(CONFIG_DIGIC) +=3D digic-timer.o
 common-obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
=20
-obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
-
 common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
=20
 common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1ddae4e7d7..02bf8a8ce8 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -33,7 +33,7 @@
 #include "qemu/timer.h"
 #include "hw/timer/hpet.h"
 #include "hw/sysbus.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "migration/vmstate.h"
 #include "hw/timer/i8254.h"
=20
diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
new file mode 100644
index 0000000000..888e04f9ab
--- /dev/null
+++ b/include/hw/rtc/mc146818rtc.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU MC146818 RTC emulation
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#ifndef MC146818RTC_H
+#define MC146818RTC_H
+
+#include "hw/isa/isa.h"
+#include "hw/rtc/mc146818rtc_regs.h"
+
+#define TYPE_MC146818_RTC "mc146818rtc"
+
+ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
+                             qemu_irq intercept_irq);
+void rtc_set_memory(ISADevice *dev, int addr, int val);
+int rtc_get_memory(ISADevice *dev, int addr);
+
+#endif /* MC146818RTC_H */
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/rtc/mc14681=
8rtc_regs.h
similarity index 98%
rename from include/hw/timer/mc146818rtc_regs.h
rename to include/hw/rtc/mc146818rtc_regs.h
index bfbb57e570..c4c6305473 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/rtc/mc146818rtc_regs.h
@@ -26,6 +26,7 @@
 #define MC146818RTC_REGS_H
=20
 #include "qemu/timer.h"
+#include "qemu/host-utils.h"
=20
 #define RTC_ISA_IRQ 8
=20
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rt=
c.h
deleted file mode 100644
index fe6ed63f71..0000000000
--- a/include/hw/timer/mc146818rtc.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef MC146818RTC_H
-#define MC146818RTC_H
-
-#include "hw/isa/isa.h"
-#include "hw/timer/mc146818rtc_regs.h"
-
-#define TYPE_MC146818_RTC "mc146818rtc"
-
-ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
-                             qemu_irq intercept_irq);
-void rtc_set_memory(ISADevice *dev, int addr, int val);
-int rtc_get_memory(ISADevice *dev, int addr);
-
-#endif /* MC146818RTC_H */
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index 6309b0ef6c..79a4ff1ed6 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -15,7 +15,7 @@
=20
 #include "libqtest-single.h"
 #include "qemu/timer.h"
-#include "hw/timer/mc146818rtc_regs.h"
+#include "hw/rtc/mc146818rtc_regs.h"
=20
 #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
=20
--=20
2.20.1


