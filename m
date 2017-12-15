Received: from eggs.gnu.org ([2001:4830:134:3::10]:42839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdrG-0002qA-Ge
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdrC-00063X-Mr
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ePdrC-00062o-HN
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:28:06 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu, 14 Dec 2017 16:27:59 -0800
Message-Id: <1513297683-14295-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1513297683-14295-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1712141612170.3857@sstabellini-ThinkPad-X260>
	<1513297683-14295-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 2/6] ui: generate qcode to linux mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Owen Smith <owen.smith@citrix.com>

From: Owen Smith <owen.smith@citrix.com>

Use keycodedb to generate a qcode to linux mapping

Signed-off-by: Owen Smith <owen.smith@citrix.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 Makefile           | 1 +
 include/ui/input.h | 3 +++
 ui/input-keymap.c  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index ab0354c..0331c18 100644
--- a/Makefile
+++ b/Makefile
@@ -229,6 +229,7 @@ KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux-to-qcode.c \
 		 ui/input-keymap-qcode-to-qnum.c \
 		 ui/input-keymap-qnum-to-qcode.c \
+		 ui/input-keymap-qcode-to-linux.c \
 		 $(NULL)
 
 GENERATED_FILES += $(KEYCODEMAP_FILES)
diff --git a/include/ui/input.h b/include/ui/input.h
index f8cee43..5cc76d6 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -77,4 +77,7 @@ extern const guint16 qemu_input_map_qcode_to_qnum[];
 extern const guint qemu_input_map_qnum_to_qcode_len;
 extern const guint16 qemu_input_map_qnum_to_qcode[];
 
+extern const guint qemu_input_map_qcode_to_linux_len;
+extern const guint16 qemu_input_map_qcode_to_linux[];
+
 #endif /* INPUT_H */
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 3a19a16..663986a 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -8,6 +8,7 @@
 #include "ui/input-keymap-linux-to-qcode.c"
 #include "ui/input-keymap-qcode-to-qnum.c"
 #include "ui/input-keymap-qnum-to-qcode.c"
+#include "ui/input-keymap-qcode-to-linux.c"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
-- 
1.9.1
