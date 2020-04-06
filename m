Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E7BC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00514206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRVqn9rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00514206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVvs-0002WH-3t
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqw-0001lK-M1
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqv-00028x-Cn
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqv-00024c-64; Mon, 06 Apr 2020 13:48:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a25so547823wrd.0;
 Mon, 06 Apr 2020 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mu58XTLOEJ0Z47s7hq7QXuE41EW+M1RFpApzokyZC4I=;
 b=nRVqn9rkGY7U3g7uXtJxo3Ar8zpVQrPkPVzPL5BjnksUoMsou+q371pwhRqztVa00v
 mbk8xcP9BmLacWNgj2VMmfXVedPUTBUL8T6+UIzAQ1vjTD4653JY4OtG0h4qx7UeqLrV
 TKWUP+GTIfdU46cSfkEk/2GCDD3vmBL7lUNhUs+eC4yUXnUPnPaS6HeBv1/dNWJTQwIv
 IA5vD8kNjGlQJVApU2jrXpFNgMH3eCdRK7GwL2II9bf3Tn5sjx9lYf3FyM9E/acxuZaG
 KdJ4Ns7bT/YdM7g0N4uwtKuGD1JGZba+PJ/Amcdf1Jq91bUPZadcQY2dIY8MhSqRyWZP
 jtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Mu58XTLOEJ0Z47s7hq7QXuE41EW+M1RFpApzokyZC4I=;
 b=T3bD1f5CpiboCWKbE9YoZ6AJcBzvnpOxhtGuJIG2GT+DP7l2fUlAyPRIAStnajPMqu
 BXly7Ti0eroWquUCex2r40Cy7V8qmxas/GyY/DhU2l3SUTfomnFBW6qDGf7pro07iI7R
 6Lql6zdaoLu5pnFV4BF/2Ge88iuSlYIqPSM0vOl+QaoqOLSE8PYv8fq+tKF5A91JUuez
 uhQ/StlzZnjmGdevF4K90KeIzH/hZbX11/bt3DwPzDWTa+vQ5qLGIooRid6lhqALe14+
 FiiAlBBjJpuGPUZWdgAO3Yu50BWSkE62TsNliSFQMY87oaRj5kX8103NpISE2NBY66AX
 xoxw==
X-Gm-Message-State: AGi0PuaVQwCnW5dnEVajjxzL7ESb+11M3LRvEkkKwnpcio618zvaj90M
 zOAuLjgdthKI9+0Br7Ocu9N4Ivxh5l4=
X-Google-Smtp-Source: APiQypLxsfGyUHBz3le362zbRq0llBgrUDDrB7Bbw45OQy8Slr36ljKq10sdewfnxTh8syHlPsNG0w==
X-Received: by 2002:adf:a548:: with SMTP id j8mr322240wrb.331.1586195283915;
 Mon, 06 Apr 2020 10:48:03 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 13/54] hw/arm/stm32f205_soc: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:47:02 +0200
Message-Id: <20200406174743.16956-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/stm32f205_soc.c
  >>> possible moves from stm32f205_soc_initfn() to stm32f205_soc_realize() in ./hw/arm/stm32f205_soc.c:83

Move the calls using &error_fatal which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/stm32f205_soc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 42f4e44134..76b0b0e9be 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -49,6 +49,7 @@ static const int spi_irq[STM_NUM_SPIS] = {35, 36, 51};
 static void stm32f205_soc_initfn(Object *obj)
 {
     STM32F205State *s = STM32F205_SOC(obj);
+    MemoryRegion *system_memory = get_system_memory();
     int i;
 
     sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
@@ -78,6 +79,14 @@ static void stm32f205_soc_initfn(Object *obj)
         sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
                               TYPE_STM32F2XX_SPI);
     }
+
+    memory_region_init_ram(&s->sram, NULL, "STM32F205.sram", SRAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
+
+    memory_region_init_rom(&s->flash, obj, "STM32F205.flash",
+                           FLASH_SIZE, &error_fatal);
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
 }
 
 static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -87,19 +96,10 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
-    MemoryRegion *system_memory = get_system_memory();
 
-    memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32F205.flash",
-                           FLASH_SIZE, &error_fatal);
     memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
                              "STM32F205.flash.alias", &s->flash, 0, FLASH_SIZE);
-
-    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
-    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
-
-    memory_region_init_ram(&s->sram, NULL, "STM32F205.sram", SRAM_SIZE,
-                           &error_fatal);
-    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
+    memory_region_add_subregion(get_system_memory(), 0, &s->flash_alias);
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
-- 
2.21.1


