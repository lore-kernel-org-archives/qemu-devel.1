Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20576C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5EC2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nReDE7X5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5EC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSZH-0007Aq-4i
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSD-0004XM-Mz; Wed, 17 Jun 2020 03:25:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSC-0002aN-2B; Wed, 17 Jun 2020 03:25:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id x14so1172293wrp.2;
 Wed, 17 Jun 2020 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F2YxX9VCCUyY03bbs5Etq9snItCbfRtbE7wliPQ48mM=;
 b=nReDE7X54tsGZKuzKKfgyO7o91mE9AMYQ61BD5+nrD5ecAf9wXRaRsBBiD9mqycf9u
 Fw0cRfbm0vPbhfH6E/AYjE1nd3JzE0gGduujItqAiH9DXNL+M/Ms35Pwl8Kc2jh1ZNIn
 q69cNpiNwOBOnHzerceQKxCWyra1DnWfU9u+GdYGNZHXEReHuPlOpEjwz04wWelQ4uXZ
 oLnr9714tMsYtVhI7/5qfluZpFiP9isaREJ2ZLHLEwAe0gNHXCftqHG6OAAPgYfcOY2n
 xtL/KSl++7C6zAqtbYfQiNJhahy8vpjJfYOQJbFshlZoXFmfbZIzGpeUmBcD0SmRjZ80
 vCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=F2YxX9VCCUyY03bbs5Etq9snItCbfRtbE7wliPQ48mM=;
 b=ixCQWPSmk21IXZvZEwr23vvo9XeSbGJQwMTqI0MPRKZfcIC6GURyG4SJJGpWEzwEO/
 9oLm4Hus/oyM6+D0Yirx2XpDFNzTFKvLkfH46Qh+U3SS6RlSAKw/bS8e1UWBwz2WFhgA
 D6EPRfsVFYru/xRjgNCvV7nrC9kCUcfk4aW4FpalTsFInZGYUWdyfPliN+de06w6oGe/
 DFoL9Huy4p4WYUcMjyOQXzzzRY4TROG3wZCWplCMnpzcQt+SWOgLzWMryVELzjKudB04
 EJwb2el5t2iYKM6aw754Ba+2NM4n/3FqQ0cnvGbU5Qw7hz54oMzwGCSTRTfCKgS0GOzK
 nOCQ==
X-Gm-Message-State: AOAM533j35ZNVMfEdpw/wVfrgB29uLAxMZlO22PvwhvScDxci+FExEG0
 dlyN/8DD1EHkFYQXDI5YEpLAQkDn
X-Google-Smtp-Source: ABdhPJwrYUHIOn2aSMjEzKgGPTM5qCgrnT5EN2WGy1p99owakbApyGO2cFaxgauqDpzd4EB+/uRCoQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr2361123wrq.189.1592378746100; 
 Wed, 17 Jun 2020 00:25:46 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/14] hw/i2c: Add header for ARM SBCon two-wire serial bus
 interface
Date: Wed, 17 Jun 2020 09:25:29 +0200
Message-Id: <20200617072539.32686-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
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


