Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B4DC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCB820724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6bVa01R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCB820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBbr-0003Dn-S7
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 16:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBX8-0004aN-69; Sun, 05 Jul 2020 16:46:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBX6-0000pZ-KP; Sun, 05 Jul 2020 16:46:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id a6so38743220wrm.4;
 Sun, 05 Jul 2020 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zq4O1k2rwycdf6oHiRxmb0Ixv9secgC8eTrxhU7dpKo=;
 b=a6bVa01RQg54e9WoT8RxKoP2OUMpe6C2Hlq175437gpJRF6SloXA3HlnxvVu0Qy+VA
 wPLtHF0y6MrasjQ2bRjvg7JRmjLru338nzgvME9gmd9pLWBl4Cby3I8XyYXg008s+ZbQ
 3oc581IYc80164snEnWu/24rkEw/JVaX1XoJ7cxelexuQEg5CfbUAP59pTEBHFC36kVr
 mKhF82yEaHer4R70u1JKATosgn+NY3GpaxehNj0pHpSi6P0q0iT7UcScpYGZYKuguSr9
 BwBxvW0cFjsb0I0tU0rfbwL+jyOxF/iTm999U9mO4G4p7bCYxvb4FQ81UjApVyARGILr
 xDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zq4O1k2rwycdf6oHiRxmb0Ixv9secgC8eTrxhU7dpKo=;
 b=gth8BPUkhh0EFpI9oy41M4HPGnuQ+4uaJCnv9b9KLNSREJXBi/cteySQiJkYuApbDX
 qHJcELN2urDEu8CcX68vLRlJEYs8NZPfR27llOHQjEpxvMVwBTSKhin8Zmk+jadJCusC
 p/Mr21iCO0+eVaNy2SdzwNW907hCAiwxGRgDEbNyF7OPs72OKPeQ16PpJKwK/+MzpPUo
 1dCLj3ez4xXO+VASe6fHXj5/ILX69wYS05aFzD9DjTrGEryGdXbKUUR+uw2e43JJa5gp
 yzZgq9Sqf7qvmKW2kSu16EJWeOcVgDIh/40Kt3NbrIAQDgcZDKbo4Md2avR5eUKJ4Bua
 34TQ==
X-Gm-Message-State: AOAM5327bjriy+VGa99mpWZ9idBulXCHxQgCB4KquejdfYBHEm733EmP
 AtU8OeQ2VNR3OtBmdckRxfNUk/5O8yo=
X-Google-Smtp-Source: ABdhPJzQ2mrD/Thmxb1UJHEdD7k1yejLIcEpzcv3Mi6zCcEg9NVNEOD0zA9yK94giT7FI84MVzzZCQ==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr48531843wrq.351.1593981998684; 
 Sun, 05 Jul 2020 13:46:38 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g144sm51397817wme.2.2020.07.05.13.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 13:46:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/10] hw/sd/pl181: Use named GPIOs
Date: Sun,  5 Jul 2020 22:46:25 +0200
Message-Id: <20200705204630.4133-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705204630.4133-1-f4bug@amsat.org>
References: <20200705204630.4133-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make the code easier to manage/review/use, rename the
cardstatus[0] variable as 'card_readonly' and name the GPIO
"card-read-only".
Similarly with cardstatus[1], renamed as 'card_inserted' and
name its GPIO "card-inserted".

Adapt the users accordingly by using the qdev_init_gpio_out_named()
function.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/integratorcp.c | 4 ++--
 hw/arm/realview.c     | 4 ++--
 hw/arm/vexpress.c     | 4 ++--
 hw/sd/pl181.c         | 8 +++++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b11a846355..2595e4d052 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -645,9 +645,9 @@ static void integratorcp_init(MachineState *machine)
     sysbus_create_simple(TYPE_INTEGRATOR_DEBUG, 0x1a000000, 0);
 
     dev = sysbus_create_varargs("pl181", 0x1c000000, pic[23], pic[24], NULL);
-    qdev_connect_gpio_out(dev, 0,
+    qdev_connect_gpio_out_named(dev, "card-read-only", 0,
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT, 0));
-    qdev_connect_gpio_out(dev, 1,
+    qdev_connect_gpio_out_named(dev, "card-inserted", 0,
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDIN, 0));
     sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b6c0a1adb9..8dc5f77139 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -234,8 +234,8 @@ static void realview_init(MachineState *machine,
     mmc_irq[1] = qemu_irq_split(
         qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_CARDIN),
         qemu_irq_invert(qdev_get_gpio_in(gpio2, 0)));
-    qdev_connect_gpio_out(dev, 0, mmc_irq[0]);
-    qdev_connect_gpio_out(dev, 1, mmc_irq[1]);
+    qdev_connect_gpio_out_named(dev, "card-read-only", 0, mmc_irq[0]);
+    qdev_connect_gpio_out_named(dev, "card-inserted", 0, mmc_irq[1]);
 
     sysbus_create_simple("pl031", 0x10017000, pic[10]);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5bf9cff8a8..16629d6599 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -624,9 +624,9 @@ static void vexpress_common_init(MachineState *machine)
 
     dev = sysbus_create_varargs("pl181", map[VE_MMCI], pic[9], pic[10], NULL);
     /* Wire up MMC card detect and read-only signals */
-    qdev_connect_gpio_out(dev, 0,
+    qdev_connect_gpio_out_named(dev, "card-read-only", 0,
                           qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_WPROT));
-    qdev_connect_gpio_out(dev, 1,
+    qdev_connect_gpio_out_named(dev, "card-inserted", 0,
                           qdev_get_gpio_in(sysctl, ARM_SYSCTL_GPIO_MMC_CARDIN));
 
     sysbus_create_simple("pl050_keyboard", map[VE_KMI0], pic[12]);
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 86219c851d..ab4cd733a4 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -60,7 +60,8 @@ typedef struct PL181State {
     uint32_t fifo[PL181_FIFO_LEN]; /* TODO use Fifo32 */
     qemu_irq irq[2];
     /* GPIO outputs for 'card is readonly' and 'card inserted' */
-    qemu_irq cardstatus[2];
+    qemu_irq card_readonly;
+    qemu_irq card_inserted;
 } PL181State;
 
 static const VMStateDescription vmstate_pl181 = {
@@ -479,7 +480,7 @@ static void pl181_reset(DeviceState *d)
     s->mask[1] = 0;
 
     /* We can assume our GPIO outputs have been wired up now */
-    sd_set_cb(s->card, s->cardstatus[0], s->cardstatus[1]);
+    sd_set_cb(s->card, s->card_readonly, s->card_inserted);
     /* Since we're still using the legacy SD API the card is not plugged
      * into any bus, and we must reset it manually.
      */
@@ -496,7 +497,8 @@ static void pl181_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq[0]);
     sysbus_init_irq(sbd, &s->irq[1]);
-    qdev_init_gpio_out(dev, s->cardstatus, 2);
+    qdev_init_gpio_out_named(dev, &s->card_readonly, "card-read-only", 1);
+    qdev_init_gpio_out_named(dev, &s->card_inserted, "card-inserted", 1);
 }
 
 static void pl181_realize(DeviceState *dev, Error **errp)
-- 
2.21.3


