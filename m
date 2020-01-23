Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35BAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF52214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9cmQTiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF52214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuemW-00033o-Rl
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrf-0005PK-Ac
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrd-0004CR-JI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:47023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrd-00049I-Bk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:41 -0500
Received: by mail-wr1-x432.google.com with SMTP id z7so3098748wrl.13
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OERtFp3Q/y9ZSPI8cgyrtVoTr3IWEd9WgGvVo945KWA=;
 b=f9cmQTiA3WG4LxqkbQj6KMd0VeJ/E/HQehW2jkb1e9Ond5jwBP+2flEAntyQxTMU+S
 YMW6l2WksOkZX7lbq1sc0+lgqMtxFM9xQOQ0JOlP8hacxUVh1t21qFWJdLOuumdoIq4R
 2lGy5sNkUDHSQpOGcuFXPICjih1RxE8qq3qCQ/NS9wgHwDLuP3JPPFNpDdrHPUZ/OslR
 h11wSAeXzqhTXYAIdBL2aRTQ/vZoWu9x2qMLzXDBJPX79UQ2UTSy47hiSzJwXHlgyWM0
 juExQt4yA2bxDJDIDR0VRUj2jn/pMpaDNizhiqiGVSVIMcJiEgcXnArKPHMU1ycmgzgb
 /0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OERtFp3Q/y9ZSPI8cgyrtVoTr3IWEd9WgGvVo945KWA=;
 b=GSwWolEue2jo1eWHZWlwFC7bAwPaVfhxdNQbSDJPqW6rvRpJeH4gcaw3fiSqv0RboV
 sdddqgIEZYe/BicMzPn+F/du1mLlyhlsnGkfhaDYUrJGKHVWPaG4SQkaSg2A0K7poDLh
 JoSUK0ebtHatEmV8quhj4HS/VhYQkmFO3Uqd84OeR7Qf0zQvumsq6ezgprv4Ev+oZGxV
 eZC6sfW9DJ+AJ1GmOc4zGAfgqArDxrSiZOc3i6+DG0MZXkAYiKcVXgdfYObOHTGb4Xik
 l7HtLusDbgA/v4wWqvQXEXvIdFSQFF+DRiClggEkLsZoeA78Vzu/Z827ayDc9xndBY2X
 KCPQ==
X-Gm-Message-State: APjAAAVq0wd0A5xgGPBrS/gEC9rk/Xo+GcvYfLIcmh+Lw7HWEbHUtTEf
 3kTWjgAoYgL03VTJ+h1cqAarimMi
X-Google-Smtp-Source: APXvYqx1oHDukj04xWlbH8PntS9uz6GMsB5JP7T4B5BTq6freQ3b3ni//hoetmoplCdk2tBSBtebxw==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr17514860wrn.384.1579787380137; 
 Thu, 23 Jan 2020 05:49:40 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/59] object: make object_class_property_add* return property
Date: Thu, 23 Jan 2020 14:48:41 +0100
Message-Id: <1579787342-27146-39-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

This will help calling other ObjectProperty associated functions
easily after.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-9-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 24 +++++++++++++-------
 qom/object.c         | 64 ++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index ca47308..9f52bc3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1556,7 +1556,8 @@ void object_property_add_str(Object *obj, const char *name,
                              void (*set)(Object *, const char *, Error **),
                              Error **errp);
 
