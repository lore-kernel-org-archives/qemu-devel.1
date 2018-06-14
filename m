Received: from eggs.gnu.org ([2001:4830:134:3::10]:39419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTNgq-00078H-38
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTNgk-0000o1-Cr
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:33:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fTNgk-0000ns-7s
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:33:02 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Jun 2018 10:32:57 +0200
Message-Id: <20180614083258.14618-2-kraxel@redhat.com>
In-Reply-To: <20180614083258.14618-1-kraxel@redhat.com>
References: <20180614083258.14618-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] ui: darwin: gtk: Add missing input keymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Keno Fischer <keno@juliacomputing.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Keno Fischer <keno@juliacomputing.com>

In appears the input keymap for osx was forgotten in the commit that
converted the gtk frontend to keycodemapdb. Add it.

Fixes: 2ec78706 ("ui: convert GTK and SDL1 frontends to keycodemapdb")
CC: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Message-id: 1528933916-40670-1-git-send-email-keno@juliacomputing.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile           | 1 +
 include/ui/input.h | 3 +++
 ui/input-keymap.c  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 6c6664d9a3..bdae3133fb 100644
--- a/Makefile
+++ b/Makefile
@@ -322,6 +322,7 @@ KEYCODEMAP_FILES = \
 		 ui/input-keymap-xorgkbd-to-qcode.c \
 		 ui/input-keymap-xorgxquartz-to-qcode.c \
 		 ui/input-keymap-xorgxwin-to-qcode.c \
+		 ui/input-keymap-osx-to-qcode.c \
 		 $(NULL)
 
 GENERATED_FILES += $(KEYCODEMAP_FILES)
diff --git a/include/ui/input.h b/include/ui/input.h
index 16395ab8f2..34ebc67c5a 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -116,4 +116,7 @@ extern const guint16 qemu_input_map_xorgxquartz_to_qcode[];
 extern const guint qemu_input_map_xorgxwin_to_qcode_len;
 extern const guint16 qemu_input_map_xorgxwin_to_qcode[];
 
+extern const guint qemu_input_map_osx_to_qcode_len;
+extern const guint16 qemu_input_map_osx_to_qcode[];
+
 #endif /* INPUT_H */
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 87cc301b7a..db5ccff5ad 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -21,6 +21,7 @@
 #include "ui/input-keymap-xorgkbd-to-qcode.c"
 #include "ui/input-keymap-xorgxquartz-to-qcode.c"
 #include "ui/input-keymap-xorgxwin-to-qcode.c"
+#include "ui/input-keymap-osx-to-qcode.c"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
-- 
2.9.3
