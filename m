Received: from eggs.gnu.org ([2001:4830:134:3::10]:48008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1d45Sa-0005Ox-1j
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1d45SU-0001Fn-JY
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:57:20 -0400
From: Luc MICHEL <luc.michel@git.antfield.fr>
Date: Fri, 28 Apr 2017 14:56:32 +0200
Message-Id: <20170428125632.5704-2-luc.michel@git.antfield.fr>
In-Reply-To: <20170428125632.5704-1-luc.michel@git.antfield.fr>
References: <20170428125632.5704-1-luc.michel@git.antfield.fr>
Subject: [Qemu-devel] [PATCH 1/1] target/arm: add data cache invalidation
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
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-trivial@nongnu.org

The cp15, CRn=15, opc1=0, CRm=5, opc2=0 instruction invalidates all the
data cache on the cortex-r5. Implementing it as a NOP.

Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b357aee778..47687a40c4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1062,6 +1062,8 @@ static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
       .access = PL1_RW, .type = ARM_CP_CONST },
     { .name = "BTCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
       .access = PL1_RW, .type = ARM_CP_CONST },
+    { .name = "DCACHE_INVAL", .cp = 15, .opc1 = 0, .crn = 15, .crm = 5,
+      .opc2 = 0, .access = PL1_W, .type = ARM_CP_NOP },
     REGINFO_SENTINEL
 };
 
-- 
2.12.2
