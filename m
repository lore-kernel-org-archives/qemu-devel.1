Received: from eggs.gnu.org ([2001:4830:134:3::10]:47846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gj-0005H8-FC
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gi-00072O-JD
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Gi-00071n-Ec
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A451240FB646
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:47:28 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:13 +0100
Message-Id: <20180220134723.11776-3-kraxel@redhat.com>
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] vl: rename DisplayType to
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180202111022.19269-4-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index c1f763f3e1..746e2c169c 100644
--- a/vl.c
+++ b/vl.c
@@ -2083,7 +2083,7 @@ static void select_vgahw(const char *p)
     }
 }
 
-typedef enum DisplayType {
+typedef enum LegacyDisplayType {
     DT_DEFAULT,
     DT_CURSES,
     DT_SDL,
@@ -2091,12 +2091,12 @@ typedef enum DisplayType {
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
@@ -3051,7 +3051,7 @@ int main(int argc, char **argv, char **envp)
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
