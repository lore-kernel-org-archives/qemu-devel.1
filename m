Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0246DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74E521D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74E521D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvLi-0006jM-2S
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv5H-0001HQ-Mg
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv5C-00084W-AM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:35 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv58-000813-Kd; Fri, 25 Oct 2019 04:36:26 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MkpOZ-1himgp23qR-00mKlv; Fri, 25 Oct 2019 10:35:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/19] hw: Move sun4v hypervisor RTC from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri, 25 Oct 2019 10:35:03 +0200
Message-Id: <20191025083511.11463-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2E4FC47zjnu/IU4BsZd1CtXVEkYxFmlQwgRMLW7X0/TXZCkS/Xj
 6tiznLRkZkCMiKNF0NRG7eCC6WPmsbqob4ja73U1Tr77nBgi9aXIExk1S41+uPGuIgsoAoq
 G+gIlzlih5iL8Ucr09o/jSBVZb3r6LVQ8jIT6GGAhKtFrSxRdx2rE7xY6HAPx+5CbMU8y4r
 eD+4vhf+KEeQPSHRs+gLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M8dzK/PK1So=:rhaMZtTst4WTyqnO14su7s
 LewxrVf1EtTGc6RpdGc5fhUkUZJqShgJmEqoW9yxIxlSJqnPcDr/wWUkl+4NY+iiVpAWR6geN
 qtJW+2DGv0qO2QYewCa8BNT4ub1CjN00KLO9+W2DxVkyOWxcSIINYIfIArvWNwONiNCVFEMKc
 wuLgPcY0iWk8WYTT0m03eN29K3g4GfWKyz5LbcqiTjNb1fnZjIq+j0JBcWd5Bg1Z4XrAqSHh1
 2EWNO5Z1FH7QhSdzmsvX+kphF0Fwoj4HYTyklbOue3wUyf9wZ0v2m8XJbJProXiwTM8kHT6pl
 5xcB0SV6wrq2ILlg8731AiaX0V00UJG0SQFtqoUgdlVglvL0xkG8pB+K70ReANQP98+3mQuu5
 DHdVN5W3AgGk5gMEn90dXqzxMZyNVKvXy6Ru3p1qkI6qsUOxqTFQY//nzkqCdoTlIrvTl72ai
 eJZeFcWqyVooTzJwJa7cxmuKLgoPLNWi+imJuu/F68iypXfZWgoE8NXzcMXGl9uAjB4ar+MPl
 XFvEyW7nt5j82tLtx82alHY3doJ9WRoKoOzKo9RmXwJOCwKGAAaRgzN+TuOZCyGi7rxkpbtZP
 V3fBOaX9/XWXqiL8hCkF2oQO9ZpX96KacAkUgBGageYQRbR2EuzjMqy0yVYp+RfiYIIKbT/qY
 UaZZDB9vtFHtguiuWsIWYmkbd3EtFy8WlvVmS9w9LD19la6YyqRxTDf8WU4H1uXKx/QvJKdVu
 TTHMeiGeSgF80PCBAHoZjyLgsGVzRZ4AkyDVqxnpFc0oORDZJSS7QOlBwj6rUcNDaT32mNKY6
 ObjrJEV8EGhNQtdeRXz2fnEiwGwoEe7ss4rlQao2WM6Y83hSRHZCfDTzCypgqMuh8/Q5HaA+i
 SHI8yMQup1MsYgctQh/YSyOz4oYXuC5kxI5DKpgd8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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

