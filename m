Received: from eggs.gnu.org ([209.51.188.92]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW3E-0008SN-V2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW0Z-00065R-QX
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghW0Z-00064Z-Hb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC0607FD63
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:48:09 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 10 Jan 2019 09:47:49 +0100
Message-Id: <20190110084752.30510-6-kraxel@redhat.com>
In-Reply-To: <20190110084752.30510-1-kraxel@redhat.com>
References: <20190110084752.30510-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] keymaps: drop nl-be map
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

It doesn't define any keys, only includes "common".
Which makes it effectively an "en-us" map.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20181116104319.10329-3-kraxel@redhat.com
---
 Makefile              | 2 +-
 pc-bios/keymaps/nl-be | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)
 delete mode 100644 pc-bios/keymaps/nl-be

diff --git a/Makefile b/Makefile
index 16cbee2c5f..74e20755ac 100644
--- a/Makefile
+++ b/Makefile
@@ -653,7 +653,7 @@ distclean: clean
 
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
