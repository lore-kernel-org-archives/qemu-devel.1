Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E3C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9293B206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmWPI53S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9293B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVsV-0003Vw-OZ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqk-0001TT-2i
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqi-0001Ru-09
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqh-0001Qf-Qj; Mon, 06 Apr 2020 13:47:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id z7so300433wmk.1;
 Mon, 06 Apr 2020 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SEX/nwZgTPc5n/w+lMa0+UqvNUZKOIm8zzduq8bu1fA=;
 b=OmWPI53SVitm/Hc/eeQ4R7pbBNgpOgA4UffgmeF40nLceZUObiufYQ4edn2Csv/01G
 iS4p9aAQs7JpusZEYNa9VfrlcxEumFLsC4n4mcpyQ1jVMx6wfsjanzLHMhMycZHbm3d7
 pzv6l1VrPgeXx0n09ug9D+VxoK7lspWknUSxKSww9yfXAyDu0+d5qEhjfZC6giUDjE4S
 9dOnsgP3UiPUDN+oh3j4CrqClpcbDxhQtBfvWqGgJlBBe5AwGdmDwxtX+L7e3fBmxy6B
 b9EYAOQ5AOYMorNYw6quJoJuaYwg1yIS8V07LP3cLZbgR4u/i29sMbckoLHF4NZTxpTV
 S7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SEX/nwZgTPc5n/w+lMa0+UqvNUZKOIm8zzduq8bu1fA=;
 b=NGT4lSxRnNTeswsaU8M10XDac/soA8IS2sX2bI7W2cMOO37/rA6U32QzNNVNq/QxgF
 U6uN25DpLn7nwEqek5LX+479MIMwu8JLo5B5818PjPrhK7P4JF9sVM0o8LOVK3cj7Gbb
 MDOkom/20IpbgmBYK7c1/pgH4ujRviHz3rEF4Zv8EJyqn22ctid88tI1Lnpo9Empb0yf
 9MwxdIiI13N/vKDqTFt4sj5u7Cseq6fcZBuR4gaxLhYvr94b9WFHwO5IYVIgm3qjQeFe
 Nng2OhFhfzGgOpfh0cwlLlQNofH1NqpbFuBr/K3pnDSsUUpDxfsznAVZ9VDX/AiFBrSQ
 oQYQ==
X-Gm-Message-State: AGi0PuYmt/nUMOj+Pnl6pZwL/4VEBuk5jOMZ9sIJCCN1IM/isc1nTOOF
 ne0t/FXxhkFbDw9KnW0BwhB6QRAidIk=
X-Google-Smtp-Source: APiQypIYR5otdZAL+FRzOeSaWNGO4ue1YpD6fLr6TZ6iVgcz4ccUwumQUECtLxoJC/Kou8sxfr/qcg==
X-Received: by 2002:a1c:dfc6:: with SMTP id w189mr497008wmg.180.1586195270273; 
 Mon, 06 Apr 2020 10:47:50 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 03/54] hw/arm/allwinner-a10: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:46:52 +0200
Message-Id: <20200406174743.16956-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:Allwinner-a10" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/allwinner-a10.c
  >>> possible moves from aw_a10_init() to aw_a10_realize() in ./hw/arm/allwinner-a10.c:77

Move the calls using &error_fatal which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


