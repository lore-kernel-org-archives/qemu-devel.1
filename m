Received: from eggs.gnu.org ([2001:4830:134:3::10]:48528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6u-0004Dx-91
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6r-0001UX-8R
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:08 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:18:59 +0200
Message-Id: <20180515091901.27774-9-kraxel@redhat.com>
In-Reply-To: <20180515091901.27774-1-kraxel@redhat.com>
References: <20180515091901.27774-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] ui: document non-qapi parser cases.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Add comments to the cases not (yet) switched
over to parse_display_qapi().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180507095539.19584-5-kraxel@redhat.com
---
 vl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/vl.c b/vl.c
index 5f1734d851..3b39bbd7a8 100644
--- a/vl.c
+++ b/vl.c
@@ -2114,6 +2114,16 @@ static void parse_display(const char *p)
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
@@ -2179,6 +2189,10 @@ static void parse_display(const char *p)
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
