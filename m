Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E3C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA78A2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA78A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWUM-0004Uj-Ma
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTWPY-0006XH-VM
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTWPC-00028A-3o
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:00:56 -0400
Received: from relay.sw.ru ([185.231.240.75]:39184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTWPB-00022K-7o; Tue, 28 Apr 2020 16:00:33 -0400
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTWOy-0000u3-Tb; Tue, 28 Apr 2020 23:00:20 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v22 4/4] iotests: 287: add qcow2 compression type test
Date: Tue, 28 Apr 2020 23:00:13 +0300
Message-Id: <20200428200013.24474-5-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=dplotnikov@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 16:00:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test checks fulfilling qcow2 requirements for the compression
type feature and zstd compression type operability.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/287     | 152 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/287.out |  67 ++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 220 insertions(+)
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out

diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
new file mode 100755
index 0000000000..21fe1f19f5
--- /dev/null
+++ b/tests/qemu-iotests/287
@@ -0,0 +1,152 @@
+#!/usr/bin/env bash
+#
+# Test case for an image using zstd compression
+#
+# Copyright (c) 2020 Virtuozzo International GmbH
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
+owner=dplotnikov@virtuozzo.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+# standard environment
+. ./common.rc
+. ./common.filter
+
+# This tests qocw2-specific low-level functionality
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+_unsupported_imgopts 'compat=0.10' data_file
+
+COMPR_IMG="$TEST_IMG.compressed"
+RAND_FILE="$TEST_DIR/rand_data"
+
+_cleanup()
+{
+	_rm_test_img
+	rm -f "$COMPR_IMG"
+	rm -f "$RAND_FILE"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# for all the cases
+CLUSTER_SIZE=65536
+
+# Check if we can run this test.
+if IMGOPTS='compression_type=zstd' _make_test_img 64M |
+    grep "Invalid parameter 'zstd'"; then
+    _notrun "ZSTD is disabled"
+fi
+
+echo
+echo "=== Testing compression type incompatible bit setting for zlib ==="
+echo
+_make_test_img -o compression_type=zlib 64M
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+echo
+echo "=== Testing compression type incompatible bit setting for zstd ==="
+echo
+_make_test_img -o compression_type=zstd 64M
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+echo
+echo "=== Testing zlib with incompatible bit set ==="
+echo
+_make_test_img -o compression_type=zlib 64M
+$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
+# to make sure the bit was actually set
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
+    echo "Error: The image opened successfully. The image must not be opened."
+fi
+
+echo
+echo "=== Testing zstd with incompatible bit unset ==="
+echo
+_make_test_img -o compression_type=zstd 64M
+$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
+# to make sure the bit was actually unset
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+
+if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
+    echo "Error: The image opened successfully. The image must not be opened."
+fi
+
+echo
+echo "=== Testing compression type values ==="
+echo
+# zlib=0
+_make_test_img -o compression_type=zlib 64M
+peek_file_be "$TEST_IMG" 104 1
+echo
+
+# zstd=1
+_make_test_img -o compression_type=zstd 64M
+peek_file_be "$TEST_IMG" 104 1
+echo
+
+echo
+echo "=== Testing simple reading and writing with zstd ==="
+echo
+_make_test_img -o compression_type=zstd 64M
+$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
+# read on the cluster boundaries
+$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Testing adjacent clusters reading and writing with zstd ==="
+echo
+_make_test_img -o compression_type=zstd 64M
+$QEMU_IO -c "write -c -P 0xAB 0 64K " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -c -P 0xAD 128K 64K " "$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IO -c "read -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAC 64K 64k " "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read -P 0xAD 128K 64k " "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Testing incompressible cluster processing with zstd ==="
+echo
+# create a 2M image and fill it with 1M likely incompressible data
+# and 1M compressible data
+dd if=/dev/urandom of="$RAND_FILE" bs=1M count=1 seek=1
+QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS_NO_FMT" \
+$QEMU_IO -f raw -c "write -P 0xFA 0 1M" "$RAND_FILE" | _filter_qemu_io
+
+$QEMU_IMG convert -f raw -O $IMGFMT -c \
+-o "$(_optstr_add "$IMGOPTS" "compression_type=zlib")" "$RAND_FILE" \
+"$TEST_IMG" | _filter_qemu_io
+
+$QEMU_IMG convert -O $IMGFMT -c \
+-o "$(_optstr_add "$IMGOPTS" "compression_type=zstd")" "$TEST_IMG" \
+"$COMPR_IMG" | _filter_qemu_io
+
+$QEMU_IMG compare "$TEST_IMG" "$COMPR_IMG"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
new file mode 100644
index 0000000000..6b9dfb4af0
--- /dev/null
+++ b/tests/qemu-iotests/287.out
@@ -0,0 +1,67 @@
+QA output created by 287
+
+=== Testing compression type incompatible bit setting for zlib ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+incompatible_features     []
+
+=== Testing compression type incompatible bit setting for zstd ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+incompatible_features     [3]
+
+=== Testing zlib with incompatible bit set  ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+incompatible_features     [3]
+
+=== Testing zstd with incompatible bit unset  ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+incompatible_features     []
+
+=== Testing compression type values  ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+   0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+   1
+
+=== Testing simple reading and writing with zstd ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0001fffe:  ac ac 00 00 00 00 00 00  ........
+read 8/8 bytes at offset 131070
+8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0000fffe:  00 00 ac ac ac ac ac ac  ........
+read 8/8 bytes at offset 65534
+8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing adjacent clusters reading and writing with zstd ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 131072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 131072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Testing incompressible cluster processing with zstd ===
+
+1+0 records in
+1+0 records out
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Images are identical.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 435dccd5af..3bbe02c88d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -294,6 +294,7 @@
 283 auto quick
 284 rw
 286 rw quick
+287 auto quick
 288 quick
 289 rw quick
 290 rw auto quick
-- 
2.17.0


