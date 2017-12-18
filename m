Received: from eggs.gnu.org ([2001:4830:134:3::10]:35262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eQvPY-0002wc-Ix
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eQvPV-0007Me-VJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:24:52 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miika9764@gmail.com>) id 1eQvPV-0007Lx-Mr
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:24:49 -0500
Received: by mail-lf0-x244.google.com with SMTP id f20so17764756lfe.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:24:49 -0800 (PST)
From: Miika S <miika9764@gmail.com>
Date: Mon, 18 Dec 2017 15:24:37 +0200
Message-Id: <20171218132439.2772-1-miika9764@gmail.com>
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
Cc: Miika S <miika9764@gmail.com>

Signed-off-by: Miika S <miika9764@gmail.com>
---
 hw/input/virtio-input-hid.c | 7 +++++++
 qapi/ui.json                | 2 +-
 ui/keycodemapdb             | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

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
index 07b468f625..da4be505ac 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -775,7 +775,7 @@
             'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
             'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
-            'ro', 'hiragana', 'henkan', 'yen',
+            'ro', 'hiragana', 'muhenkan', 'henkan', 'katakanahiragana', 'yen',
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
