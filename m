Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC3C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78792070B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78792070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZt1T-0002LR-RM
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 03:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1iZsx4-0005i4-4L
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1iZsum-0002nh-Hw
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:43:13 -0500
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18]:58536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1iZsum-0002lm-9n
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:43:12 -0500
Received: from ramsan ([84.195.182.253]) by michel.telenet-ops.be with bizsmtp
 id Wwiu2100e5USYZQ06wiuWY; Wed, 27 Nov 2019 09:43:08 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iZsuU-0000xe-KQ; Wed, 27 Nov 2019 09:42:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1iZsuU-0004OJ-IG; Wed, 27 Nov 2019 09:42:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v3 1/7] gpiolib: Add GPIOCHIP_NAME definition
Date: Wed, 27 Nov 2019 09:42:47 +0100
Message-Id: <20191127084253.16356-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127084253.16356-1-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:110:4::f00:18
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The string literal "gpiochip" is used in several places.
Add a definition for it, and use it everywhere, to make sure everything
stays in sync.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 drivers/gpio/gpiolib-sysfs.c | 7 +++----
 drivers/gpio/gpiolib.c       | 4 ++--
 drivers/gpio/gpiolib.h       | 2 ++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index fbf6b1a0a4fae6ce..23e3d335cd543d53 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -762,10 +762,9 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 		parent = &gdev->dev;
 
 	/* use chip->base for the ID; it's already known to be unique */
-	dev = device_create_with_groups(&gpio_class, parent,
-					MKDEV(0, 0),
-					chip, gpiochip_groups,
-					"gpiochip%d", chip->base);
+	dev = device_create_with_groups(&gpio_class, parent, MKDEV(0, 0), chip,
+					gpiochip_groups, GPIOCHIP_NAME "%d",
+					chip->base);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index dce0b31f4125a6b3..c9e47620d2434983 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1419,7 +1419,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 		ret = gdev->id;
 		goto err_free_gdev;
 	}
-	dev_set_name(&gdev->dev, "gpiochip%d", gdev->id);
+	dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
 	device_initialize(&gdev->dev);
 	dev_set_drvdata(&gdev->dev, gdev);
 	if (chip->parent && chip->parent->driver)
@@ -5105,7 +5105,7 @@ static int __init gpiolib_dev_init(void)
 		return ret;
 	}
 
-	ret = alloc_chrdev_region(&gpio_devt, 0, GPIO_DEV_MAX, "gpiochip");
+	ret = alloc_chrdev_region(&gpio_devt, 0, GPIO_DEV_MAX, GPIOCHIP_NAME);
 	if (ret < 0) {
 		pr_err("gpiolib: failed to allocate char dev region\n");
 		bus_unregister(&gpio_bus_type);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index ca9bc1e4803c2979..a4a759920faa48ab 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -16,6 +16,8 @@
 #include <linux/module.h>
 #include <linux/cdev.h>
 
+#define GPIOCHIP_NAME	"gpiochip"
+
 /**
  * struct gpio_device - internal state container for GPIO devices
  * @id: numerical ID number for the GPIO chip
-- 
2.17.1


