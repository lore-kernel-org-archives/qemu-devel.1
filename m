Received: from eggs.gnu.org ([2001:4830:134:3::10]:45749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCEA-0007xH-If
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCE7-0002Md-Ui
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCE7-0002LZ-Oy
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D40BFC059726
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 16:24:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:23:59 +0100
Message-Id: <20180129162408.415-4-kraxel@redhat.com>
In-Reply-To: <20180129162408.415-1-kraxel@redhat.com>
References: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/12] vl: rename DisplayType to
 LegacyDisplayType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

qapi DisplayType will replace the current enum.  For the transition both
will coexist though, so rename it so we don't have a name clash.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index fa19a61500..a2478412c7 100644
--- a/vl.c
+++ b/vl.c
@@ -2082,7 +2082,7 @@ static void select_vgahw(const char *p)
     }
 }
 
-typedef enum DisplayType {
+typedef enum LegacyDisplayType {
     DT_DEFAULT,
     DT_CURSES,
     DT_SDL,
@@ -2090,12 +2090,12 @@ typedef enum DisplayType {
     DT_GTK,
     DT_EGL,
     DT_NONE,
-} DisplayType;
+} LegacyDisplayType;
 
-static DisplayType select_display(const char *p)
+static LegacyDisplayType select_display(const char *p)
 {
     const char *opts;
-    DisplayType display = DT_DEFAULT;
+    LegacyDisplayType display = DT_DEFAULT;
 
     if (strstart(p, "sdl", &opts)) {
 #ifdef CONFIG_SDL
@@ -3058,7 +3058,7 @@ int main(int argc, char **argv, char **envp)
     const char *incoming = NULL;
     bool userconfig = true;
     bool nographic = false;
-    DisplayType display_type = DT_DEFAULT;
+    LegacyDisplayType display_type = DT_DEFAULT;
     int display_remote = 0;
     const char *log_mask = NULL;
     const char *log_file = NULL;
-- 
2.9.3