-void object_class_property_add_str(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_str(ObjectClass *klass,
+                                   const char *name,
                                    char *(*get)(Object *, Error **),
                                    void (*set)(Object *, const char *,
                                                Error **),
@@ -1578,7 +1579,8 @@ void object_property_add_bool(Object *obj, const char *name,
                               void (*set)(Object *, bool, Error **),
                               Error **errp);
 
-void object_class_property_add_bool(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
+                                    const char *name,
                                     bool (*get)(Object *, Error **),
                                     void (*set)(Object *, bool, Error **),
                                     Error **errp);
@@ -1602,7 +1604,8 @@ void object_property_add_enum(Object *obj, const char *name,
                               void (*set)(Object *, int, Error **),
                               Error **errp);
 
-void object_class_property_add_enum(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
+                                    const char *name,
                                     const char *typename,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
@@ -1623,7 +1626,8 @@ void object_property_add_tm(Object *obj, const char *name,
                             void (*get)(Object *, struct tm *, Error **),
                             Error **errp);
 
-void object_class_property_add_tm(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
+                                  const char *name,
                                   void (*get)(Object *, struct tm *, Error **),
                                   Error **errp);
 
@@ -1639,7 +1643,8 @@ void object_class_property_add_tm(ObjectClass *klass, const char *name,
  */
 void object_property_add_uint8_ptr(Object *obj, const char *name,
                                    const uint8_t *v, Error **errp);
-void object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+                                         const char *name,
                                          const uint8_t *v, Error **errp);
 
 /**
@@ -1654,7 +1659,8 @@ void object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
  */
 void object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v, Error **errp);
-void object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+                                          const char *name,
                                           const uint16_t *v, Error **errp);
 
 /**
@@ -1669,7 +1675,8 @@ void object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
  */
 void object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v, Error **errp);
-void object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+                                          const char *name,
                                           const uint32_t *v, Error **errp);
 
 /**
@@ -1684,7 +1691,8 @@ void object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
  */
 void object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v, Error **errp);
