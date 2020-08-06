Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89088C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C9320748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C9320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mVv-0003p3-Ka
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3lgQ-0002Xw-Os; Thu, 06 Aug 2020 15:36:10 -0400
Received: from relay.sw.ru ([185.231.240.75]:56458 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3lgK-0000Km-7H; Thu, 06 Aug 2020 15:36:10 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3lgC-0003k9-4X; Thu, 06 Aug 2020 22:35:56 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v13 11/11] iotests: dump QCOW2 header in JSON in #303
Date: Thu,  6 Aug 2020 22:35:57 +0300
Message-Id: <1596742557-320265-12-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596742557-320265-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1596742557-320265-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 15:35:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend the test case #303 by dumping QCOW2 image metadata in JSON
format.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/303     |  3 ++
 tests/qemu-iotests/303.out | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/tests/qemu-iotests/303 b/tests/qemu-iotests/303
index e9accdc..6c21774 100755
--- a/tests/qemu-iotests/303
+++ b/tests/qemu-iotests/303
@@ -58,3 +58,6 @@ add_bitmap(1, 0, 6, False)
 add_bitmap(2, 6, 8, True)
 dump = ['qcow2.py', disk, 'dump-header']
 subprocess.run(dump)
+# Dump the metadata in JSON format
+dump.append('-j')
+subprocess.run(dump)
diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
index 70828e0..7fa1ede 100644
--- a/tests/qemu-iotests/303.out
+++ b/tests/qemu-iotests/303.out
@@ -80,3 +80,79 @@ extra_data_size           0
 Bitmap table   type            size         offset
 0              all-zeroes      0            0
 
+{
+    "magic": 1363560955,
+    "version": 3,
+    "backing_file_offset": 0,
+    "backing_file_size": 0,
+    "cluster_bits": 16,
+    "size": 10485760,
+    "crypt_method": 0,
+    "l1_size": 1,
+    "l1_table_offset": 196608,
+    "refcount_table_offset": 65536,
+    "refcount_table_clusters": 1,
+    "nb_snapshots": 0,
+    "snapshot_offset": 0,
+    "incompatible_features": 0,
+    "compatible_features": 0,
+    "autoclear_features": 1,
+    "refcount_order": 4,
+    "header_length": 112
+}
+
+[
+    {
+        "name": "Feature table",
+        "magic": 1745090647,
+        "length": 336,
+        "data_str": "<binary>"
+    },
+    {
+        "name": "Bitmaps",
+        "magic": 595929205,
+        "length": 24,
+        "data": {
+            "nb_bitmaps": 2,
+            "reserved32": 0,
+            "bitmap_directory_size": 64,
+            "bitmap_directory_offset": 10289152,
+            "bitmap_directory": [
+                {
+                    "name": "bitmap-1",
+                    "bitmap_table_offset": 10158080,
+                    "bitmap_table_size": 1,
+                    "flags": 2,
+                    "type": 1,
+                    "granularity_bits": 15,
+                    "name_size": 8,
+                    "extra_data_size": 0,
+                    "bitmap_table": [
+                        {
+                            "type": "serialized",
+                            "offset": 10092544,
+                            "reserved": 0
+                        }
+                    ]
+                },
+                {
+                    "name": "bitmap-2",
+                    "bitmap_table_offset": 10223616,
+                    "bitmap_table_size": 1,
+                    "flags": 0,
+                    "type": 1,
+                    "granularity_bits": 16,
+                    "name_size": 8,
+                    "extra_data_size": 0,
+                    "bitmap_table": [
+                        {
+                            "type": "all-zeroes",
+                            "offset": 0,
+                            "reserved": 0
+                        }
+                    ]
+                }
+            ]
+        }
+    }
+]
-- 
1.8.3.1


