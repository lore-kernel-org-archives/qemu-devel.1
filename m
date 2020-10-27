Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C4FC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7747721D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcIAobtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7747721D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOSf-0000Pb-Eq
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPh-0001ZS-A4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPa-0004Zy-FM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id h22so1103907wmb.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oFTqEA1Ec4xzgG6UB1H8yvtpkow/6LqkhyaFb7FLJRU=;
 b=YcIAobtxasVZwvCPagdtbO+3n+xL5N8XJRUk3U/B/oE4IjcTGXoNkd1cpsnZAdoO8D
 GdgUy6vNG0xY3MvrIE1WCAcy2vfI125/8W8YEdbxlKlf56pKIgM+tqAzy4M1In6SCBIi
 Lcp38UL3LWLDT1Lt2uzx89LhCaES9XFGdQh1+KORLLcc7hzyBnc7VMqez5jfqVEd4f2C
 55bilymawxPE3VjZlL/GsVVZIvYgDcdbrJCAq7wd3gJbJhnNoSKgnGhJJF0C4tOnHr29
 Lo4OJdvwOyzVrvyYrXhUPbxPg2uIKr16nDRcDxr58ZRb+SGV21u8haKgTzC8nvYfLxkv
 VXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oFTqEA1Ec4xzgG6UB1H8yvtpkow/6LqkhyaFb7FLJRU=;
 b=sj/0DcAhLQEMN4iKmQuYUQf51S6usc6aCwggVWtgeNGX5vnEhgRPF73rOyyrK0LJPb
 stClwcO0KdwioJfjArKlMzCy5kNj8ahJ/NQ+4xti5BwZhdephoWsYlfTHKmSzgIDMC1e
 yQ7lAnE/PC6iVMhYG5I+DjEHqV/BNZM1W5SXDQpgitM7dZ41W8Z5NJhQU1ZyoJL1nJH3
 cqgFq8k3dn8vFDuBIa1iFsusNJWWeY6Me222T30VHCpLpqEL2R/TN/qJMbI/b0D2g+jI
 /bTMJbXECB5LFDgHv09Y2QDF+P5sJCoIlyW3953XX1ERgbVp2BmQtdtcWwfjYNfXz8mx
 TFmA==
X-Gm-Message-State: AOAM532s1nJ3hs15t2epBswuocNEQu8oWb/CVScWh0osoro7uoeENrQp
 HnOEH5Htz7BFFTjfXgqwUf0LkpsPK7tbwA==
X-Google-Smtp-Source: ABdhPJzlXlwEcflTctBJtJZsc6ozfsU7XaXydgeh/MXsfpgj3oF7j94qXls6YU/84Pzlcq2zZYhzxw==
X-Received: by 2002:a7b:c015:: with SMTP id c21mr2286631wmb.22.1603799108232; 
 Tue, 27 Oct 2020 04:45:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/48] hw/arm/bcm2836: QOM'ify more by adding class_init() to
 each SoC type
Date: Tue, 27 Oct 2020 11:44:12 +0000
Message-Id: <20201027114438.17662-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Remove usage of TypeInfo::class_data. Instead fill the fields in
the corresponding class_init().

So far all children use the same values for almost all fields,
but we are going to add the BCM2711/BCM2838 SoC for the raspi4
machine which use different fields.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201024170127.3592182-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2836.c | 108 ++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 57 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index e7cc2c930d9..8f921d8e904 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -17,57 +17,31 @@
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
     const char *name;
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
-                                info->cpu_type);
+                                bc->cpu_type);
     }
 
     object_initialize_child(obj, "control", &s->control, TYPE_BCM2836_CONTROL);
@@ -84,7 +58,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
-    const BCM283XInfo *info = bc->info;
     Object *obj;
     int n;
 
@@ -102,14 +75,14 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                               "sd-bus");
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
-                            info->peri_base, 1);
+                            bc->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), errp)) {
         return;
     }
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
@@ -118,11 +91,11 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
         /* TODO: this should be converted to a property of ARM_CPU */
-        s->cpu[n].core.mp_affinity = (info->clusterid << 8) | n;
+        s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
         if (!object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
-                                     info->peri_base, errp)) {
+                                     bc->peri_base, errp)) {
             return;
         }
 
@@ -165,38 +138,59 @@ static Property bcm2836_props[] = {
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
2.20.1


