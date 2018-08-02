Received: from eggs.gnu.org ([2001:4830:134:3::10]:34410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEo2-0004uA-By
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEnz-0004Sz-9o
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:42:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54730 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEnz-0004Sd-1g
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:42:19 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:53 +0200
Message-Id: <1533219424-7627-67-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 66/77] linux-user: Add sockbits.h header for
 nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add sockbits.h header for nanoMIPS.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/nanomips/sockbits.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 linux-user/nanomips/sockbits.h

diff --git a/linux-user/nanomips/sockbits.h b/linux-user/nanomips/sockbits.h
new file mode 100644
index 0000000..e6b6d31
--- /dev/null
+++ b/linux-user/nanomips/sockbits.h
@@ -0,0 +1 @@
+#include "../mips/sockbits.h"
-- 
1.9.1
