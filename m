Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D3FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15CA2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15CA2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvD5-0005Em-N3
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv59-00012C-UA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv58-00081O-47
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv4x-0007qC-MG; Fri, 25 Oct 2019 04:36:15 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNKyQ-1icpHo3yV0-00Onq2; Fri, 25 Oct 2019 10:35:35 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] hw: Move PL031 device from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri, 25 Oct 2019 10:34:59 +0200
Message-Id: <20191025083511.11463-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1Yj9pNygKerZ5iUZcCSAJRHrTy0Uv2L1BFRvnfzRNKo4FevvEjc
 kFxWxa+3puenFGupfG/VWdTOiOtYcNGRRBJvTQzpOYPuUEEDd0WL75K031oyNOC+8yZQ77u
 5MSL3evxPNj34gsi0bFXZykBDdlnsEKl4EBS87kJ6kOX6S3b7IzHLrUFwmQjY+X0pulKDbW
 isnQLafa7Dgpq4y8LVqfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ctNIOKHoaj8=:1HmFOGi2RYebz0cuHxwh72
 +3LSN65CFKOW76aX63T0JkF9xEeeDl3sr7jFr6NijIyC10SmvKbTb7NuwQMp27B+D0KyMQ/3z
 s08GEU06AgaFXkS2RLBnHwMKi2rXgnni+1/yZRnhQYU/CTGQsoN3yx8QEQWS0FimxYdwUWjkz
 3VD1+NUq2QQ0WC1hq39ulfpmw7mT/9HeByTviAHkhxTBhwx8P8XkAB2D/XeXtRw3Aqye5CINt
 syh6vim+WTdSN42ot94RdXVCaIqo40w8g4MsKGoY8Ky7hMIh6uz3LpM6VCBtIEe6mV7Sk3hwi
 gYCa4tM6f5et+owITxVTF+WbZ7BB+gahlfTTPda4/e2VmPvy5+Q7sOvJcNGB51Bv/M1+2yIZD
 waLveaW9QBksDOuyqxTGa+qDc/Tjgaf24NY9jLfdGvCwXvah6oKMsYzJm0REFA9X+lYx6BEqn
 RPLmGKPbUlUH+tMdGe7iiCU/J0xoqhqdFjU9Np92y2QjMfR5BLM1Sl7MiOD7C3CMM5/c/96Rr
 RaWhXAUQ94z6e1hmwl7WCQ9BFZLdtM39Zwc8igJDbxRnhfRgNpALwPthLoiCmigFEhOmw8c1o
 uSWLo9YrHXeirEHRl1Afoy5tOp1F+b/usnyXREnKi8zhP29CkvcWZ4GvjdfaZmxBW1HaKVcn/
 6W5Fcx6rfZivYSf20R5w5hhCISSYHQQnP/ff2WVKSJeJkTcnhwGaZHBq4ncuYSYysuNfPSQ2o
 QZONpgT4V3KlU6xMn2sVdBYsQWAmzYwnNVBMnQrQE2aDzDB0wKoiP44I3l0ulOrzUfqesMIgr
 lF0CD659Yu6kgOq/LKAFBE+iTvEw8o5Vn+rNNo95zLWXzcR/R2htPDVorJk6rRPW62JNzWL1o
 9hnJn1JqEJm185uEH1kdZRg4fTQUiXJOsmmVG6epw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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

