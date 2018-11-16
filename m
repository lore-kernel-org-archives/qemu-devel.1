Received: from eggs.gnu.org ([2001:4830:134:3::10]:57519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNbb8-0007H4-PD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNbb2-0000db-U1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNbaz-0000Vj-2z
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:29 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Nov 2018 11:43:16 +0100
Message-Id: <20181116104319.10329-2-kraxel@redhat.com>
In-Reply-To: <20181116104319.10329-1-kraxel@redhat.com>
References: <20181116104319.10329-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] keymaps: remove modifiers include
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

"common" is the only file using it, so we can just include it directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile                  |  2 +-
 pc-bios/keymaps/common    | 19 ++++++++++++++++++-
 pc-bios/keymaps/modifiers | 18 ------------------
 3 files changed, 19 insertions(+), 20 deletions(-)
 delete mode 100644 pc-bios/keymaps/modifiers

diff --git a/Makefile b/Makefile
index f2947186a4..7899f9d621 100644
--- a/Makefile
+++ b/Makefile
@@ -794,7 +794,7 @@ distclean: clean
 	rm -Rf .sdk
 	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
-KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  modifiers  no  pt-br  sv \
+KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
 ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
 common  de-ch  es     fo  fr-ca  hu     ja  mk  nl-be      pt  sl     tr \
 bepo    cz
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
