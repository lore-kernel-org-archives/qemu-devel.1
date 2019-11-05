Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F7CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175A421A49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175A421A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5qi-0002KD-T7
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5ov-0000DW-Pu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5ou-0001re-BM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:52:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1100
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5ou-0001ql-6Z; Tue, 05 Nov 2019 15:52:56 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpXDZ133229; Tue, 5 Nov 2019 15:52:54 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w3engv3h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:52:53 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5Kpafs133476;
 Tue, 5 Nov 2019 15:52:53 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w3engv3gy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:52:52 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnuYR025651;
 Tue, 5 Nov 2019 20:52:52 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02wdc.us.ibm.com with ESMTP id 2w11e797w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:52:52 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5Kqppt10945384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:52:51 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5C63124052;
 Tue,  5 Nov 2019 20:52:51 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A877A124058;
 Tue,  5 Nov 2019 20:52:51 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:52:51 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/55] iotests: Test reverse sub-cluster qcow2 writes
Date: Tue,  5 Nov 2019 14:51:57 -0600
Message-Id: <20191105205243.3766-10-mdroth@linux.vnet.ibm.com>
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

This exercises the regression introduced in commit
50ba5b2d994853b38fed10e0841b119da0f8b8e5.  On my machine, it has close
to a 50 % false-negative rate, but that should still be sufficient to
test the fix.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ae6ef0190981a21f2d4bc8dcee7253688f14fae7)
 Conflicts:
	tests/qemu-iotests/group
*fix context deps on tests not in 4.1.0
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/265     | 67 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/265.out |  6 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 74 insertions(+)
 create mode 100755 tests/qemu-iotests/265
 create mode 100644 tests/qemu-iotests/265.out

diff --git a/tests/qemu-iotests/265 b/tests/qemu-iotests/265
new file mode 100755
index 0000000000..dce6f77be3
--- /dev/null
+++ b/tests/qemu-iotests/265
@@ -0,0 +1,67 @@
+#!/usr/bin/env bash
+#
+# Test reverse-ordered qcow2 writes on a sub-cluster level
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
+seq=$(basename $0)
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
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
+# qcow2-specific test
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo '--- Writing to the image ---'
+
+# Reduce cluster size so we get more and quicker I/O
+IMGOPTS='cluster_size=4096' _make_test_img 1M
+(for ((kb = 1024 - 4; kb >= 0; kb -= 4)); do \
+     echo "aio_write -P 42 $((kb + 1))k 2k"; \
+ done) \
+ | $QEMU_IO "$TEST_IMG" > /dev/null
+
+echo '--- Verifying its content ---'
+
+(for ((kb = 0; kb < 1024; kb += 4)); do \
+    echo "read -P 0 ${kb}k 1k"; \
+    echo "read -P 42 $((kb + 1))k 2k"; \
+    echo "read -P 0 $((kb + 3))k 1k"; \
+ done) \
+ | $QEMU_IO "$TEST_IMG" | _filter_qemu_io | grep 'verification'
+
+# Status of qemu-io
+if [ ${PIPESTATUS[1]} = 0 ]; then
+    echo 'Content verified.'
+fi
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/265.out b/tests/qemu-iotests/265.out
new file mode 100644
index 0000000000..6eac620f25
--- /dev/null
+++ b/tests/qemu-iotests/265.out
@@ -0,0 +1,6 @@
+QA output created by 265
+--- Writing to the image ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+--- Verifying its content ---
+Content verified.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f13e5f2e23..468458efb1 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -271,3 +271,4 @@
 254 rw backing quick
 255 rw quick
 256 rw quick
+265 rw auto quick
-- 
2.17.1


