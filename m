Received: from eggs.gnu.org ([208.118.235.92]:52215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAju-0007bi-2U
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjs-00029p-Qb
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:45 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjs-00022U-Ic
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:44 -0500
Received: by mail-wm1-x344.google.com with SMTP id n190so9881434wmd.0
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:43 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:50 +0100
Message-Id: <7d984c53e0cce55748abf07e85b0caf5bb48952e.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 14/52] spiceaudio: port to -audiodev config
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
