Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F606C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3092075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OirLJVh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3092075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60899 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9yc-00058c-1l
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:22:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0004uR-9R
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eq-0006lh-Lm
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eo-0006el-96
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id v16so14714225wrp.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=6r82UB3Jx2QL4KWS/trUKLi2visweaet7Q5LHJLeEw0=;
	b=OirLJVh/JCkt1DmrKKUGBOhDFjqFdprDlJFU1BeHrYoPynmzoQuVQQO+l3YreNCSQC
	RvbHAxQwE+H4KhjbS0Ey+8C7nSnp4oa8BFzhogcAVFTKkTV6KHGbI0s2JBxsJRRCgTUl
	xELzr2akCW03cRCyhs8wMEjOGlPxtIMJyWB1HLm2TlPlfgwO23/lcvBgQkxNLVn+mTpB
	/5nsPPMmfzuQNRwOnHLdJQTrNfijqkGRBEllHH/0h2SguelBXvKuY2RyjQ7F0W+H/ugy
	9p8y/XTNAXF+Vh5BvbCVEKtbgfPKJky2CUnfyA7tWZQ8G5lZ9IiVQi7P9MYngJUbObs3
	majw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6r82UB3Jx2QL4KWS/trUKLi2visweaet7Q5LHJLeEw0=;
	b=bUMWISTaXI1uwy6zqnZ3/sy0Mhr1qSZHMima27xhlG8fP4te4eouiZ1gHnWdIhiqfe
	fc73wLQ7buCIQK8+npNGUOP+ozkxSY4wIM/kxw/VJ85E075oTz53Q20rmZcL2KERLRye
	LVUX6smryHw5VT1Y0SveC4wt4iHjhIVxI/9QF9uQUVDo7MEfD08GtjZT2dswQcABwE14
	2Tl9jRPst2DUQOAGUEbCyhBrSw0imfoY52Ff9be57vh23bxmbEmcPhI59HMzGiaJ2Q7C
	ww3X4eztHJt8HQ/l3pt9vX5ndn9NxkxAYMsnWMGhfBCnU50jyWC7sX81bDCeTUmyZAT0
	7jjQ==
X-Gm-Message-State: APjAAAXcoenKBqPKX8avePrU+aWrLx/LvXn3n5gsZrGzm6K2uBzHFTfe
	jF7P0L/0efSK4LmXyU6x52vaNJxM5Nc=
X-Google-Smtp-Source: APXvYqz6WWHTPdey3BXKpom8fv+V1oSchSDodBQuSPljM0DN3taajP3DZwQ5UJZyRMeYgryMqDEIng==
X-Received: by 2002:a5d:40c8:: with SMTP id b8mr24043321wrq.205.1556557281335; 
	Mon, 29 Apr 2019 10:01:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:26 +0100
Message-Id: <20190429170030.11323-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 38/42] hw/devices: Move TI touchscreen
 declarations into a new header
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429170026.Q57r1HmbyHwHqX3HSDLaCMuphd8tRvYxAC6cyiMAY7k@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since uWireSlave is only used in this new header, there is no
need to expose it via "qemu/typedefs.h".

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-9-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h      |  6 +-----
 include/hw/devices.h       | 15 ---------------
 include/hw/input/tsc2xxx.h | 36 ++++++++++++++++++++++++++++++++++++
 include/qemu/typedefs.h    |  1 -
 hw/arm/nseries.c           |  2 +-
 hw/arm/palm.c              |  2 +-
 hw/input/tsc2005.c         |  2 +-
 hw/input/tsc210x.c         |  4 ++--
 MAINTAINERS                |  2 ++
 9 files changed, 44 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/input/tsc2xxx.h

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index e7fbd340f37..9de867daa46 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -20,6 +20,7 @@
 #include "exec/memory.h"
 # define hw_omap_h		"omap.h"
 #include "hw/irq.h"
+#include "hw/input/tsc2xxx.h"
 #include "target/arm/cpu-qom.h"
 #include "qemu/log.h"
 
@@ -679,11 +680,6 @@ qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
 void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handler);
 void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down);
 
-struct uWireSlave {
-    uint16_t (*receive)(void *opaque);
-    void (*send)(void *opaque, uint16_t data);
-    void *opaque;
-};
 struct omap_uwire_s;
 void omap_uwire_attach(struct omap_uwire_s *s,
                 uWireSlave *slave, int chipselect);
