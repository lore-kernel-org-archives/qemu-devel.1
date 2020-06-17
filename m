Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F6DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68AF206F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHErhG4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68AF206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR2s-00007v-VG
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzf-0002Z7-Sa; Wed, 17 Jun 2020 01:52:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQze-0004R7-7O; Wed, 17 Jun 2020 01:52:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id x6so883258wrm.13;
 Tue, 16 Jun 2020 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F2YxX9VCCUyY03bbs5Etq9snItCbfRtbE7wliPQ48mM=;
 b=tHErhG4cqCU0lMjAIGJH1+wWsa+WpRnALnaIKvknu4HmdM/IHwdl1V5s7UDP2e2SER
 /QQhoykdV7RUAbaDcAPqDJE5+zD1uJOJ7dtyfuLeBWcZvJdU8jqEqkXg0we19eXDS+a6
 mesbdoF20TF9AIJS3nH4gihhC/fSC1FdcFVqjMjR5GZA/K7e5ThyN//lx2HIkBsIXfyy
 Bsd1Y0kJMYwkfeHjUR+7cUXIO5tYkeHyCqWn3mBUAlf6ZPQLruDhoJ9yscGju0zTGk5H
 X1HyjhXxuMumQMeqcfSymS3bokmSxMcgjop5U30NRksLXgrWMiMy0FellhTIOGCUiU8u
 6KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=F2YxX9VCCUyY03bbs5Etq9snItCbfRtbE7wliPQ48mM=;
 b=RCeSyzl9hLZ4P8s9Bspsqt5UdyUDRau3hCQo+FWj4JMAL2pcZVWFATu/koBQPSjgpH
 QM/IzXwqUCiXpy5rbvP5aRk9UpcpazWV5xS2C3w//1fo15kqnwawr3hMn+NOOemTCJtR
 s6aJKil28icjOiPfb4dsfqu2REH1Qq8aBEJQq5ZlmTEsWkw0HqD1+Pd6Kkb66wG1ZKce
 vmxz3jeVBXtShYf6Zhqr3OxQmV7s3zKruecdUWBA8fPzVzHedU6Iq2XE8bnuh7HsKdEQ
 x0gxnj7pzj/8qSHm84UFHvbQGKeEe40R+EJpJTg+vMvctwoCOGgS+ZoP29F860xYcuZW
 M+1w==
X-Gm-Message-State: AOAM532c0U3P4ciIVyJl8LwsMDk+hCiIKhH2DZPKjfiG3tX+G7lb1vAu
 5l7Wv1jJcIbdW2KmmJpz50bn8CO2
X-Google-Smtp-Source: ABdhPJw6X8/oONQZWAV0rrtw8jIr4jwM/QZRlNB0MbbX6BiHuXqxfjMhTnlSpb/YNR+K19s4hl/+XQ==
X-Received: by 2002:a5d:5006:: with SMTP id e6mr6959836wrt.170.1592373132400; 
 Tue, 16 Jun 2020 22:52:12 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d28sm3000809wrc.50.2020.06.16.22.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 22:52:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/14] hw/i2c: Add header for ARM SBCon two-wire serial bus
 interface
Date: Wed, 17 Jun 2020 07:51:55 +0200
Message-Id: <20200617055205.3576-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617055205.3576-1-f4bug@amsat.org>
References: <20200617055205.3576-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'ARM SBCon two-wire serial bus interface' is the official
name describing the pair of registers used to bitbanging
I2C in the Versatile boards.

Make the private VersatileI2CState structure as public
ArmSbconI2CState.
Add the TYPE_ARM_SBCON_I2C, alias to our current
TYPE_VERSATILE_I2C model.
Rename the memory region description as 'arm_sbcon_i2c'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/arm_sbcon_i2c.h | 35 ++++++++++++++++++++++++++++++++++
 hw/i2c/versatile_i2c.c         | 17 +++++------------
 MAINTAINERS                    |  1 +
 3 files changed, 41 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/i2c/arm_sbcon_i2c.h

diff --git a/include/hw/i2c/arm_sbcon_i2c.h b/include/hw/i2c/arm_sbcon_i2c.h
new file mode 100644
index 0000000000..5d96507ab6
--- /dev/null
+++ b/include/hw/i2c/arm_sbcon_i2c.h
@@ -0,0 +1,35 @@
+/*
+ * ARM SBCon two-wire serial bus interface (I2C bitbang)
+ *   a.k.a.
+ * ARM Versatile I2C controller
+ *
+ * Copyright (c) 2006-2007 CodeSourcery.
+ * Copyright (c) 2012 Oskar Andero <oskar.andero@gmail.com>
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_I2C_ARM_SBCON_H
+#define HW_I2C_ARM_SBCON_H
+
+#include "hw/sysbus.h"
+#include "hw/i2c/bitbang_i2c.h"
+
+#define TYPE_VERSATILE_I2C "versatile_i2c"
+#define TYPE_ARM_SBCON_I2C TYPE_VERSATILE_I2C
+
+#define ARM_SBCON_I2C(obj) \
+    OBJECT_CHECK(ArmSbconI2CState, (obj), TYPE_ARM_SBCON_I2C)
+
+typedef struct ArmSbconI2CState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    bitbang_i2c_interface bitbang;
+    int out;
+    int in;
+} ArmSbconI2CState;
+
+#endif /* HW_I2C_ARM_SBCON_H */
diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index 0ce10a1bcc..da8cda2ec1 100644
--- a/hw/i2c/versatile_i2c.c
+++ b/hw/i2c/versatile_i2c.c
@@ -1,5 +1,6 @@
 /*
- * ARM Versatile I2C controller
+ * ARM SBCon two-wire serial bus interface (I2C bitbang)
+ * a.k.a. ARM Versatile I2C controller
  *
  * Copyright (c) 2006-2007 CodeSourcery.
  * Copyright (c) 2012 Oskar Andero <oskar.andero@gmail.com>
@@ -22,24 +23,16 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sysbus.h"
-#include "hw/i2c/bitbang_i2c.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/registerfields.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
-#define TYPE_VERSATILE_I2C "versatile_i2c"
 #define VERSATILE_I2C(obj) \
     OBJECT_CHECK(VersatileI2CState, (obj), TYPE_VERSATILE_I2C)
 
-typedef struct VersatileI2CState {
-    SysBusDevice parent_obj;
+typedef ArmSbconI2CState VersatileI2CState;
 
-    MemoryRegion iomem;
-    bitbang_i2c_interface bitbang;
-    int out;
-    int in;
-} VersatileI2CState;
 
 REG32(CONTROL_GET, 0)
 REG32(CONTROL_SET, 0)
@@ -99,7 +92,7 @@ static void versatile_i2c_init(Object *obj)
     bus = i2c_init_bus(dev, "i2c");
     bitbang_i2c_init(&s->bitbang, bus);
     memory_region_init_io(&s->iomem, obj, &versatile_i2c_ops, s,
-                          "versatile_i2c", 0x1000);
+                          "arm_sbcon_i2c", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..185d39e151 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -842,6 +842,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/versatile*
+F: include/hw/i2c/arm_sbcon_i2c.h
 F: hw/misc/arm_sysctl.c
 F: docs/system/arm/versatile.rst
 
-- 
2.21.3


