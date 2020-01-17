Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCD0C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4EB2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSPSYSTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4EB2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isShC-0003F9-7R
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbr-0006Df-Co
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbp-00071K-VR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:27 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbp-00070P-Oe
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:25 -0500
Received: by mail-wr1-x435.google.com with SMTP id c9so22912783wrw.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yD7+tDg0Iz3qIsokXqUffP6V8oJrZAOzynwkHXxb7yI=;
 b=LSPSYSTfKwnRgoyY3FTzRVgV71JWtoihYuR3mdL/AU3f776XA8ncShfRooodKiJt/8
 o/zmwV2MzeqewiptgyU7xMBQx9Nn3UZiBaYm8Wgc3FhYEnj3TtvkM0MuG0JFKXKpzZrh
 u8VGWjivz1koBKsOg5XSp1t7M8FN4JMenw5z6IH3hPRMYwPKG5zDjHmL8+43DmGbWabX
 K6ZMKwCp6MuTgbQrtnCbtOAzR+WjfFwWsaVtm8I7ySdKiN8yWvVMiL70NbGaxpGIbjPV
 SPUaSjQvx0rj68Mznt3Bvd1tmSJusvLCOeanFZkTw9tTG15A8gst4oi3jqHHe/qWfTO4
 eoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yD7+tDg0Iz3qIsokXqUffP6V8oJrZAOzynwkHXxb7yI=;
 b=e7sy6O8ksyjl56418dRbSfEEH2gypfXCWhjJPakfpzSk3g7YD30tG0Zr3Mp7PTPs2T
 PAu7xcf7xwKXxXnCLDQkvnQroDaMqAU9NzEAxeO26xP//dwaiFy76VJknUGsLe5wtaQG
 1puPJxonCGREzOQjquOYNIYjrAYC2oqOpxAJgpewZbUh2j9+YVvmrz0Z72wNq8fMm6jL
 rny63gvH6fz5gmE7gn8wAYTS3qRocK+Lv7ibdE0qxbyE5vVuaYj06sUWkPqabTqMH+JJ
 CKIXWrePPI+J5EwxGq1N7KdhPjXZqml0fymEjwZSNAmHjMIsXscBMUnKIpm6wph3mGkI
 lMAA==
X-Gm-Message-State: APjAAAW65a6pUIOylEzC3ModyT8V9VpsqgfpEH4dfUp87uhm62QNPOYU
 VogcPRELHrtHQEm1MloAYl8bh8GRF+Shzw==
X-Google-Smtp-Source: APXvYqwLepy7RugoFAofMr4Z3wDpp9cNRvRM9x/03sXjeT7CSWMis+n98pxLsCIxWZtwjIsrVFdVbg==
X-Received: by 2002:adf:c145:: with SMTP id w5mr3431237wre.205.1579271304500; 
 Fri, 17 Jan 2020 06:28:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/15] hw/arm: Add the Netduino Plus 2
Date: Fri, 17 Jan 2020 14:28:05 +0000
Message-Id: <20200117142816.15110-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair@alistair23.me>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: dad8d8d47f7625913e35e27a1c00f603a6b08f9a.1576658572.git.alistair@alistair23.me
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs   |  1 +
 hw/arm/netduinoplus2.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS            |  6 +++++
 3 files changed, 59 insertions(+)
 create mode 100644 hw/arm/netduinoplus2.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index d9d54da7cff..336f6dd3749 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -11,6 +11,7 @@ obj-$(CONFIG_MAINSTONE) += mainstone.o
 obj-$(CONFIG_MICROBIT) += microbit.o
 obj-$(CONFIG_MUSICPAL) += musicpal.o
 obj-$(CONFIG_NETDUINO2) += netduino2.o
+obj-$(CONFIG_NETDUINOPLUS2) += netduinoplus2.o
 obj-$(CONFIG_NSERIES) += nseries.o
 obj-$(CONFIG_SX1) += omap_sx1.o
 obj-$(CONFIG_CHEETAH) += palm.o
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
new file mode 100644
index 00000000000..e5e247edbed
--- /dev/null
+++ b/hw/arm/netduinoplus2.c
@@ -0,0 +1,52 @@
+/*
+ * Netduino Plus 2 Machine Model
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32f405_soc.h"
+#include "hw/arm/boot.h"
+
+static void netduinoplus2_init(MachineState *machine)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
+    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       FLASH_SIZE);
+}
+
+static void netduinoplus2_machine_init(MachineClass *mc)
+{
+    mc->desc = "Netduino Plus 2 Machine";
+    mc->init = netduinoplus2_init;
+}
+
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/MAINTAINERS b/MAINTAINERS
index cae53f5c146..55d3642e6c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -830,6 +830,12 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/netduino2.c
 
+Netduino Plus 2
+M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: hw/arm/netduinoplus2.c
+
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1


