Received: from eggs.gnu.org ([2001:4830:134:3::10]:55431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gYmTy-0003V8-Sp
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gYmTu-0006SA-TS
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:34:26 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gYmTu-0006Re-Mg
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:34:22 -0500
Received: by mail-pf1-x443.google.com with SMTP id u6so5842488pfh.11
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 22:34:22 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 16 Dec 2018 22:34:16 -0800
Message-Id: <1545028456-2797-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] main-loop: remove unused header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 util/main-loop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/main-loop.c b/util/main-loop.c
index affe0403c5..845a4b1f13 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -26,7 +26,6 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
-#include "qemu/sockets.h"	// struct in_addr needed for libslirp.h
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "sysemu/replay.h"
-- 
2.11.0
