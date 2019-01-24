Received: from eggs.gnu.org ([209.51.188.92]:51670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd4G-00021D-H7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd4A-00051G-S1
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmd4A-00050L-M4
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:21:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Jan 2019 12:20:52 +0100
Message-Id: <20190124112055.547-4-kraxel@redhat.com>
In-Reply-To: <20190124112055.547-1-kraxel@redhat.com>
References: <20190124112055.547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/6] audio: use try-sdl for openbsd
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
index 6a2aa3b533..1eff5946f6 100755
--- a/configure
+++ b/configure
@@ -829,7 +829,7 @@ NetBSD)
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
