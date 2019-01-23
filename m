Received: from eggs.gnu.org ([209.51.188.92]:60053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmKLe-0008Ha-6O
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmKLd-0008Ih-2A
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmKLc-000856-Qf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:21:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Jan 2019 16:21:12 +0100
Message-Id: <20190123152112.15757-7-kraxel@redhat.com>
In-Reply-To: <20190123152112.15757-1-kraxel@redhat.com>
References: <20190123152112.15757-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] audio: probe audio drivers by default
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

Add the drivers listed in audio_possible_drivers to audio_drv_list,
using the try-* variants.  That way the probable drivers are compiled by
default if possible.

Reordered linux drivers, order is now: pa alsa sdl oss

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 99f3c10759..cb6ae555fc 100755
--- a/configure
+++ b/configure
@@ -793,13 +793,13 @@ MINGW32*)
 ;;
 GNU/kFreeBSD)
   bsd="yes"
-  audio_drv_list="oss"
+  audio_drv_list="oss try-sdl try-pa"
   audio_possible_drivers="oss sdl pa"
 ;;
 FreeBSD)
   bsd="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="oss"
+  audio_drv_list="oss try-sdl try-pa"
   audio_possible_drivers="oss sdl pa"
   # needed for kinfo_getvmmap(3) in libutil.h
   LIBS="-lutil $LIBS"
@@ -812,14 +812,14 @@ FreeBSD)
 DragonFly)
   bsd="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="oss"
+  audio_drv_list="oss try-sdl try-pa"
   audio_possible_drivers="oss sdl pa"
   HOST_VARIANT_DIR="dragonfly"
 ;;
 NetBSD)
   bsd="yes"
   make="${MAKE-gmake}"
-  audio_drv_list="oss"
+  audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
   oss_lib="-lossaudio"
   HOST_VARIANT_DIR="netbsd"
@@ -844,7 +844,7 @@ Darwin)
     LDFLAGS="-arch x86_64 $LDFLAGS"
   fi
   cocoa="yes"
-  audio_drv_list="coreaudio"
+  audio_drv_list="coreaudio try-sdl"
   audio_possible_drivers="coreaudio sdl"
   LDFLAGS="-framework CoreFoundation -framework IOKit $LDFLAGS"
   libs_softmmu="-F/System/Library/Frameworks -framework Cocoa -framework IOKit $libs_softmmu"
@@ -860,7 +860,7 @@ SunOS)
   install="${INSTALL-ginstall}"
   smbd="${SMBD-/usr/sfw/sbin/smbd}"
   if test -f /usr/include/sys/soundcard.h ; then
-    audio_drv_list="oss"
+    audio_drv_list="oss try-sdl"
   fi
   audio_possible_drivers="oss sdl"
 # needed for CMSG_ macros in sys/socket.h
@@ -878,7 +878,7 @@ Haiku)
   LIBS="-lposix_error_mapper -lnetwork $LIBS"
 ;;
 Linux)
-  audio_drv_list="oss"
+  audio_drv_list="try-pa try-alsa try-sdl oss"
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
-- 
2.9.3
