Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9246B2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9246B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvP9-0006Nr-7v
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv5Q-0001VL-OF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv5O-0008CE-Fn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:44 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv5O-0008Bg-5W; Fri, 25 Oct 2019 04:36:42 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTiDV-1iaL7m2LHB-00Tydl; Fri, 25 Oct 2019 10:35:40 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/19] hw: Move M48T59 device from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri, 25 Oct 2019 10:35:01 +0200
Message-Id: <20191025083511.11463-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S986VUfjJZRzIa53Eng4S7LTVlVuKZryH/QlVUabYeJmEJr7aXq
 GgXAsFGdFr2k9qsTGZNO5QK2emHkSl94CA1YX9J64Ys2+m5pL+sQQxypXfDltlCk1eapAw6
 S+UBFzSUWHvkiMywftrB0+f7VOpbr/FA7nayxrZ/xRdcBQTb/DAFPpDY/Px/s1mOXh274TE
 APbNA6hWZucyNtpqAhNdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:63EMmejZy/E=:1+L4nPwJv+7d9kgFh0CMFB
 EZpD+ZLeGICF463z6aS43+/GjOEUlJnt0sIhGy7FB/FkffF3syv8AowMPMu5y0L1mnGwnMHPi
 TNRxtTIebb36gQx/XtVtmmnDm+Eo0fTOr3DwxHd7E6lgCIW6CI2F5HJcuOUBf8h2FL8/xraN8
 WmwTHWbRv8DDHG8rVE9uoMBJEL0UYxaTz1c8Ds4eCBGdWWM5N74zSs5IEmNmMGqO162v1PBMx
 SGYuWOCuVe0PgnzvZCdBcGdYSd5ErUthI0MjTAvxyNu3u59eHsAGiK7c/l7nw4t93krvij0v7
 80veOSNAjF7YTMf0pZHdNCPoiD3Qj3CBDAMNi2IRQDGcgZnAR/Q+0j7yLCWp9bIuu952s6cvV
 eem+ks1ISDJ279ASTMUJ5RLQJzgOuuyos+FSrORtz9kG40cGjIB4tDGTEemlq76ialsO+qktl
 bl/yV6DQESpM2T5p4p+PRGbD0RhtvHFjM7ZZ6QYjdBp69doE6QafzRopPtjhXNMyvYf23D3TC
 zVIS+RUXc2ZRL+hFPJ7ksuceN96XubOKYo8XjHcLvs7dWmA7iUMRR0Ah3GrBJaTD4e9Nng0oz
 pViODjlbldi1VS2Ulz0N1xS9+ZQqOdKGN1w9THo06BC9BVaxEzMZXcsi/zibDS8ZMBqeXO/GM
 GFVIT0KkKTZKjWO7w8QVI+YW8pYu6cQAoCTHqrwJ0+1bg2FfjL9DwxMMNpSF61j234m+4U11G
 +cF1baOQ3oRAaSz6OkitDvwUU+k6iI/7KmG+OdvpYFLnIbWkzOK7vxKYO/cI83jLNGPIWCKd/
 PPX+MgHkJJOBD1MI5VL3jiiHGsqFnUxk77sS/1PnKV6rifCiFWKBuZsjlW4tuGUrkxDZZiJFw
 8veVRqMqfVBtUL+2FRXpBmDZ6RDo6cXAQb5QiosWI=
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

The M48T59 is a Real Time Clock, not a timer.
Move it under the hw/rtc/ subdirectory.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191003230404.19384-5-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                         |  4 +-
 hw/ppc/ppc405_boards.c              |  2 +-
 hw/ppc/prep.c                       |  2 +-
 hw/rtc/Kconfig                      |  3 ++
 hw/rtc/Makefile.objs                |  4 ++
 hw/{timer => rtc}/m48t59-internal.h |  0
 hw/{timer => rtc}/m48t59-isa.c      |  4 +-
 hw/{timer => rtc}/m48t59.c          |  2 +-
 hw/sparc/sun4m.c                    |  2 +-
 hw/sparc64/sun4u.c                  |  2 +-
 hw/timer/Kconfig                    |  3 --
 hw/timer/Makefile.objs              |  4 --
 include/hw/rtc/m48t59.h             | 57 +++++++++++++++++++++++++++++
 include/hw/timer/m48t59.h           | 32 ----------------
 14 files changed, 73 insertions(+), 48 deletions(-)
 rename hw/{timer => rtc}/m48t59-internal.h (100%)
 rename hw/{timer => rtc}/m48t59-isa.c (98%)
 rename hw/{timer => rtc}/m48t59.c (99%)
 create mode 100644 include/hw/rtc/m48t59.h
 delete mode 100644 include/hw/timer/m48t59.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7eba146444ae..4e65f062f29c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1064,9 +1064,9 @@ F: hw/pci-host/prep.[hc]
 F: hw/isa/i82378.c
 F: hw/isa/pc87312.c
 F: hw/dma/i82374.c
-F: hw/timer/m48t59-isa.c
+F: hw/rtc/m48t59-isa.c
 F: include/hw/isa/pc87312.h
-F: include/hw/timer/m48t59.h
+F: include/hw/rtc/m48t59.h
 F: pc-bios/ppc_rom.bin
 
 sPAPR
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 388cae0b4370..1f721feed6a4 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -29,7 +29,7 @@
 #include "cpu.h"
 #include "hw/ppc/ppc.h"
 #include "ppc405.h"
-#include "hw/timer/m48t59.h"
+#include "hw/rtc/m48t59.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3a51536e1a39..862345c2ac5f 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/timer/m48t59.h"
+#include "hw/rtc/m48t59.h"
 #include "hw/char/serial.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 7ffd702268ad..159c2335171a 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -1,3 +1,6 @@
