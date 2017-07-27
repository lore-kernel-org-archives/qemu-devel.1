Received: from eggs.gnu.org ([2001:4830:134:3::10]:33750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLT-0003RN-B7
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLJ-0001vo-Vw
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dajLI-0001ul-VD
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B29031B9835
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 14:00:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Jul 2017 16:00:24 +0200
Message-Id: <20170727140025.392-7-kraxel@redhat.com>
In-Reply-To: <20170727140025.392-1-kraxel@redhat.com>
References: <20170727140025.392-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] ui: drop altgr and altgr_r QKeyCodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

The right alt key (alt_r aka KEY_RIGHTALT) is used for AltGr.
The altgr and altgr_r keys simply don't exist.  Drop them.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170727104720.30061-1-kraxel@redhat.com
---
 hw/char/escc.c    | 1 -
 hw/input/adb.c    | 1 -
 hw/input/ps2.c    | 2 --
 ui/input-keymap.c | 2 --
 qapi-schema.json  | 3 ++-
 5 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 89ae9eb997..1aca564e33 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -722,7 +722,6 @@ static const uint8_t qcode_to_keycode[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_SHIFT_R]       = 110,
     [Q_KEY_CODE_ALT]           = 19,
     [Q_KEY_CODE_ALT_R]         = 13,
-    [Q_KEY_CODE_ALTGR]         = 13,
     [Q_KEY_CODE_CTRL]          = 76,
     [Q_KEY_CODE_CTRL_R]        = 76,
     [Q_KEY_CODE_ESC]           = 29,
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 43d3205472..fcca3a8eb9 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -201,7 +201,6 @@ int qcode_to_adb_keycode[] = {
     [Q_KEY_CODE_SHIFT_R]       = ADB_KEY_RIGHT_SHIFT,
     [Q_KEY_CODE_ALT]           = ADB_KEY_LEFT_OPTION,
     [Q_KEY_CODE_ALT_R]         = ADB_KEY_RIGHT_OPTION,
-    [Q_KEY_CODE_ALTGR]         = ADB_KEY_RIGHT_OPTION,
     [Q_KEY_CODE_CTRL]          = ADB_KEY_LEFT_CONTROL,
     [Q_KEY_CODE_CTRL_R]        = ADB_KEY_RIGHT_CONTROL,
     [Q_KEY_CODE_META_L]        = ADB_KEY_COMMAND,
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 25ae7fc852..9f057e46ea 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -387,8 +387,6 @@ static const uint16_t qcode_to_keycode_set2[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_AC_REFRESH] = 0xe020,
     [Q_KEY_CODE_AC_BOOKMARKS] = 0xe018,
 
-    [Q_KEY_CODE_ALTGR] = 0x08,
-    [Q_KEY_CODE_ALTGR_R] = 0xe008,
     [Q_KEY_CODE_ASTERISK] = 0x7c,
     [Q_KEY_CODE_LESS] = 0x61,
     [Q_KEY_CODE_SYSRQ] = 0x7f,
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index ae781beae9..f96adf4165 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -146,8 +146,6 @@ static const int qcode_to_number[] = {
 
     [Q_KEY_CODE_ALT] = 0x38,
     [Q_KEY_CODE_ALT_R] = 0xb8,
-    [Q_KEY_CODE_ALTGR] = 0x64,
-    [Q_KEY_CODE_ALTGR_R] = 0xe4,
     [Q_KEY_CODE_CTRL] = 0x1d,
     [Q_KEY_CODE_CTRL_R] = 0x9d,
 
diff --git a/qapi-schema.json b/qapi-schema.json
index 9cb15092a7..dcc12c83a9 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4863,13 +4863,14 @@
 # @ac_stop: since 2.10
 # @ac_refresh: since 2.10
 # @ac_bookmarks: since 2.10
+# altgr, altgr_r: dropped in 2.10
 #
 # Since: 1.3.0
 #
 ##
 { 'enum': 'QKeyCode',
   'data': [ 'unmapped',
-            'shift', 'shift_r', 'alt', 'alt_r', 'altgr', 'altgr_r', 'ctrl',
+            'shift', 'shift_r', 'alt', 'alt_r', 'ctrl',
             'ctrl_r', 'menu', 'esc', '1', '2', '3', '4', '5', '6', '7', '8',
             '9', '0', 'minus', 'equal', 'backspace', 'tab', 'q', 'w', 'e',
             'r', 't', 'y', 'u', 'i', 'o', 'p', 'bracket_left', 'bracket_right',
-- 
2.9.3
