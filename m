Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63927CA9EB3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CC721D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TddYRqK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CC721D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEsO-0003Ns-B2
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 19:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEiw-0000pU-UB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEiu-0002Sd-Sb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEiu-0002SI-KW; Thu, 17 Oct 2019 18:58:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id p14so4144721wro.4;
 Thu, 17 Oct 2019 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A6i2oQoY030V1ibxvwKbd3JNI8/xljifPg8xnDM8bpc=;
 b=TddYRqK4pjYaWEwXdwK/nje98MV+a6JTtudrFNjsb4T+3M55bMOmvtxtX4h5FFOP5Y
 MFoDX655F+PPaDV5FbvYlInrXYk8/gSu932XViyQM3VU8XCqEKBZGiRIcNQPvLeOtKWu
 LIddyIvpLizpBh16pTqvlauv37qUuJLVFSI9RmQjvn/nmwl9jZ2R7wM3LgwCJyxth5lc
 N6kZljLn6c9IAJGlfWYB6WVbbqlCia8BvcBtuG+CaM8NIxd3QMvYPjTyoflWl0eC5Jpw
 t7viHR55f05XsVJ2vpf8O7WIvMph779bBPVUmZ1qYrRRp7KZ2SFncdkFTD2FO8kELRE8
 BVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=A6i2oQoY030V1ibxvwKbd3JNI8/xljifPg8xnDM8bpc=;
 b=inXNxvi4232pG8EjopwpUsw8ZaElj4NJ7Lav47SupleUBH22ekXbCkGregpam0nqPM
 +LQBvWi/JaV4/9FtGVwkUMf22vab2DDs6NrwOoNxzfhBUF8WYDU5lQrM6CDLRVCA6iwZ
 OdaXhECAt10PhfWAlzXulgMPZSOc4MILwyeQVWxq1r/kZAG2fo8Cy5m3g1dzUWkhffAW
 Fr9ANkSBwKApgtxJpZd4DKX3y1b0bYOk7wpEDzOJaiR+QooXtH84bLsY9a501zUSe5Zj
 S/4pf+fW4rApBivEfcvNcxAYwGNOSaNJeFiZhSADaXFCy+15YkuMC9Lc67gPXpbqSpAt
 xqsQ==
X-Gm-Message-State: APjAAAXTlVu0cOh3PbWElim4FiGuU8Whqa7n4r4ccphicMbMIZmLXVsN
 ARPD5SlTJc4q5+Hgi/o5SDz3xNQv
X-Google-Smtp-Source: APXvYqyixix39WThzTRntJ5RlrVJoTugbcHCzaH5/4FNWfKk4nigfS5QZMBzQFv2D3CXIA+EDfbPvg==
X-Received: by 2002:a05:6000:11d2:: with SMTP id
 i18mr5204364wrx.109.1571353103049; 
 Thu, 17 Oct 2019 15:58:23 -0700 (PDT)
Received: from localhost.localdomain (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id m18sm3993873wrg.97.2019.10.17.15.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 15:58:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/10] hw/arm/bcm2836: Use per CPU address spaces
Date: Fri, 18 Oct 2019 00:57:57 +0200
Message-Id: <20191017225800.6946-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017225800.6946-1-f4bug@amsat.org>
References: <20191017225800.6946-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Pekka Enberg <penberg@iki.fi>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently all CPUs access the main system bus. Let each CPU have
his own address space.

