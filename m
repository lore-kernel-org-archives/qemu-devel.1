Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCA3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4DD2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4DD2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfks8-0001SY-Qt
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknf-0003pp-EV; Mon, 01 Jun 2020 09:48:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:38782 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknc-0001k4-50; Mon, 01 Jun 2020 09:48:23 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknN-0005dY-Qd; Mon, 01 Jun 2020 16:48:05 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 6/6] iotests: Dump QCOW2 image metadata in JSON format with
 qcow2.py
Date: Mon,  1 Jun 2020 16:48:13 +0300
Message-Id: <1591019293-211155-7-git-send-email-andrey.shinkevich@virtuozzo.com>
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

Represent QCOW2 metadata dumping with qcow2.py script in JSON format

{
    "QCOW2_header_extensions": [
        {
            "Header_extension": "Feature table",
            "magic": "0x6803f857",
            "length": 192,
            "data_str": "<binary>"
        },
        {
            "Header_extension": "Bitmaps",
            "magic": "0x23852875",
            "length": 24,
            "data": {
                "nb_bitmaps": 2,
                "reserved32": 0,
                "bitmap_directory_size": 64,
                "bitmap_directory_offset": 1048576,
                "entries": [
                    {
                        "name": "bitmap-1",
                        "flags": [],
                        "flag_bits": 0,
                        "bitmap_table_offset": 589824,
                        "bitmap_table_size": 8,
                        "type": 1,
                        "granularity": 16,
                        "name_size": 8,
                        "extra_data_size": 0,
                        "bitmap_table": {
                            "table_entries": [
                                {
                                    "type": "serialized",
                                    "offset": 655360,
                                    "size": 65536
                                },

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py | 108 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 76e0c69..fd1ef4f 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -3,11 +3,21 @@
 import sys
 import struct
 import string
+import json
 
 
+dump_json = False
 cluster_size = 0
 
 
+class ComplexEncoder(json.JSONEncoder):
+    def default(self, obj):
+        if hasattr(obj, 'get_info_dict'):
+            return obj.get_info_dict()
+        else:
+            return json.JSONEncoder.default(self, obj)
+
+
 class Qcow2BitmapTableEntry:
 
     BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
@@ -23,6 +33,9 @@ class Qcow2BitmapTableEntry:
             index = entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES
         self.type = self.bmte_type[index]
 
+    def get_info_dict(self):
+        return dict(type=self.type, offset=self.offset, size=self.cluster_size)
+
 
 class Qcow2BitmapTable:
 
@@ -39,6 +52,9 @@ class Qcow2BitmapTable:
                                              entry.cluster_size))
         print("")
 
+    def get_info_dict(self):
+        return dict(table_entries=self.entries)
+
 
 class Qcow2BitmapDirEntry:
 
@@ -102,6 +118,18 @@ class Qcow2BitmapDirEntry:
 
         self.bitmap_table.print_bitmap_table()
 
+    def get_info_dict(self):
+        return dict(name=self.name,
+                    flags=self.bitmap_flags,
+                    flag_bits=self.flag_bits,
+                    bitmap_table_offset=self.bitmap_table_offset,
+                    bitmap_table_size=self.bitmap_table_size,
+                    type=self.type,
+                    granularity=self.granularity_bits,
+                    name_size=self.name_size,
+                    extra_data_size=self.extra_data_size,
+                    bitmap_table=self.bitmap_table)
+
 
 class Qcow2BitmapDirectory:
 
@@ -177,6 +205,31 @@ class Qcow2BitmapExt:
         self.dump_bitmap_ext()
         self.dump_bitmap_directory()
 
+    def get_info_dict(self):
+        return dict(nb_bitmaps=self.nb_bitmaps,
+                    reserved32=self.reserved32,
+                    bitmap_directory_size=self.bitmap_directory_size,
+                    bitmap_directory_offset=self.bitmap_directory_offset,
+                    entries=self.bitmaps)
+
+
+class Qcow2HeaderDoc:
+
+    def __init__(self, h):
+        self.header = h
+
+    def get_info_dict(self):
+        return dict(QCOW2_header=self.header)
+
+
+class Qcow2HeaderExtensionsDoc:
+
+    def __init__(self, extensions):
+        self.extensions = extensions
+
+    def get_info_dict(self):
+        return dict(QCOW2_header_extensions=self.extensions)
+
 
 class QcowHeaderExtension:
 
@@ -224,6 +277,17 @@ class QcowHeaderExtension:
         if self.obj is not None:
             self.obj.load(fd)
 
+    def get_info_dict(self):
+        he_dict = dict(Header_extension=self.name,
+                       magic=hex(self.magic),
+                       length=self.length)
+        if self.obj is not None:
+            he_dict.update(data=self.obj)
+        else:
+            he_dict.update(data_str=self.data_str)
+
+        return he_dict
+
 
 class QcowHeader:
 
@@ -353,9 +417,34 @@ class QcowHeader:
             print("%-25s" % f[2], value_str)
         print("")
 
+    def get_info_dict(self):
+        return dict(magic=hex(self.magic),
+                    version=self.version,
+                    backing_file_offset=hex(self.backing_file_offset),
+                    backing_file_size=self.backing_file_size,
+                    cluster_bits=self.cluster_bits,
+                    size=self.size,
+                    crypt_method=self.crypt_method,
+                    l1_size=self.l1_size,
+                    l1_table_offset=hex(self.l1_table_offset),
+                    refcount_table_offset=hex(self.refcount_table_offset),
+                    refcount_table_clusters=self.refcount_table_clusters,
+                    nb_snapshots=self.nb_snapshots,
+                    snapshot_offset=hex(self.snapshot_offset),
+                    incompatible_features=self.incompatible_features,
+                    compatible_features=self.compatible_features,
+                    autoclear_features=self.autoclear_features,
+                    refcount_order=self.refcount_order,
+                    header_length=self.header_length)
+
     def dump_extensions(self):
-        for ex in self.extensions:
+        if dump_json:
+            ext_doc = Qcow2HeaderExtensionsDoc(self.extensions)
+            print(json.dumps(ext_doc.get_info_dict(), indent=4,
+                             cls=ComplexEncoder))
+            return
 
+        for ex in self.extensions:
             print("%-25s %s" % ("Header extension:", ex.name))
             print("%-25s %#x" % ("magic", ex.magic))
             print("%-25s %d" % ("length", ex.length))
@@ -368,7 +457,11 @@ class QcowHeader:
 
 def cmd_dump_header(fd):
     h = QcowHeader(fd)
-    h.dump()
+    if dump_json:
+        h_doc = Qcow2HeaderDoc(h)
+        print(json.dumps(h_doc.get_info_dict(), indent=4, cls=ComplexEncoder))
+    else:
+        h.dump()
     h.dump_extensions()
 
 def cmd_dump_header_exts(fd):
@@ -460,6 +553,12 @@ cmds = [
 ]
 
 def main(filename, cmd, args):
+    global dump_json
+    dump_json = '-j' in sys.argv
+    if dump_json:
+        sys.argv.remove('-j')
+        args.remove('-j')
+
     fd = open(filename, "r+b")
     try:
         for name, handler, num_args, desc in cmds:
@@ -476,11 +575,14 @@ def main(filename, cmd, args):
         fd.close()
 
 def usage():
-    print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
+    print("Usage: %s <file> <cmd> [<arg>, ...] [<key>, ...]" % sys.argv[0])
     print("")
     print("Supported commands:")
     for name, handler, num_args, desc in cmds:
         print("    %-20s - %s" % (name, desc))
+    print("")
+    print("Supported keys:")
+    print("    %-20s - %s" % ('-j', 'Dump in JSON format'))
 
 if __name__ == '__main__':
     if len(sys.argv) < 3:
-- 
1.8.3.1


