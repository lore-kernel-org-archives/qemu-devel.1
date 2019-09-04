Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA8EC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A4F2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwAHdrV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A4F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Z8x-0002wX-Tv
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yql-0001jJ-4v
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqi-00079o-Gw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqi-00079F-61; Wed, 04 Sep 2019 13:13:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id r195so4718355wme.2;
 Wed, 04 Sep 2019 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ykU8gHuJpolHJspGCXGN29S68B/lyOH0ZSECMmtfWFc=;
 b=nwAHdrV/F312+N2AYbJx6mKzV27iers+camiq0oFZq6n1KozJ0fJanVtuGG9z4OBcV
 KcR/IZI5QcRUTDBGpR0ismGy1gPDFidpNqFvlLFyytxpDBN9MN6t20RfZ0k4yqeEmALE
 S1WJzlcRsPddON2EjlvO+YOLjsoB3Py27ok8CqYJ2mYJzXG0oSzveTHEamoTlfjRQ+24
 GC4J7DbIudF4F7FpFo0/8+csN6uOTUQuEhD0Hdy3myG0VAM21fm/iMCpNEFlZxarylY9
 bFT7SzqNdJv6USHZWWawIjCbfW72d4VcuT7CxaP+f0pa/+m6idqMuoBluSU4vswRJr37
 iOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ykU8gHuJpolHJspGCXGN29S68B/lyOH0ZSECMmtfWFc=;
 b=SPBR01v9AzQTqbbkyWPHbkOh66OXXZ+tpr/Z3ZTAvD9YF5pIHvuWCLZ60aVcUqsQJj
 wkZ+G34MQdYa5FUMUqCnmLs+G5zOH8Gj3wn0LjFaLKq+SltUq4/b7E0esALNcNql6bMw
 k/43DSpJv55z6GpMEt3/ibDZ3jd/BqK1HcrWlSQchpfKQzbknw+Q7eQFyN451QPCtK9S
 5zfYgnIi5TmCkb0FT6hbNumoyu877SuGKu+RRtZPareg1M5f9gyHAWZyovDk0Ika5XZ7
 pMDog/nY5ZUiXOhUgwhqN7OOwhp9UBK5WVXcNO0MkiZ9eTdN0SrZ9fm1plrdV0S6dsuf
 IUsw==
X-Gm-Message-State: APjAAAXhwo12l29Xw9pfV4eatzyuV08HZs+GejLxAiiMaSZOC2XX8L8T
 1n6JIELekhhPHL59zCOY0sQ=
X-Google-Smtp-Source: APXvYqz2YZDBItjO+3mfovnvKCHf5ru/BZACfoT6KRQKNbNg1WcF3u4wgMfDz8uRkX2MtTpc0t7KBA==
X-Received: by 2002:a1c:b745:: with SMTP id h66mr5243020wmf.70.1567617219090; 
 Wed, 04 Sep 2019 10:13:39 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:13 +0200
Message-Id: <20190904171315.8354-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [RFC PATCH 12/14] hw/arm/bcm2836: Add the BCM2838
 which uses a GICv2
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2838 is improvement of the BCM2837:
- Cortex-A72 instead of the A53
- peripheral block and local soc controller are mapped differently,
- GICv2
- PCIe block
- exhanced MMU to address over 4GiB of SDRAM

See https://www.raspberrypi.org/forums/viewtopic.php?t=244479&start=25
and https://patchwork.kernel.org/patch/11053097/

This patch starts mapping the GICv2 but interrupt lines are NOT
wired (yet).

This is enough to start running the Ubuntu kernel8.img from [1].

Extract the kernel with:

  $ mkdir bootpart
  $ guestfish \
      --ro \
      -a ubuntu-18.04.3-preinstalled-server-arm64+raspi4.img \
      -m /dev/sda1
  Welcome to guestfish, the guest filesystem shell for
  editing virtual machine filesystems and disk images.

  ><fs> ls /
  COPYING.linux
  LICENCE.broadcom
  System.map
  armstub8-gic.bin
  bcm2710-rpi-3-b-plus.dtb
  bcm2710-rpi-3-b.dtb
  bcm2710-rpi-cm3.dtb
  bcm2711-rpi-4-b.dtb
  bcm2837-rpi-3-b-plus.dtb
  bcm2837-rpi-3-b.dtb
  cmdline.txt
  config.txt
  fixup4.dat
  fixup4cd.dat
  fixup4db.dat
  fixup4x.dat
  kernel8.img
  overlays
  start4.elf
  start4cd.elf
  start4db.elf
  start4x.elf
  ><fs> copy-out / bootpart/
  ><fs> q

Then some progress can be noticed running:

  $ qemu-system-aarch64 -d unimp,guest_errors,int,in_asm \
      -M raspi4 \
      -kernel bootpart/kernel8.img \
      -dtb bootpart/bcm2711-rpi-4-b.dtb \
      -initrd bootpart/boot/initrd.img \
      -append \
         "earlycon=pl011,0xfe201000 console=ttyAMA0 console=tty1 loglevel=8"

