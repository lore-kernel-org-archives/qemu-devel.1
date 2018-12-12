Received: from eggs.gnu.org ([2001:4830:134:3::10]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mm-00016z-W7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mh-0000SH-MJ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:02 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6Mh-0000Qt-Bx
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:59 -0500
Received: by mail-wm1-x336.google.com with SMTP id c126so6366926wmh.0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:58 +0100
Message-Id: <1544628195-37728-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/54] audio/alsaaudio: Remove compiler check
 around pragma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Both GCC v4.8 and Clang v3.4 support the -Waddress option, so we do
not need the compiler version check here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1543937577-28256-6-git-send-email-thuth@redhat.com>
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
