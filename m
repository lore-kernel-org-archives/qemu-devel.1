Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A405AC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D09F206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGEKLlQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D09F206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlKC-0002j4-Ir
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDz-0006Zz-I4
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDy-0002pt-GU
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:37:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDy-0002pc-Ak; Sun, 12 Apr 2020 18:37:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id a81so8355795wmf.5;
 Sun, 12 Apr 2020 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=03MmkCIzrXFk47EffNUcQSBR3zXYGz9X21Cp/fIhcLE=;
 b=iGEKLlQArYa83S7I9arl1DJbwIwAdHBaLioZNrYS/3FDqyukGXGl/TTBgepyGBIbGj
 E6q7tcniVvnUOO4fyRzL2OjNM9pryPhNjpWPUeKhPt3ZGKfylBYZla04/Ojo3dEntlkj
 7VfnRkcV4QXCP2TROvJyuvlSi2qWmoJoaJHU5YFBWfvg7ZJ4JuyVy3LaaTinyglqFKMm
 lcmk6RjXz2WbDnt45QBVHxJU1ZfFwzeuseyBfi6r84AqtWa+COmzT9w27rXqmpI6wdFy
 qI2SoIcHLMqhVZ2cz+HV+JUm/qercaprVo84UB1yV3h3EBwimyg1x7N9YP1w50tDKpzk
 A8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=03MmkCIzrXFk47EffNUcQSBR3zXYGz9X21Cp/fIhcLE=;
 b=qEtF57XxPDAq4sJG9BAj8AdiO3P6v74NeetedQz0USyX5dOYz848n0wSTx6K2+No9n
 oreDatyvZv/ryqBjAaaqeyPT+t4szSDlD2zF0qx3mZYmL29fQd9FF99fopJgPctmFhd5
 Uf0RDQQ2BYmsHmkppV7rykQnTt3XkD2ZrYrwFr9SW6NcP3pciKeZBklKEuHeIfUiNXo0
 LmxO8XPhAEPqgT4e0cO1zsX75z1SURznQDRGUBG9lULCv1xuaqlCuAHD52KCUpr7qLoV
 XvluyBUg3HIDxgdGvluT/zh4h+uCA47yne/xyfhnF38BM2UP5TTqfGjPQHtW8/vULhbm
 yypg==
X-Gm-Message-State: AGi0PuYiIRix7BxDZws5omroPeKltkUKg/iy6ySAnJrkYgNhfW0YXtBg
 b9sQWYhj/y5eIx/YqCZHoggVcZsrceBrNg==
X-Google-Smtp-Source: APiQypI9LAKr+0Ga6TN/qeZAVtFecKvPUhSqxUrX6VIooxdBhL55/QuAsxg4P51twKNS1LVmOGmL7w==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr14927358wmc.64.1586731029197; 
 Sun, 12 Apr 2020 15:37:09 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:37:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 13/24] hw/arm/stm32f205_soc: Move some code from
 realize() to init()
Date: Mon, 13 Apr 2020 00:36:08 +0200
Message-Id: <20200412223619.11284-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/stm32f205_soc.c
  >>> possible moves from stm32f205_soc_initfn() to stm32f205_soc_realize() in ./hw/arm/stm32f205_soc.c:83

Move the calls using &error_fatal which don't depend on input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Typo 'depend of' -> 'depend on' (eblake)
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