+config M48T59
+    bool
+
 config PL031
     bool
 
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 3cac0d5a637b..c87f81405e9d 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -1,2 +1,6 @@
+common-obj-$(CONFIG_M48T59) += m48t59.o
+ifeq ($(CONFIG_ISA_BUS),y)
+common-obj-$(CONFIG_M48T59) += m48t59-isa.o
+endif
 common-obj-$(CONFIG_PL031) += pl031.o
 obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
diff --git a/hw/timer/m48t59-internal.h b/hw/rtc/m48t59-internal.h
similarity index 100%
rename from hw/timer/m48t59-internal.h
rename to hw/rtc/m48t59-internal.h
diff --git a/hw/timer/m48t59-isa.c b/hw/rtc/m48t59-isa.c
similarity index 98%
rename from hw/timer/m48t59-isa.c
rename to hw/rtc/m48t59-isa.c
index 5e5432abfdfa..7fde854c0f8f 100644
--- a/hw/timer/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -1,5 +1,5 @@
 /*
- * QEMU M48T59 and M48T08 NVRAM emulation (ISA bus interface
+ * QEMU M48T59 and M48T08 NVRAM emulation (ISA bus interface)
  *
  * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
  * Copyright (c) 2013 Hervé Poussineau
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
-#include "hw/timer/m48t59.h"
+#include "hw/rtc/m48t59.h"
 #include "m48t59-internal.h"
 #include "qemu/module.h"
 
diff --git a/hw/timer/m48t59.c b/hw/rtc/m48t59.c
similarity index 99%
rename from hw/timer/m48t59.c
rename to hw/rtc/m48t59.c
index a9fc2f981a56..fc592b9fb126 100644
--- a/hw/timer/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -27,7 +27,7 @@
 #include "qemu-common.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "hw/timer/m48t59.h"
+#include "hw/rtc/m48t59.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 6c5a17a02055..2aaa5bf1ae2e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -31,7 +31,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "hw/sparc/sun4m_iommu.h"
-#include "hw/timer/m48t59.h"
+#include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/block/fdc.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 1ded2a4c9ab3..955082773b06 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -36,7 +36,7 @@
 #include "hw/pci-host/sabre.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
-#include "hw/timer/m48t59.h"
+#include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
 #include "hw/input/i8042.h"
 #include "hw/block/fdc.h"
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index af415c8ef831..a57e9b59fca8 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -24,9 +24,6 @@ config M41T80
     bool
     depends on I2C
 
-config M48T59
-    bool
-
 config TWL92230
     bool
     depends on I2C
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index b0159189cf34..fe2d1fbc4040 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -7,10 +7,6 @@ common-obj-$(CONFIG_DS1338) += ds1338.o
 common-obj-$(CONFIG_HPET) += hpet.o
 common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
 common-obj-$(CONFIG_M41T80) += m41t80.o
-common-obj-$(CONFIG_M48T59) += m48t59.o
-ifeq ($(CONFIG_ISA_BUS),y)
-common-obj-$(CONFIG_M48T59) += m48t59-isa.o
-endif
 common-obj-$(CONFIG_PUV3) += puv3_ost.o
 common-obj-$(CONFIG_TWL92230) += twl92230.o
 common-obj-$(CONFIG_XILINX) += xilinx_timer.o
diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
new file mode 100644
index 000000000000..e7ea4e8761b9
--- /dev/null
+++ b/include/hw/rtc/m48t59.h
@@ -0,0 +1,57 @@
+/*
+ * QEMU M48T59 and M48T08 NVRAM emulation
+ *
+ * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
+ * Copyright (c) 2013 Hervé Poussineau
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_RTC_M48T59_H
+#define HW_RTC_M48T59_H
+
+#include "exec/hwaddr.h"
+#include "qom/object.h"
+
+#define TYPE_NVRAM "nvram"
+
+#define NVRAM_CLASS(klass) \
+    OBJECT_CLASS_CHECK(NvramClass, (klass), TYPE_NVRAM)
+#define NVRAM_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(NvramClass, (obj), TYPE_NVRAM)
+#define NVRAM(obj) \
+    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
+
+typedef struct Nvram Nvram;
+
+typedef struct NvramClass {
+    InterfaceClass parent;
+
+    uint32_t (*read)(Nvram *obj, uint32_t addr);
+    void (*write)(Nvram *obj, uint32_t addr, uint32_t val);
+    void (*toggle_lock)(Nvram *obj, int lock);
+} NvramClass;
+
+Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
+                       int base_year, int type);
+Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
+                   uint32_t io_base, uint16_t size, int base_year,
+                   int type);
+
+#endif /* HW_M48T59_H */
diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
deleted file mode 100644
index f74854c0260b..000000000000
--- a/include/hw/timer/m48t59.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef HW_M48T59_H
-#define HW_M48T59_H
-
-#include "exec/hwaddr.h"
-#include "qom/object.h"
-
-#define TYPE_NVRAM "nvram"
-
-#define NVRAM_CLASS(klass) \
-    OBJECT_CLASS_CHECK(NvramClass, (klass), TYPE_NVRAM)
-#define NVRAM_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(NvramClass, (obj), TYPE_NVRAM)
-#define NVRAM(obj) \
-    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
-
-typedef struct Nvram Nvram;
-
-typedef struct NvramClass {
-    InterfaceClass parent;
-
-    uint32_t (*read)(Nvram *obj, uint32_t addr);
-    void (*write)(Nvram *obj, uint32_t addr, uint32_t val);
-    void (*toggle_lock)(Nvram *obj, int lock);
-} NvramClass;
-
-Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
-                       int base_year, int type);
-Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
-                   uint32_t io_base, uint16_t size, int base_year,
-                   int type);
-
-#endif /* HW_M48T59_H */
-- 
2.21.0


