Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A430FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AA82064C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjAs6WXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AA82064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueQg-0006l0-P7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucra-0005Hm-Sp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrZ-0003xq-Ce
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrZ-0003tm-55
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id q9so2636076wmj.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wOZKXE7AorDry02zwCbHQd2VJJlOO0auii3FGQwWC48=;
 b=VjAs6WXMmqWPkBZfM9WJdJ39aEbu49bbcM0h9eMYw/J4uuzLZMsUAkq4MOVDHAZ4tD
 zH1VJIq6IezJmfkpSumT1rzpeYtBjftzreYHBCrVcI3d/qKmQPEDdQcGgKWpPW0mrNm8
 FSpEDPftoXZfhWnEwL9GVClekbi78tSWDrIR2amWzYjWZVl8AIlCCdHpVp/HrdkGZIc2
 Loq5wl55EG3nsf5BF9xfKIL6zKXoZLOwcv7oVElSf5pQF15vbpNzl4SGNEuWiFVqW4Fc
 tQI5hwUsstpzZXolhTFTAPuwATB+oymgOWiIng6iA5j7eZjB5LAXtn7ZRsZ7xdz0FkI4
 0Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wOZKXE7AorDry02zwCbHQd2VJJlOO0auii3FGQwWC48=;
 b=L9ge6CIVLs6yyiBMJ0bg5vKGEKBrarPfrEmNZhdOlyCHz572OyrDyf0fdQebCHJMzO
 m46sTAFMvYz9HwfBwSzrMlrqvGv4kq45eWIcRBnLottY7NoDEpb96zrMQzRvp23IQdv2
 oP4qb4qrnVEMGHcjRLDaMP/EsjDUr3DKaca7l8viv7t2nl0cvYyKuoKKYqQWblJ460pI
 ltSHy8X7MXIBwmeOCVgJDz2PCYBKyFLv1GyQnva1dDiVvRUHRbIrqmtCgWTCFye4pkW6
 r1nyhxnTuBVVfy3DjGMt5C64nmdo3xJW3vmFeL9PDuBnWoCyVnN8mm0pkTShY8H/IPZo
 aPiQ==
X-Gm-Message-State: APjAAAV9vjYT4rEhsq8egTdpfVg5mU6V3+decP2kPz4W/96+zA6h4UjO
 ncpQc5QjCYAz8SOgcn07Cz+OLqfJ
X-Google-Smtp-Source: APXvYqx5BGq6bmGTmqnu+hlYgoACuIcZqwp4NMRg6le4qfa50fLZwbJuLCnrT5ojRRVk1OFzwq1nxg==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr4429316wmb.42.1579787376018; 
 Thu, 23 Jan 2020 05:49:36 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/59] qdev: remove extraneous error
Date: Thu, 23 Jan 2020 14:48:36 +0100
Message-Id: <1579787342-27146-34-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

All callers use error_abort, and even the function itself calls with
error_abort.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c               | 15 ++++-----------
 include/hw/qdev-properties.h |  3 +--
 target/arm/cpu.c             | 36 ++++++++++++------------------------
 3 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index b47dc07..60aec8b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -717,24 +717,17 @@ static void qdev_property_add_legacy(DeviceState *dev, Property *prop,
     g_free(name);
 }
 
-void qdev_property_add_static(DeviceState *dev, Property *prop,
-                              Error **errp)
+void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
-    Error *local_err = NULL;
     Object *obj = OBJECT(dev);
 
     if (prop->info->create) {
-        prop->info->create(obj, prop, &local_err);
+        prop->info->create(obj, prop, &error_abort);
     } else {
         object_property_add(obj, prop->name, prop->info->name,
                             prop->info->get, prop->info->set,
                             prop->info->release,
-                            prop, &local_err);
-    }
-
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+                            prop, &error_abort);
     }
 
     object_property_set_description(obj, prop->name,
@@ -989,7 +982,7 @@ static void device_initfn(Object *obj)
     do {
         for (prop = DEVICE_CLASS(class)->props; prop && prop->name; prop++) {
             qdev_property_add_legacy(dev, prop, &error_abort);
-            qdev_property_add_static(dev, prop, &error_abort);
+            qdev_property_add_static(dev, prop);
         }
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index a90a9ce..906e697 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -253,13 +253,12 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
  * qdev_property_add_static:
  * @dev: Device to add the property to.
  * @prop: The qdev property definition.
- * @errp: location to store error information.
  *
  * Add a static QOM property to @dev for qdev property @prop.
  * On error, store error in @errp.  Static properties access data in a struct.
  * The type of the QOM property is derived from prop->info.
  */
-void qdev_property_add_static(DeviceState *dev, Property *prop, Error **errp);
+void qdev_property_add_static(DeviceState *dev, Property *prop);
 
 void qdev_alias_all_properties(DeviceState *target, Object *source);
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 411faaa..d161da8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1104,26 +1104,22 @@ void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property);
     }
 
     if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_property);
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_rvbar_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_rvbar_property);
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         /* Add the has_el3 state CPU property only if EL3 is allowed.  This will
          * prevent "has_el3" from existing on CPUs which cannot support EL3.
          */
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el3_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el3_property);
 
 #ifndef CONFIG_USER_ONLY
         object_property_add_link(obj, "secure-memory",
@@ -1136,8 +1132,7 @@ void arm_cpu_post_init(Object *obj)
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
@@ -1154,32 +1149,27 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
         cpu->has_vfp = true;
         if (!kvm_enabled()) {
-            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property,
-                                     &error_abort);
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property);
         }
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
         cpu->has_neon = true;
         if (!kvm_enabled()) {
-            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property,
-                                     &error_abort);
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property);
         }
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_M) &&
         arm_feature(&cpu->env, ARM_FEATURE_THUMB_DSP)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property);
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property);
         if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
             qdev_property_add_static(DEVICE(obj),
-                                     &arm_cpu_pmsav7_dregion_property,
-                                     &error_abort);
+                                     &arm_cpu_pmsav7_dregion_property);
         }
     }
 
@@ -1198,12 +1188,10 @@ void arm_cpu_post_init(Object *obj)
                             NULL, NULL, &error_abort);
     }
 
-    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
-                             &error_abort);
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
 
     if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
-        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
     }
 }
 
-- 
1.8.3.1



