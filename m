Received: from eggs.gnu.org ([2001:4830:134:3::10]:34643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaX-0005sI-Vo
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaT-0003Vh-BQ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:42 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:52427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaT-0003St-6D
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:37 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Fri, 3 Nov 2017 11:56:28 +0000
Message-ID: <20171103115631.15175-2-owen.smith@citrix.com>
In-Reply-To: <20171103115631.15175-1-owen.smith@citrix.com>
References: <20171103115631.15175-1-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 1/4] ui: generate qcode to linux mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, owen.smith@citrix.com

Use keycodedb to generate a qcode to linux mapping

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 Makefile           | 1 +
 include/ui/input.h | 3 +++
 ui/input-keymap.c  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index ec73acfa9a..42a9030734 100644
--- a/Makefile
+++ b/Makefile
@@ -220,6 +220,7 @@ KEYCODEMAP_FILES = \
 		 ui/input-keymap-linux-to-qcode.c \
 		 ui/input-keymap-qcode-to-qnum.c \
 		 ui/input-keymap-qnum-to-qcode.c \
+		 ui/input-keymap-qcode-to-linux.c \
 		 $(NULL)
 
 GENERATED_FILES += $(KEYCODEMAP_FILES)
diff --git a/include/ui/input.h b/include/ui/input.h
index f8cee43f65..5cc76d6e41 100644
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
index 3a19a169f5..663986a17b 100644
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
2.11.0
