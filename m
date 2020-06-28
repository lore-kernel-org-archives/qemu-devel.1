Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7F9C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BB8206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsX2bKMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BB8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYMO-0002aO-K8
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEi-0006MZ-Gh
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEg-0004kq-HC
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so13991446wrj.13
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WciP4YXlhY7aEQRA6uEhlFST0m8DbBOd0N16ZxZywy0=;
 b=qsX2bKMnpLve06lR58bgTLDJytLYlquUENBB/WyIQFk0/vq2SJcL23Nh/wzlQ+7TTe
 bc0E5KeQN9kobP5RB66aNbxfyqOj2rq8mp38GmKdkvB5ZjZK+pVP+cY/2CjkPH23h3qQ
 NV6as9G3uaQEDGOZ1JHxufjJHqFk0Ae+dgcoVrKI60VHouK3hiYr8x7wJ2UJZQPw4zud
 gQV2Pt02JTSlmKYWXwQMdij2cyPyn9vDR3vlr1fHY4VcHLyoVFJ3bFkcN8MTajSHFQt5
 sFY25bwudg9G0PRiqvLDZiTU5vOxw4VgWkw+i1YPzFNSs4oRom9L20sh8+bRG9nIfh5E
 zAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WciP4YXlhY7aEQRA6uEhlFST0m8DbBOd0N16ZxZywy0=;
 b=t6r/fBFRkEvTEMnUh2PMnoTor5mFrfW17EwGMWU/8lyvEukh6AX9sLKGosrIlSpgg+
 PnUdtVerMLZ+5eECga24QWQwfOM695/kNEXBwdLs2Gqhn3O5eo6kTjvL/FgAIjXAe09/
 Hc73JyeOX+HeQIm/K9enHGRN2ZSAJds6yDYl/w4bMM9Y0XxirZad1eOEEYjWlCG/bEtx
 Ol2G8U5ANtDjVw9JhgYevATBd1KeQdwAfbOUDH60oxt6AWnNch/08rGKh/ziSyy93cV8
 +5EFwbS+dYRYZMMM8hWx9cjT/efSBp01y8uVUD2PFK7KhKYZmYQiHj1nV99L7vSGkyQ3
 Z4zw==
X-Gm-Message-State: AOAM533pbjkxKYuVmPKJDCwSjCFJ9FT+S41TT7xy+zemIFCF7txj3XOn
 aYqHt/LLFNltcMIBsSONOzKUQw==
X-Google-Smtp-Source: ABdhPJyQkQlsh3tVtk2dPf/va7nnytelYRgmzhr+ujSXoX63UEWWWoKgwGCx6HPb1+TVbJfqX6NzJw==
X-Received: by 2002:adf:e948:: with SMTP id m8mr13408174wrn.398.1593354285227; 
 Sun, 28 Jun 2020 07:24:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/17] hw/misc/max111x: Create header file for documentation,
 TYPE_ macros
Date: Sun, 28 Jun 2020 15:24:23 +0100
Message-Id: <20200628142429.17111-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
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
---
To be honest the main driver here is that I wanted a header
file to put the documentation comment in :-)
---
 include/hw/misc/max111x.h | 57 +++++++++++++++++++++++++++++++++++++++
 hw/arm/spitz.c            |  3 ++-
 hw/misc/max111x.c         | 25 +----------------
 MAINTAINERS               |  1 +
 4 files changed, 61 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/misc/max111x.h

diff --git a/include/hw/misc/max111x.h b/include/hw/misc/max111x.h
new file mode 100644
index 00000000000..337ba63d588
--- /dev/null
+++ b/include/hw/misc/max111x.h
@@ -0,0 +1,57 @@
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
+#include "hw/irq.h"
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
index 3a5cb838445..d41cfd92a8d 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -11,34 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/ssi/ssi.h"
+#include "hw/misc/max111x.h"
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
index 1b40446c739..550844d1514 100644
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


