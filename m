Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EE3C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A73F2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A73F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmsM-0000hr-VE
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmmN-0003OZ-5G
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmmL-0007di-Vt
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7113)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmmJ-0007aV-H6; Fri, 27 Sep 2019 05:43:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFAE77BDA0;
 Fri, 27 Sep 2019 09:43:06 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BCB55C21A;
 Fri, 27 Sep 2019 09:43:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 09/18] iotests: Drop IMGOPTS use in 267
Date: Fri, 27 Sep 2019 11:42:33 +0200
Message-Id: <20190927094242.11152-10-mreitz@redhat.com>
In-Reply-To: <20190927094242.11152-1-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 27 Sep 2019 09:43:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Overwriting IMGOPTS means ignoring all user-supplied options, which is
not what we want.  Replace the current IMGOPTS use by a new BACKING_FILE
variable.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/267 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 95f885442f..529f5f9afe 100755
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
     printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qemu "$@=
" | _filter_date
 }
=20
@@ -119,12 +123,12 @@ echo
=20
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
=20
-IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
+BACKING_FILE=3D"$TEST_IMG.base" \
 run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=3D=
backing-file \
          -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
          -blockdev driver=3D$IMGFMT,file=3Dfile,backing=3Dbacking-file,n=
ode-name=3Dfmt
=20
-IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
+BACKING_FILE=3D"$TEST_IMG.base" \
 run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-name=3D=
backing-file \
          -blockdev driver=3D$IMGFMT,file=3Dbacking-file,node-name=3Dback=
ing-fmt \
          -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3Dfile=
 \
@@ -141,7 +145,7 @@ echo
 echo "=3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D"
 echo
=20
-IMGOPTS=3D"backing_file=3D$TEST_IMG.base" _make_test_img $size
+_make_test_img -b "$TEST_IMG.base" $size
 cat <<EOF |
 nbd_server_start unix:$TEST_DIR/nbd
 nbd_server_add -w backing-fmt
--=20
2.21.0


