Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2B5C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9999F205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Os3bWgsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9999F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwYh-0006FE-Ol
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwHz-0008Ud-1u
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwHw-0001ij-RI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26549
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwHw-0001ga-MM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONK3peM5o23dysGCeGaKgCbK3oNvNYjMkTlDgtsX0Xs=;
 b=Os3bWgsZyWb+vLKlVsbBAQOPVnpaWPpBR9KAk0LQYh/rEpoW7BeWkeXJakWWNALaYzlAhe
 ZEbm1Cg1i5Ipggjrdc7ligKwoOFWbesrKrb7Pro61XbnzCn9AXYaeiM1zi7IisV5N+SDVW
 rTnvuG4SVqglwOLU99Bhx583mO8O3n0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-JCQs080AN728TBHds9nVJg-1; Fri, 10 Jan 2020 10:33:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 118568C3068
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:33:24 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 265F019C6A;
 Fri, 10 Jan 2020 15:33:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/26] object: rename link "child" to "target"
Date: Fri, 10 Jan 2020 19:30:26 +0400
Message-Id: <20200110153039.1379601-14-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: JCQs080AN728TBHds9nVJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A child property is a different kind of property. Let's use "target"
for the link target.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h |  4 ++--
 qom/object.c         | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index fb133d693f..7e66bc78c9 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1545,7 +1545,7 @@ void object_property_allow_set_link(const Object *, c=
onst char *,
  * @obj: the object to add a property to
  * @name: the name of the property
  * @type: the qobj type of the link
- * @child: a pointer to where the link object reference is stored
+ * @targetp: a pointer to where the link object reference is stored
  * @check: callback to veto setting or NULL if the property is read-only
  * @flags: additional options for the link
  * @errp: if an error occurs, a pointer to an area to store the error
@@ -1570,7 +1570,7 @@ void object_property_allow_set_link(const Object *, c=
onst char *,
  * modified.
  */
 void object_property_add_link(Object *obj, const char *name,
-                              const char *type, Object **child,
+                              const char *type, Object **targetp,
                               void (*check)(const Object *obj, const char =
*name,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags,
diff --git a/qom/object.c b/qom/object.c
index 9df4c14226..47d8be81a6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1720,7 +1720,7 @@ void object_property_allow_set_link(const Object *obj=
, const char *name,
 }
=20
 typedef struct {
-    Object **child;
+    Object **targetp;
     void (*check)(const Object *, const char *, Object *, Error **);
     ObjectPropertyLinkFlags flags;
 } LinkProperty;
@@ -1730,11 +1730,11 @@ static void object_get_link_property(Object *obj, V=
isitor *v,
                                      Error **errp)
 {
     LinkProperty *lprop =3D opaque;
-    Object **child =3D lprop->child;
+    Object **targetp =3D lprop->targetp;
     gchar *path;
=20
-    if (*child) {
-        path =3D object_get_canonical_path(*child);
+    if (*targetp) {
+        path =3D object_get_canonical_path(*targetp);
         visit_type_str(v, name, &path, errp);
         g_free(path);
     } else {
@@ -1789,8 +1789,8 @@ static void object_set_link_property(Object *obj, Vis=
itor *v,
 {
     Error *local_err =3D NULL;
     LinkProperty *prop =3D opaque;
-    Object **child =3D prop->child;
-    Object *old_target =3D *child;
+    Object **targetp =3D prop->targetp;
+    Object *old_target =3D *targetp;
     Object *new_target =3D NULL;
     char *path =3D NULL;
=20
@@ -1812,7 +1812,7 @@ static void object_set_link_property(Object *obj, Vis=
itor *v,
         return;
     }
=20
-    *child =3D new_target;
+    *targetp =3D new_target;
     if (prop->flags & OBJ_PROP_LINK_STRONG) {
         object_ref(new_target);
         object_unref(old_target);
@@ -1823,7 +1823,7 @@ static Object *object_resolve_link_property(Object *p=
arent, void *opaque, const
 {
     LinkProperty *lprop =3D opaque;
=20
-    return *lprop->child;
+    return *lprop->targetp;
 }
=20
 static void object_release_link_property(Object *obj, const char *name,
@@ -1831,14 +1831,14 @@ static void object_release_link_property(Object *ob=
j, const char *name,
 {
     LinkProperty *prop =3D opaque;
=20
-    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *prop->child) {
-        object_unref(*prop->child);
+    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *prop->targetp) {
+        object_unref(*prop->targetp);
     }
     g_free(prop);
 }
=20
 void object_property_add_link(Object *obj, const char *name,
-                              const char *type, Object **child,
+                              const char *type, Object **targetp,
                               void (*check)(const Object *, const char *,
                                             Object *, Error **),
                               ObjectPropertyLinkFlags flags,
@@ -1849,7 +1849,7 @@ void object_property_add_link(Object *obj, const char=
 *name,
     gchar *full_type;
     ObjectProperty *op;
=20
-    prop->child =3D child;
+    prop->targetp =3D targetp;
     prop->check =3D check;
     prop->flags =3D flags;
=20
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


