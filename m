Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E13FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFE4206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFE4206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs8Wx-0003Ut-Tm
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hs8WO-0002bM-AJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hs8WN-0005Nj-E6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hs8WN-0005NL-9I
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:29:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A363A3064FAF
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 16:29:10 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-222.ams2.redhat.com
 [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E3F360856;
 Mon, 29 Jul 2019 16:29:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, berrange@redhat.com, cohuck@redhat.com,
 mst@redhat.com
Date: Mon, 29 Jul 2019 17:29:02 +0100
Message-Id: <20190729162903.4489-2-dgilbert@redhat.com>
In-Reply-To: <20190729162903.4489-1-dgilbert@redhat.com>
References: <20190729162903.4489-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 29 Jul 2019 16:29:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/2] Revert "Revert "globals: Allow global
 properties to be optional""
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This reverts commit 8fa70dbd8bb478d9483c1da3e9976a2d86b3f9a0.

Because we're about to revert it's neighbour and thus uses an optional
again.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/hw/qdev-core.h | 3 +++
 qom/object.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e157fc4acd..136df7774c 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -252,6 +252,8 @@ struct PropertyInfo {
 /**
  * GlobalProperty:
  * @used: Set to true if property was used when initializing a device.
+ * @optional: If set to true, GlobalProperty will be skipped without err=
ors
+ *            if the property doesn't exist.
  *
  * An error is fatal for non-hotplugged devices, when the global is appl=
ied.
  */
@@ -260,6 +262,7 @@ typedef struct GlobalProperty {
     const char *property;
     const char *value;
     bool used;
+    bool optional;
 } GlobalProperty;
=20
 static inline void
diff --git a/qom/object.c b/qom/object.c
index 3966a3d461..1555547727 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -386,6 +386,9 @@ void object_apply_global_props(Object *obj, const GPt=
rArray *props, Error **errp
         if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
             continue;
         }
+        if (p->optional && !object_property_find(obj, p->property, NULL)=
) {
+            continue;
+        }
         p->used =3D true;
         object_property_parse(obj, p->value, p->property, &err);
         if (err !=3D NULL) {
--=20
2.21.0


