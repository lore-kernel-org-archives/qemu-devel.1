Received: from eggs.gnu.org ([2001:4830:134:3::10]:34690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEp0-0005q0-By
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEoz-0005Eo-8i
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:43:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56456 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEoz-0005Cp-0c
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:43:21 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:56 +0200
Message-Id: <1533219424-7627-70-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 69/77] linux-user: Add target_structs.h
 header for nanoMIPS
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

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Add target_structs.h header for nanoMIPS, that in fact only redirects
to the corresponding MIPS header.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/nanomips/target_structs.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 linux-user/nanomips/target_structs.h

diff --git a/linux-user/nanomips/target_structs.h b/linux-user/nanomips/target_structs.h
new file mode 100644
index 0000000..cc6c6ea
--- /dev/null
+++ b/linux-user/nanomips/target_structs.h
@@ -0,0 +1 @@
+#include "../mips/target_structs.h"
-- 
1.9.1
