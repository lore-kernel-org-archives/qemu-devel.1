Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B78F20B80
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJSxryxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B78F20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPJe-0000n3-Cd
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxV-0005X0-Jm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxT-0005mD-Ko
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:41 -0400
Received: by mail-wr1-x42a.google.com with SMTP id k6so33437975wrn.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UtlmxB+fyNUWPbT2HQyqJRiOYmojja7C2iCam/D7HtA=;
 b=HJSxryxxho2hjPzV9+3cfichOP0MDserb92dcfHp69Y7P7xnA5Cuw/pl+rgDPw+qcc
 l7xnx8NsW3Im+rXxul3IhjHan/X2irSHx4cxHHzjlOpuoG1xsqAJWWoplh0uwiVxrNPT
 O1cERSGfFQllTENvM3nye1Jp/YwKJKQEJicKVzJ1B+Rp3NWfXZ9pBE0/JNirOT8oQyYx
 jrJt0ZhmYxizw8yqt8tYgtvs5y1akq/1+uqvqsjoKDY1Ffn722m7v0gLC7r5e+HQPKe1
 IxWlawjCRv09P31w9ADYVKIBJuAM6Kp5NICmUg3TvhJBXAG7RYCWRwrRpKhvPjFlodcK
 GXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UtlmxB+fyNUWPbT2HQyqJRiOYmojja7C2iCam/D7HtA=;
 b=obixuCdcqBkqQ6ebqmoWLl4Tlux5aIo3LhRy7uIGLeF4kyakDBjl3XlbfuwnWmPZtK
 wbAzwhBBwOO0q+5WR8hjTzIbXgjAgOUwNV683+um1u5gU5kRcXhQOJ3EDHw77/eRPbKh
 wOsiK7iirAQb0nWXYxraBTKoDoew4/IVCehhFIZ6dq2fuPMp7k+voA5vIRB151hsYJo0
 i40SxHehfvtvOlo/pfg3nu6/82tsnZ6ML0K+DQBLYySu5UV1EuYdB6Shi7V8qlav00Db
 tRV3x4TPLekanDk35sKAaSoMnZ04V+aC+Y8KvVrq+huEiejdLBh2HfD+2TSD4BJiicZT
 Ssyw==
X-Gm-Message-State: AOAM530f8V17CNPw5Zv828KqZv48PMYLWZAuLtThnaNCAs6FI00HGsjm
 WZEBH3FZgyU7xzweX4C+m8E71m2QPndLJg==
X-Google-Smtp-Source: ABdhPJx21A8II0O82BKzsjfd/VICES23PyT5qJ+R+LvpM0e34sUy3Jq3F3LoossT4sJIaTBxrkV6fQ==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr2686353wrq.216.1593795277823; 
 Fri, 03 Jul 2020 09:54:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/34] hw/misc/max111x: Create header file for documentation,
 TYPE_ macros
Date: Fri,  3 Jul 2020 17:53:58 +0100
Message-Id: <20200703165405.17672-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a header file for the hw/misc/max111x device, in the
usual modern style for QOM devices:
 * definition of the TYPE_ constants and macros
 * definition of the device's state struct so that it can
   be embedded in other structs if desired
 * documentation of the interface

This allows us to use TYPE_MAX_1111 in the spitz.c code rather
than the string "max1111".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200628142429.17111-12-peter.maydell@linaro.org
---
 include/hw/misc/max111x.h | 56 +++++++++++++++++++++++++++++++++++++++
 hw/arm/spitz.c            |  3 ++-
 hw/misc/max111x.c         | 24 +----------------
 MAINTAINERS               |  1 +
 4 files changed, 60 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/misc/max111x.h

