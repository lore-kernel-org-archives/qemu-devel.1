Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF576C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B877720714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fA8qKwiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B877720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRsL-0008AZ-QF
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRqr-0006O7-Va
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRqq-0005M3-Tg
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:25:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRqq-0005Lo-Py
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9NdW5T8GZNWnd06cgNoCXzbdnjkelvI2UZjDgoyrZ4=;
 b=fA8qKwiD9fan5AMfbN+stIOO4DK45WvxGCKu6M1pmC36nmEteY64AvPODgWqA7N3w1JPkl
 qLrZn96pbHvH9qE5LXhynqY2aP0Yg68HW4NKhUDoC7OXufrvrAjus91Yop8xxU2A7/RTSX
 0QGUXc+luctgUCWlzuDzygp9aUA1GRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-_QISwLbkOPSZe9W8GG7B_Q-1; Wed, 20 Nov 2019 10:25:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C630F801E7E;
 Wed, 20 Nov 2019 15:24:59 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 409826BF83;
 Wed, 20 Nov 2019 15:24:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/37] qdev: remove unused qdev_prop_int64
Date: Wed, 20 Nov 2019 19:24:06 +0400
Message-Id: <20191120152442.26657-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _QISwLbkOPSZe9W8GG7B_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c    | 32 --------------------------------
 include/hw/qdev-properties.h |  3 ---
 2 files changed, 35 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ac28890e5a..be4cb01f0b 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -409,31 +409,6 @@ static void set_uint64(Object *obj, Visitor *v, const =
char *name,
     visit_type_uint64(v, name, ptr, errp);
 }
=20
-static void get_int64(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
-
-    visit_type_int64(v, name, ptr, errp);
-}
-
-static void set_int64(Object *obj, Visitor *v, const char *name,
-                      void *opaque, Error **errp)
-{
-    DeviceState *dev =3D DEVICE(obj);
-    Property *prop =3D opaque;
-    int64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
-
-    if (dev->realized) {
-        qdev_prop_set_after_realize(dev, name, errp);
-        return;
-    }
-
-    visit_type_int64(v, name, ptr, errp);
-}
-
 const PropertyInfo qdev_prop_uint64 =3D {
     .name  =3D "uint64",
     .get   =3D get_uint64,
@@ -441,13 +416,6 @@ const PropertyInfo qdev_prop_uint64 =3D {
     .set_default_value =3D set_default_value_uint,
 };
=20
-const PropertyInfo qdev_prop_int64 =3D {
-    .name  =3D "int64",
-    .get   =3D get_int64,
-    .set   =3D set_int64,
-    .set_default_value =3D set_default_value_int,
-};
-
 /* --- string --- */
=20
 static void release_string(Object *obj, const char *name, void *opaque)
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index c6a8cb5516..690ff07ae2 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -13,7 +13,6 @@ extern const PropertyInfo qdev_prop_uint16;
 extern const PropertyInfo qdev_prop_uint32;
 extern const PropertyInfo qdev_prop_int32;
 extern const PropertyInfo qdev_prop_uint64;
-extern const PropertyInfo qdev_prop_int64;
 extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_chr;
@@ -164,8 +163,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
-#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
--=20
2.24.0


