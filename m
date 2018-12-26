Received: from eggs.gnu.org ([208.118.235.92]:37486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <plaes@plaes.org>) id 1gbxCz-0007AY-Oe
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 19:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <plaes@plaes.org>) id 1gbxCu-0004s6-S2
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 19:38:01 -0500
From: Priit Laes <plaes@plaes.org>
Date: Wed, 26 Dec 2018 02:37:22 +0200
Message-Id: <20181226003722.31257-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qom: Include qemu/fprintf-fn.h in cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Priit Laes <plaes@plaes.org>

QOM cpu.h uses fprintf_function which requires Qemu's
qemu/fprintf-fn.h header. Include it.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 include/qom/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1396f53e5b..6d1ba53d72 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/fprintf-fn.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
--=20
2.20.1
