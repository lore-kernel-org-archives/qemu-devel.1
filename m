Received: from eggs.gnu.org ([2001:4830:134:3::10]:45198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcrx-0002AR-HB
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcrw-0005F9-Hb
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:55:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:55:37 +0200
Message-Id: <20180507095539.19584-3-kraxel@redhat.com>
In-Reply-To: <20180507095539.19584-1-kraxel@redhat.com>
References: <20180507095539.19584-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] ui: switch trivial displays to qapi
 parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Drop the option-less display types (egl-headless, curses, none) from
parse_display(), so they'll be handled by parse_display_qapi().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/vl.c b/vl.c
index d53ea078bd..1bd6758f3a 100644
--- a/vl.c
+++ b/vl.c
@@ -2185,10 +2185,6 @@ static void parse_display(const char *p)
             error_report("VNC requires a display argument vnc=<display>");
             exit(1);
         }
-    } else if (strstart(p, "egl-headless", &opts)) {
-        dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
-    } else if (strstart(p, "curses", &opts)) {
-        dpy.type = DISPLAY_TYPE_CURSES;
     } else if (strstart(p, "gtk", &opts)) {
         dpy.type = DISPLAY_TYPE_GTK;
         while (*opts) {
@@ -2221,8 +2217,6 @@ static void parse_display(const char *p)
             }
             opts = nextopt;
         }
-    } else if (strstart(p, "none", &opts)) {
-        dpy.type = DISPLAY_TYPE_NONE;
     } else {
         parse_display_qapi(p);
     }
-- 
2.9.3
