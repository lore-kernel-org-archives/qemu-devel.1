Received: from eggs.gnu.org ([2001:4830:134:3::10]:55606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1hq-0000Sd-I1
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1hl-0007jX-Jn
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:06:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57948 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1hl-0007ij-C0
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:06:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:32:02 +0200
Message-Id: <1532453527-22911-51-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 50/55] linux-user: Add target_structs.h
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Add target_structs.h header for nanoMIPS, that redirects to the
corresponding MIPS header.

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
2.7.4
