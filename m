Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF775C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9885C2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9885C2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35519 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sQG-0002Aq-U4
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9ruw-0003tS-Qv
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9ruu-00012V-Ta
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9ruq-00010s-Lg; Mon, 16 Sep 2019 10:23:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E88493083362;
 Mon, 16 Sep 2019 14:23:43 +0000 (UTC)
Received: from localhost (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73F9E600C1;
 Mon, 16 Sep 2019 14:23:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 16:22:46 +0200
Message-Id: <20190916142246.31474-17-mreitz@redhat.com>
In-Reply-To: <20190916142246.31474-1-mreitz@redhat.com>
References: <20190916142246.31474-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 16 Sep 2019 14:23:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/16] qemu-iotests: Add test for bz #1745922
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

From: Maxim Levitsky <mlevitsk@redhat.com>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190915203655.21638-4-mlevitsk@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/263     | 91 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/263.out | 40 +++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 132 insertions(+)
 create mode 100755 tests/qemu-iotests/263
 create mode 100644 tests/qemu-iotests/263.out

diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
new file mode 100755
index 0000000000..d2c030fae9
--- /dev/null
+++ b/tests/qemu-iotests/263
@@ -0,0 +1,91 @@
+#!/usr/bin/env bash
+#
+# Test encrypted write that crosses cluster boundary of two unallocated =
clusters
+# Based on 188
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+# creator
+owner=3Dmlevitsk@redhat.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto generic
+_supported_os Linux
+
+
+size=3D1M
+
+SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
+QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
+
+
+_run_test()
+{
+	echo "=3D=3D reading the whole image =3D=3D"
+	$QEMU_IO --object $SECRET -c "read -P 0 0 $size" --image-opts "$1" | _f=
ilter_qemu_io | _filter_testdir
+
+	echo
+	echo "=3D=3D write two 512 byte sectors on a cluster boundary =3D=3D"
+	$QEMU_IO --object $SECRET -c "write -P 0xAA 0xFE00 0x400" --image-opts =
"$1" | _filter_qemu_io | _filter_testdir
+
+	echo
+	echo "=3D=3D verify that the rest of the image is not changed =3D=3D"
+	$QEMU_IO --object $SECRET -c "read -P 0x00 0x00000 0xFE00" --image-opts=
 "$1" | _filter_qemu_io | _filter_testdir
+	$QEMU_IO --object $SECRET -c "read -P 0xAA 0x0FE00 0x400" --image-opts =
"$1" | _filter_qemu_io | _filter_testdir
+	$QEMU_IO --object $SECRET -c "read -P 0x00 0x10200 0xEFE00" --image-opt=
s "$1" | _filter_qemu_io | _filter_testdir
+
+}
+
+
+echo
+echo "testing LUKS qcow2 encryption"
+echo
+
+_make_test_img --object $SECRET -o "encrypt.format=3Dluks,encrypt.key-se=
cret=3Dsec0,encrypt.iter-time=3D10,cluster_size=3D64K" $size
+_run_test "driver=3D$IMGFMT,encrypt.key-secret=3Dsec0,file.filename=3D$T=
EST_IMG"
+_cleanup_test_img
+
+echo
+echo "testing legacy AES qcow2 encryption"
+echo
+
+
+_make_test_img --object $SECRET -o "encrypt.format=3Daes,encrypt.key-sec=
ret=3Dsec0,cluster_size=3D64K" $size
+_run_test "driver=3D$IMGFMT,encrypt.key-secret=3Dsec0,file.filename=3D$T=
EST_IMG"
+_cleanup_test_img
+
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
new file mode 100644
index 0000000000..0c982c55cb
--- /dev/null
+++ b/tests/qemu-iotests/263.out
@@ -0,0 +1,40 @@
+QA output created by 263
+
+testing LUKS qcow2 encryption
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.form=
at=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+=3D=3D reading the whole image =3D=3D
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D write two 512 byte sectors on a cluster boundary =3D=3D
+wrote 1024/1024 bytes at offset 65024
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D verify that the rest of the image is not changed =3D=3D
+read 65024/65024 bytes at offset 0
+63.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1024/1024 bytes at offset 65024
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 982528/982528 bytes at offset 66048
+959.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+testing legacy AES qcow2 encryption
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.form=
at=3Daes encrypt.key-secret=3Dsec0
+=3D=3D reading the whole image =3D=3D
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D write two 512 byte sectors on a cluster boundary =3D=3D
+wrote 1024/1024 bytes at offset 65024
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D verify that the rest of the image is not changed =3D=3D
+read 65024/65024 bytes at offset 0
+63.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1024/1024 bytes at offset 65024
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 982528/982528 bytes at offset 66048
+959.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 6082c74806..5d3da937e4 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -274,5 +274,6 @@
 257 rw
 258 rw quick
 262 rw quick migration
+263 rw quick
 265 rw auto quick
 266 rw quick
--=20
2.21.0


