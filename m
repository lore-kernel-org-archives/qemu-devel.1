Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41142068D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41142068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfkof-000574-0i
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfkne-0003oO-14; Mon, 01 Jun 2020 09:48:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:38774 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknc-0001k3-4Y; Mon, 01 Jun 2020 09:48:21 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknN-0005dY-O0; Mon, 01 Jun 2020 16:48:05 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 4/6] iotests: Dump bitmap directory info with qcow2.py
Date: Mon,  1 Jun 2020 16:48:11 +0300
Message-Id: <1591019293-211155-5-git-send-email-andrey.shinkevich@virtuozzo.com>
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

Read and dump entries from the bitmap directory of QCOW2 image with the
script qcow2.py.

Header extension:         Bitmaps
...
Bitmap name               bitmap-1
flag                      auto
bitmap_table_offset       0xf0000
bitmap_table_size         8
flag_bits                 2
type                      1
granularity_bits          16
name_size                 8
extra_data_size           0

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py | 104 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 8286115..e4453f6 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -5,6 +5,88 @@ import struct
 import string
 
 
+class Qcow2BitmapDirEntry:
+
+    name = ''
+
+    uint8_t = 'B'
+    uint16_t = 'H'
+    uint32_t = 'I'
+    uint64_t = 'Q'
+
+    fields = [
+        [uint64_t, '%#x', 'bitmap_table_offset'],
+        [uint32_t, '%d',  'bitmap_table_size'],
+        [uint32_t, '%d',  'flag_bits'],
+        [uint8_t,  '%d',  'type'],
+        [uint8_t,  '%d',  'granularity_bits'],
+        [uint16_t, '%d',  'name_size'],
+        [uint32_t, '%d',  'extra_data_size']
+    ]
+
+    fmt = '>' + ''.join(field[0] for field in fields)
+
+    def __init__(self, data):
+
+        entry = struct.unpack(Qcow2BitmapDirEntry.fmt, data)
+        self.__dict__ = dict((field[2], entry[i])
+                             for i, field in enumerate(
+                                 Qcow2BitmapDirEntry.fields))
+
+        self.bitmap_table_size = self.bitmap_table_size \
+            * struct.calcsize(self.uint64_t)
+
+        self.bitmap_flags = []
+        BME_FLAG_IN_USE = 1
+        BME_FLAG_AUTO = 1 << 1
+        if (self.flag_bits & BME_FLAG_IN_USE) != 0:
+            self.bitmap_flags.append("in-use")
+        if (self.flag_bits & BME_FLAG_AUTO) != 0:
+            self.bitmap_flags.append("auto")
+
+    def bitmap_dir_entry_raw_size(self):
+        return struct.calcsize(self.fmt) + self.name_size + \
+            self.extra_data_size
+
+    def dump_bitmap_dir_entry(self):
+        print("%-25s" % 'Bitmap name', self.name)
+
+        for fl in self.bitmap_flags:
+            print("%-25s" % 'flag', fl)
+
+        for f in Qcow2BitmapDirEntry.fields:
+            value = self.__dict__[f[2]]
+            value_str = f[1] % value
+            print("%-25s" % f[2], value_str)
+
+
+class Qcow2BitmapDirectory:
+
+    def __init__(self, bm_header_ext):
+        self.nb_bitmaps = bm_header_ext.nb_bitmaps
+        self.bitmap_directory_offset = bm_header_ext.bitmap_directory_offset
+        self.bitmap_directory_size = bm_header_ext.bitmap_directory_size
+
+    def read_bitmap_directory(self, fd):
+        self.bitmaps = []
+        fd.seek(self.bitmap_directory_offset)
+        buf_size = struct.calcsize(Qcow2BitmapDirEntry.fmt)
+
+        for n in range(self.nb_bitmaps):
+            buf = fd.read(buf_size)
+            dir_entry = Qcow2BitmapDirEntry(buf)
+            fd.seek(dir_entry.extra_data_size, 1)
+            bitmap_name = fd.read(dir_entry.name_size)
+            dir_entry.name = bitmap_name.decode('ascii')
+            self.bitmaps.append(dir_entry)
+            entry_raw_size = dir_entry.bitmap_dir_entry_raw_size()
+            shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
+            fd.seek(shift, 1)
+
+    def get_bitmaps(self):
+        return self.bitmaps
+
+
 class Qcow2BitmapExt:
 
     uint32_t = 'I'
@@ -33,8 +115,21 @@ class Qcow2BitmapExt:
             print("%-25s" % f[2], value_str)
         print("")
 
+    def read_bitmap_directory(self, fd):
+        bm_directory = Qcow2BitmapDirectory(self)
+        bm_directory.read_bitmap_directory(fd)
+        self.bitmaps = bm_directory.get_bitmaps()
+
+    def load(self, fd):
+        self.read_bitmap_directory(fd)
+
+    def dump_bitmap_directory(self):
+        for bm in self.bitmaps:
+            bm.dump_bitmap_dir_entry()
+
     def dump_ext(self):
         self.dump_bitmap_ext()
+        self.dump_bitmap_directory()
 
 
 class QcowHeaderExtension:
@@ -79,6 +174,10 @@ class QcowHeaderExtension:
             self.QCOW2_EXT_MAGIC_DATA_FILE: 'Data file',
         }.get(magic, 'Unknown')
 
+    def load(self, fd):
+        if self.obj is not None:
+            self.obj.load(fd)
+
 
 class QcowHeader:
 
@@ -157,7 +256,10 @@ class QcowHeader:
             else:
                 padded = (length + 7) & ~7
                 data = fd.read(padded)
-                self.extensions.append(QcowHeaderExtension(magic, length, data))
+                self.extensions.append(QcowHeaderExtension(magic, length,
+                                                           data))
+        for ex in self.extensions:
+            ex.load(fd)
 
     def update_extensions(self, fd):
 
-- 
1.8.3.1


