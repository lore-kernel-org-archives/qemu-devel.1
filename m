Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D65D20702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uixN0IGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D65D20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9AxZ-0005OU-QK
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArD-0001Xe-SD; Fri, 21 Aug 2020 13:29:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArC-0001Cq-6l; Fri, 21 Aug 2020 13:29:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so2682176wrw.1;
 Fri, 21 Aug 2020 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Dd44R7OJJJDfs5YP/o1IXlGifzo41VurSE267jt/Qo=;
 b=uixN0IGA9f5HhwbE+r28ZLzMQM119tsozjO7Rrom6I9Sg6S64ypFoEIlp6W9lCBR9M
 pxbU8bv8A3AyUOHq4+4Fzg0axw3BLuWE2NgSWRQE5y7P6XDX165EXlShFhbdW87LLgs1
 Fk/G2Y26V5iMix7ig8oTrdiDuCXxnpcQ0yaAQ869gLtWAUAu511oHTs1uUNRIOs5JW0W
 7UIJvAgk8K0dgzliBTWZDl/IVY1V1u6o5fINQojuyFyJa7W2RJ1+MUhC+/NFB42XNB0T
 THKE5fCSGU1CSjSUFqfHvrSlgyBcM0Vx3uIz2fjbBvUSpuOf0022Wa3yuAND9NxpRiAf
 /d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0Dd44R7OJJJDfs5YP/o1IXlGifzo41VurSE267jt/Qo=;
 b=UswyQHKHKRqlqrQWHOUpLBDnTAGZKFebpnRAf2nfUmu6H555fE2cXD2B9phEyPhqEE
 gaKG+ifaMgIq2xJRHewzOdeyc+1MgHQrvGsz6dgutFUR4KATOxB3QGY0d0kQ/dz/VgPl
 Hl7UXwSMccqnjDj7as3rcMHTEi3rmpHCZpfmsOHXirdo37/Utmy/TUpWZJxRQyw+gjbu
 3sf7QEtRpZDy/kEejyu3gwP88osJ5iRCxsnX16DdaUTOw1AOAIwECDVvcDIUptwEVTza
 1HDdfTnKnOgksxJS8Sy83X2dKA5ew+xu/9lsdzgOA5Oi/jt/oY1+wzWhZcVybyuL5C1k
 wjAQ==
X-Gm-Message-State: AOAM530/0B1iUpmrr/Mw81wD4VyQTZongB0/Bv/G4elgfNGSw5zAna7m
 v/yh4Ad5SE1KwoeqxRvOi2MlsNGeJYI=
X-Google-Smtp-Source: ABdhPJxT3XyIVRf9ma2mA0aLGLaGPNCGAa9b7Uyw77r1ZFQAqJR/bYlqhnnBGRIJMdvt1r9vcsVpGA==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr3479004wrq.85.1598030975685; 
 Fri, 21 Aug 2020 10:29:35 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/23] hw/sd/pl181: Do not create SD card within the SD host
 controller
Date: Fri, 21 Aug 2020 19:29:04 +0200
Message-Id: <20200821172916.1260954-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SD/MMC host controllers provide a SD Bus to plug SD cards,
but don't come with SD card plugged in :) Let the machine/board
model create and plug the SD cards when required.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200705204630.4133-8-f4bug@amsat.org>
---
 hw/arm/integratorcp.c | 13 +++++++++++++
 hw/arm/realview.c     | 12 ++++++++++++
 hw/arm/versatilepb.c  | 26 ++++++++++++++++++++++++--
 hw/arm/vexpress.c     | 11 +++++++++++
 hw/sd/pl181.c         | 19 +------------------
 5 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 16c4d750a4f..fe7c2b9d4b1 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -25,6 +25,7 @@
 #include "hw/char/pl011.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/sd/sd.h"
 
 #define TYPE_INTEGRATOR_CM "integrator_core"
 #define INTEGRATOR_CM(obj) \
@@ -595,6 +596,7 @@ static void integratorcp_init(MachineState *machine)
     MemoryRegion *ram_alias = g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     DeviceState *dev, *sic, *icp;
+    DriveInfo *dinfo;
     int i;
 
     cpuobj = object_new(machine->cpu_type);
