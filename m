Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B1421569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyM0R9Yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B1421569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufik-00013Q-Tp
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucu0-0000lR-Nu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuctz-0000mx-6q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47393
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctz-0000m5-3U
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sIDfpUAfjmb3GO2cMU5bNvUrPqrsqmxPRyHuEIvKml0=;
 b=eyM0R9YfPADl5wH01nu+lUYsnsCTIioqFuqw7yglIeYk3scRd5o1xLaHePgHgO1nwhwpSK
 rW6cZ0AgCr34irWoJXxhAfwHYqpQWbF4ySDhO/EyIIupwtLSrC4RoSU0xceAKmYgnNq4Rg
 ulYk+RalQUC739XvjJ2O1HmN4mClqCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-cE9VDBzTO3G_SOnexpkXKQ-1; Thu, 23 Jan 2020 08:52:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F2FD9A289
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:03 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55FA085780;
 Thu, 23 Jan 2020 13:52:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/59] qdev: remove extraneous error
Date: Thu, 23 Jan 2020 14:50:23 +0100
Message-Id: <1579787449-27599-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: cE9VDBzTO3G_SOnexpkXKQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

All callers use error_abort, and even the function itself calls with
error_abort.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
@@ -717,24 +717,17 @@ static void qdev_property_add_legacy(DeviceState *dev=
, Property *prop,
     g_free(name);
 }
=20
-void qdev_property_add_static(DeviceState *dev, Property *prop,
-                              Error **errp)
+void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
-    Error *local_err =3D NULL;
     Object *obj =3D OBJECT(dev);
=20
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
=20
     object_property_set_description(obj, prop->name,
@@ -989,7 +982,7 @@ static void device_initfn(Object *obj)
     do {
         for (prop =3D DEVICE_CLASS(class)->props; prop && prop->name; prop=
++) {
             qdev_property_add_legacy(dev, prop, &error_abort);
-            qdev_property_add_static(dev, prop, &error_abort);
+            qdev_property_add_static(dev, prop);
         }
         class =3D object_class_get_parent(class);
     } while (class !=3D object_class_by_name(TYPE_DEVICE));
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index a90a9ce..906e697 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -253,13 +253,12 @@ void error_set_from_qdev_prop_error(Error **errp, int=
 ret, DeviceState *dev,
  * qdev_property_add_static:
  * @dev: Device to add the property to.
  * @prop: The qdev property definition.
- * @errp: location to store error information.
  *
  * Add a static QOM property to @dev for qdev property @prop.
  * On error, store error in @errp.  Static properties access data in a str=
uct.
  * The type of the QOM property is derived from prop->info.
  */
-void qdev_property_add_static(DeviceState *dev, Property *prop, Error **er=
rp);
+void qdev_property_add_static(DeviceState *dev, Property *prop);
=20
 void qdev_alias_all_properties(DeviceState *target, Object *source);
=20
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 411faaa..d161da8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1104,26 +1104,22 @@ void arm_cpu_post_init(Object *obj)
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property=
,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property=
);
     }
=20
     if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_proper=
ty,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_proper=
ty);
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_rvbar_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_rvbar_property);
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         /* Add the has_el3 state CPU property only if EL3 is allowed.  Thi=
s will
          * prevent "has_el3" from existing on CPUs which cannot support EL=
3.
          */
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el3_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el3_property);
=20
 #ifndef CONFIG_USER_ONLY
         object_property_add_link(obj, "secure-memory",
@@ -1136,8 +1132,7 @@ void arm_cpu_post_init(Object *obj)
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
@@ -1154,32 +1149,27 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
         cpu->has_vfp =3D true;
         if (!kvm_enabled()) {
-            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_propert=
y,
-                                     &error_abort);
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_propert=
y);
         }
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
         cpu->has_neon =3D true;
         if (!kvm_enabled()) {
-            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_proper=
ty,
-                                     &error_abort);
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_proper=
ty);
         }
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_M) &&
         arm_feature(&cpu->env, ARM_FEATURE_THUMB_DSP)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property);
     }
=20
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
=20
@@ -1198,12 +1188,10 @@ void arm_cpu_post_init(Object *obj)
                             NULL, NULL, &error_abort);
     }
=20
-    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
-                             &error_abort);
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
-        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property)=
;
     }
 }
=20
--=20
1.8.3.1