The PL031 is a Real Time Clock, not a timer.
Move it under the hw/rtc/ subdirectory.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20191003230404.19384-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                       | 4 ++--
 Makefile.objs                     | 1 +
 hw/Kconfig                        | 1 +
 hw/Makefile.objs                  | 1 +
 hw/arm/musca.c                    | 2 +-
 hw/rtc/Kconfig                    | 2 ++
 hw/rtc/Makefile.objs              | 1 +
 hw/{timer => rtc}/pl031.c         | 2 +-
 hw/rtc/trace-events               | 8 ++++++++
 hw/timer/Kconfig                  | 3 ---
 hw/timer/Makefile.objs            | 1 -
 hw/timer/trace-events             | 7 -------
 include/hw/{timer => rtc}/pl031.h | 5 +++--
 13 files changed, 21 insertions(+), 17 deletions(-)
 create mode 100644 hw/rtc/Kconfig
 create mode 100644 hw/rtc/Makefile.objs
 rename hw/{timer => rtc}/pl031.c (99%)
 create mode 100644 hw/rtc/trace-events
 rename include/hw/{timer => rtc}/pl031.h (93%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed41d7d1b6cc..2e13ba46282d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -495,8 +495,8 @@ F: hw/intc/pl190.c
 F: hw/sd/pl181.c
 F: hw/ssi/pl022.c
 F: include/hw/ssi/pl022.h
-F: hw/timer/pl031.c
-F: include/hw/timer/pl031.h
+F: hw/rtc/pl031.c
+F: include/hw/rtc/pl031.h
 F: include/hw/arm/primecell.h
 F: hw/timer/cmsdk-apb-timer.c
 F: include/hw/timer/cmsdk-apb-timer.h
diff --git a/Makefile.objs b/Makefile.objs
index abcbd89654ac..11ba1a36bd39 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -173,6 +173,7 @@ trace-events-subdirs += hw/pci-host
 trace-events-subdirs += hw/ppc
 trace-events-subdirs += hw/rdma
 trace-events-subdirs += hw/rdma/vmw
+trace-events-subdirs += hw/rtc
 trace-events-subdirs += hw/s390x
 trace-events-subdirs += hw/scsi
 trace-events-subdirs += hw/sd
diff --git a/hw/Kconfig b/hw/Kconfig
index b45db3c813ff..4b53fee4d0ce 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -27,6 +27,7 @@ source pci-host/Kconfig
 source pcmcia/Kconfig
 source pci/Kconfig
 source rdma/Kconfig
+source rtc/Kconfig
 source scsi/Kconfig
 source sd/Kconfig
 source semihosting/Kconfig
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ece6cc37550f..fd9750e5f273 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -26,6 +26,7 @@ devices-dirs-y += nvram/
 devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
+devices-dirs-y += rtc/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
 devices-dirs-y += ssi/
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 68db4b5b3878..ba99dd19413d 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -32,7 +32,7 @@
 #include "hw/misc/tz-mpc.h"
 #include "hw/misc/tz-ppc.h"
 #include "hw/misc/unimp.h"
-#include "hw/timer/pl031.h"
+#include "hw/rtc/pl031.h"
 
 #define MUSCA_NUMIRQ_MAX 96
 #define MUSCA_PPC_MAX 3
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
new file mode 100644
index 000000000000..8a4383bca9b2
--- /dev/null
+++ b/hw/rtc/Kconfig
@@ -0,0 +1,2 @@
+config PL031
+    bool
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
new file mode 100644
index 000000000000..3e1eb4256388
--- /dev/null
+++ b/hw/rtc/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_PL031) += pl031.o
diff --git a/hw/timer/pl031.c b/hw/rtc/pl031.c
similarity index 99%
rename from hw/timer/pl031.c
rename to hw/rtc/pl031.c
index 2b3e26100699..3a982752a2ad 100644
--- a/hw/timer/pl031.c
+++ b/hw/rtc/pl031.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/timer/pl031.h"
+#include "hw/rtc/pl031.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
new file mode 100644
index 000000000000..54c94ac557b2
--- /dev/null
+++ b/hw/rtc/trace-events
@@ -0,0 +1,8 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# pl031.c
+pl031_irq_state(int level) "irq state %d"
+pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl031_alarm_raised(void) "alarm raised"
+pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index eefc95f35ecc..27c5dce09e43 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -27,9 +27,6 @@ config M41T80
 config M48T59
     bool
 
-config PL031
-    bool
-
 config TWL92230
     bool
     depends on I2C
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index f407523aa49d..9f64f6e11e78 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -11,7 +11,6 @@ common-obj-$(CONFIG_M48T59) += m48t59.o
 ifeq ($(CONFIG_ISA_BUS),y)
 common-obj-$(CONFIG_M48T59) += m48t59-isa.o
 endif
-common-obj-$(CONFIG_PL031) += pl031.o
 common-obj-$(CONFIG_PUV3) += puv3_ost.o
 common-obj-$(CONFIG_TWL92230) += twl92230.o
 common-obj-$(CONFIG_XILINX) += xilinx_timer.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index db02a9142cda..6936fe8573e9 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -80,10 +80,3 @@ xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec
 # nrf51_timer.c
 nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-
-# pl031.c
-pl031_irq_state(int level) "irq state %d"
-pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-pl031_alarm_raised(void) "alarm raised"
-pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
diff --git a/include/hw/timer/pl031.h b/include/hw/rtc/pl031.h
similarity index 93%
rename from include/hw/timer/pl031.h
rename to include/hw/rtc/pl031.h
index 8c3f555ee288..e3cb1d646fc4 100644
--- a/include/hw/timer/pl031.h
+++ b/include/hw/rtc/pl031.h
@@ -11,10 +11,11 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 
-#ifndef HW_TIMER_PL031_H
-#define HW_TIMER_PL031_H
+#ifndef HW_RTC_PL031_H
+#define HW_RTC_PL031_H
 
 #include "hw/sysbus.h"
+#include "qemu/timer.h"
 
 #define TYPE_PL031 "pl031"
 #define PL031(obj) OBJECT_CHECK(PL031State, (obj), TYPE_PL031)
-- 
2.21.0


