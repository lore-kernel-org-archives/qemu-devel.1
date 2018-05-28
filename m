Received: from eggs.gnu.org ([2001:4830:134:3::10]:32771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYS-00070q-AP
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRYR-0000rs-KA
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:05 -0300
Message-Id: <20180528232719.4721-8-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 07/21] target/ppc: Include "exec/exec-all.h"
 which provides tlb_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>

Since it inception this include uses tlb_flush() declared in "exec/exec-all.h".
Include the other header to allow further includes cleanup.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/ppc/helper_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 84fd30c2db..5efd18049e 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -21,6 +21,7 @@
 #define HELPER_REGS_H
 
 #include "qemu/main-loop.h"
+#include "exec/exec-all.h"
 
 /* Swap temporary saved registers with GPRs */
 static inline void hreg_swap_gpr_tgpr(CPUPPCState *env)
-- 
2.17.0
