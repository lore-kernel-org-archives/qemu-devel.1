Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F1121929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F1121929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvVz-0000Uz-KA
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 05:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv5U-0001ag-8L
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv5R-0008EX-Sb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv5B-00083D-1p; Fri, 25 Oct 2019 04:36:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mz9pT-1i1YWg0l8d-00wDiB; Fri, 25 Oct 2019 10:35:37 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] hw: Move MC146818 device from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri, 25 Oct 2019 10:35:00 +0200
Message-Id: <20191025083511.11463-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nPAhZeV0h5yJNwT9z6ozlTm9Z6iSMJi1iiykf/RjJ7QBLmaw4rS
 P4XlS+FpzGBtqpXM+yEhUQenTgxJNxXUKs1MHaaPH2y7NWROCoyZoeYJxYuXNKcD6FVBIco
 x/tApDF4V/q/PwFZ6P+LqIUOW/oY1eQW1am8cXFNMSQqaf1YbvMfzCt1nrFZxa0COxMcamE
 20a4EThCvpoLKtm2fzTrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p7xX4NIZxz0=:vFSJuCToVho3lOZgNwBXQp
 67MFT99bEY09T6YycObB5F27m4YvyLcgItwHc9GByvwXxbpR7tza65vQChg8vaP++qXPZU5wj
 vig2BUX38jcBp/jPv7pWba0rU8yzh01yW2PGv3vXMVLnb1f9tD5ia0KUXWzwKewtLdVAcs0aa
 YybRDxpAOxYQs/hRrPpQBzmGL4ODALo+joqjz2krPVy2B1OFpLGJ5HIEksLwXPDzjlB1XwcbM
 AIin0a6RmByRGxuAa8zY5WxFvWAHTapc6J5kddRMZqmjYHIyR59ohzfCZUdj2oWIOwx32vDf5
 bX1VmQlzN27Roy3BlOHq34vHcURxnN/MuTwNhRUmPTpuFaFmLCsF/8W5SHEXdp/mho5+7SSLx
 dimXkJTq+2maBMMWGYtsK21+EdE/KVTtOHSxisfPMFx+ritBt2idp8ETJkna0FPaXVi7wa+NS
 i/Ucbhz5XKBdyaICqLsWgcAoIbdI6GvgbS82IRy1cvUvrpkUIY4RRKyI1hWozqwilF4LC2A04
 AyMePdURVX01QdTfp0PQjiuI8BCySmty+Z5NeGnAdhco84mXPht+YAeYLZUTwhfpilDn6IkPV
 xkzWhFZtwKpJLAsIVnHa1LY/TL8lq7/S7GCOpB+OpY3Kf5aP+pezGWICj0NFsTNfZ+jZ7ndJN
 IGE7+87XYH5vCquw8GBhBYicv9UWIp4U9NPjzMAsoJYkTJ/HR/Hr6pvV5A7r37mMaL89llQ3A
 5SMDd9D8XL/JZS1F02lJzT25MqTqJ7La0pcc3MdBGzy0BkZZfZxkerJGs1irfqxmLOquzRI8t
 uWthFtaiRRiojlQNYXBrqUmeftB2WWywXottMJ5FIFOZ0X7r1WrPguAFVW9F/hlOsI9a31uuJ
 4sucsJAYuDG6aGlSdeqDHGokRox24D8Y5hAc/bo1s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>,
 Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The MC146818 is a Real Time Clock, not a timer.
Move it under the hw/rtc/ subdirectory.

