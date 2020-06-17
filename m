Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46789C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BF8208D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKUAcdph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BF8208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldfU-0002BY-BR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldXA-0004dE-JH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:40 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:37220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldX8-0006Us-L6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:40 -0400
Received: by mail-ej1-x62d.google.com with SMTP id mb16so3748784ejb.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qBnGPw/KyT6+2hMNSegs0FI40sItBZY3EqbryJUTCjg=;
 b=cKUAcdphTJGu0fJQ2XQh0fh6DnL2GAomf9cQVbhSPk+QtoBdaaSd0r0EnyACukNqL8
 NXwn7KC/dn9DEkyEoOFXqGt4dnxvfz/3Ud6GKefw7yWgD+RpkQONSlJt17wq2trml/FN
 IhkwHy4Lw7CCA1Mh9OVJnNnOOija3pAlT6TEnVNWlXmgPOFkMozpswEBsPgx78OI8q3l
 sVcIyM7zIsIBvYJk+ndKcLI+AA2xT7/5Wsn79nUUJSBUZo4W07KCpfeIdO2vzEL8ngsr
 taXZd3v3jPdiXzSFTPqzbmIWhXIw6MJY+GOuOyLp7Ly5SwFRHWuaF8PJ/i2ZsnkCKQp7
 xEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qBnGPw/KyT6+2hMNSegs0FI40sItBZY3EqbryJUTCjg=;
 b=oTfYStUvCT87aaI1VzPgldujjRl7toU/WwzJILXtrySKmqbfvda5CKFbOsqxHjJtfm
 0gcx4wyhl335qs8c5saUdNACS/tY/gpW1a55zmQoVyVLB2ca5IyjOvkRbJ9oQspWVGV4
 b/D2g51Aoh8QUXKbr8OljaCo3zr8zDnR9AoJ2SeBTfGyUaceVdZTyOfkWqv5qYRav8v4
 6fe89dXw9Fb+sAYqtnBhErDojF2JdiT4RC27/ndVzubQ1tUp7Yht586hcW8nmKyYA84m
 Y7fnZOLkEx8ddnFcTi2YL9q+aFhmzSy2UjUBfCfYGwTtpRPNlxFxYQXXD8K/amlDkpHY
 eWzA==
X-Gm-Message-State: AOAM533lBL9yk0O3zkThjyYsM8X6L4ZIDbHlot59aI8RxF5cfH0Hp+G/
 nkvp+Z9RAqQNS3dxi2tY+4g=
X-Google-Smtp-Source: ABdhPJxSyjI8/8o7JF6RV9niTl8dlH2uI1dne/RZsgoivTeJvoCoTUcc4KN5UVWRn+R70uAAIuCg/A==
X-Received: by 2002:a17:906:528b:: with SMTP id
 c11mr578874ejm.407.1592421337212; 
 Wed, 17 Jun 2020 12:15:37 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 12/15] hw/rx: Register R5F562N7 and R5F562N8 MCUs
Date: Wed, 17 Jun 2020 21:15:16 +0200
Message-Id: <20200617191519.14842-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617191519.14842-1-f4bug@amsat.org>
References: <20200617191519.14842-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62d.google.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the current TYPE_RX62N_MCU an abstract class, and
generate TYPE_R5F562N7_MCU and TYPE_R5F562N8_MCU models.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/rx/rx62n.h | 17 ++++-----
 hw/rx/rx62n.c         | 87 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 7c6023bcd6..0421cd6d4d 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -34,6 +34,9 @@
 #define TYPE_RX62N_MCU "rx62n-mcu"
 #define RX62N_MCU(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N_MCU)
 
+#define TYPE_R5F562N7_MCU "r5f562n7-mcu"
+#define TYPE_R5F562N8_MCU "r5f562n8-mcu"
+
 #define RX62N_NR_TMR    2
 #define RX62N_NR_CMT    2
 #define RX62N_NR_SCI    6
@@ -59,16 +62,12 @@ typedef struct RX62NState {
     MemoryRegion iomem3;
     MemoryRegion c_flash;
     qemu_irq irq[NR_IRQS];
-} RX62NState;
 
-/*
- * RX62N Internal Memory
- * It is the value of R5F562N8.
- * Please change the size for R5F562N7.
- */
-#define RX62N_IRAM_SIZE (96 * KiB)
-#define RX62N_DFLASH_SIZE (32 * KiB)
-#define RX62N_CFLASH_SIZE (512 * KiB)
+    /* Input Clock (XTAL) frequency */
+    uint32_t xtal_freq_hz;
+    /* Peripheral Module Clock frequency */
+    uint32_t pclk_freq_hz;
+} RX62NState;
 
 #define RX62N_PCLK (48 * 1000 * 1000)
 
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index d8f0fa4625..776445fcfb 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -5,6 +5,7 @@
  * (Rev.1.40 R01UH0033EJ0140)
  *
  * Copyright (c) 2019 Yoshinori Sato
+ * Copyright (c) 2020 Philippe Mathieu-Daudé
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -55,6 +56,21 @@
 #define RX62N_CMT_IRQ   28
 #define RX62N_SCI_IRQ   214
 
