Received: from eggs.gnu.org ([2001:4830:134:3::10]:32865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fTFYn-0008Fp-Rh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 19:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fTFYk-0001kx-Mh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 19:52:17 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fTFYk-0001gy-FG
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 19:52:14 -0400
Received: by mail-qt0-x244.google.com with SMTP id h5-v6so4154877qtm.13
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 16:52:14 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Wed, 13 Jun 2018 19:51:56 -0400
Message-Id: <1528933916-40670-1-git-send-email-keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH] ui: darwin: gtk: Add missing input keymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, "Daniel P . Berrange" <berrange@redhat.com>

In appears the input keymap for osx was forgotten in the commit that
converted the gtk frontend to keycodemapdb. Add it.

Fixes: 2ec78706 ("ui: convert GTK and SDL1 frontends to keycodemapdb")
CC: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 Makefile           | 1 +
 include/ui/input.h | 3 +++
 ui/input-keymap.c  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 6a5fff0..1e79914 100644
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
index 16395ab..34ebc67 100644
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
index 87cc301..db5ccff 100644
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
2.8.1
