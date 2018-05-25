Received: from eggs.gnu.org ([2001:4830:134:3::10]:50580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM6BE-000641-U2
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fM6BB-0007e0-Qa
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:26:24 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:46118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fM6BB-0007cV-Ih
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:26:21 -0400
Received: by mail-pl0-x243.google.com with SMTP id 30-v6so2522108pld.13
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 23:26:21 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 25 May 2018 18:24:48 +1200
Message-Id: <1527229488-49822-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH] RISC-V: Correct typo in RV32 perf counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>

This patch enables mhpmcounter3h through mhpmcounter31h on RV32.
Previously the RV32 h versions (high 32-bits of 64-bit counters)
of these counters would trap with an illegal instruction instead
of returning 0 as intended.

Reported-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 3abf52453cfc..1f6dc9a85852 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -406,7 +406,7 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
         return 0;
     }
 #if defined(TARGET_RISCV32)
-    if (csrno >= CSR_MHPMCOUNTER3 && csrno <= CSR_MHPMCOUNTER31) {
+    if (csrno >= CSR_MHPMCOUNTER3H && csrno <= CSR_MHPMCOUNTER31H) {
         return 0;
     }
 #endif
-- 
2.7.0
