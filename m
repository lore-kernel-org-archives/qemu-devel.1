Received: from eggs.gnu.org ([209.51.188.92]:49554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmDSq-0003j0-QM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmDSo-0000It-JR
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmDSo-0000Gh-Cm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:00:46 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Jan 2019 09:00:04 +0100
Message-Id: <20190123080005.31078-4-kraxel@redhat.com>
In-Reply-To: <20190123080005.31078-1-kraxel@redhat.com>
References: <20190123080005.31078-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] audio: use try-sdl and try-pa for openbsd
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
Also enable pulseaudio support.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 6fef094f39..bbadd83fea 100755
--- a/configure
+++ b/configure
@@ -825,8 +825,8 @@ NetBSD)
 OpenBSD)
   bsd="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="sdl"
-  audio_possible_drivers="sdl"
+  audio_drv_list="try-sdl try-pa"
+  audio_possible_drivers="sdl pa"
   HOST_VARIANT_DIR="openbsd"
   supported_os="yes"
 ;;
-- 
2.9.3