@@ -649,6 +651,17 @@ static void integratorcp_init(MachineState *machine)
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT, 0));
     qdev_connect_gpio_out_named(dev, "card-inserted", 0,
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDIN, 0));
+    dinfo = drive_get_next(IF_SD);
+    if (dinfo) {
+        DeviceState *card;
+
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
+                               &error_fatal);
+    }
+
     sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
 
     if (nd_table[0].used)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 3e2360c261f..5f1f36b15cd 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -27,6 +27,7 @@
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
+#include "hw/sd/sd.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
@@ -69,6 +70,7 @@ static void realview_init(MachineState *machine,
     qemu_irq mmc_irq[2];
     PCIBus *pci_bus = NULL;
     NICInfo *nd;
+    DriveInfo *dinfo;
     I2CBus *i2c;
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
@@ -236,6 +238,16 @@ static void realview_init(MachineState *machine,
         qemu_irq_invert(qdev_get_gpio_in(gpio2, 0)));
     qdev_connect_gpio_out_named(dev, "card-read-only", 0, mmc_irq[0]);
     qdev_connect_gpio_out_named(dev, "card-inserted", 0, mmc_irq[1]);
+    dinfo = drive_get_next(IF_SD);
+    if (dinfo) {
+        DeviceState *card;
+
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
+                               &error_fatal);
+    }
 
     sysbus_create_simple("pl031", 0x10017000, pic[10]);
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 9dc93182b6b..9127579984f 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -25,6 +25,7 @@
 #include "hw/block/flash.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
+#include "hw/sd/sd.h"
 
 #define VERSATILE_FLASH_ADDR 0x34000000
 #define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
@@ -309,8 +310,29 @@ static void versatile_init(MachineState *machine, int board_id)
     /* Wire up the mux control signals from the SYS_CLCD register */
     qdev_connect_gpio_out(sysctl, 0, qdev_get_gpio_in(dev, 0));
 
-    sysbus_create_varargs("pl181", 0x10005000, sic[22], sic[1], NULL);
-    sysbus_create_varargs("pl181", 0x1000b000, sic[23], sic[2], NULL);
+    dev = sysbus_create_varargs("pl181", 0x10005000, sic[22], sic[1], NULL);
+    dinfo = drive_get_next(IF_SD);
+    if (dinfo) {
+        DeviceState *card;
+
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
+                               &error_fatal);
+    }
+
+    dev = sysbus_create_varargs("pl181", 0x1000b000, sic[23], sic[2], NULL);
+    dinfo = drive_get_next(IF_SD);
+    if (dinfo) {
+        DeviceState *card;
+
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
+                               &error_fatal);
+    }
 
     /* Add PL031 Real Time Clock. */
     sysbus_create_simple("pl031", 0x101e8000, pic[10]);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 049a0ec2c73..95405f59408 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -43,6 +43,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
+#include "hw/sd/sd.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
@@ -628,6 +629,16 @@ static void vexpress_common_init(MachineState *machine)
                           qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_WPROT));
     qdev_connect_gpio_out_named(dev, "card-inserted", 0,
                           qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_CARDIN));
+    dinfo = drive_get_next(IF_SD);
+    if (dinfo) {
+        DeviceState *card;
+
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
+                               &error_fatal);
+    }
 
     sysbus_create_simple("pl050_keyboard", map[VE_KMI0], pic[12]);
     sysbus_create_simple("pl050_mouse", map[VE_KMI1], pic[13]);
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index f6de06ece82..f69488ebac3 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -17,7 +17,6 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/qdev-properties.h"
 
 //#define DEBUG_PL181 1
 
@@ -518,30 +517,14 @@ static void pl181_init(Object *obj)
                         TYPE_PL181_BUS, dev, "sd-bus");
 }
 
-static void pl181_realize(DeviceState *dev, Error **errp)
-{
-    DeviceState *card;
-    DriveInfo *dinfo;
-
-    /* FIXME use a qdev drive property instead of drive_get_next() */
-    card = qdev_new(TYPE_SD_CARD);
-    dinfo = drive_get_next(IF_SD);
-    qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
-                            &error_fatal);
-    qdev_realize_and_unref(card,
-                           qdev_get_child_bus(dev, "sd-bus"),
-                           &error_fatal);
-}
-
 static void pl181_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
 
     k->vmsd = &vmstate_pl181;
     k->reset = pl181_reset;
-    /* Reason: init() method uses drive_get_next() */
+    /* Reason: output IRQs should be wired up */
     k->user_creatable = false;
-    k->realize = pl181_realize;
 }
 
 static const TypeInfo pl181_info = {
-- 
2.26.2


