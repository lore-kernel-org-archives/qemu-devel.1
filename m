Received: from eggs.gnu.org ([2001:4830:134:3::10]:58410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8K-0003Rv-0E
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8J-0008O8-4d
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8I-0008NT-Uo
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:03 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:08 +0200
Message-Id: <20180531171253.21012-9-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/53] target/ppc: Include "exec/exec-all.h"
 which provides tlb_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Since it inception this include uses tlb_flush() declared in "exec/exec-a=
ll.h".
Include the other header to allow further includes cleanup.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180528232719.4721-8-f4bug@amsat.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/helper_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 84fd30c2db..5efd18049e 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -21,6 +21,7 @@
 #define HELPER_REGS_H
=20
 #include "qemu/main-loop.h"
+#include "exec/exec-all.h"
=20
 /* Swap temporary saved registers with GPRs */
 static inline void hreg_swap_gpr_tgpr(CPUPPCState *env)
--=20
2.17.0
