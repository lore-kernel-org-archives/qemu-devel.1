Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59443C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA32021941
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGwwOK8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA32021941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFK9s-0000Ed-1A
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4v-0008M9-8v; Mon, 07 Sep 2020 12:33:13 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4t-0007dB-DR; Mon, 07 Sep 2020 12:33:12 -0400
Received: by mail-ed1-x544.google.com with SMTP id c8so13318869edv.5;
 Mon, 07 Sep 2020 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jBgL1iKIvz4jH+dRa8U6fT1B6oJw6/SF3dkJ8j+0tYI=;
 b=NGwwOK8a+fHGjLxYQTX0miQrbkb8sWxiahi18i6/0l6gF2OCge51BPuralxFjDtOwG
 WCR670KtplUUFKsjcCQr8P1sU9i7rgyNA5lEb+6IT9gi6Dj+I2Tx350khN+lPnGT+9jm
 C3oI9QO/O1+Ly8LcPWfLjnwig/6OuLuH0aKntPyUxpIY9q2Fssck494TxIb9sPAyt+Ov
 sOTMz4y2wWmUh6W3mLJH4TujsmMJTDU8b8GqG5wEuVteNt1JAtP6rTk9P3yTnvqbd2cj
 WsDaiEDYYWivElWw5n4lmyvTcSlCVkPvEGNJ4GUxVgPa3Qhu4QrajWR5xmGR7XFNses5
 sPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jBgL1iKIvz4jH+dRa8U6fT1B6oJw6/SF3dkJ8j+0tYI=;
 b=VR4EnWhribgHkMo4j+6jYUHUKFkVthRjAfQxVNZ6V7Jx2DJeQK05SYSY1SApP54RV6
 +yxylMpOfTd7ctxAeq7TK3zC3/o27rSRXVfazD3XzywuR24hwcC+CknOH+djDmE9T3AO
 xL1+kaHAf259cZmjCHway7Q3Zh5Xk6FezTxDMtiPwL/jf2uTesKO0K6J6SJVMXeADzQO
 pKEOoc2kzUPmjKYMN5xdrr2Lte9DxVaFt53AiQis/lH57N5Is2GZ6Wok+b7icbT2GD6g
 3RMX8fQjeYVgAYb2uUz4xXsL0gAptFAw4BYmPZTVJuQcUQioxtC219kCpETPe7qVTS3r
 EVPQ==
X-Gm-Message-State: AOAM530lzsbHSSApmjtKqKRn1hX6NQPt3Yfo/E/Ef4UwHpXOE+hQ8deI
 nTieUgxVSIdaX5kLf5LwGvDdnb41g5c=
X-Google-Smtp-Source: ABdhPJzLqAShOBauj9CSuC2lWda9KUiMdypw8ZqnFRsq/c1VE1GLiZkhjn3SOr7dgMJjd13xiI7RlQ==
X-Received: by 2002:a05:6402:b68:: with SMTP id
 cb8mr4902112edb.350.1599496389494; 
 Mon, 07 Sep 2020 09:33:09 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u13sm15700199ejn.82.2020.09.07.09.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:33:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/8] hw/misc/mps2-scc: Use the LED device
Date: Mon,  7 Sep 2020 18:32:55 +0200
Message-Id: <20200907163257.46527-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907163257.46527-1-f4bug@amsat.org>
References: <20200907163257.46527-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Luc Michel <luc.michel@greensocs.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the 'ARM MPS2 and MPS2+ FPGA Prototyping Boards Technical
Reference Manual' (100112_0200_07_en):

  2.1  Overview of the MPS2 and MPS2+ hardware

       The MPS2 and MPS2+ FPGA Prototyping Boards contain the
       following components and interfaces:

       * User switches and user LEDs:

         - Two green LEDs and two push buttons that connect to
           the FPGA.
         - Eight green LEDs and one 8-way dip switch that connect
           to the MCC.

Add the 8 LEDs connected to the MCC.

This remplaces the 'mps2_scc_leds' trace events by the generic
'led_set_intensity' event.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
https://youtu.be/l9kD70uPchk?t=288
---
 include/hw/misc/mps2-scc.h |  2 ++
 hw/misc/mps2-scc.c         | 25 ++++++++++++++-----------
 hw/misc/Kconfig            |  1 +
 hw/misc/trace-events       |  1 -
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/hw/misc/mps2-scc.h b/include/hw/misc/mps2-scc.h
index 7045473788b..8542f384227 100644
--- a/include/hw/misc/mps2-scc.h
+++ b/include/hw/misc/mps2-scc.h
@@ -13,6 +13,7 @@
 #define MPS2_SCC_H
 
 #include "hw/sysbus.h"
+#include "hw/misc/led.h"
 
 #define TYPE_MPS2_SCC "mps2-scc"
 #define MPS2_SCC(obj) OBJECT_CHECK(MPS2SCC, (obj), TYPE_MPS2_SCC)
@@ -25,6 +26,7 @@ typedef struct {
 
     /*< public >*/
     MemoryRegion iomem;
+    LEDState *led[8];
 
     uint32_t cfg0;
     uint32_t cfg1;
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 9d0909e7b35..745505b849d 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -20,11 +20,13 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
+#include "hw/misc/led.h"
 #include "hw/qdev-properties.h"
 
 REG32(CFG0, 0)
@@ -152,18 +154,10 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
         s->cfg0 = value;
         break;
     case A_CFG1:
-        /* CFG1 bits [7:0] control the board LEDs. We don't currently have
-         * a mechanism for displaying this graphically, so use a trace event.
-         */
-        trace_mps2_scc_leds(value & 0x80 ? '*' : '.',
-                            value & 0x40 ? '*' : '.',
-                            value & 0x20 ? '*' : '.',
-                            value & 0x10 ? '*' : '.',
-                            value & 0x08 ? '*' : '.',
-                            value & 0x04 ? '*' : '.',
-                            value & 0x02 ? '*' : '.',
-                            value & 0x01 ? '*' : '.');
         s->cfg1 = value;
+        for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
+            led_set_state(s->led[i], extract32(value, i, 1));
+        }
         break;
     case A_CFGDATA_OUT:
         s->cfgdata_out = value;
@@ -245,10 +239,19 @@ static void mps2_scc_init(Object *obj)
 
     memory_region_init_io(&s->iomem, obj, &mps2_scc_ops, s, "mps2-scc", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
+
 }
 
 static void mps2_scc_realize(DeviceState *dev, Error **errp)
 {
+    MPS2SCC *s = MPS2_SCC(dev);
+
+    for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
+        char *name = g_strdup_printf("SCC LED%zu", i);
+        s->led[i] = led_create_simple(OBJECT(dev), GPIO_POLARITY_ACTIVE_HIGH,
+                                      LED_COLOR_GREEN, name);
+        g_free(name);
+    }
 }
 
 static const VMStateDescription mps2_scc_vmstate = {
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 0cecad45aad..7557a3e7b46 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,6 +97,7 @@ config MPS2_FPGAIO
 
 config MPS2_SCC
     bool
+    select LED
 
 config TZ_MPC
     bool
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 43b9e0cf250..a620a358feb 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -85,7 +85,6 @@ aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64
 mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_scc_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_scc_reset(void) "MPS2 SCC: reset"
-mps2_scc_leds(char led7, char led6, char led5, char led4, char led3, char led2, char led1, char led0) "MPS2 SCC LEDs: %c%c%c%c%c%c%c%c"
 mps2_scc_cfg_write(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config write: function %d device %d data 0x%" PRIx32
 mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config read: function %d device %d data 0x%" PRIx32
 
-- 
2.26.2


