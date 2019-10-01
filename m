Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C31BC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 23:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEA920659
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 23:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEA920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFRv7-00045c-GX
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 19:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrd-00017L-99
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrb-0001JH-3X
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37212
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRra-0001IH-TL; Tue, 01 Oct 2019 19:47:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPVu179319; Tue, 1 Oct 2019 19:47:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpncq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:26 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlPcJ179290;
 Tue, 1 Oct 2019 19:47:25 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpncn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:25 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjkJo027153;
 Tue, 1 Oct 2019 23:47:20 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:19 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlJg944564960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:19 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A18B28059;
 Tue,  1 Oct 2019 23:47:19 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01BBF28058;
 Tue,  1 Oct 2019 23:47:19 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:18 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/97] iotests: Test unaligned raw images with O_DIRECT
Date: Tue,  1 Oct 2019 18:44:53 -0500
Message-Id: <20191001234616.7825-15-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

We already have 221 for accesses through the page cache, but it is
better to create a new file for O_DIRECT instead of integrating those
test cases into 221.  This way, we can make use of
_supported_cache_modes (and _default_cache_mode) so the test is
automatically skipped on filesystems that do not support O_DIRECT.

As part of the split, add _supported_cache_modes to 221.  With that, it
no longer fails when run with -c none or -c directsync.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 2fab30c80b33cdc6157c7efe6207e54b6835cf92)
 Conflicts:
	tests/qemu-iotests/group
*fix context deps on test groups not in 4.0

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/221     |  4 ++
 tests/qemu-iotests/253     | 84 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/253.out | 14 +++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 103 insertions(+)
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out

diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 808cd9a289..92c9b13cd8 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -1,6 +1,7 @@
 #!/usr/bin/env bash
 #
 # Test qemu-img vs. unaligned images
+# (See also 253, which is the O_DIRECT version)
 #
 # Copyright (C) 2018 Red Hat, Inc.
 #
@@ -37,6 +38,9 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux
 
+_default_cache_mode writeback
+_supported_cache_modes writeback writethrough unsafe
+
 echo
 echo "=== Check mapping of unaligned raw image ==="
 echo
diff --git a/tests/qemu-iotests/253 b/tests/qemu-iotests/253
new file mode 100755
index 0000000000..d88d5afa45
--- /dev/null
+++ b/tests/qemu-iotests/253
@@ -0,0 +1,84 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img vs. unaligned images; O_DIRECT version
+# (Originates from 221)
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
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt raw
+_supported_proto file
+_supported_os Linux
+
+_default_cache_mode none
+_supported_cache_modes none directsync
+
+echo
+echo "=== Check mapping of unaligned raw image ==="
+echo
+
+# We do not know how large a physical sector is, but it is certainly
+# going to be a factor of 1 MB
+size=$((1 * 1024 * 1024 - 1))
+
+# qemu-img create rounds size up to BDRV_SECTOR_SIZE
+_make_test_img $size
+$QEMU_IMG map --output=json --image-opts \
+    "driver=$IMGFMT,file.driver=file,file.filename=$TEST_IMG,cache.direct=on" \
+    | _filter_qemu_img_map
+
+# so we resize it and check again
+truncate --size=$size "$TEST_IMG"
+$QEMU_IMG map --output=json --image-opts \
+    "driver=$IMGFMT,file.driver=file,file.filename=$TEST_IMG,cache.direct=on" \
+    | _filter_qemu_img_map
+
+# qemu-io with O_DIRECT always writes whole physical sectors.  Again,
+# we do not know how large a physical sector is, so we just start
+# writing from a 64 kB boundary, which should always be aligned.
+offset=$((1 * 1024 * 1024 - 64 * 1024))
+$QEMU_IO -c "w $offset $((size - offset))" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG map --output=json --image-opts \
+    "driver=$IMGFMT,file.driver=file,file.filename=$TEST_IMG,cache.direct=on" \
+    | _filter_qemu_img_map
+
+# Resize it and check again -- contrary to 221, we may not get partial
+# sectors here, so there should be only two areas (one zero, one
+# data).
+truncate --size=$size "$TEST_IMG"
+$QEMU_IMG map --output=json --image-opts \
+    "driver=$IMGFMT,file.driver=file,file.filename=$TEST_IMG,cache.direct=on" \
+    | _filter_qemu_img_map
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
new file mode 100644
index 0000000000..607c0baa0b
--- /dev/null
+++ b/tests/qemu-iotests/253.out
@@ -0,0 +1,14 @@
+QA output created by 253
+
+=== Check mapping of unaligned raw image ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048575
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+wrote 65535/65535 bytes at offset 983040
+63.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": false, "offset": OFFSET},
+{ "start": 983040, "length": 65536, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index bae7718380..4cd2fe80a6 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -248,3 +248,4 @@
 246 rw auto quick
 247 rw auto quick
 248 rw auto quick
+253 rw auto quick
-- 
2.17.1