Move RTC devices under the hw/rtc/ subdirectory.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20191003230404.19384-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                   |  4 ++--
 hw/rtc/Kconfig                |  3 +++
 hw/rtc/Makefile.objs          |  1 +
 hw/{timer => rtc}/sun4v-rtc.c |  2 +-
 hw/rtc/trace-events           |  4 ++++
 hw/sparc64/niagara.c          |  2 +-
 hw/timer/Kconfig              |  3 ---
 hw/timer/Makefile.objs        |  1 -
 hw/timer/trace-events         |  4 ----
 include/hw/rtc/sun4v-rtc.h    | 19 +++++++++++++++++++
 include/hw/timer/sun4v-rtc.h  |  1 -
 11 files changed, 31 insertions(+), 13 deletions(-)
 rename hw/{timer => rtc}/sun4v-rtc.c (98%)
 create mode 100644 include/hw/rtc/sun4v-rtc.h
 delete mode 100644 include/hw/timer/sun4v-rtc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ba0d1906aae9..a7de5e2d1253 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1163,8 +1163,8 @@ Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
 F: hw/sparc64/niagara.c
-F: hw/timer/sun4v-rtc.c
-F: include/hw/timer/sun4v-rtc.h
+F: hw/rtc/sun4v-rtc.c
+F: include/hw/rtc/sun4v-rtc.h
 
 Leon3
 M: Fabien Chouteau <chouteau@adacore.com>
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 434b20b2b1bd..cc7fead764f4 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -10,3 +10,6 @@ config PL031
 
 config MC146818RTC
     bool
+
+config SUN4V_RTC
+    bool
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 89e8e48c6409..4621b37bc2f6 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -5,3 +5,4 @@ common-obj-$(CONFIG_M48T59) += m48t59-isa.o
 endif
 common-obj-$(CONFIG_PL031) += pl031.o
 obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
+common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
diff --git a/hw/timer/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
similarity index 98%
rename from hw/timer/sun4v-rtc.c
rename to hw/rtc/sun4v-rtc.c
index 54272a822fdf..ada01b57748b 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -13,7 +13,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "hw/timer/sun4v-rtc.h"
+#include "hw/rtc/sun4v-rtc.h"
 #include "trace.h"
 
 
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index 54c94ac557b2..ac9e0e0fba32 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# sun4v-rtc.c
+sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
+sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
+
 # pl031.c
 pl031_irq_state(int level) "irq state %d"
 pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 5987693659ed..5eb2d097b904 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -30,7 +30,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/loader.h"
 #include "hw/sparc/sparc64.h"
-#include "hw/timer/sun4v-rtc.h"
+#include "hw/rtc/sun4v-rtc.h"
 #include "exec/address-spaces.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index a6b668b2559b..b04c928136c2 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -35,9 +35,6 @@ config ALLWINNER_A10_PIT
 config STM32F2XX_TIMER
     bool
 
-config SUN4V_RTC
-    bool
-
 config CMSDK_APB_TIMER
     bool
     select PTIMER
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 2fb12162a623..034bd30255c0 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -35,7 +35,6 @@ common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
 
-common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
 common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
 common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
 common-obj-$(CONFIG_MSF2) += mss-timer.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 6936fe8573e9..ce34b967db9f 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -70,10 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 
-# sun4v-rtc.c
-sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
-sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
-
 # xlnx-zynqmp-rtc.c
 xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
 
diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
new file mode 100644
index 000000000000..fd868f6ed2fa
--- /dev/null
+++ b/include/hw/rtc/sun4v-rtc.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU sun4v Real Time Clock device
+ *
+ * The sun4v_rtc device (sun4v tod clock)
+ *
+ * Copyright (c) 2016 Artyom Tarasenko
+ *
+ * This code is licensed under the GNU GPL v3 or (at your option) any later
+ * version.
+ */
+
+#ifndef HW_RTC_SUN4V
+#define HW_RTC_SUN4V
+
+#include "exec/hwaddr.h"
+
+void sun4v_rtc_init(hwaddr addr);
+
+#endif
diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.h
deleted file mode 100644
index 407278f91831..000000000000
--- a/include/hw/timer/sun4v-rtc.h
+++ /dev/null
@@ -1 +0,0 @@
-void sun4v_rtc_init(hwaddr addr);
-- 
2.21.0


