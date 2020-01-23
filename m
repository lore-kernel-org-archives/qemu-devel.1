Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD39C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C26E2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Km2C4DTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C26E2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60101 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf4v-0005f6-9Q
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuT-0001VC-AQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuR-0001Ji-VN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29194
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuR-0001JW-SE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX+b1ImPAaBl326v1I8s12MpD2lknVA1E1FuR0YYiCs=;
 b=Km2C4DTI9YZbMaMlk6xRkrejj7ZfpFqHXLEcHnQMKXNYiOFYQLeXl8bzV7QJ1Dc3/asFEQ
 bpAiU+3toChBminhUrwYDCD4a9MnywzGyJtznrhX4D7PPXbyA4rOuUPWKhHprtGpsxZ0Z7
 RfvR2IiUy4j7TS21rnocbEgmDROHeqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-WqbPiTGkNJumLjPI3BN1og-1; Thu, 23 Jan 2020 08:52:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89FD1939AD
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:32 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C34A01CB
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/59] qdev: rename DeviceClass.props
Date: Thu, 23 Jan 2020 14:50:39 +0100
Message-Id: <1579787449-27599-50-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WqbPiTGkNJumLjPI3BN1og-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

Ensure that conflicts in the future will cause a syntax error.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-properties.c | 2 +-
 hw/core/qdev.c            | 8 ++++----
 include/hw/qdev-core.h    | 7 ++++++-
 qdev-monitor.c            | 2 +-
 qom/qom-qmp-cmds.c        | 2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 6ca7697..43a9153 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1071,7 +1071,7 @@ static Property *qdev_prop_find(DeviceState *dev, con=
st char *name)
     /* device properties */
     class =3D object_get_class(OBJECT(dev));
     do {
-        prop =3D qdev_prop_walk(DEVICE_CLASS(class)->props, name);
+        prop =3D qdev_prop_walk(DEVICE_CLASS(class)->props_, name);
         if (prop) {
             return prop;
         }
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8047ac9..100e266 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -751,7 +751,7 @@ void qdev_alias_all_properties(DeviceState *target, Obj=
ect *source)
     do {
         DeviceClass *dc =3D DEVICE_CLASS(class);
=20
-        for (prop =3D dc->props; prop && prop->name; prop++) {
+        for (prop =3D dc->props_; prop && prop->name; prop++) {
             object_property_add_alias(source, prop->name,
                                       OBJECT(target), prop->name,
                                       &error_abort);
@@ -954,7 +954,7 @@ static void device_initfn(Object *obj)
=20
     class =3D object_get_class(OBJECT(dev));
     do {
-        for (prop =3D DEVICE_CLASS(class)->props; prop && prop->name; prop=
++) {
+        for (prop =3D DEVICE_CLASS(class)->props_; prop && prop->name; pro=
p++) {
             qdev_property_add_legacy(dev, prop, &error_abort);
             qdev_property_add_static(dev, prop);
         }
@@ -1013,7 +1013,7 @@ static void device_class_base_init(ObjectClass *class=
, void *data)
     /* We explicitly look up properties in the superclasses,
      * so do not propagate them to the subclasses.
      */
-    klass->props =3D NULL;
+    klass->props_ =3D NULL;
 }
=20
 static void device_unparent(Object *obj)
@@ -1063,7 +1063,7 @@ static void device_class_init(ObjectClass *class, voi=
d *data)
=20
 void device_class_set_props(DeviceClass *dc, Property *props)
 {
-    dc->props =3D props;
+    dc->props_ =3D props;
 }
=20
 void device_class_set_parent_reset(DeviceClass *dc,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 4065162..506ad35 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -100,7 +100,12 @@ typedef struct DeviceClass {
     DECLARE_BITMAP(categories, DEVICE_CATEGORY_MAX);
     const char *fw_name;
     const char *desc;
-    Property *props;
+
+    /*
+     * The underscore at the end ensures a compile-time error if someone
+     * assigns to dc->props instead of using device_class_set_props.
+     */
+    Property *props_;
=20
     /*
      * Can this device be instantiated with -device / device_add?
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 3465a1e..c929262 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -748,7 +748,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev, =
int indent)
     }
     class =3D object_get_class(OBJECT(dev));
     do {
-        qdev_print_props(mon, dev, DEVICE_CLASS(class)->props, indent);
+        qdev_print_props(mon, dev, DEVICE_CLASS(class)->props_, indent);
         class =3D object_class_get_parent(class);
     } while (class !=3D object_class_by_name(TYPE_DEVICE));
     bus_print_dev(dev->parent_bus, mon, dev, indent);
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index f4494f9..ccd3aaa 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -137,7 +137,7 @@ static ObjectPropertyInfo *make_device_property_info(Ob=
jectClass *klass,
     Property *prop;
=20
     do {
-        for (prop =3D DEVICE_CLASS(klass)->props; prop && prop->name; prop=
++) {
+        for (prop =3D DEVICE_CLASS(klass)->props_; prop && prop->name; pro=
p++) {
             if (strcmp(name, prop->name) !=3D 0) {
                 continue;
             }
--=20
1.8.3.1



