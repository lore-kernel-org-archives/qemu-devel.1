Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120DCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16C12074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16C12074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfkqF-0007Iz-51
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknf-0003pA-4a; Mon, 01 Jun 2020 09:48:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:38776 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknc-0001k7-8G; Mon, 01 Jun 2020 09:48:22 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknN-0005dY-PD; Mon, 01 Jun 2020 16:48:05 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 5/6] iotests: Dump bitmap table entries serialized in QCOW2
 image
Date: Mon,  1 Jun 2020 16:48:12 +0300
Message-Id: <1591019293-211155-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 09:48:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Add bitmap table info to the QCOW2 metadata dump with qcow2.py.

Bitmap name               bitmap-1
...
itmap table    type            offset          size
        0       serialized      0xa0000         65536
        1       all-zeroes      0x0             65536
        2       all-zeroes      0x0             65536
        3       all-zeroes      0x0             65536
        4       all-zeroes      0x0             65536
        5       all-zeroes      0x0             65536
        6       all-zeroes      0x0             65536
        7       all-zeroes      0x0             65536

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index e4453f6..76e0c69 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -5,6 +5,41 @@ import struct
 import string
 
 
+cluster_size = 0
+
+
+class Qcow2BitmapTableEntry:
+
+    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
+    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
+    bmte_type = ['all-zeroes', 'all-ones', 'serialized']
+
+    def __init__(self, entry):
+        self.cluster_size = cluster_size
+        self.offset = entry & self.BME_TABLE_ENTRY_OFFSET_MASK
+        if self.offset != 0:
+            index = 2
+        else:
+            index = entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES
+        self.type = self.bmte_type[index]
+
+
+class Qcow2BitmapTable:
+
+    def __init__(self, raw_table):
+        self.entries = []
+        for entry in raw_table:
+            self.entries.append(Qcow2BitmapTableEntry(entry))
+
+    def print_bitmap_table(self):
+        bitmap_table = enumerate(self.entries)
+        print("Bitmap table\ttype\t\toffset\t\tsize")
+        for i, entry in bitmap_table:
+            print("\t%-4d\t%s\t%#x\t\t%d" % (i, entry.type, entry.offset,
+                                             entry.cluster_size))
+        print("")
+
+
 class Qcow2BitmapDirEntry:
 
     name = ''
@@ -48,6 +83,12 @@ class Qcow2BitmapDirEntry:
         return struct.calcsize(self.fmt) + self.name_size + \
             self.extra_data_size
 
+    def read_bitmap_table(self, fd):
+        fd.seek(self.bitmap_table_offset)
+        table_size = self.bitmap_table_size * struct.calcsize(self.uint64_t)
+        table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
+        self.bitmap_table = Qcow2BitmapTable(table)
+
     def dump_bitmap_dir_entry(self):
         print("%-25s" % 'Bitmap name', self.name)
 
@@ -59,6 +100,8 @@ class Qcow2BitmapDirEntry:
             value_str = f[1] % value
             print("%-25s" % f[2], value_str)
 
+        self.bitmap_table.print_bitmap_table()
+
 
 class Qcow2BitmapDirectory:
 
@@ -83,6 +126,9 @@ class Qcow2BitmapDirectory:
             shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
             fd.seek(shift, 1)
 
+        for bm in self.bitmaps:
+            bm.read_bitmap_table(fd)
+
     def get_bitmaps(self):
         return self.bitmaps
 
@@ -223,6 +269,8 @@ class QcowHeader:
 
         self.set_defaults()
         self.cluster_size = 1 << self.cluster_bits
+        global cluster_size
+        cluster_size = self.cluster_size
 
         fd.seek(self.header_length)
         self.load_extensions(fd)
-- 
1.8.3.1


