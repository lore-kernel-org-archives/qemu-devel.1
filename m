Received: from eggs.gnu.org ([2001:4830:134:3::10]:33708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLR-0003Pu-HQ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLH-0001uC-RJ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dajLH-0001tK-7J
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0AD9B06A2
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 14:00:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Jul 2017 16:00:22 +0200
Message-Id: <20170727140025.392-5-kraxel@redhat.com>
In-Reply-To: <20170727140025.392-1-kraxel@redhat.com>
References: <20170727140025.392-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Add multimedia keys to QKeyCodes and to the keymaps.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170726152918.11995-5-kraxel@redhat.com
---
 ui/input-keymap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 qapi-schema.json  | 28 +++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 7461e1edde..ae781beae9 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -116,6 +116,28 @@ static int linux_to_qcode[KEY_CNT] = {
     [KEY_LEFTMETA]       = Q_KEY_CODE_META_L,
     [KEY_RIGHTMETA]      = Q_KEY_CODE_META_R,
     [KEY_MENU]           = Q_KEY_CODE_MENU,
+
+    [KEY_SLEEP]          = Q_KEY_CODE_SLEEP,
+    [KEY_WAKEUP]         = Q_KEY_CODE_WAKE,
+    [KEY_CALC]           = Q_KEY_CODE_CALCULATOR,
+    [KEY_MAIL]           = Q_KEY_CODE_MAIL,
+    [KEY_COMPUTER]       = Q_KEY_CODE_COMPUTER,
+
+    [KEY_STOP]           = Q_KEY_CODE_AC_STOP,
+    [KEY_BOOKMARKS]      = Q_KEY_CODE_AC_BOOKMARKS,
+    [KEY_BACK]           = Q_KEY_CODE_AC_BACK,
+    [KEY_FORWARD]        = Q_KEY_CODE_AC_FORWARD,
+    [KEY_HOMEPAGE]       = Q_KEY_CODE_AC_HOME,
+    [KEY_REFRESH]        = Q_KEY_CODE_AC_REFRESH,
+    [KEY_FIND]           = Q_KEY_CODE_AC_SEARCH,
+
+    [KEY_NEXTSONG]       = Q_KEY_CODE_AUDIONEXT,
+    [KEY_PREVIOUSSONG]   = Q_KEY_CODE_AUDIOPREV,
+    [KEY_STOPCD]         = Q_KEY_CODE_AUDIOSTOP,
+    [KEY_PLAYCD]         = Q_KEY_CODE_AUDIOPLAY,
+    [KEY_MUTE]           = Q_KEY_CODE_AUDIOMUTE,
+    [KEY_VOLUMEDOWN]     = Q_KEY_CODE_VOLUMEDOWN,
+    [KEY_VOLUMEUP]       = Q_KEY_CODE_VOLUMEUP,
 };
 
 static const int qcode_to_number[] = {
@@ -252,6 +274,28 @@ static const int qcode_to_number[] = {
     [Q_KEY_CODE_YEN] = 0x7d,
     [Q_KEY_CODE_KP_COMMA] = 0x7e,
 
+    [Q_KEY_CODE_SLEEP] = 0xdf,
+    [Q_KEY_CODE_WAKE] = 0xe3,
+    [Q_KEY_CODE_CALCULATOR] = 0xa1,
+    [Q_KEY_CODE_MAIL] = 0xec,
+    [Q_KEY_CODE_COMPUTER] = 0xeb,
+
+    [Q_KEY_CODE_AC_STOP] = 0xe8,
+    [Q_KEY_CODE_AC_BOOKMARKS] = 0xe6,
+    [Q_KEY_CODE_AC_BACK] = 0xea,
+    [Q_KEY_CODE_AC_FORWARD] = 0xe9,
+    [Q_KEY_CODE_AC_HOME] = 0xb2,
+    [Q_KEY_CODE_AC_REFRESH] = 0xe7,
+    [Q_KEY_CODE_AC_SEARCH] = 0xe5,
+
+    [Q_KEY_CODE_AUDIONEXT] = 0x99,
+    [Q_KEY_CODE_AUDIOPREV] = 0x90,
+    [Q_KEY_CODE_AUDIOSTOP] = 0xa4,
+    [Q_KEY_CODE_AUDIOPLAY] = 0xa2,
+    [Q_KEY_CODE_AUDIOMUTE] = 0xa0,
+    [Q_KEY_CODE_VOLUMEDOWN] = 0xae,
+    [Q_KEY_CODE_VOLUMEUP] = 0xb0,
+
     [Q_KEY_CODE__MAX] = 0,
 };
 
diff --git a/qapi-schema.json b/qapi-schema.json
index 9c6c3e1a53..9cb15092a7 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4843,6 +4843,27 @@
 # @henkan: since 2.9
 # @yen: since 2.9
 #
+# @sleep: since 2.10
+# @wake: since 2.10
+# @audionext: since 2.10
+# @audioprev: since 2.10
+# @audiostop: since 2.10
+# @audioplay: since 2.10
+# @audiomute: since 2.10
+# @volumeup: since 2.10
+# @volumedown: since 2.10
+# @mediaselect: since 2.10
+# @mail: since 2.10
+# @calculator: since 2.10
+# @computer: since 2.10
+# @ac_search: since 2.10
+# @ac_home: since 2.10
+# @ac_back: since 2.10
+# @ac_forward: since 2.10
+# @ac_stop: since 2.10
+# @ac_refresh: since 2.10
+# @ac_bookmarks: since 2.10
+#
 # Since: 1.3.0
 #
 ##
@@ -4864,7 +4885,12 @@
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
             'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
             'ro', 'hiragana', 'henkan', 'yen',
-            'kp_comma', 'kp_equals', 'power' ] }
+            'kp_comma', 'kp_equals', 'power', 'sleep', 'wake',
+            'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
+            'volumeup', 'volumedown', 'mediaselect',
+            'mail', 'calculator', 'computer',
+            'ac_search', 'ac_home', 'ac_back', 'ac_forward', 'ac_stop',
+            'ac_refresh', 'ac_bookmarks' ] }
 
 ##
 # @KeyValue:
-- 
2.9.3
