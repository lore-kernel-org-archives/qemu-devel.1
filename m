Received: from eggs.gnu.org ([2001:4830:134:3::10]:40042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daOFa-0008Ei-7k
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daOFX-0003Hd-2P
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daOFW-0003Gk-TS
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:29:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB1BEC0B7892
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 15:29:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 17:29:14 +0200
Message-Id: <20170726152918.11995-2-kraxel@redhat.com>
In-Reply-To: <20170726152918.11995-1-kraxel@redhat.com>
References: <20170726152918.11995-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] ui: add next and prior keysyms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Page-up and Page-down were renamed.  Add the names to the keysym list
so we can parse both old and new names.  The keypad versions are already
present in the vnc map.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 ui/curses_keys.h | 2 ++
 ui/vnc_keysym.h  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/ui/curses_keys.h b/ui/curses_keys.h
index e39ef9e718..e9195a1671 100644
--- a/ui/curses_keys.h
+++ b/ui/curses_keys.h
@@ -480,7 +480,9 @@ static const name2keysym_t name2keysym[] = {
     { "Left", KEY_LEFT },
     { "Up", KEY_UP },
     { "Down", KEY_DOWN },
+    { "Next", KEY_NPAGE },
     { "Page_Down", KEY_NPAGE },
+    { "Prior", KEY_PPAGE },
     { "Page_Up", KEY_PPAGE },
     { "Insert", KEY_IC },
     { "Delete", KEY_DC },
diff --git a/ui/vnc_keysym.h b/ui/vnc_keysym.h
index 7fa2bc1f1c..e8a2ec73c5 100644
--- a/ui/vnc_keysym.h
+++ b/ui/vnc_keysym.h
@@ -254,7 +254,9 @@ static const name2keysym_t name2keysym[]={
 {"Left", 0xff51},      /* XK_Left */
 {"Up", 0xff52},        /* XK_Up */
 {"Down", 0xff54},      /* XK_Down */
+{"Next", 0xff56},
 {"Page_Down", 0xff56}, /* XK_Page_Down */
+{"Prior", 0xff55},
 {"Page_Up", 0xff55},   /* XK_Page_Up */
 {"Insert", 0xff63},    /* XK_Insert */
 {"Delete", 0xffff},    /* XK_Delete */
-- 
2.9.3
