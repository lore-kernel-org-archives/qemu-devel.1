Received: from eggs.gnu.org ([2001:4830:134:3::10]:58601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0ag-00089U-DF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0af-00047M-MP
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:14:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX0af-00046p-Ff
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:14:01 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Dec 2018 10:13:49 +0100
Message-Id: <1544606032-16924-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1544606032-16924-1-git-send-email-thuth@redhat.com>
References: <1544606032-16924-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] audio/alsaaudio: Remove compiler check
 around pragma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Both GCC v4.8 and Clang v3.4 support the -Waddress option, so we do
not need the compiler version check here anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 audio/alsaaudio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 362a227..635be73 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -28,9 +28,7 @@
 #include "audio.h"
 #include "trace.h"
 
-#if QEMU_GNUC_PREREQ(4, 3)
 #pragma GCC diagnostic ignored "-Waddress"
-#endif
 
 #define AUDIO_CAP "alsa"
 #include "audio_int.h"
-- 
1.8.3.1
