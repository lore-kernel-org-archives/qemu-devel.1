Received: from eggs.gnu.org ([2001:4830:134:3::10]:57570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNbbE-0007IL-If
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNbbD-0000nG-Uq
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNbbC-0000Vv-BH
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:42 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Nov 2018 11:43:19 +0100
Message-Id: <20181116104319.10329-5-kraxel@redhat.com>
In-Reply-To: <20181116104319.10329-1-kraxel@redhat.com>
References: <20181116104319.10329-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] keymaps: drop support for include files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/keymaps.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 085889b555..6e44f738ed 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -115,10 +115,9 @@ static int parse_keyboard_layout(kbd_layout_t *k,
             continue;
         }
         if (!strncmp(line, "include ", 8)) {
-            if (parse_keyboard_layout(k, table, line + 8, errp) < 0) {
-                ret = -1;
-                goto out;
-            }
+            error_setg(errp, "keymap include files are not supported any more");
+            ret = -1;
+            goto out;
         } else {
             int offset = 0;
             while (line[offset] != 0 &&
-- 
2.9.3