-void object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
+ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+                                          const char *name,
                                           const uint64_t *v, Error **errp);
 
 /**
diff --git a/qom/object.c b/qom/object.c
index 49c2429..213a796 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2074,7 +2074,8 @@ void object_property_add_str(Object *obj, const char *name,
     }
 }
 
-void object_class_property_add_str(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_str(ObjectClass *klass, const char *name,
                                    char *(*get)(Object *, Error **),
                                    void (*set)(Object *, const char *,
                                                Error **),
@@ -2082,11 +2083,12 @@ void object_class_property_add_str(ObjectClass *klass, const char *name,
 {
     Error *local_err = NULL;
     StringProperty *prop = g_malloc0(sizeof(*prop));
+    ObjectProperty *rv;
 
     prop->get = get;
     prop->set = set;
 
-    object_class_property_add(klass, name, "string",
+    rv = object_class_property_add(klass, name, "string",
                               get ? property_get_str : NULL,
                               set ? property_set_str : NULL,
                               property_release_str,
@@ -2095,6 +2097,8 @@ void object_class_property_add_str(ObjectClass *klass, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
 
 typedef struct BoolProperty
@@ -2164,18 +2168,20 @@ void object_property_add_bool(Object *obj, const char *name,
     }
 }
 
-void object_class_property_add_bool(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_bool(ObjectClass *klass, const char *name,
                                     bool (*get)(Object *, Error **),
                                     void (*set)(Object *, bool, Error **),
                                     Error **errp)
 {
     Error *local_err = NULL;
     BoolProperty *prop = g_malloc0(sizeof(*prop));
+    ObjectProperty *rv;
 
     prop->get = get;
     prop->set = set;
 
-    object_class_property_add(klass, name, "bool",
+    rv = object_class_property_add(klass, name, "bool",
                               get ? property_get_bool : NULL,
                               set ? property_set_bool : NULL,
                               property_release_bool,
@@ -2184,6 +2190,8 @@ void object_class_property_add_bool(ObjectClass *klass, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
 
 static void property_get_enum(Object *obj, Visitor *v, const char *name,
@@ -2249,7 +2257,8 @@ void object_property_add_enum(Object *obj, const char *name,
     }
 }
 
-void object_class_property_add_enum(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_enum(ObjectClass *klass, const char *name,
                                     const char *typename,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
@@ -2258,12 +2267,13 @@ void object_class_property_add_enum(ObjectClass *klass, const char *name,
 {
     Error *local_err = NULL;
     EnumProperty *prop = g_malloc(sizeof(*prop));
+    ObjectProperty *rv;
 
     prop->lookup = lookup;
     prop->get = get;
     prop->set = set;
 
-    object_class_property_add(klass, name, typename,
+    rv = object_class_property_add(klass, name, typename,
                               get ? property_get_enum : NULL,
                               set ? property_set_enum : NULL,
                               property_release_enum,
@@ -2272,6 +2282,8 @@ void object_class_property_add_enum(ObjectClass *klass, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
 
 typedef struct TMProperty {
@@ -2352,16 +2364,18 @@ void object_property_add_tm(Object *obj, const char *name,
     }
 }
 
-void object_class_property_add_tm(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_tm(ObjectClass *klass, const char *name,
                                   void (*get)(Object *, struct tm *, Error **),
                                   Error **errp)
 {
     Error *local_err = NULL;
     TMProperty *prop = g_malloc0(sizeof(*prop));
+    ObjectProperty *rv;
 
     prop->get = get;
 
-    object_class_property_add(klass, name, "struct tm",
+    rv = object_class_property_add(klass, name, "struct tm",
                               get ? property_get_tm : NULL, NULL,
                               property_release_tm,
                               prop, &local_err);
@@ -2369,6 +2383,8 @@ void object_class_property_add_tm(ObjectClass *klass, const char *name,
         error_propagate(errp, local_err);
         g_free(prop);
     }
+
+    return rv;
 }
 
 static char *qdev_get_type(Object *obj, Error **errp)
@@ -2411,11 +2427,13 @@ void object_property_add_uint8_ptr(Object *obj, const char *name,
                         NULL, NULL, (void *)v, errp);
 }
 
-void object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
                                          const uint8_t *v, Error **errp)
 {
-    object_class_property_add(klass, name, "uint8", property_get_uint8_ptr,
-                              NULL, NULL, (void *)v, errp);
+    return object_class_property_add(klass, name, "uint8",
+                                     property_get_uint8_ptr,
+                                     NULL, NULL, (void *)v, errp);
 }
 
 void object_property_add_uint16_ptr(Object *obj, const char *name,
@@ -2425,11 +2443,13 @@ void object_property_add_uint16_ptr(Object *obj, const char *name,
                         NULL, NULL, (void *)v, errp);
 }
 
-void object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
                                           const uint16_t *v, Error **errp)
 {
-    object_class_property_add(klass, name, "uint16", property_get_uint16_ptr,
-                              NULL, NULL, (void *)v, errp);
+    return object_class_property_add(klass, name, "uint16",
+                                     property_get_uint16_ptr,
+                                     NULL, NULL, (void *)v, errp);
 }
 
 void object_property_add_uint32_ptr(Object *obj, const char *name,
@@ -2439,11 +2459,13 @@ void object_property_add_uint32_ptr(Object *obj, const char *name,
                         NULL, NULL, (void *)v, errp);
 }
 
-void object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
                                           const uint32_t *v, Error **errp)
 {
-    object_class_property_add(klass, name, "uint32", property_get_uint32_ptr,
-                              NULL, NULL, (void *)v, errp);
+    return object_class_property_add(klass, name, "uint32",
+                                     property_get_uint32_ptr,
+                                     NULL, NULL, (void *)v, errp);
 }
 
 void object_property_add_uint64_ptr(Object *obj, const char *name,
@@ -2453,11 +2475,13 @@ void object_property_add_uint64_ptr(Object *obj, const char *name,
                         NULL, NULL, (void *)v, errp);
 }
 
-void object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
+ObjectProperty *
+object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
                                           const uint64_t *v, Error **errp)
 {
-    object_class_property_add(klass, name, "uint64", property_get_uint64_ptr,
-                              NULL, NULL, (void *)v, errp);
+    return object_class_property_add(klass, name, "uint64",
+                                     property_get_uint64_ptr,
+                                     NULL, NULL, (void *)v, errp);
 }
 
 typedef struct {
-- 
1.8.3.1



