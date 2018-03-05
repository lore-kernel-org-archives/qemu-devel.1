Received: from eggs.gnu.org ([2001:4830:134:3::10]:37782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnm-0003qm-H1
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnj-0003am-BV
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eslnj-0003Yv-37
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:48:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EC8A40FB653
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 08:48:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  5 Mar 2018 09:48:43 +0100
Message-Id: <20180305084844.18222-13-kraxel@redhat.com>
In-Reply-To: <20180305084844.18222-1-kraxel@redhat.com>
References: <20180305084844.18222-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 12/13] audio: rename CONFIG_* to CONFIG_AUDIO_*
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

This avoids a name clash for CONFIG_SDL, which is used by both sdl video
support and sdl audio support.  It also more clear that this is a audio
driver configuration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180301100547.18962-13-kraxel@redhat.com
---
 configure           |  2 +-
 audio/audio_int.h   |  2 +-
 audio/Makefile.objs | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index e651533466..269add1187 100755
--- a/configure
+++ b/configure
@@ -5981,7 +5981,7 @@ if test "$cap_ng" = "yes" ; then
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
-    def=CONFIG_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
+    def=CONFIG_AUDIO_$(echo $drv | LC_ALL=C tr '[a-z]' '[A-Z]')
     echo "$def=y" >> $config_host_mak
 done
 echo "ALSA_LIBS=$alsa_libs" >> $config_host_mak
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5b25da0a37..700bd43143 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -25,7 +25,7 @@
 #ifndef QEMU_AUDIO_INT_H
 #define QEMU_AUDIO_INT_H
 
-#ifdef CONFIG_COREAUDIO
+#ifdef CONFIG_AUDIO_COREAUDIO
 #define FLOAT_MIXENG
 /* #define RECIPROCAL */
 #endif
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index 8a5ede6e2b..f6ce5c6744 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -1,11 +1,11 @@
 common-obj-y = audio.o noaudio.o wavaudio.o mixeng.o
-common-obj-$(CONFIG_SDL) += sdlaudio.o
-common-obj-$(CONFIG_OSS) += ossaudio.o
+common-obj-$(CONFIG_AUDIO_SDL) += sdlaudio.o
+common-obj-$(CONFIG_AUDIO_OSS) += ossaudio.o
 common-obj-$(CONFIG_SPICE) += spiceaudio.o
-common-obj-$(CONFIG_COREAUDIO) += coreaudio.o
-common-obj-$(CONFIG_ALSA) += alsaaudio.o
-common-obj-$(CONFIG_DSOUND) += dsoundaudio.o
-common-obj-$(CONFIG_PA) += paaudio.o
+common-obj-$(CONFIG_AUDIO_COREAUDIO) += coreaudio.o
+common-obj-$(CONFIG_AUDIO_ALSA) += alsaaudio.o
+common-obj-$(CONFIG_AUDIO_DSOUND) += dsoundaudio.o
+common-obj-$(CONFIG_AUDIO_PA) += paaudio.o
 common-obj-$(CONFIG_AUDIO_PT_INT) += audio_pt_int.o
 common-obj-$(CONFIG_AUDIO_WIN_INT) += audio_win_int.o
 common-obj-y += wavcapture.o
-- 
2.9.3
