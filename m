Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9ABC352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5E62051A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFo9BX/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5E62051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5wf-0004Sm-7T
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jP5v7-0002QP-3M
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jP5v5-0005YG-SX
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:55:13 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jP5v5-0005Y5-NC; Thu, 16 Apr 2020 10:55:11 -0400
Received: by mail-pl1-x643.google.com with SMTP id d24so1440708pll.8;
 Thu, 16 Apr 2020 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CUyXXTyShFlx2/maCp5HGaaaIrvw4HRoNrxDU7Mf/kQ=;
 b=TFo9BX/JiUgY2i7sIny2sbGnmuUkXgnw4r8gv5ogjIgfbCi3y41zD6/QoFUqmsAkpU
 yWRgUrVgAqg31l8f8wCpV8ksXllB2dgZggDwK9p2PFERJRYL5Pyn7NwTDr95ZEbLA47C
 KXrZqvfwoP2EPEf3Hrw6nqiCNfoyweLLcxKgo4jc8CysjHfmvaLzUaooOVQ+7jLlDaAw
 qsaiNCZerciOkaahyHt9EovpAm0g13cTFPC9ju4v1ncEStFmDcQeJl6Zh9T/FPXmECEp
 IqzdUCBGv1qfxulA2crwMZn/af3ZEYdLU2XnTrvsK0C0XommRj4oC/V907MNlVyR+CJY
 9sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CUyXXTyShFlx2/maCp5HGaaaIrvw4HRoNrxDU7Mf/kQ=;
 b=cFnFlueKkXs1g1coNxIWUsbA4nG9cF9FR7MfzwD9q7r1a2R9z2bf5g4pfv/tBpct/q
 fWvysAH+sh10H3Ksj11n35vieX2gu6hJpj+Jc1OLDkJO5B4w0j1mw3d7WjCVp/LlT3R1
 AN+yfz2dxKMa557knNMV75u+zukR0ljnvUMmm+pZsYHLFeoxMwrqjIcfw3NVBwAmxlEf
 aauVCsUmzbvXhba17o6OvQAjNJzyNxVh9LHnLTh3eE3HSHAYKmh/B4yMKCUK7z7qwgOx
 i7Oy5XZlNEsQWlTjNU62bWzlWxyiUf+2R2dqSm1DOxQhXK0WNwa3TXZcGJYdwRxoMJqi
 UvXQ==
X-Gm-Message-State: AGi0PuYlNl5hi2Zf9vbzLZQYkPhxjFaytVXl9tCJMkLqZrRXZbAZq1YU
 KRVQg6otMFa3oeOYjSz3CC0=
X-Google-Smtp-Source: APiQypL/lqKI6jQZ24xcheHkkOsXQvMqgj3Wp+Qr+B9Jy5NoviN7hVdt83B/+bo8MaVHnVdGx99PWw==
X-Received: by 2002:a17:90a:fe18:: with SMTP id
 ck24mr5926762pjb.57.1587048910844; 
 Thu, 16 Apr 2020 07:55:10 -0700 (PDT)
Received: from hyd1358.marvell.com ([115.113.156.2])
 by smtp.googlemail.com with ESMTPSA id s63sm3671973pfb.44.2020.04.16.07.55.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 07:55:10 -0700 (PDT)
From: sundeep.lkml@gmail.com
To: jasowang@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [Qemu devel PATCH v6 2/3] msf2: Add EMAC block to SmartFusion2 SoC
Date: Thu, 16 Apr 2020 20:24:50 +0530
Message-Id: <1587048891-30493-3-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587048891-30493-1-git-send-email-sundeep.lkml@gmail.com>
References: <1587048891-30493-1-git-send-email-sundeep.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Subbaraya Sundeep <sundeep.lkml@gmail.com>

With SmartFusion2 Ethernet MAC model in
place this patch adds the same to SoC.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/msf2-soc.c         | 26 ++++++++++++++++++++++++--
 include/hw/arm/msf2-soc.h |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 588d643..a455b88 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -1,7 +1,7 @@
 /*
  * SmartFusion2 SoC emulation.
  *
- * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
+ * Copyright (c) 2017-2020 Subbaraya Sundeep <sundeep.lkml@gmail.com>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -35,11 +35,14 @@
 
 #define MSF2_TIMER_BASE       0x40004000
 #define MSF2_SYSREG_BASE      0x40038000
+#define MSF2_EMAC_BASE        0x40041000
 
 #define ENVM_BASE_ADDRESS     0x60000000
 
 #define SRAM_BASE_ADDRESS     0x20000000
 
+#define MSF2_EMAC_IRQ         12
+
 #define MSF2_ENVM_MAX_SIZE    (512 * KiB)
 
 /*
@@ -81,6 +84,13 @@ static void m2sxxx_soc_initfn(Object *obj)
         sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
                           TYPE_MSS_SPI);
     }
+
+    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
+                          TYPE_MSS_EMAC);
+    if (nd_table[0].used) {
+        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
+        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
+    }
 }
 
 static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -192,6 +202,19 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         g_free(bus_name);
     }
 
+    dev = DEVICE(&s->emac);
+    object_property_set_link(OBJECT(&s->emac), OBJECT(get_system_memory()),
+                             "ahb-bus", &error_abort);
+    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, MSF2_EMAC_BASE);
+    sysbus_connect_irq(busdev, 0,
+                       qdev_get_gpio_in(armv7m, MSF2_EMAC_IRQ));
+
     /* Below devices are not modelled yet. */
     create_unimplemented_device("i2c_0", 0x40002000, 0x1000);
     create_unimplemented_device("dma", 0x40003000, 0x1000);
@@ -202,7 +225,6 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("can", 0x40015000, 0x1000);
     create_unimplemented_device("rtc", 0x40017000, 0x1000);
     create_unimplemented_device("apb_config", 0x40020000, 0x10000);
-    create_unimplemented_device("emac", 0x40041000, 0x1000);
     create_unimplemented_device("usb", 0x40043000, 0x1000);
 }
 
diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index 3cfe5c7..c9cb214 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -29,6 +29,7 @@
 #include "hw/timer/mss-timer.h"
 #include "hw/misc/msf2-sysreg.h"
 #include "hw/ssi/mss-spi.h"
+#include "hw/net/msf2-emac.h"
 
 #define TYPE_MSF2_SOC     "msf2-soc"
 #define MSF2_SOC(obj)     OBJECT_CHECK(MSF2State, (obj), TYPE_MSF2_SOC)
@@ -62,6 +63,7 @@ typedef struct MSF2State {
     MSF2SysregState sysreg;
     MSSTimerState timer;
     MSSSpiState spi[MSF2_NUM_SPIS];
+    MSF2EmacState emac;
 } MSF2State;
 
 #endif
-- 
2.7.4


