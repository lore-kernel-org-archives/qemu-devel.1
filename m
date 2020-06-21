Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F87C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9676421582
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIUPm5yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9676421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzVy-0000AO-Pk
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOe-0005Mw-UK
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOc-0002rb-TG
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id b6so13977808wrs.11
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8hvxw8zViwef4lvqYH+G0patKwDRHQfaUOaMCkfSQM4=;
 b=kIUPm5yj6VuHBhMbjp52YB2IhCvLxW+UB9/4B6v/MpQ6UuKow3TZSy91zeeKrFpGOo
 X9ICYXZNehr8eZNUR1c2FUWf20Y8kOC+IIlNM9RMk+iTlbdKm+2yiJSxWPBBXlvUzJJJ
 WgFjpUXq33bYH/w8JAQR2YBvEwut5cIx/sv2sd3JmR/Ojmrd6rP/Z+y0XndIIyCdWRNO
 QwHM+2nruVvVEkB+qZtMaKXM1xG+6aMcy+2blhxKLXu4hGslz2962hPNlY0nX7JcAm5o
 r1iBDg5v8xDgmYuSyLbjVP3m7TnTjRb4YzRK323m/N7GcGAendFaM08Cwtw/D27nGio0
 1bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8hvxw8zViwef4lvqYH+G0patKwDRHQfaUOaMCkfSQM4=;
 b=MvFFF0SG/4hc5zCDlK35/S77Toks0gZhh6wEr6msCDeMwuRV+/pKuXPOyAsWMc9yzL
 HT09f4fQ7t8AypL6pr4+HDhtmTmh5ErdfYK176ZIdirmWQS8lKqHBWtlPwJMXO67ochI
 sQ8cyL3p3ZOBeEWSVu0H7/9UYYgBfR6//mf3b8H9mhsU6Z94OvdlJTE4mnE/Qm+QuRzu
 zhAITv8aXR74PBunjvyhJb1tuznCf/XXxDbMwBfuBGv80gTT65j69zgwAjbrTS3yBrlB
 8Uema+g4MzWECbPA1/N6lDu9G0/K8o3fdMgWNZT7a8ZdArSLZShoa/qm0nPBMUCoJWv8
 jMUQ==
X-Gm-Message-State: AOAM533fvc5UMXiC46RXDHXYhtCJOeMHlN86mm6p++JbKx0wkAvTt8KZ
 aXemnahATOWBofJz06xjr/MAK7WG
X-Google-Smtp-Source: ABdhPJxSNq77sBGkFF+NKveCZeE/r4TrwAsYqNf6fc1LEyS42Dbj4a6o84n+bBGuEF6dcnlphGrE2Q==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr5285548wrq.343.1592743705267; 
 Sun, 21 Jun 2020 05:48:25 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] hw/rx: Register R5F562N7 and R5F562N8 MCUs
Date: Sun, 21 Jun 2020 14:48:04 +0200
Message-Id: <20200621124807.17226-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the current TYPE_RX62N_MCU an abstract class, and
generate TYPE_R5F562N7_MCU and TYPE_R5F562N8_MCU models.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/rx/rx62n.h | 19 ++++-----
 hw/rx/rx62n.c         | 92 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 7c6023bcd6..1d3e6a5cad 100644
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
@@ -59,17 +62,11 @@ typedef struct RX62NState {
     MemoryRegion iomem3;
     MemoryRegion c_flash;
     qemu_irq irq[NR_IRQS];
+
+    /* Input Clock (XTAL) frequency */
+    uint32_t xtal_freq_hz;
+    /* Peripheral Module Clock frequency */
+    uint32_t pclk_freq_hz;
 } RX62NState;
 
-/*
- * RX62N Internal Memory
- * It is the value of R5F562N8.
- * Please change the size for R5F562N7.
- */
-#define RX62N_IRAM_SIZE (96 * KiB)
-#define RX62N_DFLASH_SIZE (32 * KiB)
-#define RX62N_CFLASH_SIZE (512 * KiB)
-
-#define RX62N_PCLK (48 * 1000 * 1000)
-
 #endif
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index d8f0fa4625..b9c217ebfa 100644
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
@@ -55,6 +56,25 @@
 #define RX62N_CMT_IRQ   28
 #define RX62N_SCI_IRQ   214
 
+#define RX62N_XTAL_MIN_HZ  (8 * 1000 * 1000)
+#define RX62N_XTAL_MAX_HZ (14 * 1000 * 1000)
+#define RX62N_PCLK_MAX_HZ (50 * 1000 * 1000)
+
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
@@ -148,7 +168,7 @@ static void register_tmr(RX62NState *s, int unit)
     object_initialize_child(OBJECT(s), "tmr[*]",
                             &s->tmr[unit], TYPE_RENESAS_TMR);
     tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
-    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", s->pclk_freq_hz);
     sysbus_realize(tmr, &error_abort);
 
     irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
@@ -166,7 +186,7 @@ static void register_cmt(RX62NState *s, int unit)
     object_initialize_child(OBJECT(s), "cmt[*]",
                             &s->cmt[unit], TYPE_RENESAS_CMT);
     cmt = SYS_BUS_DEVICE(&s->cmt[unit]);
-    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", s->pclk_freq_hz);
     sysbus_realize(cmt, &error_abort);
 
     irqbase = RX62N_CMT_IRQ + CMT_NR_IRQ * unit;
@@ -185,7 +205,7 @@ static void register_sci(RX62NState *s, int unit)
                             &s->sci[unit], TYPE_RENESAS_SCI);
     sci = SYS_BUS_DEVICE(&s->sci[unit]);
     qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
-    qdev_prop_set_uint64(DEVICE(sci), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(sci), "input-freq", s->pclk_freq_hz);
     sysbus_realize(sci, &error_abort);
 
     irqbase = RX62N_SCI_IRQ + SCI_NR_IRQ * unit;
@@ -198,15 +218,31 @@ static void register_sci(RX62NState *s, int unit)
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
+    if (s->xtal_freq_hz < RX62N_XTAL_MIN_HZ
+            || s->xtal_freq_hz > RX62N_XTAL_MAX_HZ) {
+        error_setg(errp, "\"xtal-frequency-hz\" property in incorrect range.");
+        return;
+    }
+    /* Use a 4x fixed multiplier */
+    s->pclk_freq_hz = 4 * s->xtal_freq_hz;
+    /* PCLK range: 8-50 MHz */
+    assert(s->pclk_freq_hz <= RX62N_PCLK_MAX_HZ);
 
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
@@ -235,6 +271,7 @@ static Property rx62n_properties[] = {
     DEFINE_PROP_LINK("main-bus", RX62NState, sysmem, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
+    DEFINE_PROP_UINT32("xtal-frequency-hz", RX62NState, xtal_freq_hz, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -246,16 +283,41 @@ static void rx62n_class_init(ObjectClass *klass, void *data)
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


