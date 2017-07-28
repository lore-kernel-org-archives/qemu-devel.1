Received: from eggs.gnu.org ([2001:4830:134:3::10]:35566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db4rw-0005mm-BN
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db4rm-0008Lb-CV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1db4rm-0008Kj-0L
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7C848E386
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 12:59:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 14:59:34 +0200
Message-Id: <20170728125935.18167-3-kraxel@redhat.com>
In-Reply-To: <20170728125935.18167-1-kraxel@redhat.com>
References: <20170728125935.18167-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] ui: drop ac_search and ac_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Both keys exist already: "ac_search" is "find" and "ac_stop" is "stop".

Fixes: 37810e80553c19f0dac3644924895a9bf5c70785
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170728063415.27480-1-kraxel@redhat.com
---
 hw/input/ps2.c    | 8 ++++----
 ui/input-keymap.c | 8 ++++----
 qapi-schema.json  | 5 +----
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 9f057e46ea..77906d5f46 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -239,11 +239,11 @@ static const uint16_t qcode_to_keycode_set1[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_MAIL] = 0xe06c,
     [Q_KEY_CODE_CALCULATOR] = 0xe021,
     [Q_KEY_CODE_COMPUTER] = 0xe06b,
-    [Q_KEY_CODE_AC_SEARCH] = 0xe065,
+    [Q_KEY_CODE_FIND] = 0xe065,
     [Q_KEY_CODE_AC_HOME] = 0xe032,
     [Q_KEY_CODE_AC_BACK] = 0xe06a,
     [Q_KEY_CODE_AC_FORWARD] = 0xe069,
-    [Q_KEY_CODE_AC_STOP] = 0xe068,
+    [Q_KEY_CODE_STOP] = 0xe068,
     [Q_KEY_CODE_AC_REFRESH] = 0xe067,
     [Q_KEY_CODE_AC_BOOKMARKS] = 0xe066,
 
@@ -379,11 +379,11 @@ static const uint16_t qcode_to_keycode_set2[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_MAIL] = 0xe048,
     [Q_KEY_CODE_CALCULATOR] = 0xe02b,
     [Q_KEY_CODE_COMPUTER] = 0xe040,
-    [Q_KEY_CODE_AC_SEARCH] = 0xe010,
+    [Q_KEY_CODE_FIND] = 0xe010,
     [Q_KEY_CODE_AC_HOME] = 0xe03a,
     [Q_KEY_CODE_AC_BACK] = 0xe038,
     [Q_KEY_CODE_AC_FORWARD] = 0xe030,
-    [Q_KEY_CODE_AC_STOP] = 0xe028,
+    [Q_KEY_CODE_STOP] = 0xe028,
     [Q_KEY_CODE_AC_REFRESH] = 0xe020,
     [Q_KEY_CODE_AC_BOOKMARKS] = 0xe018,
 
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 0d9ddde9c9..cdad5652d3 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -123,13 +123,13 @@ static int linux_to_qcode[KEY_CNT] = {
     [KEY_MAIL]           = Q_KEY_CODE_MAIL,
     [KEY_COMPUTER]       = Q_KEY_CODE_COMPUTER,
 
-    [KEY_STOP]           = Q_KEY_CODE_AC_STOP,
+    [KEY_STOP]           = Q_KEY_CODE_STOP,
     [KEY_BOOKMARKS]      = Q_KEY_CODE_AC_BOOKMARKS,
     [KEY_BACK]           = Q_KEY_CODE_AC_BACK,
     [KEY_FORWARD]        = Q_KEY_CODE_AC_FORWARD,
     [KEY_HOMEPAGE]       = Q_KEY_CODE_AC_HOME,
     [KEY_REFRESH]        = Q_KEY_CODE_AC_REFRESH,
-    [KEY_FIND]           = Q_KEY_CODE_AC_SEARCH,
+    [KEY_FIND]           = Q_KEY_CODE_FIND,
 
     [KEY_NEXTSONG]       = Q_KEY_CODE_AUDIONEXT,
     [KEY_PREVIOUSSONG]   = Q_KEY_CODE_AUDIOPREV,
@@ -279,13 +279,13 @@ static const int qcode_to_number[] = {
     [Q_KEY_CODE_MAIL] = 0xec,
     [Q_KEY_CODE_COMPUTER] = 0xeb,
 
-    [Q_KEY_CODE_AC_STOP] = 0xe8,
+    [Q_KEY_CODE_STOP] = 0xe8,
     [Q_KEY_CODE_AC_BOOKMARKS] = 0xe6,
     [Q_KEY_CODE_AC_BACK] = 0xea,
     [Q_KEY_CODE_AC_FORWARD] = 0xe9,
     [Q_KEY_CODE_AC_HOME] = 0xb2,
     [Q_KEY_CODE_AC_REFRESH] = 0xe7,
-    [Q_KEY_CODE_AC_SEARCH] = 0xe5,
+    [Q_KEY_CODE_FIND] = 0xe5,
 
     [Q_KEY_CODE_AUDIONEXT] = 0x99,
     [Q_KEY_CODE_AUDIOPREV] = 0x90,
diff --git a/qapi-schema.json b/qapi-schema.json
index dcc12c83a9..c96f0a26f6 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4856,11 +4856,9 @@
 # @mail: since 2.10
 # @calculator: since 2.10
 # @computer: since 2.10
-# @ac_search: since 2.10
 # @ac_home: since 2.10
 # @ac_back: since 2.10
 # @ac_forward: since 2.10
-# @ac_stop: since 2.10
 # @ac_refresh: since 2.10
 # @ac_bookmarks: since 2.10
 # altgr, altgr_r: dropped in 2.10
@@ -4890,8 +4888,7 @@
             'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
             'volumeup', 'volumedown', 'mediaselect',
             'mail', 'calculator', 'computer',
-            'ac_search', 'ac_home', 'ac_back', 'ac_forward', 'ac_stop',
-            'ac_refresh', 'ac_bookmarks' ] }
+            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', 'ac_bookmarks' ] }
 
 ##
 # @KeyValue:
-- 
2.9.3