Use copyright statement from 80cabfad163 for "hw/rtc/mc146818rtc.h".

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191003230404.19384-4-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                                  |  4 ++--
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
 hw/rtc/Kconfig                               |  3 +++
 hw/rtc/Makefile.objs                         |  1 +
 hw/{timer => rtc}/mc146818rtc.c              |  2 +-
 hw/timer/Kconfig                             |  3 ---
 hw/timer/Makefile.objs                       |  2 --
 hw/timer/hpet.c                              |  2 +-
 include/hw/{timer => rtc}/mc146818rtc.h      | 14 +++++++++++---
 include/hw/{timer => rtc}/mc146818rtc_regs.h |  5 +++--
 tests/rtc-test.c                             |  2 +-
 21 files changed, 34 insertions(+), 26 deletions(-)
 rename hw/{timer => rtc}/mc146818rtc.c (99%)
 rename include/hw/{timer => rtc}/mc146818rtc.h (58%)
 rename include/hw/{timer => rtc}/mc146818rtc_regs.h (96%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e13ba46282d..7eba146444ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1261,7 +1261,7 @@ F: hw/misc/debugexit.c
 F: hw/misc/pc-testdev.c
 F: hw/timer/hpet*
 F: hw/timer/i8254*
-F: hw/timer/mc146818rtc*
+F: hw/rtc/mc146818rtc*
 F: hw/watchdog/wdt_ib700.c
 F: hw/watchdog/wdt_i6300esb.c
 F: include/hw/display/vga.h
@@ -1273,7 +1273,7 @@ F: include/hw/isa/i8259_internal.h
 F: include/hw/isa/superio.h
 F: include/hw/timer/hpet.h
 F: include/hw/timer/i8254*
-F: include/hw/timer/mc146818rtc*
+F: include/hw/rtc/mc146818rtc*
 
 Machine core
 M: Eduardo Habkost <ehabkost@redhat.com>
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 51feee855812..51b3cf7a6128 100644
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
index 953d454f4879..b30aba6d5439 100644
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
index 1d077a7cb772..d9435ba0b310 100644
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
index 4b1904237ec6..51b72439b440 100644
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
index 8fad20f3146a..748fc2ee15bf 100644
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
index cf537dd7e631..03a27e176796 100644
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
index 8d010a0b6e10..d978bb64a0f5 100644
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
index 4d9c64b36ab2..c1c8810e7198 100644
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
index bc0be2654415..70024235ae52 100644
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
index 4a51fb65a834..60632720ef6f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -48,7 +48,7 @@
 #include "hw/isa/isa.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
-#include "hw/timer/mc146818rtc.h"
+#include "hw/rtc/mc146818rtc.h"
 
 #include <libfdt.h>
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 4f3c6bf19018..3a51536e1a39 100644
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
index 8a4383bca9b2..7ffd702268ad 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -1,2 +1,5 @@
 config PL031
     bool
+
+config MC146818RTC
+    bool
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 3e1eb4256388..3cac0d5a637b 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -1 +1,2 @@
 common-obj-$(CONFIG_PL031) += pl031.o
+obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
diff --git a/hw/timer/mc146818rtc.c b/hw/rtc/mc146818rtc.c
similarity index 99%
rename from hw/timer/mc146818rtc.c
rename to hw/rtc/mc146818rtc.c
index 6cb378751b1f..ced15f764fc1 100644
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
index 27c5dce09e43..af415c8ef831 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -35,9 +35,6 @@ config ALTERA_TIMER
     bool
     select PTIMER
 
-config MC146818RTC
-    bool
-
 config ALLWINNER_A10_PIT
     bool
     select PTIMER
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 9f64f6e11e78..b0159189cf34 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -35,8 +35,6 @@ common-obj-$(CONFIG_SH4) += sh_timer.o
 common-obj-$(CONFIG_DIGIC) += digic-timer.o
 common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
 
-obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
-
 common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1ddae4e7d7dc..02bf8a8ce8fc 100644
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
 
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
similarity index 58%
rename from include/hw/timer/mc146818rtc.h
rename to include/hw/rtc/mc146818rtc.h
index fe6ed63f7179..2e9331637a6d 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -1,8 +1,16 @@
-#ifndef MC146818RTC_H
-#define MC146818RTC_H
+/*
+ * QEMU MC146818 RTC emulation
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_RTC_MC146818RTC_H
+#define HW_RTC_MC146818RTC_H
 
 #include "hw/isa/isa.h"
-#include "hw/timer/mc146818rtc_regs.h"
+#include "hw/rtc/mc146818rtc_regs.h"
 
 #define TYPE_MC146818_RTC "mc146818rtc"
 
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/rtc/mc146818rtc_regs.h
similarity index 96%
rename from include/hw/timer/mc146818rtc_regs.h
rename to include/hw/rtc/mc146818rtc_regs.h
index bfbb57e57012..dd6c09e2fcf9 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/rtc/mc146818rtc_regs.h
@@ -22,10 +22,11 @@
  * THE SOFTWARE.
  */
 
-#ifndef MC146818RTC_REGS_H
-#define MC146818RTC_REGS_H
+#ifndef HW_RTC_MC146818RTC_REGS_H
+#define HW_RTC_MC146818RTC_REGS_H
 
 #include "qemu/timer.h"
+#include "qemu/host-utils.h"
 
 #define RTC_ISA_IRQ 8
 
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index 6309b0ef6cc2..79a4ff1ed611 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -15,7 +15,7 @@
 
 #include "libqtest-single.h"
 #include "qemu/timer.h"
-#include "hw/timer/mc146818rtc_regs.h"
+#include "hw/rtc/mc146818rtc_regs.h"
 
 #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
 
-- 
2.21.0


