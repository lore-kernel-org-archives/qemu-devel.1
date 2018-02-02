Received: from eggs.gnu.org ([2001:4830:134:3::10]:42555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehccd-0003nM-PK
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehccd-0004x5-2J
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehccc-0004vw-RZ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1951BDC1
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 11:10:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 12:10:16 +0100
Message-Id: <20180202111022.19269-7-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-1-kraxel@redhat.com>
References: <20180202111022.19269-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/12] vl: drop no_quit variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Not used any more, delete it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 25e784be63..c17dedfa4e 100644
--- a/vl.c
+++ b/vl.c
@@ -152,7 +152,6 @@ int vga_interface_type = VGA_NONE;
 static int full_screen = 0;
 static DisplayOptions dpy;
 int no_frame;
-int no_quit = 0;
 Chardev *serial_hds[MAX_SERIAL_PORTS];
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
@@ -2141,10 +2140,8 @@ static LegacyDisplayType select_display(const char *p)
                 opts = nextopt;
                 dpy.has_window_close = true;
                 if (strstart(opts, "on", &nextopt)) {
-                    no_quit = 0;
                     dpy.window_close = true;
                 } else if (strstart(opts, "off", &nextopt)) {
-                    no_quit = 1;
                     dpy.window_close = false;
                 } else {
                     goto invalid_sdl_args;
@@ -3679,7 +3676,6 @@ int main(int argc, char **argv, char **envp)
                 ctrl_grab = 1;
                 break;
             case QEMU_OPTION_no_quit:
-                no_quit = 1;
                 dpy.has_window_close = true;
                 dpy.window_close = false;
                 break;
@@ -4368,7 +4364,8 @@ int main(int argc, char **argv, char **envp)
         error_report("-no-frame, -alt-grab and -ctrl-grab are only valid "
                      "for SDL, ignoring option");
     }
-    if (no_quit && (display_type != DT_GTK && display_type != DT_SDL)) {
+    if (dpy.has_window_close &&
+        (display_type != DT_GTK && display_type != DT_SDL)) {
         error_report("-no-quit is only valid for GTK and SDL, "
                      "ignoring option");
     }
-- 
2.9.3
