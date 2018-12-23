Received: from eggs.gnu.org ([208.118.235.92]:52117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjp-0007Rs-EF
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjo-0001u4-Lm
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:41 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjo-0001rt-Fg
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:40 -0500
Received: by mail-wm1-x341.google.com with SMTP id f188so10406915wmf.5
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:40 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:46 +0100
Message-Id: <41f3a0498fae350f8362023292606cfffea122e9.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/52] noaudio: port to -audiodev config
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
index 2cc274c5e5..f1eb048d80 100644
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
