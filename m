Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E8BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADB02072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6q5G+4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADB02072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhrJ-0005UV-A7
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHU-0003de-RI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:40:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHN-0003TU-Kg
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id f18so2854103wml.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=32ydQvoqd2RGUyvJM88qaq2rPeJ++f/3bS2LA96loH4=;
 b=a6q5G+4wTLzlZu3yG8SB9vJ4picfdgn0b8gLUzybHTshXFZ+0PExe2yoVlRhg2bF7v
 o4Kc/pmKTsWENEY6KDkj10PTqtqXzwgGC0nMHwTARIzZptm84FGOghou2TaqdY39vP/s
 8yPeSb6C0Uq0ifE+x4lPZGn9kFfH0PBB8uAbP58i9CWR3006qIjDoBqKQIIuIygzGR6M
 2dgkW//Hy+z5ZVHPYg/lwlKidjoaZNusAF+aLMT9AClbjSCyFSMT/nYYhMdc+L0j7r5u
 uX9Myrb0fzH+8f8Sf962tQ/TGkftwgE9cMHXTh6jqU5PdX8dDtOHHHPXeBkXh1ByJOdI
 lEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=32ydQvoqd2RGUyvJM88qaq2rPeJ++f/3bS2LA96loH4=;
 b=cjcIibXxPVGBM7nv6ySnxK6wQ0BNTJOPCr/MfJ6R3SX0AXHTZLwY3Sx4kHak7PJV0T
 KfT88xPvQGFat8k40XbwI6UdNQR1k3vZpt2AoK0Jcl+GM6lQwJyvhqVU1DmLwJhqGJtJ
 zbPyXW7gPbHYZOyaOr8CesJLlA1g4Bl4tm6/vtfUGeDbo2aDexlPyu1PHkqfMUA1Ff01
 dGvHl57ryiePhAd+kzUoOSkcfkCgRIcsOt3l/2/1UOhadMqbLSBcU6tfDziuEpbua0Md
 m3D06fIM5dOHWnWsnyizHYv9MLv1NdBN7aiYZBgZQS7hksokp1TqmTwlfuDJAuSXW0/s
 6XkA==
X-Gm-Message-State: AOAM533i7YKE8mkRpjtMoJohjaPEdkmZubYY17ZbBdbFIxqRUiU4bRde
 UHEEs9yugIOc1l7cf+EWdBomYYzC3AMJTw==
X-Google-Smtp-Source: ABdhPJw74bFjM4ZfPsUnXpidLKhbskLZqlmlwtY38ZAkmaSdjeFgSkgRP/uDX+1F/53Iy0UTp/dKoQ==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr10373014wmc.188.1592912391245; 
 Tue, 23 Jun 2020 04:39:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/42] hw/arm/mps2-tz: Use the ARM SBCon two-wire serial bus
 interface
Date: Tue, 23 Jun 2020 12:39:01 +0100
Message-Id: <20200623113904.28805-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From 'Application Note AN521', chapter 4.7:

  The SMM implements four SBCon serial modules:

  One SBCon module for use by the Color LCD touch interface.
  One SBCon module to configure the audio controller.
  Two general purpose SBCon modules, that connect to the
  Expansion headers J7 and J8, are intended for use with the
  V2C-Shield1 which provide an I2C interface on the headers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-15-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8155c35418d..a4fd5ddede7 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -58,6 +58,7 @@
 #include "hw/arm/armsse.h"
 #include "hw/dma/pl080.h"
 #include "hw/ssi/pl022.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/core/split-irq.h"
@@ -87,7 +88,7 @@ typedef struct {
     TZPPC ppc[5];
     TZMPC ssram_mpc[3];
     PL022State spi[5];
-    UnimplementedDeviceState i2c[4];
+    ArmSbconI2CState i2c[4];
     UnimplementedDeviceState i2s_audio;
     UnimplementedDeviceState gpio[4];
     UnimplementedDeviceState gfx;
@@ -365,6 +366,18 @@ static MemoryRegion *make_spi(MPS2TZMachineState *mms, void *opaque,
     return sysbus_mmio_get_region(s, 0);
 }
 
+static MemoryRegion *make_i2c(MPS2TZMachineState *mms, void *opaque,
+                              const char *name, hwaddr size)
+{
+    ArmSbconI2CState *i2c = opaque;
+    SysBusDevice *s;
+
+    object_initialize_child(OBJECT(mms), name, i2c, TYPE_ARM_SBCON_I2C);
+    s = SYS_BUS_DEVICE(i2c);
+    sysbus_realize(s, &error_fatal);
+    return sysbus_mmio_get_region(s, 0);
+}
+
 static void mps2tz_common_init(MachineState *machine)
 {
     MPS2TZMachineState *mms = MPS2TZ_MACHINE(machine);
@@ -499,10 +512,10 @@ static void mps2tz_common_init(MachineState *machine)
                 { "uart2", make_uart, &mms->uart[2], 0x40202000, 0x1000 },
                 { "uart3", make_uart, &mms->uart[3], 0x40203000, 0x1000 },
                 { "uart4", make_uart, &mms->uart[4], 0x40204000, 0x1000 },
-                { "i2c0", make_unimp_dev, &mms->i2c[0], 0x40207000, 0x1000 },
-                { "i2c1", make_unimp_dev, &mms->i2c[1], 0x40208000, 0x1000 },
-                { "i2c2", make_unimp_dev, &mms->i2c[2], 0x4020c000, 0x1000 },
-                { "i2c3", make_unimp_dev, &mms->i2c[3], 0x4020d000, 0x1000 },
+                { "i2c0", make_i2c, &mms->i2c[0], 0x40207000, 0x1000 },
+                { "i2c1", make_i2c, &mms->i2c[1], 0x40208000, 0x1000 },
+                { "i2c2", make_i2c, &mms->i2c[2], 0x4020c000, 0x1000 },
+                { "i2c3", make_i2c, &mms->i2c[3], 0x4020d000, 0x1000 },
             },
         }, {
             .name = "apb_ppcexp2",
-- 
2.20.1


