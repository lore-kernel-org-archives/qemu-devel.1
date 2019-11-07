Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCA3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBBF2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqUmb+QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBBF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkyj-0000K6-QB
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkn1-0003FK-OZ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkn0-0005j0-MX
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51031
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkn0-0005im-Ik
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=puOmEJEsbUG+t7Rcle7txARr/NoGmMt3Wu/FWQgji5g=;
 b=UqUmb+QPyz8RUdq8qp6fBIXPWHP94xex/AqucUqLmRxFHPVZnIOuj/tRaersPOOWUJZo8T
 +okftc3BWazwhoKYM+9SCf725rf3ERIFJkTQo/bQsFSEktfgYYZ2p1Khrv+4n26l7FbXz2
 B9qy0P0z8CzbkA/LwY5Z6Xv5vafN/cA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-kYc7g0KvNHeaEnscufdEHQ-1; Thu, 07 Nov 2019 11:37:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BD6A477;
 Thu,  7 Nov 2019 16:37:38 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AC1460BEC;
 Thu,  7 Nov 2019 16:37:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 13/22] iotests: Drop IMGOPTS use in 267
Date: Thu,  7 Nov 2019 17:36:59 +0100
Message-Id: <20191107163708.833192-14-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kYc7g0KvNHeaEnscufdEHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Overwriting IMGOPTS means ignoring all user-supplied options, which is
not what we want.  Replace the current IMGOPTS use by a new BACKING_FILE
variable.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/267 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 170e173c0a..f54262a4ad 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -68,7 +68,11 @@ size=3D128M
=20
 run_test()
 {
-    _make_test_img $size
+    if [ -n "$BACKING_FILE" ]; then
+        _make_test_img -b "$BACKING_FILE" $size
+    else
+        _make_test_img $size
+    fi
     printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qemu "$@" =
| _filter_date
 }
=20
@@ -119,12 +123,12 @@ echo
=20
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
=20
-IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
+BACKING_FILE=3D"$TEST_IMG.base" \
 run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=3Db=
acking-file \
          -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile \
          -blockdev driver=3D$IMGFMT,file=3Dfile,backing=3Dbacking-file,nod=
e-name=3Dfmt
=20
-IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
+BACKING_FILE=3D"$TEST_IMG.base" \
 run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=3Db=
acking-file \
          -blockdev driver=3D$IMGFMT,file=3Dbacking-file,node-name=3Dbackin=
g-fmt \
          -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile \
@@ -141,7 +145,7 @@ echo
 echo "=3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D"
 echo
=20
-IMGOPTS=3D"backing_file=3D$TEST_IMG.base" _make_test_img $size
+_make_test_img -b "$TEST_IMG.base" $size
 cat <<EOF |
 nbd_server_start unix:$SOCK_DIR/nbd
 nbd_server_add -w backing-fmt
--=20
2.23.0


