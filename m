Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E88C76194
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CBA2239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CBA2239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyH1-0003Wk-3J
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43216)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBE-0007TU-A7
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBC-000636-8e
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1934
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyBA-0005m9-68
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NH27fU109375
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:02:07 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx60s8n8v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:02:06 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 18:01:29 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 18:01:27 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1QFT64684438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:26 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F7E1BE05B;
 Tue, 23 Jul 2019 17:01:26 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58D7DBE056;
 Tue, 23 Jul 2019 17:01:26 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:26 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:01:03 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072317-0004-0000-0000-0000152DB9B2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236375; UDB=6.00651638; IPR=6.01017731; 
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 17:01:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072317-0005-0000-0000-00008C9463CB
Message-Id: <20190723170104.4327-36-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 35/36] iotests: Test unaligned raw images with
 O_DIRECT
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
*remove context dependencies on iotests not in 3.1
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
index 06f48f1f23..66d7546e35 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -1,6 +1,7 @@
 #!/bin/bash
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
index 61a6d98ebd..c90889fac2 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -233,3 +233,4 @@
 233 auto quick
 234 auto quick migration
 235 auto quick
+253 rw auto quick
-- 
2.17.1


