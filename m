Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B693C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 20:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E191E214C6
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 20:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E191E214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9bIM-0004jW-1t
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 16:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i9bGk-00038X-HP
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 16:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i9bGj-0000hb-2S
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 16:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i9bGf-0000f9-GG; Sun, 15 Sep 2019 16:37:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C87683086258;
 Sun, 15 Sep 2019 20:37:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 969B75C1D6;
 Sun, 15 Sep 2019 20:37:06 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:36:55 +0300
Message-Id: <20190915203655.21638-4-mlevitsk@redhat.com>
In-Reply-To: <20190915203655.21638-1-mlevitsk@redhat.com>
References: <20190915203655.21638-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Sun, 15 Sep 2019 20:37:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v7 3/3] qemu-iotests: Add test for bz #1745922
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
+# Test encrypted write that crosses cluster boundary of two unallocated clusters
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
+owner=mlevitsk@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
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
+size=1M
+
+SECRET="secret,id=sec0,data=astrochicken"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+
+_run_test()
+{
+	echo "== reading the whole image =="
+	$QEMU_IO --object $SECRET -c "read -P 0 0 $size" --image-opts "$1" | _filter_qemu_io | _filter_testdir
+
+	echo
+	echo "== write two 512 byte sectors on a cluster boundary =="
+	$QEMU_IO --object $SECRET -c "write -P 0xAA 0xFE00 0x400" --image-opts "$1" | _filter_qemu_io | _filter_testdir
+
+	echo
+	echo "== verify that the rest of the image is not changed =="
+	$QEMU_IO --object $SECRET -c "read -P 0x00 0x00000 0xFE00" --image-opts "$1" | _filter_qemu_io | _filter_testdir
+	$QEMU_IO --object $SECRET -c "read -P 0xAA 0x0FE00 0x400" --image-opts "$1" | _filter_qemu_io | _filter_testdir
+	$QEMU_IO --object $SECRET -c "read -P 0x00 0x10200 0xEFE00" --image-opts "$1" | _filter_qemu_io | _filter_testdir
+
+}
+
+
+echo
+echo "testing LUKS qcow2 encryption"
+echo
+
+_make_test_img --object $SECRET -o "encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10,cluster_size=64K" $size
+_run_test "driver=$IMGFMT,encrypt.key-secret=sec0,file.filename=$TEST_IMG"
+_cleanup_test_img
+
+echo
+echo "testing legacy AES qcow2 encryption"
+echo
+
+
+_make_test_img --object $SECRET -o "encrypt.format=aes,encrypt.key-secret=sec0,cluster_size=64K" $size
+_run_test "driver=$IMGFMT,encrypt.key-secret=sec0,file.filename=$TEST_IMG"
+_cleanup_test_img
+
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
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
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+== reading the whole image ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== write two 512 byte sectors on a cluster boundary ==
+wrote 1024/1024 bytes at offset 65024
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify that the rest of the image is not changed ==
+read 65024/65024 bytes at offset 0
+63.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1024/1024 bytes at offset 65024
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 982528/982528 bytes at offset 66048
+959.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+testing legacy AES qcow2 encryption
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=aes encrypt.key-secret=sec0
+== reading the whole image ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== write two 512 byte sectors on a cluster boundary ==
+wrote 1024/1024 bytes at offset 65024
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify that the rest of the image is not changed ==
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
-- 
2.17.2


