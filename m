Received: from eggs.gnu.org ([2001:4830:134:3::10]:41482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKus-00029w-0p
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKuo-0000jk-VB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evKuo-0000iE-OL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1958A7B4C8
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:42:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 11:42:41 +0100
Message-Id: <20180312104241.24965-9-kraxel@redhat.com>
In-Reply-To: <20180312104241.24965-1-kraxel@redhat.com>
References: <20180312104241.24965-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] audio/sdl: build as module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180306074053.22856-8-kraxel@redhat.com
---
 configure           | 2 +-
 audio/Makefile.objs | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 27bc39bd4d..9f9ffb2cf9 100755
--- a/configure
+++ b/configure
@@ -5974,7 +5974,7 @@ echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
     def=CONFIG_AUDIO_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
     case "$drv" in
-	alsa | oss | pa)
+	alsa | oss | pa | sdl)
 	    echo "$def=m" >> $config_host_mak ;;
 	*)
 	    echo "$def=y" >> $config_host_mak ;;
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index b98835934d..db4fa7f18f 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -1,5 +1,4 @@
 common-obj-y = audio.o noaudio.o wavaudio.o mixeng.o
-common-obj-$(CONFIG_AUDIO_SDL) += sdlaudio.o
 common-obj-$(CONFIG_SPICE) += spiceaudio.o
 common-obj-$(CONFIG_AUDIO_COREAUDIO) += coreaudio.o
 common-obj-$(CONFIG_AUDIO_DSOUND) += dsoundaudio.o
@@ -7,8 +6,6 @@ common-obj-$(CONFIG_AUDIO_PT_INT) += audio_pt_int.o
 common-obj-$(CONFIG_AUDIO_WIN_INT) += audio_win_int.o
 common-obj-y += wavcapture.o
 
-sdlaudio.o-cflags := $(SDL_CFLAGS)
-sdlaudio.o-libs := $(SDL_LIBS)
 coreaudio.o-libs := $(COREAUDIO_LIBS)
 dsoundaudio.o-libs := $(DSOUND_LIBS)
 
@@ -26,3 +23,9 @@ oss.mo-libs := $(OSS_LIBS)
 common-obj-$(CONFIG_AUDIO_PA) += pa.mo
 pa.mo-objs = paaudio.o
 pa.mo-libs := $(PULSE_LIBS)
+
+# sdl module
+common-obj-$(CONFIG_AUDIO_SDL) += sdl.mo
+sdl.mo-objs = sdlaudio.o
+sdl.mo-cflags := $(SDL_CFLAGS)
+sdl.mo-libs := $(SDL_LIBS)
-- 
2.9.3
