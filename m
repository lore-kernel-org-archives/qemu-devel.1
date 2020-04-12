Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69F0C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D7D206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTYU73qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D7D206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlHt-0006U2-K3
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDS-00057H-P2
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDR-00022B-II
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDR-0001zl-Aq; Sun, 12 Apr 2020 18:36:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id 65so8549525wrl.1;
 Sun, 12 Apr 2020 15:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0L3GtgkM+tHAsomgjJ+0n9R4GwoMloXQteUzufC2V7I=;
 b=jTYU73qGqVFddr8pLnVQpLbF5W2VR27kMU7rzfTogZDI+MLQvq0BoNDP7FDEEvSRBX
 0ZNK4KsvD2fjIjLEu7ZM4UXndxYQ6owfy2j6Ifdfg68yAYMy7FOK7okPnY1OQ1l3M2Mw
 uLMFStGPYm5v+vCENxCdqkSYFw3+z0vBvc7LR3+wPtpgOEAGG4M6thP4q+rPL/C/+IlQ
 tJ2MpkbjbvVZPc2Yx42MoILUTLS7bq5Rqf29jIcEfLLWsMcqnZdsRahPVkGNx1t2shat
 ud7bFgG/ceAmbWp/JuEKJsOeHmcHTKgWEg1r2TXfNTdtd8AKLbcjAPHnMN+e7iRjm2EE
 /1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0L3GtgkM+tHAsomgjJ+0n9R4GwoMloXQteUzufC2V7I=;
 b=TiDvkiBEgSH5ngW+qv81Ud9AYCGrqSZYaCdSsBEwcjvMTcGAJHDT7Gs9EzbDvAcGiZ
 4y0Ivx4gNnLP9IS5YNlsSGS+bsGyJTYST/Dlv6OriGmKwCc4+d4g5wn4SA6xq7K4+6q7
 UqnBrKTT1HwoTpLMmJ/XoqBuWGdbj4fytEYB1VC85Ruhn+WmMu+pfx97gKHCKW1hHO9s
 f/i++3CUYU8nvmCoew4M9maWy3A9YzOjh32ulKEnMCrtA8jLTtpcaJEa1kymlWRn9rhz
 f+VvH3pqJ7IxKSp4AK9gJPoePmzAKXkG9BmFHyUvrZsfX5nhj/i2E2n35DQ7d18TLkU2
 5vSg==
X-Gm-Message-State: AGi0PubLTWsdERrkaN1Wuwup/DbP9MGysFwDdVs9EokZpmrp0JsXstD5
 /ieyPzU285a+bmiogRs3plJJaG2R2qiEGg==
X-Google-Smtp-Source: APiQypKbvGTU4Pf9Pr1DbRq3aUYFhdoJtit2q5Q3w5auGE9iEbijWU1OypoPSTTdWhJUNH+wBlYysQ==
X-Received: by 2002:a5d:53ce:: with SMTP id a14mr15422281wrw.129.1586730995171; 
 Sun, 12 Apr 2020 15:36:35 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:36:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 03/24] hw/arm/allwinner-a10: Move some code from
 realize() to init()
Date: Mon, 13 Apr 2020 00:35:58 +0200
Message-Id: <20200412223619.11284-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
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
  HANDLING: ./hw/arm/allwinner-a10.c
  >>> possible moves from aw_a10_init() to aw_a10_realize() in ./hw/arm/allwinner-a10.c:77

Move the calls using &error_fatal which don't depend on input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Typo 'depend of' -> 'depend on' (eblake)
---
 hw/arm/allwinner-a10.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 62a67a3e1a..f41395734a 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -60,10 +60,18 @@ static void aw_a10_init(Object *obj)
         int i;
 
         for (i = 0; i < AW_A10_NUM_USB; i++) {
+            char bus[16];
+
             sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
                                   sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
             sysbus_init_child_obj(obj, "ohci[*]", OBJECT(&s->ohci[i]),
                                   sizeof(s->ohci[i]), TYPE_SYSBUS_OHCI);
+            object_property_set_bool(OBJECT(&s->ehci[i]), true,
+                                     "companion-enable", &error_fatal);
+
+            sprintf(bus, "usb-bus.%d", i);
+            object_property_set_str(OBJECT(&s->ohci[i]), bus, "masterbus",
+                                    &error_fatal);
         }
     }
 
@@ -72,6 +80,11 @@ static void aw_a10_init(Object *obj)
 
     sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
                           TYPE_AW_RTC_SUN4I);
+
+    memory_region_init_ram(&s->sram_a, obj, "sram A", 48 * KiB,
+                           &error_fatal);
+    memory_region_add_subregion(get_system_memory(), 0x00000000, &s->sram_a);
+    create_unimplemented_device("a10-sram-ctrl", 0x01c00000, 4 * KiB);
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
@@ -113,11 +126,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(sysbusdev, 4, qdev_get_gpio_in(dev, 67));
     sysbus_connect_irq(sysbusdev, 5, qdev_get_gpio_in(dev, 68));
 
-    memory_region_init_ram(&s->sram_a, OBJECT(dev), "sram A", 48 * KiB,
-                           &error_fatal);
-    memory_region_add_subregion(get_system_memory(), 0x00000000, &s->sram_a);
-    create_unimplemented_device("a10-sram-ctrl", 0x01c00000, 4 * KiB);
-
     /* FIXME use qdev NIC properties instead of nd_table[] */
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
@@ -149,12 +157,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         int i;
 
         for (i = 0; i < AW_A10_NUM_USB; i++) {
-            char bus[16];
-
-            sprintf(bus, "usb-bus.%d", i);
-
-            object_property_set_bool(OBJECT(&s->ehci[i]), true,
-                                     "companion-enable", &error_fatal);
             object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
                                      &error_fatal);
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
@@ -162,8 +164,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                                qdev_get_gpio_in(dev, 39 + i));
 
-            object_property_set_str(OBJECT(&s->ohci[i]), bus, "masterbus",
-                                    &error_fatal);
             object_property_set_bool(OBJECT(&s->ohci[i]), true, "realized",
                                      &error_fatal);
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
-- 
2.21.1


