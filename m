Received: from eggs.gnu.org ([2001:4830:134:3::10]:50643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlu-0003BZ-El
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlt-0004MZ-Hb
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlt-0004L8-9j
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlr-0003lZ-V5
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:10 +0100
Message-Id: <20180608124517.29475-25-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/31] RISC-V: Add trailing '\n' to qemu_log()
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180606152128.449-11-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/riscv/op_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 3abf52453cf..aec7558e1b9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -293,7 +293,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         if ((val_to_write & 3) == 0) {
             env->stvec = val_to_write >> 2 << 2;
         } else {
-            qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported");
+            qemu_log_mask(LOG_UNIMP,
+                          "CSR_STVEC: vectored traps not supported\n");
         }
         break;
     case CSR_SCOUNTEREN:
@@ -320,7 +321,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         if ((val_to_write & 3) == 0) {
             env->mtvec = val_to_write >> 2 << 2;
         } else {
-            qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported");
+            qemu_log_mask(LOG_UNIMP,
+                          "CSR_MTVEC: vectored traps not supported\n");
         }
         break;
     case CSR_MCOUNTEREN:
-- 
2.17.1
