Received: from eggs.gnu.org ([2001:4830:134:3::10]:60783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eSPDG-0003MK-DL
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eSPDC-0001Il-Bv
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:18 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miika9764@gmail.com>) id 1eSPDC-0001IL-4T
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:14 -0500
Received: by mail-lf0-x241.google.com with SMTP id y78so26252478lfd.1
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 07:26:14 -0800 (PST)
From: Miika S <miika9764@gmail.com>
Date: Fri, 22 Dec 2017 17:25:29 +0200
Message-Id: <20171222152531.1849-2-miika9764@gmail.com>
In-Reply-To: <20171222152531.1849-1-miika9764@gmail.com>
References: <20171222152531.1849-1-miika9764@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] input: add missing JIS keys to virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, Miika S <miika9764@gmail.com>

keycodemapdb updated to add the QKeyCodes muhenkan and katakanahiragana

Signed-off-by: Miika S <miika9764@gmail.com>
---
 hw/input/virtio-input-hid.c | 7 +++++++
 qapi/ui.json                | 5 ++++-
 ui/keycodemapdb             | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index e78faec0b1..9628d289f9 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -139,6 +139,13 @@ static const unsigned int keymap_qcode[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_META_L]              = KEY_LEFTMETA,
     [Q_KEY_CODE_META_R]              = KEY_RIGHTMETA,
     [Q_KEY_CODE_MENU]                = KEY_MENU,
+
+    [Q_KEY_CODE_MUHENKAN]            = KEY_MUHENKAN,
+    [Q_KEY_CODE_HENKAN]              = KEY_HENKAN,
+    [Q_KEY_CODE_KATAKANAHIRAGANA]    = KEY_KATAKANAHIRAGANA,
+    [Q_KEY_CODE_COMPOSE]             = KEY_COMPOSE,
+    [Q_KEY_CODE_RO]                  = KEY_RO,
+    [Q_KEY_CODE_YEN]                 = KEY_YEN,
 };
 
 static const unsigned int keymap_button[INPUT_BUTTON__MAX] = {
diff --git a/qapi/ui.json b/qapi/ui.json
index 07b468f625..d6679aa8f5 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -748,6 +748,9 @@
 # @ac_bookmarks: since 2.10
 # altgr, altgr_r: dropped in 2.10
 #
+# @muhenkan: since 2.12
+# @katakanahiragana: since 2.12
+#
 # 'sysrq' was mistakenly added to hack around the fact that
 # the ps2 driver was not generating correct scancodes sequences
 # when 'alt+print' was pressed. This flaw is now fixed and the
@@ -775,7 +778,7 @@
             'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
             'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
-            'ro', 'hiragana', 'henkan', 'yen',
+            'ro', 'hiragana', 'henkan', 'yen', 'muhenkan', 'katakanahiragana',
             'kp_comma', 'kp_equals', 'power', 'sleep', 'wake',
             'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
             'volumeup', 'volumedown', 'mediaselect',
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
index 10739aa260..05dad417e9 160000
--- a/ui/keycodemapdb
+++ b/ui/keycodemapdb
@@ -1 +1 @@
-Subproject commit 10739aa26051a5d49d88132604539d3ed085e72e
+Subproject commit 05dad417e9d0b37ee1fba33056d91a6b734b3357
-- 
2.15.1
