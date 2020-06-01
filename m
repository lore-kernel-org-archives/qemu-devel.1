Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980E3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC6B2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC6B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfktL-00033D-7w
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfkne-0003od-8L; Mon, 01 Jun 2020 09:48:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:38772 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknc-0001k9-1H; Mon, 01 Jun 2020 09:48:21 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfknN-0005dY-KW; Mon, 01 Jun 2020 16:48:05 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 1/6] iotests: Add extension names to qcow2.py dump
Date: Mon,  1 Jun 2020 16:48:08 +0300
Message-Id: <1591019293-211155-2-git-send-email-andrey.shinkevich@virtuozzo.com>
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

Header extension:         Feature table
magic                     0x6803f857
length                    192
data                      <binary>

The change incurs modification of the output in 031, 036 and 061 test
cases.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/031.out  | 22 +++++++++++-----------
 tests/qemu-iotests/036.out  |  4 ++--
 tests/qemu-iotests/061.out  | 18 +++++++++---------
 tests/qemu-iotests/qcow2.py | 23 ++++++++++++++++++++---
 4 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 5a4beda..966c8d9 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -24,7 +24,7 @@ autoclear_features        []
 refcount_order            4
 header_length             72
 
-Header extension:
+Header extension:         Unknown
 magic                     0x12345678
 length                    31
 data                      'This is a test header extension'
@@ -52,7 +52,7 @@ autoclear_features        []
 refcount_order            4
 header_length             72
 
-Header extension:
+Header extension:         Unknown
 magic                     0x12345678
 length                    31
 data                      'This is a test header extension'
@@ -80,12 +80,12 @@ autoclear_features        []
 refcount_order            4
 header_length             72
 
-Header extension:
+Header extension:         Backing format
 magic                     0xe2792aca
 length                    11
 data                      'host_device'
 
-Header extension:
+Header extension:         Unknown
 magic                     0x12345678
 length                    31
 data                      'This is a test header extension'
@@ -115,12 +115,12 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
 
-Header extension:
+Header extension:         Unknown
 magic                     0x12345678
 length                    31
 data                      'This is a test header extension'
@@ -148,12 +148,12 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
 
-Header extension:
+Header extension:         Unknown
 magic                     0x12345678
 length                    31
 data                      'This is a test header extension'
@@ -181,17 +181,17 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Backing format
 magic                     0xe2792aca
 length                    11
 data                      'host_device'
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
 
-Header extension:
+Header extension:         Unknown
 magic                     0x12345678
 length                    31
 data                      'This is a test header extension'
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index e409acf..81a7366 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -24,7 +24,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 incompatible_features     []
 compatible_features       []
 autoclear_features        [63]
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
@@ -36,7 +36,7 @@ No errors were found on the image.
 incompatible_features     []
 compatible_features       []
 autoclear_features        []
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index a51ad1b..7821b7f 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -24,7 +24,7 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
@@ -82,7 +82,7 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
@@ -138,7 +138,7 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
@@ -193,7 +193,7 @@ autoclear_features        [42]
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
@@ -262,7 +262,7 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
@@ -324,7 +324,7 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
@@ -353,7 +353,7 @@ autoclear_features        []
 refcount_order            4
 header_length             112
 
-Header extension:
+Header extension:         Feature table
 magic                     0x6803f857
 length                    336
 data                      <binary>
@@ -491,7 +491,7 @@ wrote 65536/65536 bytes at offset 2147483648
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 3221225472
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-    (0.00/100%)
    (12.50/100%)
    (25.00/100%)
    (37.50/100%)
    (50.00/100%)
    (62.50/100%)
    (75.00/100%)
    (87.50/100%)
    (100.00/100%)
    (100.00/100%)
+    (0.00/100%)    (12.50/100%)    (25.00/100%)    (37.50/100%)    (50.00/100%)    (62.50/100%)    (75.00/100%)    (87.50/100%)    (100.00/100%)    (100.00/100%)
 No errors were found on the image.
 
 === Testing progress report with snapshot ===
@@ -506,7 +506,7 @@ wrote 65536/65536 bytes at offset 2147483648
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 3221225472
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-    (0.00/100%)
    (6.25/100%)
    (12.50/100%)
    (18.75/100%)
    (25.00/100%)
    (31.25/100%)
    (37.50/100%)
    (43.75/100%)
    (50.00/100%)
    (56.25/100%)
    (62.50/100%)
    (68.75/100%)
    (75.00/100%)
    (81.25/100%)
    (87.50/100%)
    (93.75/100%)
    (100.00/100%)
    (100.00/100%)
+    (0.00/100%)    (6.25/100%)    (12.50/100%)    (18.75/100%)    (25.00/100%)    (31.25/100%)    (37.50/100%)    (43.75/100%)    (50.00/100%)    (56.25/100%)    (62.50/100%)    (68.75/100%)    (75.00/100%)    (81.25/100%)    (87.50/100%)    (93.75/100%)    (100.00/100%)    (100.00/100%)
 No errors were found on the image.
 
 === Testing version downgrade with external data file ===
diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 94a07b2..e824b09 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -6,19 +6,36 @@ import string
 
 class QcowHeaderExtension:
 
+    QCOW2_EXT_MAGIC_BACKING_FORMAT = 0xE2792ACA
+    QCOW2_EXT_MAGIC_FEATURE_TABLE = 0x6803f857
+    QCOW2_EXT_MAGIC_CRYPTO_HEADER = 0x0537be77
+    QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
+    QCOW2_EXT_MAGIC_DATA_FILE = 0x44415441
+
     def __init__(self, magic, length, data):
         if length % 8 != 0:
             padding = 8 - (length % 8)
             data += b"\0" * padding
 
-        self.magic  = magic
+        self.magic = magic
         self.length = length
-        self.data   = data
+        self.data = data
+        self.name = self.extension_name(magic)
 
     @classmethod
     def create(cls, magic, data):
         return QcowHeaderExtension(magic, len(data), data)
 
+    def extension_name(self, magic):
+        return {
+            self.QCOW2_EXT_MAGIC_BACKING_FORMAT: 'Backing format',
+            self.QCOW2_EXT_MAGIC_FEATURE_TABLE: 'Feature table',
+            self.QCOW2_EXT_MAGIC_CRYPTO_HEADER: 'Crypto header',
+            self.QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
+            self.QCOW2_EXT_MAGIC_DATA_FILE: 'Data file',
+        }.get(magic, 'Unknown')
+
+
 class QcowHeader:
 
     uint32_t = 'I'
@@ -151,7 +168,7 @@ class QcowHeader:
             else:
                 data = "<binary>"
 
-            print("Header extension:")
+            print("%-25s %s" % ("Header extension:", ex.name))
             print("%-25s %#x" % ("magic", ex.magic))
             print("%-25s %d" % ("length", ex.length))
             print("%-25s %s" % ("data", data))
-- 
1.8.3.1