diff --git a/include/hw/misc/max111x.h b/include/hw/misc/max111x.h
new file mode 100644
index 00000000000..af7f1017eff
--- /dev/null
+++ b/include/hw/misc/max111x.h
@@ -0,0 +1,56 @@
+/*
+ * Maxim MAX1110/1111 ADC chip emulation.
+ *
+ * Copyright (c) 2006 Openedhand Ltd.
+ * Written by Andrzej Zaborowski <balrog@zabor.org>
+ *
+ * This code is licensed under the GNU GPLv2.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#ifndef HW_MISC_MAX111X_H
+#define HW_MISC_MAX111X_H
+
+#include "hw/ssi/ssi.h"
+
+/*
+ * This is a model of the Maxim MAX1110/1111 ADC chip, which for QEMU
+ * is an SSI slave device. It has either 4 (max1110) or 8 (max1111)
+ * 8-bit ADC channels.
+ *
+ * QEMU interface:
+ *  + GPIO inputs 0..3 (for max1110) or 0..7 (for max1111): set the value
+ *    of each ADC input, as an unsigned 8-bit value
+ *  + GPIO output 0: interrupt line
+ *  + Properties "input0" to "input3" (max1110) or "input0" to "input7"
+ *    (max1111): initial reset values for ADC inputs.
+ *
+ * Known bugs:
+ *  + the interrupt line is not correctly implemented, and will never
+ *    be lowered once it has been asserted.
+ */
+typedef struct {
+    SSISlave parent_obj;
+
+    qemu_irq interrupt;
+    /* Values of inputs at system reset (settable by QOM property) */
+    uint8_t reset_input[8];
+
+    uint8_t tb1, rb2, rb3;
+    int cycle;
+
+    uint8_t input[8];
+    int inputs, com;
+} MAX111xState;
+
+#define TYPE_MAX_111X "max111x"
+
+#define MAX_111X(obj) \
+    OBJECT_CHECK(MAX111xState, (obj), TYPE_MAX_111X)
+
+#define TYPE_MAX_1110 "max1110"
+#define TYPE_MAX_1111 "max1111"
+
+#endif
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index fa592aad6d6..1400a56729d 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -29,6 +29,7 @@
 #include "audio/audio.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
+#include "hw/misc/max111x.h"
 #include "migration/vmstate.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
@@ -732,7 +733,7 @@ static void spitz_ssp_attach(SpitzMachineState *sms)
                           qdev_get_gpio_in(sms->mpu->gpio, SPITZ_GPIO_TP_INT));
 
     bus = qdev_get_child_bus(sms->mux, "ssi2");
-    sms->max1111 = qdev_new("max1111");
+    sms->max1111 = qdev_new(TYPE_MAX_1111);
     max1111 = sms->max1111;
     qdev_prop_set_uint8(sms->max1111, "input1" /* BATT_VOLT */,
                         SPITZ_BATTERY_VOLT);
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index 3a5cb838445..7e6723f3435 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -11,34 +11,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/misc/max111x.h"
 #include "hw/irq.h"
-#include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 
-typedef struct {
-    SSISlave parent_obj;
-
-    qemu_irq interrupt;
-    /* Values of inputs at system reset (settable by QOM property) */
-    uint8_t reset_input[8];
-
-    uint8_t tb1, rb2, rb3;
-    int cycle;
-
-    uint8_t input[8];
-    int inputs, com;
-} MAX111xState;
-
-#define TYPE_MAX_111X "max111x"
-
-#define MAX_111X(obj) \
-    OBJECT_CHECK(MAX111xState, (obj), TYPE_MAX_111X)
-
-#define TYPE_MAX_1110 "max1110"
-#define TYPE_MAX_1111 "max1111"
-
 /* Control-byte bitfields */
 #define CB_PD0		(1 << 0)
 #define CB_PD1		(1 << 1)
diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b1..c31c878c635 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -787,6 +787,7 @@ F: hw/gpio/max7310.c
 F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
 F: hw/misc/max111x.c
+F: include/hw/misc/max111x.h
 F: include/hw/arm/pxa.h
 F: include/hw/arm/sharpsl.h
 F: include/hw/display/tc6393xb.h
-- 
2.20.1


