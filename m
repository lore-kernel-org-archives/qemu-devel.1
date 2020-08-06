Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A95420748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A95420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mSw-0006Az-BB
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3lgO-0002PT-8D; Thu, 06 Aug 2020 15:36:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:56481 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3lgK-0000Kr-5A; Thu, 06 Aug 2020 15:36:07 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k3lgB-0003k9-VR; Thu, 06 Aug 2020 22:35:55 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v13 07/11] qcow2_format.py: Dump bitmap table serialized
 entries
Date: Thu,  6 Aug 2020 22:35:53 +0300
Message-Id: <1596742557-320265-8-git-send-email-andrey.shinkevich@virtuozzo.com>
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Add bitmap table information to the QCOW2 metadata dump.

Bitmap name               bitmap-1
...
Bitmap table   type            size         offset
0              serialized      65536        10092544
1              all-zeroes      0            0
2              all-zeroes      0            0

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/303.out         |  4 +++
 tests/qemu-iotests/qcow2_format.py | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
index 038ba93..70828e0 100644
--- a/tests/qemu-iotests/303.out
+++ b/tests/qemu-iotests/303.out
@@ -66,6 +66,8 @@ type                      1
 granularity_bits          15
 name_size                 8
 extra_data_size           0
+Bitmap table   type            size         offset
+0              serialized      65536        10092544
 
 Bitmap name               bitmap-2
 bitmap_table_offset       0x9c0000
@@ -75,4 +77,6 @@ type                      1
 granularity_bits          16
 name_size                 8
 extra_data_size           0
+Bitmap table   type            size         offset
+0              all-zeroes      0            0
 
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index ca0d350..574249b 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -175,6 +175,10 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         entry_raw_size = self.bitmap_dir_entry_raw_size()
         padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
         fd.seek(padding, 1)
+        self.bitmap_table = Qcow2BitmapTable(fd=fd,
+                                             offset=self.bitmap_table_offset,
+                                             nb_entries=self.bitmap_table_size,
+                                             cluster_size=self.cluster_size)
 
     def bitmap_dir_entry_raw_size(self):
         return struct.calcsize(self.fmt) + self.name_size + \
@@ -183,6 +187,52 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
     def dump(self):
         print(f'{"Bitmap name":<25} {self.name}')
         super(Qcow2BitmapDirEntry, self).dump()
+        self.bitmap_table.dump()
+
+
+class Qcow2BitmapTableEntry(Qcow2Struct):
+
+    fields = (
+        ('u64',  '{}', 'entry'),
+    )
+
+    BME_TABLE_ENTRY_RESERVED_MASK = 0xff000000000001fe
+    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
+    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
+
+    def __init__(self, fd):
+        super().__init__(fd=fd)
+        self.reserved = self.entry & self.BME_TABLE_ENTRY_RESERVED_MASK
+        self.offset = self.entry & self.BME_TABLE_ENTRY_OFFSET_MASK
+        if self.offset:
+            if self.entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
+                self.type = 'invalid'
+            else:
+                self.type = 'serialized'
+        elif self.entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
+            self.type = 'all-ones'
+        else:
+            self.type = 'all-zeroes'
+
+
+class Qcow2BitmapTable:
+
+    def __init__(self, fd, offset, nb_entries, cluster_size):
+        self.cluster_size = cluster_size
+        position = fd.tell()
+        fd.seek(offset)
+        self.entries = [Qcow2BitmapTableEntry(fd) for _ in range(nb_entries)]
+        fd.seek(position)
+
+    def dump(self):
+        bitmap_table = enumerate(self.entries)
+        print(f'{"Bitmap table":<14} {"type":<15} {"size":<12} {"offset"}')
+        for i, entry in bitmap_table:
+            if entry.type == 'serialized':
+                size = self.cluster_size
+            else:
+                size = 0
+            print(f'{i:<14} {entry.type:<15} {size:<12} {entry.offset}')
 
 
 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
-- 
1.8.3.1


