Received: from eggs.gnu.org ([2001:4830:134:3::10]:52782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dIgld-0004Nt-3s
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1dIglY-0006i1-7F
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:37:21 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed,  7 Jun 2017 12:36:44 -0700
Message-Id: <1496864204-5954-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: gdbstub: drop dead return
 statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/gdbstub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index da131ae..d78a1b4 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -72,7 +72,6 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
                       __func__, n, reg->type);
         memset(mem_buf, 0, reg->size);
         return reg->size;
-        return 0;
     }
 }
 
-- 
2.1.4
