Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF269C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 17:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7922206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 17:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7922206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6I7y-000687-NK
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 13:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6I61-0003rY-Q1
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 13:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6I5z-0003Dp-Ed
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 13:32:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i6I5t-00034q-Rf; Fri, 06 Sep 2019 13:32:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56D1310C051F;
 Fri,  6 Sep 2019 17:32:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8B585D9CA;
 Fri,  6 Sep 2019 17:32:14 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 20:32:01 +0300
Message-Id: <20190906173201.7926-4-mlevitsk@redhat.com>
In-Reply-To: <20190906173201.7926-1-mlevitsk@redhat.com>
References: <20190906173201.7926-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 06 Sep 2019 17:32:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] qemu-iotests: test for bz #1745922
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
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/263     | 76 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/263.out | 19 ++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 96 insertions(+)
 create mode 100755 tests/qemu-iotests/263
 create mode 100644 tests/qemu-iotests/263.out

diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
new file mode 100755
index 0000000000..9cb23aa81e
--- /dev/null
+++ b/tests/qemu-iotests/263
@@ -0,0 +1,76 @@
+#!/usr/bin/env bash
+#
+# Test encrypted write that crosses cluster boundary of two unallocated clusters
+# Based on 188
+#
+# Copyright (C) 2017 Red Hat, Inc.
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
+SECRETALT="secret,id=sec0,data=platypus"
+
+_make_test_img --object $SECRET -o "encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10,cluster_size=64K" $size
+
+IMGSPEC="driver=$IMGFMT,encrypt.key-secret=sec0,file.filename=$TEST_IMG"
+
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "== reading whole image =="
+$QEMU_IO --object $SECRET -c "read -P 0 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== write two 512 byte sectors on a cluster boundary =="
+$QEMU_IO --object $SECRET -c "write -P 0xAA 0xFE00 0x400" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify that the rest of the image is not changed =="
+$QEMU_IO --object $SECRET -c "read -P 0x00 0x00000 0xFE00" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0xAA 0x0FE00 0x400" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0x00 0x10200 0xEFE00" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+_cleanup_test_img
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
new file mode 100644
index 0000000000..fa4e4e0e4a
--- /dev/null
+++ b/tests/qemu-iotests/263.out
@@ -0,0 +1,19 @@
+QA output created by 263
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+
+== reading whole image ==
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
index d95d556414..be1c4a3baa 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -274,3 +274,4 @@
 257 rw
 258 rw quick
 262 rw quick migration
+263 rw quick
-- 
2.17.2