Before:

  address-space: cpu-secure-memory-0
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-000000003fffffff (prio 0, ram): ram
      000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
        000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-timer
        000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
        000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
        000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp804
        000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
        000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprman
        000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
        000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
        000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
        000000003f201000-000000003f201fff (prio 0, i/o): pl011
        000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
        000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
        000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
        000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
        000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
        000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
        000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
        000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
        000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
        000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
        000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
        000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
        000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
        000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
        000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
        000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdramc
        000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15
      0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control

  address-space: cpu-memory-0
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-000000003fffffff (prio 0, ram): ram
      000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
        000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-timer
        000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
        000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
        000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp804
        000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
        000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprman
        000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
        000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
        000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
        000000003f201000-000000003f201fff (prio 0, i/o): pl011
        000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
        000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
        000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
        000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
        000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
        000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
        000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
        000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
        000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
        000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
        000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
        000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
        000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
        000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
        000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
        000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdramc
        000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15
      0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control

  memory-region: bcm2835-peripherals
    000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
      000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-timer
      000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
      000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
      000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp804
      000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
      000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprman
      000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
      000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
      000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
      000000003f201000-000000003f201fff (prio 0, i/o): pl011
      000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
      000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
      000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
      000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
      000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
      000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
      000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
      000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
      000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
      000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
      000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
      000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
      000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
      000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
      000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
      000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdramc
      000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15

After:

  address-space: cpu-secure-memory-0
    0000000000000000-00000000ffffffff (prio 0, i/o): cpu-bus
      0000000000000000-000000003fffffff (prio 1, i/o): alias arm-ram-alias @ram 0000000000000000-000000003fffffff
      000000003f000000-000000003fffffff (prio 2, i/o): alias arm-peripherals-alias @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000040000000-0000000040003fff (prio 2, i/o): alias arm-control-alias @bcm2836-control 0000000000000000-0000000000003fff

  address-space: cpu-memory-0
    0000000000000000-00000000ffffffff (prio 0, i/o): cpu-bus
      0000000000000000-000000003fffffff (prio 1, i/o): alias arm-ram-alias @ram 0000000000000000-000000003fffffff
      000000003f000000-000000003fffffff (prio 2, i/o): alias arm-peripherals-alias @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000040000000-0000000040003fff (prio 2, i/o): alias arm-control-alias @bcm2836-control 0000000000000000-0000000000003fff

  memory-region: bcm2835-peripherals
    0000000000000000-0000000000ffffff (prio 0, i/o): bcm2835-peripherals
      0000000000003000-000000000000301f (prio 0, i/o): bcm2835-sys-timer
      0000000000007000-0000000000007fff (prio 0, i/o): bcm2835-dma
      000000000000b200-000000000000b3ff (prio 0, i/o): bcm2835-ic
      000000000000b400-000000000000b43f (prio -1000, i/o): bcm2835-sp804
      000000000000b800-000000000000bbff (prio 0, i/o): bcm2835-mbox
      0000000000100000-0000000000100fff (prio -1000, i/o): bcm2835-cprman
      0000000000102000-0000000000102fff (prio -1000, i/o): bcm2835-a2w
      0000000000104000-000000000010400f (prio 0, i/o): bcm2835-rng
      0000000000200000-0000000000200fff (prio 0, i/o): bcm2835_gpio
      0000000000201000-0000000000201fff (prio 0, i/o): pl011
      0000000000202000-0000000000202fff (prio 0, i/o): bcm2835-sdhost
      0000000000203000-00000000002030ff (prio -1000, i/o): bcm2835-i2s
      0000000000204000-000000000020401f (prio -1000, i/o): bcm2835-spi0
      0000000000205000-000000000020501f (prio -1000, i/o): bcm2835-i2c0
      000000000020f000-000000000020f07f (prio -1000, i/o): bcm2835-otp
      0000000000212000-0000000000212007 (prio 0, i/o): bcm2835-thermal
      0000000000214000-00000000002140ff (prio -1000, i/o): bcm2835-spis
      0000000000215000-00000000002150ff (prio 0, i/o): bcm2835-aux
      0000000000300000-00000000003000ff (prio 0, i/o): sdhci
      0000000000600000-00000000006000ff (prio -1000, i/o): bcm2835-smi
      0000000000804000-000000000080401f (prio -1000, i/o): bcm2835-i2c1
      0000000000805000-000000000080501f (prio -1000, i/o): bcm2835-i2c2
      0000000000900000-0000000000907fff (prio -1000, i/o): bcm2835-dbus
      0000000000910000-0000000000917fff (prio -1000, i/o): bcm2835-ave0
      0000000000980000-0000000000980fff (prio -1000, i/o): dwc-usb2
      0000000000e00000-0000000000e000ff (prio -1000, i/o): bcm2835-sdramc
      0000000000e05000-0000000000e050ff (prio 0, i/o): bcm2835-dma-chan15

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c         | 38 ++++++++++++++++++++++++++++++++------
 hw/arm/raspi.c           |  2 --
 include/hw/arm/bcm2836.h |  8 +++++++-
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index d712f36052..36742af403 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -70,6 +70,8 @@ static void bcm2836_init(Object *obj)
     }
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
+        memory_region_init(&s->cpu[n].container_mr, obj, "cpu-bus", 4 * GiB);
+
         object_initialize_child(obj, "cpu[*]", &s->cpus[n], sizeof(s->cpus[n]),
                                 info->cpu_type, &error_abort, NULL);
     }
