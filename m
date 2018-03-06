Received: from eggs.gnu.org ([2001:4830:134:3::10]:53612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJfe-000124-PT
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJfa-0002wP-UH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:50 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJfa-0002wL-OA
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:46 -0500
Received: by mail-pl0-x241.google.com with SMTP id 93-v6so3224plc.9
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:58:46 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:56:30 +1300
Message-Id: <1520369790-38306-21-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369790-38306-1-git-send-email-mjc@sifive.com>
References: <1520369790-38306-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 22/22] RISC-V: Remove support for adhoc
 X_COP interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

This is essentially dead-code elimination. Support for more
local interrupts will be added in a future revision, as they
will be defined in a future version of the Privileged ISA
specification.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_bits.h  | 1 -
 target/riscv/op_helper.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 12b4757..133e070 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -346,7 +346,6 @@
 #define IRQ_S_EXT       9
 #define IRQ_H_EXT       10 /* until: priv-1.9.1 */
 #define IRQ_M_EXT       11 /* until: priv-1.9.1 */
-#define IRQ_X_COP       12 /* non-standard */
 
 /* Default addresses */
 #define DEFAULT_RSTVEC     0x00001000
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f8595a6..f543e61 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -90,7 +90,7 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         target_ulong csrno)
 {
 #ifndef CONFIG_USER_ONLY
-    uint64_t delegable_ints = MIP_SSIP | MIP_STIP | MIP_SEIP | (1 << IRQ_X_COP);
+    uint64_t delegable_ints = MIP_SSIP | MIP_STIP | MIP_SEIP;
     uint64_t all_ints = delegable_ints | MIP_MSIP | MIP_MTIP;
 #endif
 
-- 
2.7.0
