Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B632BC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2334B21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2334B21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6Rz-0000tL-Gi
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5qa-0002kF-PB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5qY-00039t-6N
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:54:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5qX-00039K-Ty; Tue, 05 Nov 2019 15:54:38 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KsTiK043519; Tue, 5 Nov 2019 15:54:37 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3e19w8mm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:54:36 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5Ksapo044042;
 Tue, 5 Nov 2019 15:54:36 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3e19w8h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:54:36 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnwpW017684;
 Tue, 5 Nov 2019 20:53:10 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma03wdc.us.ibm.com with ESMTP id 2w11e7h8u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:10 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrAUJ52953492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBB6D124052;
 Tue,  5 Nov 2019 20:53:09 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2E9C12405B;
 Tue,  5 Nov 2019 20:53:09 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:09 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/55] iotests: Test internal snapshots with -blockdev
Date: Tue,  5 Nov 2019 14:52:28 -0600
Message-Id: <20191105205243.3766-41-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Peter Krempa <pkrempa@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
(cherry picked from commit 92b22e7b1789b0e5f20d245706e72eae70dbddce)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/267           | 168 ++++++++++++++++++++++++++++
 tests/qemu-iotests/267.out       | 182 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/common.filter |  11 +-
 tests/qemu-iotests/group         |   1 +
 4 files changed, 358 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/267
 create mode 100644 tests/qemu-iotests/267.out

diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
new file mode 100755
index 0000000000..d37a67c012
--- /dev/null
+++ b/tests/qemu-iotests/267
@@ -0,0 +1,168 @@
+#!/usr/bin/env bash
+#
+# Test which nodes are involved in internal snapshots
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
+owner=kwolf@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_DIR/nbd"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+# Internal snapshots are (currently) impossible with refcount_bits=1
+_unsupported_imgopts 'refcount_bits=1[^0-9]'
+
+do_run_qemu()
+{
+    echo Testing: "$@"
+    (
+        if ! test -t 0; then
+            while read cmd; do
+                echo $cmd
+            done
+        fi
+        echo quit
+    ) | $QEMU -nographic -monitor stdio -nodefaults "$@"
+    echo
+}
+
+run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp |
+        _filter_generated_node_ids | _filter_imgfmt | _filter_vmstate_size
+}
+
+size=128M
+
+run_test()
+{
+    _make_test_img $size
+    printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qemu "$@" | _filter_date
+}
+
+
+echo
+echo "=== No block devices at all ==="
+echo
+
+run_test
+
+echo
+echo "=== -drive if=none ==="
+echo
+
+run_test -drive driver=file,file="$TEST_IMG",if=none
+run_test -drive driver=$IMGFMT,file="$TEST_IMG",if=none
+run_test -drive driver=$IMGFMT,file="$TEST_IMG",if=none -device virtio-blk,drive=none0
+
+echo
+echo "=== -drive if=virtio ==="
+echo
+
+run_test -drive driver=file,file="$TEST_IMG",if=virtio
+run_test -drive driver=$IMGFMT,file="$TEST_IMG",if=virtio
+
+echo
+echo "=== Simple -blockdev ==="
+echo
+
+run_test -blockdev driver=file,filename="$TEST_IMG",node-name=file
+run_test -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+         -blockdev driver=$IMGFMT,file=file,node-name=fmt
+run_test -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+         -blockdev driver=raw,file=file,node-name=raw \
+         -blockdev driver=$IMGFMT,file=raw,node-name=fmt
+
+echo
+echo "=== -blockdev with a filter on top ==="
+echo
+
+run_test -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+         -blockdev driver=$IMGFMT,file=file,node-name=fmt \
+         -blockdev driver=copy-on-read,file=fmt,node-name=filter
+
+echo
+echo "=== -blockdev with a backing file ==="
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+
+IMGOPTS="backing_file=$TEST_IMG.base" \
+run_test -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
+         -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+         -blockdev driver=$IMGFMT,file=file,backing=backing-file,node-name=fmt
+
+IMGOPTS="backing_file=$TEST_IMG.base" \
+run_test -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
+         -blockdev driver=$IMGFMT,file=backing-file,node-name=backing-fmt \
+         -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+         -blockdev driver=$IMGFMT,file=file,backing=backing-fmt,node-name=fmt
+
+# A snapshot should be present on the overlay, but not the backing file
+echo Internal snapshots on overlay:
+$QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date | _filter_vmstate_size
+
+echo Internal snapshots on backing file:
+$QEMU_IMG snapshot -l "$TEST_IMG.base" | _filter_date | _filter_vmstate_size
+
+echo
+echo "=== -blockdev with NBD server on the backing file ==="
+echo
+
+IMGOPTS="backing_file=$TEST_IMG.base" _make_test_img $size
+cat <<EOF |
+nbd_server_start unix:$TEST_DIR/nbd
+nbd_server_add -w backing-fmt
+savevm snap0
+info snapshots
+loadvm snap0
+EOF
+run_qemu -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
+         -blockdev driver=$IMGFMT,file=backing-file,node-name=backing-fmt \
+         -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+         -blockdev driver=$IMGFMT,file=file,backing=backing-fmt,node-name=fmt |
+         _filter_date
+
+# This time, a snapshot should be created on both files
+echo Internal snapshots on overlay:
+$QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date | _filter_vmstate_size
+
+echo Internal snapshots on backing file:
+$QEMU_IMG snapshot -l "$TEST_IMG.base" | _filter_date | _filter_vmstate_size
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
new file mode 100644
index 0000000000..9d812e3c72
--- /dev/null
+++ b/tests/qemu-iotests/267.out
@@ -0,0 +1,182 @@
+QA output created by 267
+
+=== No block devices at all ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing:
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+Error: No block device can accept snapshots
+(qemu) info snapshots
+No available block device supports snapshots
+(qemu) loadvm snap0
+Error: No block device supports snapshots
+(qemu) quit
+
+
+=== -drive if=none ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+Error: Device 'none0' is writable but does not support snapshots
+(qemu) info snapshots
+No available block device supports snapshots
+(qemu) loadvm snap0
+Error: Device 'none0' is writable but does not support snapshots
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none -device virtio-blk,drive=none0
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+
+=== -drive if=virtio ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=virtio
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+Error: Device 'virtio0' is writable but does not support snapshots
+(qemu) info snapshots
+No available block device supports snapshots
+(qemu) loadvm snap0
+Error: Device 'virtio0' is writable but does not support snapshots
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=virtio
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+
+=== Simple -blockdev ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+Error: Device '' is writable but does not support snapshots
+(qemu) info snapshots
+No available block device supports snapshots
+(qemu) loadvm snap0
+Error: Device '' is writable but does not support snapshots
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,node-name=fmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=raw,file=file,node-name=raw -blockdev driver=IMGFMT,file=raw,node-name=fmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+
+=== -blockdev with a filter on top ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,node-name=fmt -blockdev driver=copy-on-read,file=fmt,node-name=filter
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+
+=== -blockdev with a backing file ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-file,node-name=fmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=IMGFMT,file=backing-file,node-name=backing-fmt -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-fmt,node-name=fmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Internal snapshots on overlay:
+Snapshot list:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+Internal snapshots on backing file:
+
+=== -blockdev with NBD server on the backing file ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=IMGFMT,file=backing-file,node-name=backing-fmt -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-fmt,node-name=fmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) nbd_server_start unix:TEST_DIR/nbd
+(qemu) nbd_server_add -w backing-fmt
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+Internal snapshots on overlay:
+Snapshot list:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+Internal snapshots on backing file:
+Snapshot list:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+*** done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 35fddc746f..67fd5f4e41 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -19,12 +19,15 @@
 # standard filters
 #
 
-# ctime(3) dates
-#
 _filter_date()
 {
-    $SED \
-        -e 's/[A-Z][a-z][a-z] [A-z][a-z][a-z]  *[0-9][0-9]* [0-9][0-9]:[0-9][0-9]:[0-9][0-9] [0-9][0-9][0-9][0-9]$/DATE/'
+    $SED -re 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/yyyy-mm-dd hh:mm:ss/'
+}
+
+_filter_vmstate_size()
+{
+    $SED -r -e 's/[0-9. ]{5} [KMGT]iB/     SIZE/' \
+            -e 's/[0-9. ]{5} B/   SIZE/'
 }
 
 _filter_generated_node_ids()
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 3660a741f2..8bc2f3857d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -273,3 +273,4 @@
 256 rw quick
 265 rw auto quick
 266 rw quick
+267 rw auto quick snapshot
-- 
2.17.1