+typedef struct RX62NClass {
+    /*< private >*/
+    DeviceClass parent_class;
+    /*< public >*/
+    const char *name;
+    uint64_t ram_size;
+    uint64_t rom_flash_size;
+    uint64_t data_flash_size;
+} RX62NClass;
+
+#define RX62N_MCU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(RX62NClass, (klass), TYPE_RX62N_MCU)
+#define RX62N_MCU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RX62NClass, (obj), TYPE_RX62N_MCU)
+
 /*
  * IRQ -> IPR mapping table
  * 0x00 - 0x91: IPR no (IPR00 to IPR91)
@@ -148,7 +164,7 @@ static void register_tmr(RX62NState *s, int unit)
     object_initialize_child(OBJECT(s), "tmr[*]",
                             &s->tmr[unit], TYPE_RENESAS_TMR);
     tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
-    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", s->pclk_freq_hz);
     sysbus_realize(tmr, &error_abort);
 
     irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
@@ -166,7 +182,7 @@ static void register_cmt(RX62NState *s, int unit)
     object_initialize_child(OBJECT(s), "cmt[*]",
                             &s->cmt[unit], TYPE_RENESAS_CMT);
     cmt = SYS_BUS_DEVICE(&s->cmt[unit]);
-    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", s->pclk_freq_hz);
     sysbus_realize(cmt, &error_abort);
 
     irqbase = RX62N_CMT_IRQ + CMT_NR_IRQ * unit;
@@ -185,7 +201,7 @@ static void register_sci(RX62NState *s, int unit)
                             &s->sci[unit], TYPE_RENESAS_SCI);
     sci = SYS_BUS_DEVICE(&s->sci[unit]);
     qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
-    qdev_prop_set_uint64(DEVICE(sci), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(sci), "input-freq", s->pclk_freq_hz);
     sysbus_realize(sci, &error_abort);
 
     irqbase = RX62N_SCI_IRQ + SCI_NR_IRQ * unit;
@@ -198,15 +214,30 @@ static void register_sci(RX62NState *s, int unit)
 static void rx62n_realize(DeviceState *dev, Error **errp)
 {
     RX62NState *s = RX62N_MCU(dev);
+    RX62NClass *rxc = RX62N_MCU_GET_CLASS(dev);
+
+    if (s->xtal_freq_hz == 0) {
+        error_setg(errp, "\"xtal-frequency-hz\" property must be provided.");
+        return;
+    }
+    /* XTAL range: 8-14 MHz */
+    if (s->xtal_freq_hz < 8e6 || s->xtal_freq_hz > 14e6) {
+        error_setg(errp, "\"xtal-frequency-hz\" property in incorrect range.");
+        return;
+    }
+    /* Use a 4x fixed multiplier */
+    s->pclk_freq_hz = 4 * s->xtal_freq_hz;
+    /* PCLK range: 8-50 MHz */
+    assert(s->pclk_freq_hz <= 50e6);
 
     memory_region_init_ram(&s->iram, OBJECT(dev), "iram",
-                           RX62N_IRAM_SIZE, &error_abort);
+                           rxc->ram_size, &error_abort);
     memory_region_add_subregion(s->sysmem, RX62N_IRAM_BASE, &s->iram);
     memory_region_init_rom(&s->d_flash, OBJECT(dev), "flash-data",
-                           RX62N_DFLASH_SIZE, &error_abort);
+                           rxc->data_flash_size, &error_abort);
     memory_region_add_subregion(s->sysmem, RX62N_DFLASH_BASE, &s->d_flash);
     memory_region_init_rom(&s->c_flash, OBJECT(dev), "flash-code",
-                           RX62N_CFLASH_SIZE, &error_abort);
+                           rxc->rom_flash_size, &error_abort);
     memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flash);
 
     if (!s->kernel) {
@@ -235,6 +266,7 @@ static Property rx62n_properties[] = {
     DEFINE_PROP_LINK("main-bus", RX62NState, sysmem, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
+    DEFINE_PROP_UINT32("xtal-frequency-hz", RX62NState, xtal_freq_hz, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -246,16 +278,41 @@ static void rx62n_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, rx62n_properties);
 }
 
-static const TypeInfo rx62n_info = {
-    .name = TYPE_RX62N_MCU,
-    .parent = TYPE_DEVICE,
-    .instance_size = sizeof(RX62NState),
-    .class_init = rx62n_class_init,
+static void r5f562n7_class_init(ObjectClass *oc, void *data)
+{
+    RX62NClass *rxc = RX62N_MCU_CLASS(oc);
+
+    rxc->ram_size = 64 * KiB;
+    rxc->rom_flash_size = 384 * KiB;
+    rxc->data_flash_size = 32 * KiB;
 };
 
-static void rx62n_register_types(void)
+static void r5f562n8_class_init(ObjectClass *oc, void *data)
 {
-    type_register_static(&rx62n_info);
-}
+    RX62NClass *rxc = RX62N_MCU_CLASS(oc);
 
-type_init(rx62n_register_types)
+    rxc->ram_size = 96 * KiB;
+    rxc->rom_flash_size = 512 * KiB;
+    rxc->data_flash_size = 32 * KiB;
+};
+
+static const TypeInfo rx62n_types[] = {
+    {
+        .name           = TYPE_R5F562N7_MCU,
+        .parent         = TYPE_RX62N_MCU,
+        .class_init     = r5f562n7_class_init,
+    }, {
+        .name           = TYPE_R5F562N8_MCU,
+        .parent         = TYPE_RX62N_MCU,
+        .class_init     = r5f562n8_class_init,
+    }, {
+        .name           = TYPE_RX62N_MCU,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(RX62NState),
+        .class_size     = sizeof(RX62NClass),
+        .class_init     = rx62n_class_init,
+        .abstract       = true,
+     }
+};
+
+DEFINE_TYPES(rx62n_types)
-- 
2.21.3


