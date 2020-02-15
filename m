Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ABDC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A4C206D6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0ty9M79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A4C206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j32zX-0000kB-AE
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32uz-0008SL-HJ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32uy-0004I2-0G
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32ux-0004HY-Pp; Sat, 15 Feb 2020 14:15:55 -0500
Received: by mail-wm1-x342.google.com with SMTP id q9so13334240wmj.5;
 Sat, 15 Feb 2020 11:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pPEcldfHD5OEhzQuYmprGj9+p4+mZQlzGRO9gMQy3Os=;
 b=Q0ty9M794wYXqt0r4fzM7ztljMLs0XYTnqx4DlSdbTis3II3KidV3mdY3rShtB7neK
 WojctAnkCKARVuk8/qg1yc4vjmm9QRMaTN9BaSyIjJ01Ag+ata4ZWpzTz+dSYAay2KNp
 PG3ZAWvjGQOPV2Z5w58iSL/XjkT4JfkUX0XoMuTh0K4jxTlAAcEHgjJBuNoauJqdpil8
 xYgZJJwNNPaSStBdnimzfLGsRNl/sjgc6fjLKbQyOV7r7C7K6sJm+jC+oyWoQFIXj/uh
 ZJk6WzsqTYi6fRSy2XDeOUhEq734PBmZNkMm6pnfHr4PzQ12CQn3uJL/7c0kWmuRrJkQ
 jMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pPEcldfHD5OEhzQuYmprGj9+p4+mZQlzGRO9gMQy3Os=;
 b=kVvBTFug8kL29fFHasHY8YG6qzQrH5USa//4wutn8xyyfsp6k4Em1LmZ6ptV17akM5
 ktZPQIQFCgTsULcl8DWNq3KphC23uGt8NRN4RxrSQhS/bA42BtWv5l0YAxiHtw+nfXUX
 Z1KZUr6G4SGGp235cj3onxHpyjCO58+Y3zsEhi9rS2NkVNAmKB58hbH++YjMPPlyXnQF
 rYSw4W8Hx7KKaSsigdpPZ9erk/E/lO+Wxnkr3Ecmz/beJyIg7SawgxbBDNvTBWXtX6ZV
 qNJUnvU2vRQHlOY1xLER5Md07G9L1muHzuelrkbrGnAdp2quJAv1+YF8iyWIL17ECt6u
 rl4A==
X-Gm-Message-State: APjAAAUFwBBQ/AAK+udUNoBDRPmpOPtjfN1wXtW/s6mCOUqme4I88m++
 Gw6sDL8e4uePHGVigyhHcukXYJyI25Y=
X-Google-Smtp-Source: APXvYqxg9d31T70kpIR2Xg4ZvH6WqXCTwv81la7HabTi0PVFuaizbqvaCQgbJ2c41DKp+nL9sKtGOg==
X-Received: by 2002:a1c:7317:: with SMTP id d23mr12301275wmb.165.1581794154640; 
 Sat, 15 Feb 2020 11:15:54 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm9678605wrw.20.2020.02.15.11.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:15:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/12] hw/arm/bcm2836: QOM'ify more by adding class_init() to
 each SoC type
Date: Sat, 15 Feb 2020 20:15:37 +0100
Message-Id: <20200215191543.3235-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215191543.3235-1-f4bug@amsat.org>
References: <20200215191543.3235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove usage of TypeInfo::class_data. Instead fill the fields in
the corresponding class_init().

Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 109 ++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 24109fef1d..683d04d6ea 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -16,57 +16,30 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 
-typedef struct BCM283XInfo BCM283XInfo;
-
 typedef struct BCM283XClass {
     /*< private >*/
     DeviceClass parent_class;
     /*< public >*/
-    const BCM283XInfo *info;
-} BCM283XClass;
-
-struct BCM283XInfo {
-    const char *name;
     const char *cpu_type;
     hwaddr peri_base; /* Peripheral base address seen by the CPU */
     hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
     int clusterid;
-};
+} BCM283XClass;
 
 #define BCM283X_CLASS(klass) \
     OBJECT_CLASS_CHECK(BCM283XClass, (klass), TYPE_BCM283X)
 #define BCM283X_GET_CLASS(obj) \
     OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
 
