Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjHH-0008M2-MK
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjHE-0002nG-8i
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47383 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmjHD-0002kq-L2
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:40 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 19:00:34 +0200
Message-Id: <1533574847-19294-68-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 67/80] linux-user: Add sockbits.h header for
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

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
2.7.4
