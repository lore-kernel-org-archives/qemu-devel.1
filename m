Received: from eggs.gnu.org ([209.51.188.92]:38647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2O4b-0007gY-VV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2O4b-0002de-21
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1h2O4a-0002cw-Rd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id r5so22945289wrg.9
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 14:34:36 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Fri,  8 Mar 2019 23:34:19 +0100
Message-Id: <0c35b1956ed1105244309a774c038816c040108c.1552083282.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
References: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 08/14] noaudio: port to -audiodev config
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
 audio/noaudio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/audio/noaudio.c b/audio/noaudio.c
index 79690af1ea..ccc611fc84 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -163,7 +163,6 @@ static struct audio_pcm_ops no_pcm_ops = {
 static struct audio_driver no_audio_driver = {
     .name           = "none",
     .descr          = "Timer based audio emulation",
-    .options        = NULL,
     .init           = no_audio_init,
     .fini           = no_audio_fini,
     .pcm_ops        = &no_pcm_ops,
-- 
2.20.1
