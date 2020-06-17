Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67994C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342C2207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXewhp5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342C2207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR7A-0007tB-Da
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzq-000304-VZ; Wed, 17 Jun 2020 01:52:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzp-0004U7-Bp; Wed, 17 Jun 2020 01:52:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id l26so593185wme.3;
 Tue, 16 Jun 2020 22:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DU8MPmKR4oqV6/BAgGxIVSvkYzVMETNdD9pP50lGwu4=;
 b=iXewhp5I22tG5YsVKxC/7jJ3Mgcmh8c9epLwy9rdr99Aaq7CZWeCE9YekBr53OS95b
 Wxn+y8KofALB+fFm+II0XGtLXtBFd/LsKkI/LrnUQjSSOj7egWJpF6ZRuibvrFocuGGC
 2OUr7wh9651CCa4nW07jGzzjHJ5jLDlBuMn539d0gkYgR4M9U6bM7B4dZEEayFX76frY
 s9Mz2BPhqhZ0MlEbPB9H/12Ij/VdZc03owYMN3GU5itx+nRF4T6rEO54r3HVFSeOKO+h
 vNI26qEpZtjYP9j7fhMGl1XMR2c3rDj/nII/vlpdCy5u5PDaEVqU2PMx1WP+xtAA+m3H
 kefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DU8MPmKR4oqV6/BAgGxIVSvkYzVMETNdD9pP50lGwu4=;
 b=Trc4lxyN9LL88NRU5N3QmZNfuZC5aVz2k861pJ02ilnSudPefUbVgDXEPGzTAfeFbX
 FdO+SX5uNgbInX2CxX+Qw/13sS27U2XZoUhRn96q4tW4kkXk47epbZwpynmwmyctVOfE
 J3m8xqqvnN4VuGYiqN24yiJnqHw9AHR/539Ocl7TiSoS9wWaK5PIfTkY9raqWiJg4y3y
 yhjmO5YDTyw0u1QxhzUYkVQ9BIpCbSAfZjZwQQlusJ50U4itLUYDf/f2ztq0t5nUelvj
 st0c2F25h58ECUr6oLxcDsAKOGgLkjE6KU4xl12ovAXXM7TXr9sAWDpYhfNv4uMSfKaV
 DLTA==
X-Gm-Message-State: AOAM531lYeh00jygU+YwpS/Qx1TLK7H7C++NalcSC7SxSivG3zXokgOZ
 zQx5Rxn7r0KXi6cKbBHjX87WjIEn
X-Google-Smtp-Source: ABdhPJzWTNXBk4+QNKw81B7yoZ58mXSw/TZsiQIcWLcnvBrF8DxdChJNEgPDqpWM77zedkWV/Cts1g==
X-Received: by 2002:a1c:4405:: with SMTP id r5mr6976264wma.72.1592373143458;
 Tue, 16 Jun 2020 22:52:23 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d28sm3000809wrc.50.2020.06.16.22.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 22:52:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/14] hw/arm/mps2-tz: Use the ARM SBCon two-wire serial
 bus interface
Date: Wed, 17 Jun 2020 07:52:05 +0200
Message-Id: <20200617055205.3576-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617055205.3576-1-f4bug@amsat.org>
References: <20200617055205.3576-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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