Not very interesting, but it runs until configuring the GIC.
(remove 'in_asm' if too verbose).

TODO:

- wire IRQs to the GIC :)

- map the SPI bootrom from [3] (boot sequence: [4])

- per [2] we could try booting without using the GIC, adding "enable_gic=0"
  in config.txt. this variable is parsed by the firmware:

  $ fgrep -r enable_gic bootpart
  Binary file bootpart/start4x.elf matches
  Binary file bootpart/start4.elf matches
  Binary file bootpart/start4db.elf matches
  Binary file bootpart/start4cd.elf matches
  bootpart/config.txt:enable_gic=1

  the stub [5] doesn't seem to check a register for it.
  maybe it falls back to kernel7l?

- decompile start4.elf to check how 'enable_gic' is used
  using vc4 toolchain from [6]

[1] https://github.com/TheRemote/Ubuntu-Server-raspi4-unofficial/releases
[2] https://jamesachambers.com/raspberry-pi-ubuntu-server-18-04-2-installation-guide/
[3] https://www.raspberrypi.org/documentation/hardware/raspberrypi/booteeprom.md
[4] https://raspberrypi.stackexchange.com/questions/10442/what-is-the-boot-sequence
[5] https://github.com/raspberrypi/tools/commit/7f4a937e1bacbc111a22552169bc890b4bb26a94#diff-8c41083e9fa0c98f1c3015e11b897444
[6] https://github.com/christinaa/rpi-open-firmware

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c         | 75 ++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/bcm2836.h |  3 ++
 2 files changed, 78 insertions(+)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 019e67b906..d89d7cd71d 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -21,6 +21,7 @@ struct BCM283XInfo {
     const char *cpu_type;
     hwaddr peri_base; /* Peripheral base address seen by the CPU */
     hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
+    hwaddr gic_base;
     int clusterid;
 };
 
@@ -40,9 +41,25 @@ static const BCM283XInfo bcm283x_socs[] = {
         .ctrl_base = 0x40000000,
         .clusterid = 0x0,
     },
+    {
+        .name = TYPE_BCM2838,
+        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a72"),
+        .peri_base = 0xfe000000,
+        .ctrl_base = 0xff800000,
+        .gic_base = 0x40000,
+    },
 #endif
 };
 
+#define GIC_NUM_IRQS                256
+
+#define GIC_BASE_OFS                0x0000
+#define GIC_DIST_OFS                0x1000
+#define GIC_CPU_OFS                 0x2000
+#define GIC_VIFACE_THIS_OFS         0x4000
+#define GIC_VIFACE_OTHER_OFS(cpu)  (0x5000 + (cpu) * 0x200)
+#define GIC_VCPU_OFS                0x6000
+
 static void bcm2836_init(Object *obj)
 {
     BCM283XState *s = BCM283X(obj);
@@ -55,6 +72,11 @@ static void bcm2836_init(Object *obj)
                                 info->cpu_type, &error_abort, NULL);
     }
 
+    if (info->gic_base) {
+        sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
+                              TYPE_ARM_GIC);
+    }
+
     sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
                           TYPE_BCM2836_CONTROL);
 
@@ -115,6 +137,59 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
 
+    /* bcm2838 GICv2 */
+    if (info->gic_base) {
+        object_property_set_uint(OBJECT(&s->gic), 2, "revision", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_uint(OBJECT(&s->gic),
+                                 BCM283X_NCPUS, "num-cpu", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_uint(OBJECT(&s->gic),
+                                 32 + GIC_NUM_IRQS, "num-irq", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_bool(OBJECT(&s->gic),
+                                 true, "has-virtualization-extensions", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
+                        info->ctrl_base + info->gic_base + GIC_DIST_OFS);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
+                        info->ctrl_base + info->gic_base + GIC_CPU_OFS);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
+                        info->ctrl_base + info->gic_base + GIC_VIFACE_THIS_OFS);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
+                        info->ctrl_base + info->gic_base + GIC_VCPU_OFS);
+
+        for (n = 0; n < BCM283X_NCPUS; n++) {
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 4 + n,
+                            info->ctrl_base + info->gic_base
+                            + GIC_VIFACE_OTHER_OFS(n));
+        }
+
+        /* TODO wire IRQs!!! */
+    }
+
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 97187f72be..31c8fb90bd 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -13,6 +13,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/intc/bcm2836_control.h"
+#include "hw/intc/arm_gic.h"
 #include "target/arm/cpu.h"
 
 #define TYPE_BCM283X "bcm283x"
@@ -26,6 +27,7 @@
  */
 #define TYPE_BCM2836 "bcm2836"
 #define TYPE_BCM2837 "bcm2837"
+#define TYPE_BCM2838 "bcm2838"
 
 typedef struct BCM283XState {
     /*< private >*/
@@ -36,6 +38,7 @@ typedef struct BCM283XState {
     uint32_t enabled_cpus;
 
     ARMCPU cpus[BCM283X_NCPUS];
+    GICState gic;
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
 } BCM283XState;
-- 
2.20.1


