Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC4C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239A3206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcIYNhCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239A3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpXu-0008O1-9x
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKU-0001CT-JU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKT-0006fA-6Z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKS-0006eu-Vk
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAYLPxHUnOlrNHYHvYLYzD4/J8jjhxAfYHPGN6DyHN4=;
 b=JcIYNhCcyFjsFcU5roOX6w/r0bSgcdsQNsIGn2UK/0P4LNGIrYRSM94B9lOnP1T4jG4oXY
 H7cnqz5tTeu/mFSB5ECAWxE1wHr9FI6bN3mDCUsE4aknhUrHe1mvXWUQOCHUszJ6eN3+GL
 HkCpc5Fibljs3xeolhq2/UbB1lLTTSI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-JPcsCRNhMAKcmy6HWXKH8Q-1; Fri, 13 Mar 2020 14:46:38 -0400
X-MC-Unique: JPcsCRNhMAKcmy6HWXKH8Q-1
Received: by mail-wr1-f71.google.com with SMTP id n11so4235561wrs.13
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cIXy97ZAaCWGemZtPhQNSpEKiIqxtcSXAi/QC+TSqM0=;
 b=S9aTgjH4PIrDy0FxlSuwImIB0Zw223gqRkyJOMJfZ3WxI7AO9DsW6h8rjZmAUhXgxI
 xXsfyva5XrRP6H9sDksuYYvp5Z8MgK4FpOUFERv/mv4zzanOMeFZd5NOOJUMpd+B2jb2
 /FCwS1I+qqx7hR+EqVQNilOTt+kxWUGzRTQigsX+Z6iGw03P2NPiY2Hj809IaTvGyq19
 3X9P2vRQh1ymhzgxucGY736T716bbURARfatz8XHd0fVTMxVTxjXh3g/aFGZqvEW3rN7
 l/miMzAC3Frc11hFLolndqfSNroXgj039gj+3VS+i9oocCLqIuXJw5W2MetSTewVQJS6
 Du9w==
X-Gm-Message-State: ANhLgQ0e6UXDqik30bnUuyLZ+/rHbKxf7dzDmvJTDcsn2Qk/UQzQMQc+
 yGtGFhruymxNeoehR+E6pX4kbk8nZrEiqLxpKZjxTo/0mQWJB6yHdqNPbQAe0VdJ91GUv/5az3K
 AtqgTtfw4+PubFWg=
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr12537676wmc.171.1584125197412; 
 Fri, 13 Mar 2020 11:46:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtFeKSD2DbvqurrcqPhmXEEwtHORYygoit/XxpGA8biSIa/fimyf7g5cm6vWLLxCKizdMF2KA==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr12537651wmc.171.1584125197155; 
 Fri, 13 Mar 2020 11:46:37 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id g5sm14216255wrr.57.2020.03.13.11.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/9] hw/core/qdev-properties: Export some integer-related
 functions
Date: Fri, 13 Mar 2020 19:46:04 +0100
Message-Id: <20200313184607.11792-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to split this file and reuse these static functions.
Declare them in the local "qdev-prop-internal.h" header.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev-prop-internal.h |  9 ++++++++
 hw/core/qdev-properties.c    | 42 +++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index 2a8c9a306a..dd2f215f1c 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -15,5 +15,14 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, con=
st char *name,
=20
 void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
                                           const Property *prop);
+void qdev_propinfo_set_default_value_int(ObjectProperty *op,
+                                         const Property *prop);
+void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
+                                          const Property *prop);
+
+void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp);
+void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp);
=20
 #endif
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5912c394d4..534fc674db 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -275,12 +275,14 @@ static void set_uint8(Object *obj, Visitor *v, const =
char *name, void *opaque,
     visit_type_uint8(v, name, ptr, errp);
 }
=20
-static void set_default_value_int(ObjectProperty *op, const Property *prop=
)
+void qdev_propinfo_set_default_value_int(ObjectProperty *op,
+                                         const Property *prop)
 {
     object_property_set_default_int(op, prop->defval.i);
 }
=20
-static void set_default_value_uint(ObjectProperty *op, const Property *pro=
p)
+void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
+                                          const Property *prop)
 {
     object_property_set_default_uint(op, prop->defval.u);
 }
@@ -289,13 +291,13 @@ const PropertyInfo qdev_prop_uint8 =3D {
     .name  =3D "uint8",
     .get   =3D get_uint8,
     .set   =3D set_uint8,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- 16bit integer --- */
=20
-static void get_uint16(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
+void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
@@ -321,9 +323,9 @@ static void set_uint16(Object *obj, Visitor *v, const c=
har *name,
=20
 const PropertyInfo qdev_prop_uint16 =3D {
     .name  =3D "uint16",
-    .get   =3D get_uint16,
+    .get   =3D qdev_propinfo_get_uint16,
     .set   =3D set_uint16,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- 32bit integer --- */
@@ -353,8 +355,8 @@ static void set_uint32(Object *obj, Visitor *v, const c=
har *name,
     visit_type_uint32(v, name, ptr, errp);
 }
=20
-static void get_int32(Object *obj, Visitor *v, const char *name, void *opa=
que,
-                      Error **errp)
+void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
@@ -382,14 +384,14 @@ const PropertyInfo qdev_prop_uint32 =3D {
     .name  =3D "uint32",
     .get   =3D get_uint32,
     .set   =3D set_uint32,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 const PropertyInfo qdev_prop_int32 =3D {
     .name  =3D "int32",
-    .get   =3D get_int32,
+    .get   =3D qdev_propinfo_get_int32,
     .set   =3D set_int32,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D qdev_propinfo_set_default_value_int,
 };
=20
 /* --- 64bit integer --- */
@@ -448,14 +450,14 @@ const PropertyInfo qdev_prop_uint64 =3D {
     .name  =3D "uint64",
     .get   =3D get_uint64,
     .set   =3D set_uint64,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 const PropertyInfo qdev_prop_int64 =3D {
     .name  =3D "int64",
     .get   =3D get_int64,
     .set   =3D set_int64,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D qdev_propinfo_set_default_value_int,
 };
=20
 /* --- string --- */
@@ -739,9 +741,9 @@ const PropertyInfo qdev_prop_pci_devfn =3D {
     .name  =3D "int32",
     .description =3D "Slot and optional function number, example: 06.0 or =
06",
     .print =3D print_pci_devfn,
-    .get   =3D get_int32,
+    .get   =3D qdev_propinfo_get_int32,
     .set   =3D set_pci_devfn,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- blocksize --- */
@@ -787,9 +789,9 @@ static void set_blocksize(Object *obj, Visitor *v, cons=
t char *name,
 const PropertyInfo qdev_prop_blocksize =3D {
     .name  =3D "uint16",
     .description =3D "A power of two between 512 and 32768",
-    .get   =3D get_uint16,
+    .get   =3D qdev_propinfo_get_uint16,
     .set   =3D set_blocksize,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- pci host address --- */
@@ -1071,7 +1073,7 @@ const PropertyInfo qdev_prop_arraylen =3D {
     .name =3D "uint32",
     .get =3D get_uint32,
     .set =3D set_prop_arraylen,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- public helpers --- */
@@ -1265,7 +1267,7 @@ const PropertyInfo qdev_prop_size =3D {
     .name  =3D "size",
     .get =3D get_size,
     .set =3D set_size,
-    .set_default_value =3D set_default_value_uint,
+    .set_default_value =3D qdev_propinfo_set_default_value_uint,
 };
=20
 /* --- object link property --- */
--=20
2.21.1


