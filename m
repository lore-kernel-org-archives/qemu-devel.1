Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLJ-0003JH-Vb
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLC-0001qc-4W
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dajLB-0001pX-TW
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65785C109AAF
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 14:00:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Jul 2017 16:00:21 +0200
Message-Id: <20170727140025.392-4-kraxel@redhat.com>
In-Reply-To: <20170727140025.392-1-kraxel@redhat.com>
References: <20170727140025.392-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] ui: update keymaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Add recently added QKeyCodes to the keymaps.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170726152918.11995-4-kraxel@redhat.com
---
 ui/input-keymap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index d4972bb364..7461e1edde 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -94,6 +94,9 @@ static int linux_to_qcode[KEY_CNT] = {
     [KEY_KPASTERISK]     = Q_KEY_CODE_KP_MULTIPLY,
     [KEY_F11]            = Q_KEY_CODE_F11,
     [KEY_F12]            = Q_KEY_CODE_F12,
+    [KEY_RO]             = Q_KEY_CODE_RO,
+    [KEY_HIRAGANA]       = Q_KEY_CODE_HIRAGANA,
+    [KEY_HENKAN]         = Q_KEY_CODE_HENKAN,
     [KEY_RIGHTCTRL]      = Q_KEY_CODE_CTRL_R,
     [KEY_SYSRQ]          = Q_KEY_CODE_SYSRQ,
     [KEY_RIGHTALT]       = Q_KEY_CODE_ALT_R,
@@ -107,6 +110,9 @@ static int linux_to_qcode[KEY_CNT] = {
     [KEY_PAGEDOWN]       = Q_KEY_CODE_PGDN,
     [KEY_INSERT]         = Q_KEY_CODE_INSERT,
     [KEY_DELETE]         = Q_KEY_CODE_DELETE,
+    [KEY_POWER]          = Q_KEY_CODE_POWER,
+    [KEY_KPCOMMA]        = Q_KEY_CODE_KP_COMMA,
+    [KEY_YEN]            = Q_KEY_CODE_YEN,
     [KEY_LEFTMETA]       = Q_KEY_CODE_META_L,
     [KEY_RIGHTMETA]      = Q_KEY_CODE_META_R,
     [KEY_MENU]           = Q_KEY_CODE_MENU,
@@ -242,6 +248,7 @@ static const int qcode_to_number[] = {
     [Q_KEY_CODE_RO] = 0x73,
     [Q_KEY_CODE_HIRAGANA] = 0x70,
     [Q_KEY_CODE_HENKAN] = 0x79,
+    [Q_KEY_CODE_POWER] = 0xde,
     [Q_KEY_CODE_YEN] = 0x7d,
     [Q_KEY_CODE_KP_COMMA] = 0x7e,
 
-- 
2.9.3