diff --git a/include/hw/devices.h b/include/hw/devices.h
index 7a630da47f7..ba9034050b4 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -4,7 +4,6 @@
 /* Devices that have nowhere better to go.  */
 
 #include "hw/hw.h"
-#include "ui/console.h"
 
 /* smc91c111.c */
 void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
@@ -12,18 +11,4 @@ void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
 /* lan9118.c */
 void lan9118_init(NICInfo *, uint32_t, qemu_irq);
 
-/* tsc210x.c */
-uWireSlave *tsc2102_init(qemu_irq pint);
-uWireSlave *tsc2301_init(qemu_irq penirq, qemu_irq kbirq, qemu_irq dav);
-I2SCodec *tsc210x_codec(uWireSlave *chip);
-uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len);
-void tsc210x_set_transform(uWireSlave *chip,
-                MouseTransformInfo *info);
-void tsc210x_key_event(uWireSlave *chip, int key, int down);
-
-/* tsc2005.c */
-void *tsc2005_init(qemu_irq pintdav);
-uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
-void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
-
 #endif
diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
new file mode 100644
index 00000000000..dbfe5c55c1f
--- /dev/null
+++ b/include/hw/input/tsc2xxx.h
@@ -0,0 +1,36 @@
+/*
+ * TI touchscreen controller
+ *
+ * Copyright (c) 2006 Andrzej Zaborowski
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_INPUT_TSC2XXX_H
+#define HW_INPUT_TSC2XXX_H
+
+#include "hw/irq.h"
+#include "ui/console.h"
+
+typedef struct uWireSlave {
+    uint16_t (*receive)(void *opaque);
+    void (*send)(void *opaque, uint16_t data);
+    void *opaque;
+} uWireSlave;
+
+/* tsc210x.c */
+uWireSlave *tsc2102_init(qemu_irq pint);
+uWireSlave *tsc2301_init(qemu_irq penirq, qemu_irq kbirq, qemu_irq dav);
+I2SCodec *tsc210x_codec(uWireSlave *chip);
+uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len);
+void tsc210x_set_transform(uWireSlave *chip, MouseTransformInfo *info);
+void tsc210x_key_event(uWireSlave *chip, int key, int down);
+
+/* tsc2005.c */
+void *tsc2005_init(qemu_irq pintdav);
+uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
+void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
+
+#endif
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index e4a0a656d1c..fcdaae58c44 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -99,7 +99,6 @@ typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
-typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 6889f13d699..303f7a31e1c 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -30,8 +30,8 @@
 #include "ui/console.h"
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
-#include "hw/devices.h"
 #include "hw/display/blizzard.h"
+#include "hw/input/tsc2xxx.h"
 #include "hw/misc/cbus.h"
 #include "hw/misc/tmp105.h"
 #include "hw/block/flash.h"
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 285f43709dd..139d27d1cc0 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -26,7 +26,7 @@
 #include "hw/arm/omap.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
+#include "hw/input/tsc2xxx.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 2b9108a1932..f82771e7a7c 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -23,7 +23,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
-#include "hw/devices.h"
+#include "hw/input/tsc2xxx.h"
 #include "trace.h"
 
 #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 41731619bb6..f94cb4683bf 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -24,8 +24,8 @@
 #include "audio/audio.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
-#include "hw/arm/omap.h"	/* For I2SCodec and uWireSlave */
-#include "hw/devices.h"
+#include "hw/arm/omap.h"            /* For I2SCodec */
+#include "hw/input/tsc2xxx.h"
 
 #define TSC_DATA_REGISTERS_PAGE		0x0
 #define TSC_CONTROL_REGISTERS_PAGE	0x1
diff --git a/MAINTAINERS b/MAINTAINERS
index 39a3216e1c4..7dd71e0a2d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -669,6 +669,7 @@ F: hw/input/tsc2005.c
 F: hw/misc/cbus.c
 F: hw/timer/twl92230.c
 F: include/hw/display/blizzard.h
+F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
 
 Palm
@@ -678,6 +679,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/palm.c
 F: hw/input/tsc210x.c
+F: include/hw/input/tsc2xxx.h
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


