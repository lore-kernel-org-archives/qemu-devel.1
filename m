Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25475206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkksl8um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25475206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfn73-0007GI-82
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5X-0005QG-7i
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5W-0001XH-CL
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:58 -0400
Received: by mail-wr1-x430.google.com with SMTP id c3so367793wru.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8k7Q+h1dMdB8Hm8Essuow3OOXb1LrqVXcXCbj2V7FbQ=;
 b=Xkksl8umDVSE2m1H4nw6lFZkRXnoxFEzsHN0bG6bgxkOq6CTghqI1ao7iV1GV1onC3
 vxGj8NfEbmkYxgRra6ngDUYA9L6syDhQLroASyA3ULqXXVq257S0j1A3FedLEqRuO8Yq
 hX3qeK6KQ1EfcCqowmEuueKrgfoe71zpsjhOwpptrFydPrZJRrS3OrMHfB9R79UQ08bw
 0f0kccCRtyfojWCtdvgCUnL1//UNjj4XP88ybEid2JZsZ+5Drux7Ien/nN7lDrR6kx33
 29g5b2p+Kib9a+ZX6zIa16z6sFYvl58Do0Ka4uqN9H+GAJ/ZB7I9UsLifW2XNboTfAKd
 Ia6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8k7Q+h1dMdB8Hm8Essuow3OOXb1LrqVXcXCbj2V7FbQ=;
 b=op5E6w3FrJHJ20I+DAJCKMlHuaOO+ZJsVZAVC/b7cJR8d7fYV0m1HE1FHrTi9WY1ng
 G0RBdz5ygCnDAnDK+J4FiCT7MjS5vV/kAOMCVaLJFNprVZOVLKs0J5+tDElZw4WnW0s+
 OZcxfItKQIlCdspoZs2MOB07q/81y4eJa1clyDASlxr8VGgiMZHKx8PtDOvyk3lnZTUz
 Uf1g5CSqi3jZ2Anf/wweXakNlPkjnwm4Uybj9hcKc3ORvDKQxJztK6bX2F9JFhZtsdZM
 fAjWl56r/hE2U+AJ4yeKHO3U7h7uY0DqZaOI9BHuKr2G/wjXWzIrwRtmfkos+xQpnUwh
 EEJQ==
X-Gm-Message-State: AOAM53113bm5uZqUyACwDWyTbKeqzY0E19G6s3o7DHtpoxD8AGfLz6/f
 V59rwQgm4c0K7ZVMwtA6VyQ=
X-Google-Smtp-Source: ABdhPJwtY1BkkUdUs1fwbzZ5ZO46XGJxbXwrug23+DPUdJLUIwpoMhiZmv1dU3LAm4AIi6CpNz7M4A==
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr22868509wrx.5.1591028096923; 
 Mon, 01 Jun 2020 09:14:56 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 09/12] hw/rx: Register R5F562N7 and R5F562N8 MCUs
Date: Mon,  1 Jun 2020 18:14:38 +0200
Message-Id: <20200601161441.8086-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the current TYPE_RX62N_MCU an abstract class, and
generate TYPE_R5F562N7_MCU and TYPE_R5F562N8_MCU models.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/rx/rx62n.h | 17 +++++----
 hw/rx/rx62n.c         | 81 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 77 insertions(+), 21 deletions(-)

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
index 92d215f07a..69dc5e5da9 100644
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
@@ -153,7 +169,7 @@ static void register_tmr(RX62NState *s, int unit)
                             &error_abort, NULL);
 
     tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
-    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", s->pclk_freq_hz);
     qdev_init_nofail(DEVICE(tmr));
 
     irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
@@ -173,7 +189,7 @@ static void register_cmt(RX62NState *s, int unit)
                             &error_abort, NULL);
 
     cmt = SYS_BUS_DEVICE(&s->cmt[unit]);
-    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", s->pclk_freq_hz);
     qdev_init_nofail(DEVICE(cmt));
 
     irqbase = RX62N_CMT_IRQ + CMT_NR_IRQ * unit;
@@ -194,7 +210,7 @@ static void register_sci(RX62NState *s, int unit)
 
     sci = SYS_BUS_DEVICE(&s->sci[unit]);
     qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
-    qdev_prop_set_uint64(DEVICE(sci), "input-freq", RX62N_PCLK);
+    qdev_prop_set_uint64(DEVICE(sci), "input-freq", s->pclk_freq_hz);
     qdev_init_nofail(DEVICE(sci));
 
     irqbase = RX62N_SCI_IRQ + SCI_NR_IRQ * unit;
@@ -207,6 +223,21 @@ static void register_sci(RX62NState *s, int unit)
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
                            rxc->ram_size, &error_abort);
@@ -245,6 +276,7 @@ static Property rx62n_properties[] = {
     DEFINE_PROP_LINK("main-bus", RX62NState, sysmem, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
+    DEFINE_PROP_UINT32("xtal-frequency-hz", RX62NState, xtal_freq_hz, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -256,16 +288,41 @@ static void rx62n_class_init(ObjectClass *klass, void *data)
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


