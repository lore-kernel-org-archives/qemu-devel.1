Received: from eggs.gnu.org ([209.51.188.92]:59953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmKLW-0008DR-On
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmKLQ-0008BN-Qy
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmKLD-00084L-Kx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:29 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Jan 2019 16:21:09 +0100
Message-Id: <20190123152112.15757-4-kraxel@redhat.com>
In-Reply-To: <20190123152112.15757-1-kraxel@redhat.com>
References: <20190123152112.15757-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] audio: use try-sdl for openbsd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Fixes the openbsd build failure with SDL disabled.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index d32e4f6dbb..99f3c10759 100755
--- a/configure
+++ b/configure
@@ -828,7 +828,7 @@ NetBSD)
 OpenBSD)
   bsd="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="sdl"
+  audio_drv_list="try-sdl"
   audio_possible_drivers="sdl"
   HOST_VARIANT_DIR="openbsd"
   supported_os="yes"
-- 
2.9.3
