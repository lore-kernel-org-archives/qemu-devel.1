Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B29C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4BC20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxtGofen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4BC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTZs-000094-6a
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHTWB-0003go-Gh
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHTW9-0002rI-Cw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHTW9-0002r3-7e
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585232996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eiyTEq4pGvTXw9LT3G3qPdgGYom2OUAmGl4ySF4SH0o=;
 b=DxtGofen1kW4nbj/P6CnUlyTYQjPw//7PJ+HuoB2ppCWGb5Qtvy+dD8REKdovhDsDx2XcW
 NMgH3T3ZjLqTjq2i3MGr6SWtqDxjTmUhZf61/uSvnpZEpU2FghdpxvtrwjHStUs1sg+ku7
 HK3bGzKTFm6wFnlNcA7kD7d0YehgTFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-5NK-qfOjP9yaq4CPcrQi0A-1; Thu, 26 Mar 2020 10:29:55 -0400
X-MC-Unique: 5NK-qfOjP9yaq4CPcrQi0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D04B78018A2;
 Thu, 26 Mar 2020 14:29:53 +0000 (UTC)
Received: from localhost (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8854D5E00C;
 Thu, 26 Mar 2020 14:29:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/10] qcow2: List autoclear bit names in header
Date: Thu, 26 Mar 2020 15:29:28 +0100
Message-Id: <20200326142933.625037-6-mreitz@redhat.com>
In-Reply-To: <20200326142933.625037-1-mreitz@redhat.com>
References: <20200326142933.625037-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

The feature table is supposed to advertise the name of all feature
bits that we support; however, we forgot to update the table for
autoclear bits.  While at it, move the table to read-only memory in
code, and tweak the qcow2 spec to name the second autoclear bit.
Update iotests that are affected by the longer header length.

Fixes: 88ddffae
Fixes: 93c24936
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200324174233.1622067-3-eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/interop/qcow2.txt     |  3 ++-
 block/qcow2.c              | 12 +++++++++++-
 tests/qemu-iotests/031.out |  8 ++++----
 tests/qemu-iotests/036.out |  4 ++--
 tests/qemu-iotests/061.out | 14 +++++++-------
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 5597e24474..640e0eca40 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -143,7 +143,8 @@ the next fields through header_length.
                                 bit is unset, the bitmaps extension data m=
ust be
                                 considered inconsistent.
=20
-                    Bit 1:      If this bit is set, the external data file=
 can
+                    Bit 1:      Raw external data bit
+                                If this bit is set, the external data file=
 can
                                 be read as a consistent standalone raw ima=
ge
                                 without looking at the qcow2 metadata.
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index b565cf912e..b74cbeb047 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2825,7 +2825,7 @@ int qcow2_update_header(BlockDriverState *bs)
=20
     /* Feature table */
     if (s->qcow_version >=3D 3) {
-        Qcow2Feature features[] =3D {
+        static const Qcow2Feature features[] =3D {
             {
                 .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,
                 .bit  =3D QCOW2_INCOMPAT_DIRTY_BITNR,
@@ -2846,6 +2846,16 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  =3D QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
                 .name =3D "lazy refcounts",
             },
+            {
+                .type =3D QCOW2_FEAT_TYPE_AUTOCLEAR,
+                .bit  =3D QCOW2_AUTOCLEAR_BITMAPS_BITNR,
+                .name =3D "bitmaps",
+            },
+            {
+                .type =3D QCOW2_FEAT_TYPE_AUTOCLEAR,
+                .bit  =3D QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR,
+                .name =3D "raw external data",
+            },
         };
=20
         ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index d535e407bc..46f97c5a4e 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -117,7 +117,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 Header extension:
@@ -150,7 +150,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 Header extension:
@@ -164,7 +164,7 @@ No errors were found on the image.
=20
 magic                     0x514649fb
 version                   3
-backing_file_offset       0x178
+backing_file_offset       0x1d8
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
@@ -188,7 +188,7 @@ data                      'host_device'
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 Header extension:
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 0b52b934e1..23b699ce06 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -26,7 +26,7 @@ compatible_features       []
 autoclear_features        [63]
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
=20
@@ -38,7 +38,7 @@ compatible_features       []
 autoclear_features        []
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 8b3091a412..413cc4e0f4 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -26,7 +26,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 magic                     0x514649fb
@@ -84,7 +84,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 magic                     0x514649fb
@@ -140,7 +140,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 ERROR cluster 5 refcount=3D0 reference=3D1
@@ -195,7 +195,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 magic                     0x514649fb
@@ -264,7 +264,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 read 65536/65536 bytes at offset 44040192
@@ -298,7 +298,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 ERROR cluster 5 refcount=3D0 reference=3D1
@@ -327,7 +327,7 @@ header_length             104
=20
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>
=20
 read 131072/131072 bytes at offset 0
--=20
2.25.1


