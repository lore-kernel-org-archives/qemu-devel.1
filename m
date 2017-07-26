Received: from eggs.gnu.org ([2001:4830:134:3::10]:57403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daKvk-0003rl-GF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daKvj-00044e-2g
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:56:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daKvi-00043y-T4
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF45E2F86D0
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:56:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 13:56:37 +0200
Message-Id: <20170726115637.21558-6-kraxel@redhat.com>
In-Reply-To: <20170726115637.21558-1-kraxel@redhat.com>
References: <20170726115637.21558-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] ps2: enable multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Fixes: 8c10e0baf0260b59a4e984744462a18016662e3e
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 3ba05efd06..25ae7fc852 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -224,7 +224,6 @@ static const uint16_t qcode_to_keycode_set1[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_DOT] = 0x34,
     [Q_KEY_CODE_SLASH] = 0x35,
 
-#if 0
     [Q_KEY_CODE_POWER] = 0x0e5e,
     [Q_KEY_CODE_SLEEP] = 0x0e5f,
     [Q_KEY_CODE_WAKE] = 0x0e63,
@@ -247,7 +246,6 @@ static const uint16_t qcode_to_keycode_set1[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_AC_STOP] = 0xe068,
     [Q_KEY_CODE_AC_REFRESH] = 0xe067,
     [Q_KEY_CODE_AC_BOOKMARKS] = 0xe066,
-#endif
 
     [Q_KEY_CODE_ASTERISK] = 0x37,
     [Q_KEY_CODE_LESS] = 0x56,
@@ -366,7 +364,6 @@ static const uint16_t qcode_to_keycode_set2[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_DOT] = 0x49,
     [Q_KEY_CODE_SLASH] = 0x4a,
 
-#if 0
     [Q_KEY_CODE_POWER] = 0x0e37,
     [Q_KEY_CODE_SLEEP] = 0x0e3f,
     [Q_KEY_CODE_WAKE] = 0x0e5e,
@@ -389,7 +386,6 @@ static const uint16_t qcode_to_keycode_set2[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_AC_STOP] = 0xe028,
     [Q_KEY_CODE_AC_REFRESH] = 0xe020,
     [Q_KEY_CODE_AC_BOOKMARKS] = 0xe018,
-#endif
 
     [Q_KEY_CODE_ALTGR] = 0x08,
     [Q_KEY_CODE_ALTGR_R] = 0xe008,
-- 
2.9.3
