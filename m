Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D6EC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B772133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B772133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy00g-0001sb-Qx
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxzoA-00052n-TG
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxzo7-0004XH-Bd
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxzo0-0004TC-LK; Wed, 14 Aug 2019 16:23:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 040B3C024AF4;
 Wed, 14 Aug 2019 20:23:36 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7975E10016EB;
 Wed, 14 Aug 2019 20:23:33 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:19 +0300
Message-Id: <20190814202219.1870-14-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 14 Aug 2019 20:23:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 13/13] iotests : add tests for encryption key
 management
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/257           | 197 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/257.out       |  96 +++++++++++++++
 tests/qemu-iotests/258           |  95 +++++++++++++++
 tests/qemu-iotests/258.out       |  30 +++++
 tests/qemu-iotests/259           | 199 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/259.out       |   5 +
 tests/qemu-iotests/common.filter |   5 +-
 tests/qemu-iotests/group         |   3 +
 8 files changed, 628 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out
 create mode 100755 tests/qemu-iotests/258
 create mode 100644 tests/qemu-iotests/258.out
 create mode 100644 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
new file mode 100755
index 0000000000..5991e4a8c7
--- /dev/null
+++ b/tests/qemu-iotests/257
@@ -0,0 +1,197 @@
+#!/usr/bin/env bash
+#
+# Test encryption key management with luks
+# Based on 134
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
+_supported_fmt qcow2 luks
+_supported_proto file #TODO
+
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+# you are supposed to see the password as *******, see :-)
+SECRET0="--object secret,id=sec0,data=hunter0"
+SECRET1="--object secret,id=sec1,data=hunter1"
+SECRET2="--object secret,id=sec2,data=hunter2"
+SECRET3="--object secret,id=sec3,data=hunter3"
+SECRETS="$SECRET0 $SECRET1 $SECRET2 $SECRET3"
+
+
+if [ "$IMGFMT" = "qcow2" ] ; then
+	OPTPREFIX="encrypt."
+	EXTRA_IMG_ARGS="-o encrypt.format=luks"
+fi
+
+IMGSPEC0="driver=$IMGFMT,file.filename=$TEST_IMG,${OPTPREFIX}key-secret=sec0"
+IMGSPEC1="driver=$IMGFMT,file.filename=$TEST_IMG,${OPTPREFIX}key-secret=sec1"
+IMGSPEC2="driver=$IMGFMT,file.filename=$TEST_IMG,${OPTPREFIX}key-secret=sec2"
+IMGSPEC3="driver=$IMGFMT,file.filename=$TEST_IMG,${OPTPREFIX}key-secret=sec3"
+
+echo "== creating a test image =="
+_make_test_img $SECRET0 $EXTRA_IMG_ARGS -o "${OPTPREFIX}key-secret=sec0,${OPTPREFIX}iter-time=10"   32M
+
+echo
+echo "== test that key 0 opens the image =="
+$QEMU_IO $SECRET0 -c "read 0 4096" --image-opts $IMGSPEC0 | _filter_qemu_io | _filter_testdir
+
+
+echo
+echo "== adding a password to slot 1 =="
+$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC0 --keydef key-secret=sec1,iter-time=10
+echo "== adding a password to slot 3 =="
+$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef key-secret=sec3,iter-time=100,slot=3
+echo "== adding a password to slot 2 =="
+$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC3 --keydef key-secret=sec2,iter-time=10
+
+echo
+echo "== all secrets should work =="
+for IMGSPEC in $IMGSPEC0 $IMGSPEC1 $IMGSPEC2 $IMGSPEC3; do
+	$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+done
+
+
+echo
+echo "== erase slot 0 and try it =="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef key-secret=sec0| _filter_img_create
+$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC0 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== erase slot 2 and try it =="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef slot=2| _filter_img_create
+$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC2 | _filter_qemu_io | _filter_testdir
+
+
+# at this point slots 1 and 3 should be active
+
+echo
+echo "== filling  4 slots with secret 2 =="
+for i in $(seq 0 3) ; do
+	$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC3 --keydef key-secret=sec2,iter-time=10
+done
+
+echo
+echo "== adding secret 0 =="
+	$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC3 --keydef key-secret=sec0,iter-time=10
+
+echo
+echo "== adding secret 3 (last slot) =="
+	$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC3 --keydef key-secret=sec3,iter-time=10
+
+echo
+echo "== trying to add another slot (should fail) =="
+$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC2 --keydef key-secret=sec3,iter-time=10
+
+echo
+echo "== all secrets should work again =="
+for IMGSPEC in $IMGSPEC0 $IMGSPEC1 $IMGSPEC2 $IMGSPEC3; do
+	$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+done
+
+echo
+echo "== erase all keys of secret 2=="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef key-secret=sec2
+echo "== erase all keys of secret 1=="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef key-secret=sec1
+echo "== erase all keys of secret 0=="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC0 --keydef key-secret=sec0
+echo "== erase all keys of secret 3, except a remaining key =="
+
+
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC3 --keydef key-secret=sec3
+
+
+echo
+echo "== only secret3 should work now  =="
+for IMGSPEC in $IMGSPEC0 $IMGSPEC1 $IMGSPEC2 $IMGSPEC3; do
+	$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+done
+
+echo
+echo "== add secret0  =="
+$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC3 --keydef key-secret=sec0,iter-time=10
+
+echo "== erase secret3 =="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC0 --keydef key-secret=sec3
+
+echo
+echo "== only secret0 should work now  == "
+for IMGSPEC in $IMGSPEC0 $IMGSPEC1 $IMGSPEC2 $IMGSPEC3; do
+	$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+done
+
+echo
+echo "== replace secret0 with secret1 (should fail)  =="
+$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC0 --keydef key-secret=sec1,iter-time=10,slot=0
+
+echo
+echo "== replace secret0 with secret1 with force (should work)  =="
+$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC0 --keydef key-secret=sec1,iter-time=10,slot=0 --force
+
+
+echo
+echo "== only secret1 should work now  =="
+for IMGSPEC in $IMGSPEC0 $IMGSPEC1 $IMGSPEC2 $IMGSPEC3; do
+	$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+done
+
+
+
+echo
+echo "== erase last secret (should fail)  =="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef slot=0
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef key-secret=sec1
+
+
+echo "== erase non existing secrets (should fail)  =="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef key-secret=sec5 --force
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef key-secret=sec0 --force
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef slot=1 --force
+
+echo
+echo "== erase last secret with force by slot (should work)  =="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef slot=0 --force
+
+echo
+echo "== we have no secrets now, data is lost forever =="
+for IMGSPEC in $IMGSPEC0 $IMGSPEC1 $IMGSPEC2 $IMGSPEC3; do
+	$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
+
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
new file mode 100644
index 0000000000..77f9c9136e
--- /dev/null
+++ b/tests/qemu-iotests/257.out
@@ -0,0 +1,96 @@
+QA output created by 257
+== creating a test image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432
+
+== test that key 0 opens the image ==
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== adding a password to slot 1 ==
+== adding a password to slot 3 ==
+== adding a password to slot 2 ==
+
+== all secrets should work ==
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== erase slot 0 and try it ==
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+== erase slot 2 and try it ==
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+== filling  4 slots with secret 2 ==
+
+== adding secret 0 ==
+
+== adding secret 3 (last slot) ==
+
+== trying to add another slot (should fail) ==
+qemu-img: Can't add a keyslot - all key slots are in use
+
+== all secrets should work again ==
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== erase all keys of secret 2==
+== erase all keys of secret 1==
+== erase all keys of secret 0==
+== erase all keys of secret 3, except a remaining key ==
+
+== only secret3 should work now  ==
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== add secret0  ==
+== erase secret3 ==
+
+== only secret0 should work now  ==
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+== replace secret0 with secret1 (should fail)  ==
+qemu-img: Can't update an active key slot 0
+
+== replace secret0 with secret1 with force (should work)  ==
+
+== only secret1 should work now  ==
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+== erase last secret (should fail)  ==
+qemu-img: Only one slot active - can't erase
+qemu-img: Only one slot active - can't erase
+== erase non existing secrets (should fail)  ==
+qemu-img: No secret with id 'sec5'
+qemu-img: Didn't erase a keyslot, because no keyslots match the given password
+
+== erase last secret with force by slot (should work)  ==
+
+== we have no secrets now, data is lost forever ==
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+*** done
diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
new file mode 100755
index 0000000000..84c8ab1907
--- /dev/null
+++ b/tests/qemu-iotests/258
@@ -0,0 +1,95 @@
+#!/usr/bin/env bash
+#
+# Test that encryption key managment erases the key material
+# in addition to the header
+# Based on 134
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
+_supported_fmt luks
+_supported_proto file #TODO
+
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+# you are supposed to see the password as *******, see :-)
+SECRET0="--object secret,id=sec0,data=hunter0"
+SECRET1="--object secret,id=sec1,data=hunter1"
+SECRETS="$SECRET0 $SECRET1"
+
+
+IMGSPEC0="driver=$IMGFMT,file.filename=$TEST_IMG,key-secret=sec0"
+IMGSPEC1="driver=$IMGFMT,file.filename=$TEST_IMG,key-secret=sec1"
+
+echo "== creating a test image =="
+_make_test_img $SECRET0 -o "key-secret=sec0,iter-time=10"   32M
+
+echo
+echo "== test that key 0 opens the image =="
+$QEMU_IO $SECRET0 -c "read 0 4096" --image-opts $IMGSPEC0 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== adding a password to slot 1 =="
+$QEMU_IMG add_encryption_key $SECRETS --image-opts $IMGSPEC0 --keydef key-secret=sec1,slot=1,iter-time=10
+
+echo
+echo "== 'backup' the image header =="
+dd if=$TEST_IMG_FILE of=${TEST_IMG_FILE}.bk bs=4K skip=0 count=1
+
+echo
+echo "== erase slot 0 =="
+$QEMU_IMG erase_encryption_key $SECRETS --image-opts $IMGSPEC1 --keydef slot=0 | _filter_img_create
+
+echo
+echo "== test that key 0 doesn't open the image =="
+$QEMU_IO $SECRET0 -c "read 0 4096" --image-opts $IMGSPEC0 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== 'restore' the image header =="
+dd if=${TEST_IMG_FILE}.bk of=${TEST_IMG_FILE} bs=4K skip=0 count=1 conv=notrunc
+
+echo
+echo "== test that key 0 still doesn't open the image (key material is erased) =="
+$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC0 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== test that key 1 still works =="
+$QEMU_IO $SECRETS -c "read 0 4096" --image-opts $IMGSPEC1 | _filter_qemu_io | _filter_testdir
+
+echo "*** done"
+rm -f $seq.full
+status=0
+
+
+exit 0
diff --git a/tests/qemu-iotests/258.out b/tests/qemu-iotests/258.out
new file mode 100644
index 0000000000..ea448a0ac1
--- /dev/null
+++ b/tests/qemu-iotests/258.out
@@ -0,0 +1,30 @@
+QA output created by 258
+== creating a test image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432
+
+== test that key 0 opens the image ==
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== adding a password to slot 1 ==
+
+== 'backup' the image header ==
+1+0 records in
+1+0 records out
+
+== erase slot 0 ==
+
+== test that key 0 doesn't open the image ==
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+== 'restore' the image header ==
+1+0 records in
+1+0 records out
+
+== test that key 0 still doesn't open the image (key material is erased) ==
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+== test that key 1 still works ==
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/259 b/tests/qemu-iotests/259
new file mode 100644
index 0000000000..360e723a48
--- /dev/null
+++ b/tests/qemu-iotests/259
@@ -0,0 +1,199 @@
+#!/usr/bin/env python
+#
+# Test case QMP's encrypted key management
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
+import iotests
+import os
+import time
+
+test_img = os.path.join(iotests.test_dir, 'test.img')
+
+class Secret:
+    def __init__(self, index):
+        self._id = "keysec" + str(index)
+        # you are not supposed to see the password...
+        self._secret = "hunter" + str(index)
+
+    def id(self):
+        return self._id
+
+    def secret(self):
+        return self._secret
+
+    def to_cmdline_object(self):
+        return  [ "secret,id=" + self._id + ",data=" + self._secret]
+
+    def to_qmp_object(self):
+        return { "qom_type" : "secret", "id": self.id(),
+                 "props": { "data": self.secret() } }
+
+class EncryptionSetupTestCase(iotests.QMPTestCase):
+
+    # test case startup
+    def setUp(self):
+        # start the VM
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        # create the secrets and load 'em into the VM
+        self.secrets = [ Secret(i) for i in range(0, 4) ]
+        for secret in self.secrets:
+            result = self.vm.qmp("object-add", **secret.to_qmp_object())
+            self.assert_qmp(result, 'return', {})
+
+    # test case shutdown
+    def tearDown(self):
+        # stop the VM
+        self.vm.shutdown()
+
+    # create the encrypted block device
+    def createImg(self, file, secret):
+
+        if iotests.imgfmt == "qcow2":
+            prefix="encrypt."
+            extra_options = [ '-o', "encrypt.format=luks" ]
+        else:
+            prefix=""
+            extra_options = []
+
+        return iotests.qemu_img('create',
+                                '--object', *secret.to_cmdline_object(),
+                                '-f', iotests.imgfmt,
+                                '-o', prefix+'key-secret=' + secret.id(),
+                                '-o', prefix+'iter-time=10',
+                                *extra_options, file, '1M')
+
+    # open an encrypted block device
+    def openLUKS(self, id, file, secret):
+        if iotests.imgfmt == "qcow2":
+            encrypt_options = {
+                'encrypt': {
+                    'format':'luks',
+                    'key-secret' : secret.id()}
+                }
+        else:
+            encrypt_options = {
+                'key-secret' : secret.id()
+            }
+
+        return self.vm.qmp('blockdev-add', **
+            {
+                'driver': iotests.imgfmt,
+                'node-name': id,
+
+                **encrypt_options,
+
+                'file': {
+                    'driver': 'file',
+                    'filename': test_img,
+                }
+            }
+        )
+
+    # close the encrypted block device
+    def closeLUKS(self, id):
+        return self.vm.qmp('blockdev-del', **{ 'node-name': id })
+
+    # add a key to an encrypted block device
+    def addKey(self, id, secret, old_secret = None, slot = None, force = False):
+        args = {
+            'node-name': id,
+            'options' : { 'key-secret' : secret.id(), 'iter-time' : 10}
+        }
+
+        if slot != None:
+            args['options']['slot'] = slot
+        if old_secret != None:
+            args['options']['old-key-secret'] = old_secret.id()
+        if force == True:
+            args['force'] = True
+
+        return self.vm.qmp('x-blockdev-update-encryption', **args)
+
+    # erase a key from an encrypted block device
+    def eraseKey(self, id, secret = None, slot = None, force = False):
+        args = {
+            'node-name': id,
+            'options' : { }
+        }
+
+        if secret != None:
+            args['options']['key-secret'] = secret.id()
+        if slot != None:
+            args['options']['slot'] = slot
+        if force == True:
+            args['force'] = True
+
+        return self.vm.qmp('x-blockdev-erase-encryption', **args)
+
+    def check(self, result):
+        self.assert_qmp(result, 'return', {})
+
+    # create image, and change its key
+    def testChangeKey(self):
+
+        # create the image with secret0 and open it
+        result = self.createImg(test_img, self.secrets[0]);
+        self.check(self.openLUKS("testdev", test_img, self.secrets[0]))
+
+        # add key to slot 1
+        self.check(self.addKey("testdev", secret=self.secrets[1]))
+
+
+        # erase key from slot 0
+        self.check(self.eraseKey("testdev", secret=self.secrets[0]))
+
+        #reopen the image with secret1
+        self.check(self.closeLUKS("testdev"))
+        self.check(self.openLUKS("testdev", test_img, self.secrets[1]))
+
+        # close and erase the image for good
+        self.check(self.closeLUKS("testdev"))
+        os.remove(test_img)
+
+    # test that if we erase the old password,
+    # we can still change the encryption keys using 'old-secret'
+    def testOldPassword(self):
+
+        # create the image with secret0 and open it
+        result = self.createImg(test_img, self.secrets[0]);
+        self.check(self.openLUKS("testdev", test_img, self.secrets[0]))
+
+        # add key to slot 1
+        self.check(self.addKey("testdev", secret=self.secrets[1]))
+
+        # erase key from slot 0
+        self.check(self.eraseKey("testdev", secret=self.secrets[0]))
+
+        # this will fail as the old password is no longer valid
+        result = self.addKey("testdev", secret=self.secrets[2])
+        self.assert_qmp(result, 'error/desc', "Invalid password, cannot unlock any keyslot")
+
+        # this will work
+        self.check(self.addKey("testdev", secret=self.secrets[2], old_secret=self.secrets[1]))
+
+
+        # close and erase the image for good
+        self.check(self.closeLUKS("testdev"))
+        os.remove(test_img)
+
+
+if __name__ == '__main__':
+    # Encrypted formats support
+    iotests.main(iotests.main(supported_fmts=['qcow2','luks']))
diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out
new file mode 100644
index 0000000000..fbc63e62f8
--- /dev/null
+++ b/tests/qemu-iotests/259.out
@@ -0,0 +1,5 @@
+..
+----------------------------------------------------------------------
+Ran 2 tests
+
+OK
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 35fddc746f..c0d68e8a0c 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -138,8 +138,9 @@ _filter_img_create()
         -e "s# block_state_zero=\\(on\\|off\\)##g" \
         -e "s# log_size=[0-9]\\+##g" \
         -e "s# refcount_bits=[0-9]\\+##g" \
-        -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
-        -e "s# iter-time=[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?key-secret=[a-zA-Z0-9]\\+##g" \
+        -e "s# encrypt\\.format=[a-zA-Z0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?iter-time=[0-9]\\+##g" \
         -e "s# force_size=\\(on\\|off\\)##g"
 }
 
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f13e5f2e23..3db7f0a863 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -271,3 +271,6 @@
 254 rw backing quick
 255 rw quick
 256 rw quick
+257 rw auto
+258 rw auto quick
+259 rw auto
-- 
2.17.2


