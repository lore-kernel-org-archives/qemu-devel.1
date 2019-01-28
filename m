Received: from eggs.gnu.org ([209.51.188.92]:47707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFdC-0007re-5Y
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFd9-0003TC-RA
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:54 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1goFd9-0003SR-HD
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:51 -0500
Received: by mail-wr1-x442.google.com with SMTP id z5so19919953wrt.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:43:51 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Mon, 28 Jan 2019 23:43:35 +0100
Message-Id: <8c4fa9bd1174aabb761c4d372c174257b2e6501a.1548714862.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 12/14] spiceaudio: port to -audiodev config
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
