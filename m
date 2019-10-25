Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C5821D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C5821D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvSr-0007hl-0u
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 05:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv5V-0001dU-HG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv5T-0008H7-To
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60005)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv5N-0008BJ-5y; Fri, 25 Oct 2019 04:36:41 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEVFi-1iCKDd2bFK-00G2Qg; Fri, 25 Oct 2019 10:35:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] hw: Move Xilinx ZynqMP RTC from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri, 25 Oct 2019 10:35:06 +0200
Message-Id: <20191025083511.11463-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:etCUXD52RarWTMMWx6gvRrbz0qPxz/OK/mTowevKvf7KrVhR6fH
 R3gTkOx1/tY26LybSCfVMzae+/OMpo3pvEZGy5J2LcHeyR1ts4U+5ylkMWaJvW9ju5u1a6e
 k2JzO95VmMtpiwOZ2Jadc6g/m/IgHG8pvzsgHzPJ8ydm29LrE2hcocBnHeBtfhYlj1GQlBJ
 2lX6oQkmb7pZgW2aV0x5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KKa+C83ziFE=:bnyn3MqhkPUrazDEuUJSXF
 TI/+EBeASIWyWUG3ZUYihiD0zfIxfIx1gnv4+GMbWxfP4wrwGGZSFlCT4li+vKr64xBaWD9Ae
 r2HbVpnehIaveXClzVqXAVNcFYBp0T/JUZ3jfRIZCXWl3F26jbHKdvXsQSdirY02cmhd0ByNS
 UIQWEL2GPdKODaH+meRclnpJHAEjI89a/GUhCirneMqtnGlj+c+9L7WHvMla3hc6Z7DMbQvwc
 E154eu4Io0haAj/jAzBwlCAppD9lPxBg1N6tnJBMI81IYim+QDRBFQ8HgqhG3+1o1mZzJrdN0
 1rCgfF0kzTaACDSDelPlO7iNznTRvCJ93Msz4h1C3RjgdV0JRao7MGnMNOiQKaDgMQfSIXT6u
 fTgDoAYtV7fsnWkeygz24g3WyxHSwDnmWsQVJVqqW4Yy/OCv2JGruDj1tg9aLtyAHU3ijm2l/
 n/c8AM9yCuewCUR68Hk064qQ7vsy28aFFDyrmiHYIfItf8wtbmgRkAHJs/JwtkLJUjYFpGvPH
 KXxUChJt4N44d/MNgXqgTp62j81Qa4PzZFBtmoYpvJdB7SdyvxrqK86LPBKDIEFFLttsqqR+a
 OikkJSD6sV4QkU6a1LSraCpKJpiQGwL54SWY80zZsixg8bhBcqVF4wDPQ3WPYMNG580imIpow
 mBF4pYA8OrYupnbZiHwChtR4G85lDxIxJyZURcFEmIbVR5TCTza2AgfM6ncTluEZ0Ftncal4j
 I6SqxMGOjsjao9yFOud8N62NGWMmJe5bFM2Bj1g7dEVpKdTaa/pVwPHimbmT4dzB7atfezciY
 astSBhwQ3zEZ+eAhI7CoWSahp963/BTPvb/dgFuLXeCgMnJfys91oFivVVPomWWp8qG819Aby
 mp/opAat3zopAFVhKoBmCjKOCGo+OX95uepMIeVE0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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

Remove Alistair outdated email address (see commit c22e580c2ad).

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20191003230404.19384-10-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/rtc/Makefile.objs                        | 1 +
 hw/rtc/trace-events                         | 3 +++
 hw/{timer => rtc}/xlnx-zynqmp-rtc.c         | 2 +-
 hw/timer/Makefile.objs                      | 1 -
 hw/timer/trace-events                       | 3 ---
 include/hw/arm/xlnx-zynqmp.h                | 2 +-
 include/hw/{timer => rtc}/xlnx-zynqmp-rtc.h | 6 +++---
 7 files changed, 9 insertions(+), 9 deletions(-)
 rename hw/{timer => rtc}/xlnx-zynqmp-rtc.c (99%)
 rename include/hw/{timer => rtc}/xlnx-zynqmp-rtc.h (95%)

diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index b195863291d1..543a550a0f11 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -6,5 +6,6 @@ common-obj-$(CONFIG_M48T59) += m48t59-isa.o
 endif
 common-obj-$(CONFIG_PL031) += pl031.o
 common-obj-$(CONFIG_TWL92230) += twl92230.o
+common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
 obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index ac9e0e0fba32..7f1945ad4cc6 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -4,6 +4,9 @@
 sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
 sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
 
+# xlnx-zynqmp-rtc.c
+xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
+
 # pl031.c
 pl031_irq_state(int level) "irq state %d"
 pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
similarity index 99%
rename from hw/timer/xlnx-zynqmp-rtc.c
rename to hw/rtc/xlnx-zynqmp-rtc.c
index 5692db98c2db..f9f09b72965a 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -36,7 +36,7 @@
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
-#include "hw/timer/xlnx-zynqmp-rtc.h"
+#include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "migration/vmstate.h"
 
 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 70b61b69c7a4..294465ef47ad 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -14,7 +14,6 @@ common-obj-$(CONFIG_IMX) += imx_epit.o
 common-obj-$(CONFIG_IMX) += imx_gpt.o
 common-obj-$(CONFIG_LM32) += lm32_timer.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
-common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
 
 common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index ce34b967db9f..1459d07237b9 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -70,9 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 
-# xlnx-zynqmp-rtc.c
-xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
-
 # nrf51_timer.c
 nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index d7483c3b4285..53076fa29a75 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -29,7 +29,7 @@
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/display/xlnx_dp.h"
 #include "hw/intc/xlnx-zynqmp-ipi.h"
-#include "hw/timer/xlnx-zynqmp-rtc.h"
+#include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/cpu/cluster.h"
 #include "target/arm/cpu.h"
 
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/rtc/xlnx-zynqmp-rtc.h
similarity index 95%
rename from include/hw/timer/xlnx-zynqmp-rtc.h
rename to include/hw/rtc/xlnx-zynqmp-rtc.h
index 97e32322ed70..6fa1cb2f43f8 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/rtc/xlnx-zynqmp-rtc.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2017 Xilinx Inc.
  *
- * Written-by: Alistair Francis <alistair.francis@xilinx.com>
+ * Written-by: Alistair Francis
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -24,8 +24,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef HW_TIMER_XLNX_ZYNQMP_RTC_H
-#define HW_TIMER_XLNX_ZYNQMP_RTC_H
+#ifndef HW_RTC_XLNX_ZYNQMP_H
+#define HW_RTC_XLNX_ZYNQMP_H
 
 #include "hw/register.h"
 #include "hw/sysbus.h"
-- 
2.21.0


