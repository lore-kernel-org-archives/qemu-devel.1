Received: from eggs.gnu.org ([209.51.188.92]:57828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukl-00043G-1n
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukj-0002tM-MW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:46 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukj-0002fc-D5
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id m22so3885887wml.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:33 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:41 +0100
Message-Id: <1aba321d3f73c7145a2331ce27f36c52570ceec6.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/50] noaudio: port to -audiodev config
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
