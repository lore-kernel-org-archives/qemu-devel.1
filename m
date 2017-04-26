Received: from eggs.gnu.org ([2001:4830:134:3::10]:36833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d3MS7-0006Mf-Af
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d3MS6-0005Vz-Di
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:53:51 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d3MS6-0005Vk-82
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:53:50 -0400
Received: by mail-pf0-x242.google.com with SMTP id v14so15651795pfd.3
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 05:53:50 -0700 (PDT)
From: Zihan Yang <tgnyang@gmail.com>
Date: Wed, 26 Apr 2017 20:53:08 +0800
Message-Id: <1493211188-24086-5-git-send-email-tgnyang@gmail.com>
In-Reply-To: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
References: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
Subject: [Qemu-devel] [PATCH 5/5] hw/audio: convert exit callback in
 HDACodecDeviceClass to void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <tgnyang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

The exit callback always return 0, convert it to void

Signed-off-by: Zihan Yang <tgnyang@gmail.com>
---
 hw/audio/hda-codec.c | 3 +--
 hw/audio/intel-hda.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 52d4640..5402cd1 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -520,7 +520,7 @@ static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
     return 0;
 }
 
-static int hda_audio_exit(HDACodecDevice *hda)
+static void hda_audio_exit(HDACodecDevice *hda)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
     HDAAudioStream *st;
@@ -539,7 +539,6 @@ static int hda_audio_exit(HDACodecDevice *hda)
         }
     }
     AUD_remove_card(&a->card);
-    return 0;
 }
 
 static int hda_audio_post_load(void *opaque, int version)
diff --git a/hw/audio/intel-hda.h b/hw/audio/intel-hda.h
index d784bcf..53b78da 100644
--- a/hw/audio/intel-hda.h
+++ b/hw/audio/intel-hda.h
@@ -38,7 +38,7 @@ typedef struct HDACodecDeviceClass
     DeviceClass parent_class;
 
     int (*init)(HDACodecDevice *dev);
-    int (*exit)(HDACodecDevice *dev);
+    void (*exit)(HDACodecDevice *dev);
     void (*command)(HDACodecDevice *dev, uint32_t nid, uint32_t data);
     void (*stream)(HDACodecDevice *dev, uint32_t stnr, bool running, bool output);
 } HDACodecDeviceClass;
-- 
2.7.4