-static const BCM283XInfo bcm283x_socs[] = {
-    {
-        .name = TYPE_BCM2836,
-        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a7"),
-        .peri_base = 0x3f000000,
-        .ctrl_base = 0x40000000,
-        .clusterid = 0xf,
-    },
-#ifdef TARGET_AARCH64
-    {
-        .name = TYPE_BCM2837,
-        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a53"),
-        .peri_base = 0x3f000000,
-        .ctrl_base = 0x40000000,
-        .clusterid = 0x0,
-    },
-#endif
-};
-
 static void bcm2836_init(Object *obj)
 {
     BCM283XState *s = BCM283X(obj);
     BCM283XClass *bc = BCM283X_GET_CLASS(obj);
-    const BCM283XInfo *info = bc->info;
     int n;
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
         object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
-                                sizeof(s->cpu[n].core), info->cpu_type,
+                                sizeof(s->cpu[n].core), bc->cpu_type,
                                 &error_abort, NULL);
     }
 
@@ -85,7 +58,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
-    const BCM283XInfo *info = bc->info;
     Object *obj;
     Error *err = NULL;
     int n;
@@ -119,7 +91,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
-                            info->peri_base, 1);
+                            bc->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
@@ -128,7 +100,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
@@ -137,11 +109,11 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
         /* TODO: this should be converted to a property of ARM_CPU */
-        s->cpu[n].core.mp_affinity = (info->clusterid << 8) | n;
+        s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpu[n].core),
-                                info->peri_base,
+                                bc->peri_base,
                                 "reset-cbar", &err);
         if (err) {
             error_propagate(errp, err);
@@ -190,38 +162,59 @@ static Property bcm2836_props[] = {
 static void bcm283x_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    BCM283XClass *bc = BCM283X_CLASS(oc);
 
-    bc->info = data;
-    dc->realize = bcm2836_realize;
-    device_class_set_props(dc, bcm2836_props);
     /* Reason: Must be wired up in code (see raspi_init() function) */
     dc->user_creatable = false;
 }
 
-static const TypeInfo bcm283x_type_info = {
-    .name = TYPE_BCM283X,
-    .parent = TYPE_DEVICE,
-    .instance_size = sizeof(BCM283XState),
-    .instance_init = bcm2836_init,
-    .class_size = sizeof(BCM283XClass),
-    .abstract = true,
+static void bcm2836_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM283XClass *bc = BCM283X_CLASS(oc);
+
+    bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+    bc->peri_base = 0x3f000000;
+    bc->ctrl_base = 0x40000000;
+    bc->clusterid = 0xf;
+    dc->realize = bcm2836_realize;
+    device_class_set_props(dc, bcm2836_props);
 };
 
-static void bcm2836_register_types(void)
+#ifdef TARGET_AARCH64
+static void bcm2837_class_init(ObjectClass *oc, void *data)
 {
-    int i;
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM283XClass *bc = BCM283X_CLASS(oc);
 
-    type_register_static(&bcm283x_type_info);
-    for (i = 0; i < ARRAY_SIZE(bcm283x_socs); i++) {
-        TypeInfo ti = {
-            .name = bcm283x_socs[i].name,
-            .parent = TYPE_BCM283X,
-            .class_init = bcm283x_class_init,
-            .class_data = (void *) &bcm283x_socs[i],
-        };
-        type_register(&ti);
+    bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    bc->peri_base = 0x3f000000;
+    bc->ctrl_base = 0x40000000;
+    bc->clusterid = 0x0;
+    dc->realize = bcm2836_realize;
+    device_class_set_props(dc, bcm2836_props);
+};
+#endif
+
+static const TypeInfo bcm283x_types[] = {
+    {
+        .name           = TYPE_BCM2836,
+        .parent         = TYPE_BCM283X,
+        .class_init     = bcm2836_class_init,
+#ifdef TARGET_AARCH64
+    }, {
+        .name           = TYPE_BCM2837,
+        .parent         = TYPE_BCM283X,
+        .class_init     = bcm2837_class_init,
+#endif
+    }, {
+        .name           = TYPE_BCM283X,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(BCM283XState),
+        .instance_init  = bcm2836_init,
+        .class_size     = sizeof(BCM283XClass),
+        .class_init     = bcm283x_class_init,
+        .abstract       = true,
     }
-}
+};
 
-type_init(bcm2836_register_types)
+DEFINE_TYPES(bcm283x_types)
-- 
2.21.1


