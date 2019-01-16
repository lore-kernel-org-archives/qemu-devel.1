Received: from eggs.gnu.org ([209.51.188.92]:57995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjuks-00046t-45
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukj-0002tn-Th
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukj-0002jO-FY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id d15so3885269wmb.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:37 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:45 +0100
Message-Id: <9389fad919c0e8401972103016839b20ba91941b.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 12/50] spiceaudio: port to -audiodev config
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

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/spiceaudio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index affc3df17f..4f7873af5a 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -373,10 +373,6 @@ static int line_in_ctl (HWVoiceIn *hw, int cmd, ...)
     return 0;
 }
 
-static struct audio_option audio_options[] = {
-    { /* end of list */ },
-};
-
 static struct audio_pcm_ops audio_callbacks = {
     .init_out = line_out_init,
     .fini_out = line_out_fini,
@@ -394,7 +390,6 @@ static struct audio_pcm_ops audio_callbacks = {
 static struct audio_driver spice_audio_driver = {
     .name           = "spice",
     .descr          = "spice audio driver",
-    .options        = audio_options,
     .init           = spice_audio_init,
     .fini           = spice_audio_fini,
     .pcm_ops        = &audio_callbacks,
-- 
2.20.1