@@ -90,7 +92,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     BCM283XState *s = BCM283X(dev);
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     const BCM283XInfo *info = bc->info;
-    MemoryRegion *ram_mr, *peri_mr;
+    MemoryRegion *ram_mr, *peri_mr, *ctrl_mr;
     Object *obj;
     Error *err = NULL;
     int n;
@@ -142,8 +144,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
-                            info->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
@@ -151,15 +151,41 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
-
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
+    ctrl_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->control), 0);
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
+        memory_region_init_alias(&s->cpu[n].ram_mr_alias, OBJECT(s),
+                                 "arm-ram-alias", ram_mr, 0,
+                                 memory_region_size(ram_mr));
+        memory_region_add_subregion_overlap(&s->cpu[n].container_mr, 0,
+                                            &s->cpu[n].ram_mr_alias, 1);
+
+        memory_region_init_alias(&s->cpu[n].peri_mr_alias, OBJECT(s),
+                                 "arm-peripherals-alias",
+                                 peri_mr, 0, 16 * MiB);
+        memory_region_add_subregion_overlap(&s->cpu[n].container_mr,
+                                            info->peri_base,
+                                            &s->cpu[n].peri_mr_alias, 2);
+
+        memory_region_init_alias(&s->cpu[n].control_mr_alias, OBJECT(s),
+                                 "arm-control-alias", ctrl_mr,
+                                 0, 16 * KiB);
+        memory_region_add_subregion_overlap(&s->cpu[n].container_mr,
+                                            info->ctrl_base,
+                                            &s->cpu[n].control_mr_alias, 2);
+
+        object_property_set_link(OBJECT(&s->cpus[n]),
+                                 OBJECT(&s->cpu[n].container_mr),
+                                 "memory", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
         /* TODO: this should be converted to a property of ARM_CPU */
         s->cpus[n].mp_affinity = (info->clusterid << 8) | n;
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 615d755879..a12459bc41 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -184,8 +184,6 @@ static void raspi_init(MachineState *machine, int version)
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
                                          machine->ram_size);
-    /* FIXME: Remove when we have custom CPU address space support */
-    memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0);
 
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index a26bf895a4..af4c60dbad 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -37,9 +37,15 @@ typedef struct BCM283XState {
 
     struct {
         MemoryRegion mr[4];
-        MemoryRegion peri_mr_alias;
         MemoryRegion ram_mr_alias;
+        MemoryRegion peri_mr_alias;
     } videocore;
+    struct {
+        MemoryRegion container_mr;
+        MemoryRegion ram_mr_alias;
+        MemoryRegion peri_mr_alias;
+        MemoryRegion control_mr_alias;
+    } cpu[BCM283X_NCPUS];
     ARMCPU cpus[BCM283X_NCPUS];
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
-- 
2.21.0


