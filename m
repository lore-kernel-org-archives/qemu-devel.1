Received: from eggs.gnu.org ([2001:4830:134:3::10]:40469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFR-0007eo-35
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFO-0003qz-Ky
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:41 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewvFO-0003qm-Ed
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:38 -0400
Received: by mail-pl0-x244.google.com with SMTP id b7-v6so2425732plr.8
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:42:38 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 12:41:19 -0700
Message-Id: <1521229281-73637-23-git-send-email-mjc@sifive.com>
In-Reply-To: <1521229281-73637-1-git-send-email-mjc@sifive.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 22/24] RISC-V: Remove support for adhoc
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

This is essentially dead-code elimination. Support for more
local interrupts will be added in a future revision, as they
will be defined in a future version of the Privileged ISA
specification.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
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
