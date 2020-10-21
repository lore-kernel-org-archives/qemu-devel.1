Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D658C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 08:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B882A21655
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 08:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B882A21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV9iM-00035T-L5
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likejun6@huawei.com>)
 id 1kV8do-0002nZ-PH; Wed, 21 Oct 2020 03:34:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5196 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likejun6@huawei.com>)
 id 1kV8dm-0004LN-Es; Wed, 21 Oct 2020 03:34:36 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1151A157D69E328213EB;
 Wed, 21 Oct 2020 15:34:24 +0800 (CST)
Received: from DESKTOP-IB00AOP.china.huawei.com (10.174.184.163) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 21 Oct 2020 15:34:14 +0800
From: <likejun6@huawei.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH 4/4] qemu-iotest: add 311 testcase
Date: Wed, 21 Oct 2020 15:33:55 +0800
Message-ID: <20201021073355.2499-5-likejun6@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20201021073355.2499-1-likejun6@huawei.com>
References: <20201021073355.2499-1-likejun6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.163]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=likejun6@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 03:34:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 Oct 2020 04:40:13 -0400
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, mreitz@redhat.com, likejun <likejun6@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: likejun <likejun6@huawei.com>

Test backing file is raw

Signed-off-by: likejun <likejun6@huawei.com>
---
 tests/qemu-iotests/311     | 70 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/311.out | 30 ++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100755 tests/qemu-iotests/311
 create mode 100644 tests/qemu-iotests/311.out

diff --git a/tests/qemu-iotests/311 b/tests/qemu-iotests/311
new file mode 100755
index 0000000000..6c2b9f987f
--- /dev/null
+++ b/tests/qemu-iotests/311
@@ -0,0 +1,70 @@
+#!/bin/bash
+#
+# Test backing file is raw
+#
+# Copyright (C) 2020 Huawei, Inc
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
+owner=zhangshuai13@huawei.com
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
+. ./common.rc >/dev/null 2>&1
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo "=== Check qemu-img info output ==="
+echo
+size=64M
+
+$QEMU_IMG create -f raw $TEST_IMG $size | _filter_img_create
+_img_info | _filter_img_info
+mv "$TEST_IMG" "$TEST_IMG.base"
+
+_make_test_img -b $TEST_IMG.base -F raw
+_img_info --backing-chain | _filter_img_info
+
+echo
+echo "== reading whole image =="
+$QEMU_IO -c "read 0 $size" "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "== rewriting whole image =="
+$QEMU_IO -c "write -P 0xa 0 $size" "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "== verify pattern =="
+$QEMU_IO -c "read -P 0xa 0 $size" "$TEST_IMG" | _filter_qemu_io
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/311.out b/tests/qemu-iotests/311.out
new file mode 100644
index 0000000000..03b8374c04
--- /dev/null
+++ b/tests/qemu-iotests/311.out
@@ -0,0 +1,30 @@
+QA output created by 311
+=== Check qemu-img info output ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=raw size=67108864
+image: TEST_DIR/t.IMGFMT
+file format: raw
+virtual size: 64 MiB (67108864 bytes)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64 MiB (67108864 bytes)
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: raw
+
+image: TEST_DIR/t.IMGFMT.base
+file format: raw
+virtual size: 64 MiB (67108864 bytes)
+
+== reading whole image ==
+read 67108864/67108864 bytes at offset 0
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== rewriting whole image ==
+wrote 67108864/67108864 bytes at offset 0
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 67108864/67108864 bytes at offset 0
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index e8b6480890..ec57e16f07 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -318,3 +318,4 @@
 308 rw auto quick
 309 rw auto quick
 310 rw auto quick
+311 rw auto quick
-- 
2.19.1



