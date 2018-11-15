Received: from eggs.gnu.org ([2001:4830:134:3::10]:56225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNGov-0004p7-IQ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNGor-000616-Ij
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNGop-0005zt-II
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:25 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Nov 2018 13:32:15 +0100
Message-Id: <20181115123218.25387-2-kraxel@redhat.com>
In-Reply-To: <20181115123218.25387-1-kraxel@redhat.com>
References: <20181115123218.25387-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] keymaps: remove modifiers include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liq3ea@gmail.com>

"common" is the only file using it, so we can just include it directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/keymaps/common    | 19 ++++++++++++++++++-
 pc-bios/keymaps/modifiers | 18 ------------------
 2 files changed, 18 insertions(+), 19 deletions(-)
 delete mode 100644 pc-bios/keymaps/modifiers

diff --git a/pc-bios/keymaps/common b/pc-bios/keymaps/common
index adc56c77d2..aa844c82ed 100644
--- a/pc-bios/keymaps/common
+++ b/pc-bios/keymaps/common
@@ -1,4 +1,21 @@
-include modifiers
+Shift_R 0x36
+Shift_L 0x2a
+
+Alt_R 0xb8
+Mode_switch 0xb8
+ISO_Level3_Shift 0xb8
+Alt_L 0x38
+
+Control_R 0x9d
+Control_L 0x1d
+
+# Translate Super to Windows keys.
+# This is hardcoded. See documentation for details.
+Super_R 0xdc
+Super_L 0xdb
+
+# Translate Menu to the Windows Application key.
+Menu 0xdd
 
 #
 # Top row
diff --git a/pc-bios/keymaps/modifiers b/pc-bios/keymaps/modifiers
deleted file mode 100644
index d73b7a6637..0000000000
--- a/pc-bios/keymaps/modifiers
+++ /dev/null
@@ -1,18 +0,0 @@
-Shift_R 0x36
-Shift_L 0x2a
-
-Alt_R 0xb8
-Mode_switch 0xb8
-ISO_Level3_Shift 0xb8
-Alt_L 0x38
-
-Control_R 0x9d
-Control_L 0x1d
-
-# Translate Super to Windows keys.
-# This is hardcoded. See documentation for details.
-Super_R 0xdc
-Super_L 0xdb
-
-# Translate Menu to the Windows Application key.
-Menu 0xdd
-- 
2.9.3
