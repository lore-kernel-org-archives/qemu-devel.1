Received: from eggs.gnu.org ([2001:4830:134:3::10]:57537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNbbA-0007H8-8j
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNbb6-0000h5-IA
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNbaz-0000W0-AW
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:29 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Nov 2018 11:43:17 +0100
Message-Id: <20181116104319.10329-3-kraxel@redhat.com>
In-Reply-To: <20181116104319.10329-1-kraxel@redhat.com>
References: <20181116104319.10329-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] keymaps: drop nl-be map
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

It doesn't define any keys, only includes "common".
Which makes it effectively an "en-us" map.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile              | 2 +-
 pc-bios/keymaps/nl-be | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)
 delete mode 100644 pc-bios/keymaps/nl-be

diff --git a/Makefile b/Makefile
index 7899f9d621..d3355ec2c7 100644
--- a/Makefile
+++ b/Makefile
@@ -796,7 +796,7 @@ distclean: clean
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
 ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
-common  de-ch  es     fo  fr-ca  hu     ja  mk  nl-be      pt  sl     tr \
+common  de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
 bepo    cz
 
 ifdef INSTALL_BLOBS
diff --git a/pc-bios/keymaps/nl-be b/pc-bios/keymaps/nl-be
deleted file mode 100644
index 34fc881ad0..0000000000
--- a/pc-bios/keymaps/nl-be
+++ /dev/null
@@ -1,3 +0,0 @@
-# Dutch (Belgium)
-map 0x813
-include common
-- 
2.9.3
