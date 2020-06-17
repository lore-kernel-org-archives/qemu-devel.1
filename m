Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA669C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA7D206F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eix3CNxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA7D206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSXB-0005GT-A1
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSO-0004zW-RT; Wed, 17 Jun 2020 03:26:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSN-0002d1-5O; Wed, 17 Jun 2020 03:26:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id x6so1116801wrm.13;
 Wed, 17 Jun 2020 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DU8MPmKR4oqV6/BAgGxIVSvkYzVMETNdD9pP50lGwu4=;
 b=Eix3CNxwea86xKwD5d6N8/pR2IerEmPmhjK8pgUjQsxt8ZN09obExvm1+3pC1FGaSj
 MGu+74L0hmv8bdz0Vx+4losLTu7M4hiXFdRUQ7MVlp8MChetasJ+AZUj9cDifqmkKo4j
 qJI0TJp7gUOPkjI4Df1hcnpHDj1u738yZVDOnTsYdeCeLWe2pFLHsLZEDRwDpQ+fjd0l
 +Vq9y1rLVpLq1SB8+6+DI3m1OR+46MuVMvWKBDIqiFrYBNz89ssR5UnaPTEtKeHfyj0u
 Ppr9pR+k8MdNV/eRIsh5Imi5JQjG5bI4Bp+f0UMaRh8JjUKjy6JxtkLQHq4jNFw/ZqYM
 RJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DU8MPmKR4oqV6/BAgGxIVSvkYzVMETNdD9pP50lGwu4=;
 b=RYBRlAHCD+oFJHG0u9wGHW/8QPIrfVC0YhJ/gEbsBd92q2OCLlTTFODo1WmNRSA3wd
 QM1gBg3du95WTdI+du5bdv/1ciej5VDES9ANmZ7VUvCSp5LDjRsm/BC7frLE1MsLZ5Q1
 VCMP7HyMWRiO3JdGgvbCRGug+8ilf/hBz67i35yAc9FLn9HGDIE7tpbzBAuuH9/+Zg4W
 8YL8tbZ9/icjmauIxUC9Yn1Y2Boh8RFF+Zd09feMDcbfIfRhltx3I1jxHkamA5U5Us0C
 72iYxYhz4OyzrD+y5svhGV/nLlwxw16N1shhuvOeQ7CCdXEkaiStUJyQ7miGyR4E+nqM
 nVlw==
X-Gm-Message-State: AOAM533t2IINoEjtEgXK8KrSa/ezELeoaJkGICV+Gh4zLB1H74Xh13Ea
 sqfNwTZ+a1YWdyBLWLlEQbtBhFG4
X-Google-Smtp-Source: ABdhPJznGPG+HQibdFDhY9nttW0+rQfFeYLozoroTJ/12yQVYKbW7YVjBFjSY1kwhbmimdBaTU/chw==
X-Received: by 2002:adf:a51a:: with SMTP id i26mr6829012wrb.406.1592378757335; 
 Wed, 17 Jun 2020 00:25:57 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/14] hw/arm/mps2-tz: Use the ARM SBCon two-wire serial
 bus interface
Date: Wed, 17 Jun 2020 09:25:39 +0200
Message-Id: <20200617072539.32686-15-f4bug@amsat.org>
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

From 'Application Note AN521', chapter 4.7:

  The SMM implements four SBCon serial modules:

  One SBCon module for use by the Color LCD touch interface.
  One SBCon module to configure the audio controller.
  Two general purpose SBCon modules, that connect to the
  Expansion headers J7 and J8, are intended for use with the
  V2C-Shield1 which provide an I2C interface on the headers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2-tz.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8155c35418..a4fd5ddede 100644
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
2.21.3


