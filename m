Received: from eggs.gnu.org ([208.118.235.92]:36443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezrF5-000489-H5
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 18:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezqzm-0002OL-Nq
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:47:44 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezngZ-0003mA-9I
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:14:35 -0400
Received: by mail-pg0-x241.google.com with SMTP id j3so22377pgf.2
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:14:35 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:13:36 -0700
Message-Id: <1521915220-65389-11-git-send-email-mjc@sifive.com>
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 21/26] RISC-V: Remove support for adhoc
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
index ba3639d..1fdde90 100644
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
