Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEDDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8F220771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDKObtXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8F220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhfT-0003mf-1b
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHE-0003PI-5G
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHC-0003NC-5m
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id l17so2683972wmj.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8i5mWLDYm92VN12vLJvLbPoNaenvMWjlwAjnUllix3o=;
 b=YDKObtXFwXMCIzdepmoAfM7zWem9h+MIjd44q/zTHfaQQPBjMw8wTpK0ZaEh0ZqT6s
 Ox5GSYkostcLV4TCk7o46S7pHnUDOB5e6JuQdVgqusBKCPf+MzabHuZMsQgM3wW32QW8
 y+6uzqKwnz878Xrg1BXPdpu3zoDFbEQ8ozXiOvfeXP2RxaAz7+TWXzZDGkBj+VlFJCNL
 o3BSbr1msQ39LAkD3NlUHTE0VVMufc5uqS1vMmchJd8FbvEWm3ySvfbJHansu7MS26Rh
 Ekw4kPMiMahahKOs7MiRrB4JbShoTQMKKpHxwZNMInHeayGiN0+LCcBJ7R4U5/Z+AV8d
 1Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8i5mWLDYm92VN12vLJvLbPoNaenvMWjlwAjnUllix3o=;
 b=X/+ZXNpaUAufEgxIRPwY8SAw+Se82OguLGhQ+vDC5dy0M5u9z4lPKl+00aVZMDmIL0
 ya/jLbXJn40Rt9tcTp22AOwB/YT0gqgoEAyJdNv/EbAhTZS5Opx1sdAP0rkF9uWmiAQY
 56edzCjKxATLeIb/76MSxF6O+gDA9jDH2h2CewOiI/cDpr+RX+Z6UT5UNVIXEYHDw3Au
 10BmkqVsoJZbTAVHWQ6daUYfzYWwNe4D17d8OKCOtktPdsj/MK9u7mLEvhM2cOD6wQF9
 f8vnYsTNLYkUA4nE+LbRXawNcxboBsbuVsqnxbslIQhnABTnf/C81v1i/gCytq1hQB2Y
 Jgog==
X-Gm-Message-State: AOAM533HgBSPKKtT1gowLjhL4CYPmk1fQ4410B4rLygyPrJOxFGhx8D0
 oHaXcJ5cNlfPR7aMXbktJNDDIW4nwWb4OQ==
X-Google-Smtp-Source: ABdhPJzGBdvwuJ5WS2Z5YVaT9VWnJrJb9tnSBpcEoIO0MJhFpOTYJ2kprycMohFoL2fEzS+Q7JrIuQ==
X-Received: by 2002:a1c:4343:: with SMTP id q64mr12173523wma.20.1592912380492; 
 Tue, 23 Jun 2020 04:39:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/42] hw/i2c: Add header for ARM SBCon two-wire serial bus
 interface
Date: Tue, 23 Jun 2020 12:38:51 +0100
Message-Id: <20200623113904.28805-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

'ARM SBCon two-wire serial bus interface' is the official
name describing the pair of registers used to bitbanging
I2C in the Versatile boards.

Make the private VersatileI2CState structure as public
ArmSbconI2CState.
Add the TYPE_ARM_SBCON_I2C, alias to our current
TYPE_VERSATILE_I2C model.
Rename the memory region description as 'arm_sbcon_i2c'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-5-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/arm_sbcon_i2c.h | 35 ++++++++++++++++++++++++++++++++++
 hw/i2c/versatile_i2c.c         | 17 +++++------------
 MAINTAINERS                    |  1 +
 3 files changed, 41 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/i2c/arm_sbcon_i2c.h

diff --git a/include/hw/i2c/arm_sbcon_i2c.h b/include/hw/i2c/arm_sbcon_i2c.h
new file mode 100644
index 00000000000..5d96507ab6e
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
index 0ce10a1bcc0..da8cda2ec1c 100644
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
index f0cb1fd3371..f1a74b1dfe6 100644
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
2.20.1


