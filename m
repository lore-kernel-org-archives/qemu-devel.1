Received: from eggs.gnu.org ([2001:4830:134:3::10]:49950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcGck-0003HO-W7
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcGch-00058c-Sx
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:45:07 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dcGch-00058B-OK
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:45:03 -0400
Received: by mail-io0-x241.google.com with SMTP id j32so9957iod.3
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 12:45:03 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 31 Jul 2017 15:44:36 -0400
Message-Id: <20170731194437.4077-2-programmingkidx@gmail.com>
In-Reply-To: <20170731194437.4077-1-programmingkidx@gmail.com>
References: <20170731194437.4077-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, eblake@redhat.com, berrange@redhat.com
Cc: John Arbuckle <programmingkidx@gmail.com>

There are now keyboards that have 19 function keys. This patch extends QEMU so these function keys can be used.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 qapi-schema.json  | 16 +++++++++++++++-
 ui/input-keymap.c | 12 ++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index c96f0a26f6..f3433aabe6 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4862,6 +4862,18 @@
 # @ac_refresh: since 2.10
 # @ac_bookmarks: since 2.10
 # altgr, altgr_r: dropped in 2.10
+# @f13: since 2.11
+# @f14: since 2.11
+# @f15: since 2.11
+# @f16: since 2.11
+# @f17: since 2.11
+# @f18: since 2.11
+# @f19: since 2.11
+# @f20: since 2.11
+# @f21: since 2.11
+# @f22: since 2.11
+# @f23: since 2.11
+# @f24: since 2.11
 #
 # Since: 1.3.0
 #
@@ -4888,7 +4900,9 @@
             'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
             'volumeup', 'volumedown', 'mediaselect',
             'mail', 'calculator', 'computer',
-            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', 'ac_bookmarks' ] }
+            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', 'ac_bookmarks',
+            'f13', 'f14', 'f15', 'f16', 'f17', 'f18', 'f19', 'f20', 'f21',
+            'f22', 'f23', 'f24']}
 
 ##
 # @KeyValue:
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index cf979c2ce9..21a25d9c63 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -251,6 +251,18 @@ static const int qcode_to_number[] = {
 
     [Q_KEY_CODE_F11] = 0x57,
     [Q_KEY_CODE_F12] = 0x58,
+    [Q_KEY_CODE_F13] = 0x5d,
+    [Q_KEY_CODE_F14] = 0x5e,
+    [Q_KEY_CODE_F15] = 0x5f,
+    [Q_KEY_CODE_F16] = 0x55,
+    [Q_KEY_CODE_F17] = 0x83,
+    [Q_KEY_CODE_F18] = 0xf7,
+    [Q_KEY_CODE_F19] = 0x84,
+    [Q_KEY_CODE_F20] = 0x5a,
+    [Q_KEY_CODE_F21] = 0x74,
+    [Q_KEY_CODE_F22] = 0xf9,
+    [Q_KEY_CODE_F23] = 0x6d,
+    [Q_KEY_CODE_F24] = 0x6f,
 
     [Q_KEY_CODE_PRINT] = 0xb7,
 
-- 
2.11.0 (Apple Git-81)
