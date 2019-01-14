Received: from eggs.gnu.org ([209.51.188.92]:44877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz54-0005gr-JR
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz53-0007bI-Od
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz53-0007aG-Iu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:53 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:13 +0100
Message-Id: <1547460140-1473-19-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/25] audio: Remove AudioState from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Files requiring AudioState already include "audio_int.h".

To clean "qemu/typedefs.h", move the declaration to "audio_int.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 audio/audio_int.h       | 4 ++--
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 244b454..6c451b9 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -191,7 +191,7 @@ struct SWVoiceCap {
     QLIST_ENTRY (SWVoiceCap) entries;
 };
=20
-struct AudioState {
+typedef struct AudioState {
     struct audio_driver *drv;
     void *drv_opaque;
=20
@@ -203,7 +203,7 @@ struct AudioState {
     int nb_hw_voices_out;
     int nb_hw_voices_in;
     int vm_running;
-};
+} AudioState;
=20
 extern const struct mixeng_volume nominal_volume;
=20
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 5edf44e..c6d1c1b 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -8,7 +8,6 @@
 typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
-typedef struct AudioState AudioState;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
 typedef struct BlockBackend BlockBackend;
--=20
1.8.3.1
