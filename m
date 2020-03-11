Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCB5C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFF9206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTowrT89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFF9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC29V-0004oO-69
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC211-0007ZE-Fn
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC20y-0005Pr-Ut
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:07:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC20y-0005Pf-RG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583935636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q1+xKLvY0Rc5gYIni1A+NEFzbp/PMO7k9dQobpBzxFc=;
 b=MTowrT896tZ5C37WPKtfw2SfWh3yXCrsUb+JwsVg44tydxOTVMuRFrdVx3xgp8OObOVsMC
 uEMPbTitKWxF9CK0bU4WVOqPFaaW5xnzhNq6k/zNYOghdvk9qRZf2O8XLWsX68Vnh2YsqY
 l0G4fo3GKXyR/A3JZMPGGRxEebTRChI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-iBSJ08WePqO8yqTbTeyIeg-1; Wed, 11 Mar 2020 10:07:11 -0400
X-MC-Unique: iBSJ08WePqO8yqTbTeyIeg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34F3D1006183;
 Wed, 11 Mar 2020 14:07:10 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D0ED10013A1;
 Wed, 11 Mar 2020 14:07:09 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/026: Move v3-exclusive test to new file
Date: Wed, 11 Mar 2020 15:07:07 +0100
Message-Id: <20200311140707.1243218-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

data_file does not work with v2, and we probably want 026 to keep
working for v2 images.  Thus, open a new file for v3-exclusive error
path test cases.

Fixes: 81311255f217859413c94f2cd9cebf2684bbda94
       (=E2=80=9Ciotests/026: Test EIO on allocation in a data-file=E2=80=
=9D)
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/026             | 31 -----------
 tests/qemu-iotests/026.out         |  6 --
 tests/qemu-iotests/026.out.nocache |  6 --
 tests/qemu-iotests/289             | 89 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/289.out         |  8 +++
 tests/qemu-iotests/group           |  1 +
 6 files changed, 98 insertions(+), 43 deletions(-)
 create mode 100755 tests/qemu-iotests/289
 create mode 100644 tests/qemu-iotests/289.out

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index b05a4692cf..b9713eb591 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -240,37 +240,6 @@ $QEMU_IO -c "write 0 $CLUSTER_SIZE" "$BLKDBG_TEST_IMG"=
 | _filter_qemu_io
=20
 _check_test_img
=20
-echo
-echo =3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
-echo
-
-# Similar test as the last one, except we test what happens when there
-# is an error when writing to an external data file instead of when
-# writing to a preallocated zero cluster
-_make_test_img -o "data_file=3D$TEST_IMG.data_file" $CLUSTER_SIZE
-
-# Put blkdebug above the data-file, and a raw node on top of that so
-# that blkdebug will see a write_aio event and emit an error
-$QEMU_IO -c "write 0 $CLUSTER_SIZE" \
-    "json:{
-         'driver': 'qcow2',
-         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
-         'data-file': {
-             'driver': 'raw',
-             'file': {
-                 'driver': 'blkdebug',
-                 'config': '$TEST_DIR/blkdebug.conf',
-                 'image': {
-                     'driver': 'file',
-                     'filename': '$TEST_IMG.data_file'
-                 }
-             }
-         }
-     }" \
-    | _filter_qemu_io
-
-_check_test_img
-
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index c1b3b58482..83989996ff 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -653,10 +653,4 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
 No errors were found on the image.
-
-=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
-
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTEST_=
DIR/t.IMGFMT.data_file
-write failed: Input/output error
-No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.ou=
t.nocache
index 8d5001648a..9359d26d7e 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -661,10 +661,4 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
 No errors were found on the image.
-
-=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
-
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTEST_=
DIR/t.IMGFMT.data_file
-write failed: Input/output error
-No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/289 b/tests/qemu-iotests/289
new file mode 100755
index 0000000000..1c11d4030e
--- /dev/null
+++ b/tests/qemu-iotests/289
@@ -0,0 +1,89 @@
+#!/usr/bin/env bash
+#
+# qcow2 v3-exclusive error path testing
+# (026 tests paths common to v2 and v3)
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+seq=3D$(basename $0)
+echo "QA output created by $seq"
+
+status=3D1=09# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm "$TEST_DIR/blkdebug.conf"
+    rm -f "$TEST_IMG.data_file"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+
+_supported_fmt qcow2
+_supported_proto file
+# This is a v3-exclusive test;
+# As for data_file, error paths often very much depend on whether
+# there is an external data file or not; so we create one exactly when
+# we want to test it
+_unsupported_imgopts 'compat=3D0.10' data_file
+
+echo
+echo =3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
+echo
+
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event =3D "write_aio"
+errno =3D "5"
+once =3D "on"
+EOF
+
+# Test what happens when there is an error when writing to an external
+# data file instead of when writing to a preallocated zero cluster
+_make_test_img -o "data_file=3D$TEST_IMG.data_file" 64k
+
+# Put blkdebug above the data-file, and a raw node on top of that so
+# that blkdebug will see a write_aio event and emit an error.  This
+# will then trigger the alloc abort code, which we want to test here.
+$QEMU_IO -c "write 0 64k" \
+    "json:{
+         'driver': 'qcow2',
+         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
+         'data-file': {
+             'driver': 'raw',
+             'file': {
+                 'driver': 'blkdebug',
+                 'config': '$TEST_DIR/blkdebug.conf',
+                 'image': {
+                     'driver': 'file',
+                     'filename': '$TEST_IMG.data_file'
+                 }
+             }
+         }
+     }" \
+    | _filter_qemu_io
+
+_check_test_img
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/289.out b/tests/qemu-iotests/289.out
new file mode 100644
index 0000000000..e54e2629d4
--- /dev/null
+++ b/tests/qemu-iotests/289.out
@@ -0,0 +1,8 @@
+QA output created by 289
+
+=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536 data_file=3DTEST=
_DIR/t.IMGFMT.data_file
+write failed: Input/output error
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 559edc139a..a898fe2c26 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -294,3 +294,4 @@
 284 rw
 286 rw quick
 288 quick
+289 rw quick
--=20
2.24.1


