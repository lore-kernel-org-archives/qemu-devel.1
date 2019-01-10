Received: from eggs.gnu.org ([209.51.188.92]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW3N-0008SN-9g
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW0O-000607-SS
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghW0O-0005zn-NP
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0F739B32A
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:47:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 10 Jan 2019 09:47:48 +0100
Message-Id: <20190110084752.30510-5-kraxel@redhat.com>
In-Reply-To: <20190110084752.30510-1-kraxel@redhat.com>
References: <20190110084752.30510-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] keymaps: remove modifiers include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

"common" is the only file using it, so we can just include it directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20181116104319.10329-2-kraxel@redhat.com
---
 Makefile                  |  2 +-
 pc-bios/keymaps/common    | 19 ++++++++++++++++++-
 pc-bios/keymaps/modifiers | 18 ------------------
 3 files changed, 19 insertions(+), 20 deletions(-)
 delete mode 100644 pc-bios/keymaps/modifiers

diff --git a/Makefile b/Makefile
index dd53965f77..16cbee2c5f 100644
--- a/Makefile
+++ b/Makefile
@@ -651,7 +651,7 @@ distclean: clean
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
