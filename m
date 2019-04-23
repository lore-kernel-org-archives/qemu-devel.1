Received: from eggs.gnu.org ([209.51.188.92]:36469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdb-0001do-Ia
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0005Xv-An
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45020 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItda-0005WR-3z
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Apr 2019 13:29:40 +0200
Message-Id: <1556018982-3715-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 6/8] target/mips: Clean up lmi_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove several minor checkpatch warnings and errors.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/lmi_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/lmi_helper.c b/target/mips/lmi_helper.c
index fb1245b..6c645cf 100644
--- a/target/mips/lmi_helper.c
+++ b/target/mips/lmi_helper.c
@@ -21,9 +21,11 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-/* If the byte ordering doesn't matter, i.e. all columns are treated
-   identically, then this union can be used directly.  If byte ordering
-   does matter, we generally ignore dumping to memory.  */
+/*
+ * If the byte ordering doesn't matter, i.e. all columns are treated
+ * identically, then this union can be used directly.  If byte ordering
+ * does matter, we generally ignore dumping to memory.
+ */
 typedef union {
     uint8_t  ub[8];
     int8_t   sb[8];
-- 
2.7.4
