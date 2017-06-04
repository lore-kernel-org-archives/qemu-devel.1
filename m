Received: from eggs.gnu.org ([2001:4830:134:3::10]:60554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXns-0005E7-8O
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXno-00035x-DP
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:50:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:14 +0300
Message-Id: <95e9a242e2a393c7d4e5cc04340e39c3a9420f03.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 10/22] target/arm: add data cache invalidation
 cp15 instruction to cortex-r5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Luc MICHEL <luc.michel@git.antfield.fr>

The cp15, CRn=15, opc1=0, CRm=5, opc2=0 instruction invalidates all the
data cache on the cortex-r5. Implementing it as a NOP.

Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e748097860..04a3fea03f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1082,6 +1082,8 @@ static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
       .access = PL1_RW, .type = ARM_CP_CONST },
     { .name = "BTCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
       .access = PL1_RW, .type = ARM_CP_CONST },
+    { .name = "DCACHE_INVAL", .cp = 15, .opc1 = 0, .crn = 15, .crm = 5,
+      .opc2 = 0, .access = PL1_W, .type = ARM_CP_NOP },
     REGINFO_SENTINEL
 };
 
-- 
2.11.0
