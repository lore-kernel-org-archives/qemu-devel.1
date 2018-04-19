Received: from eggs.gnu.org ([2001:4830:134:3::10]:46745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99UW-0004hd-SZ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99UQ-0006LC-U1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:20:48 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Apr 2018 15:20:26 +0200
Message-Id: <20180419132026.5494-5-kraxel@redhat.com>
In-Reply-To: <20180419132026.5494-1-kraxel@redhat.com>
References: <20180419132026.5494-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] ui: document non-qapi parser cases.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add comments to the cases not (yet) switched
over to parse_display_qapi().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/vl.c b/vl.c
index 1123cd792e..d35c443b8c 100644
--- a/vl.c
+++ b/vl.c
@@ -2121,6 +2121,16 @@ static void parse_display(const char *p)
     const char *opts;
 
     if (strstart(p, "sdl", &opts)) {
+        /*
+         * sdl DisplayType needs hand-crafted parser instead of
+         * parse_display_qapi() due to some options not in
+         * DisplayOptions, specifically:
+         *   - frame
+         *     Already deprecated.
+         *   - ctrl_grab + alt_grab
+         *     Not clear yet what happens to them long-term.  Should
+         *     replaced by something better or deprecated and dropped.
+         */
         dpy.type = DISPLAY_TYPE_SDL;
         while (*opts) {
             const char *nextopt;
@@ -2182,6 +2192,10 @@ static void parse_display(const char *p)
             opts = nextopt;
         }
     } else if (strstart(p, "vnc", &opts)) {
+        /*
+         * vnc isn't a (local) DisplayType but a protocol for remote
+         * display access.
+         */
         if (*opts == '=') {
             vnc_parse(opts + 1, &error_fatal);
         } else {
-- 
2.9.3
