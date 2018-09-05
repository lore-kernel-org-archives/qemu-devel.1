Received: from eggs.gnu.org ([2001:4830:134:3::10]:57402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxfzu-0000m5-9N
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxfzp-0003Hf-8q
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxfzo-0003Ag-Om
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:09:57 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed,  5 Sep 2018 15:09:24 -0700
Message-Id: <20180905220932.6152-2-alistair.francis@wdc.com>
In-Reply-To: <20180905220932.6152-1-alistair.francis@wdc.com>
References: <20180905220932.6152-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 01/10] RISC-V: Update address bits to support
 sv39 and sv48
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>

From: Michael Clark <mjc@sifive.com>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34abc383e3..e0608e6d5f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -24,12 +24,12 @@
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
 #if defined(TARGET_RISCV64)
 #define TARGET_LONG_BITS 64
-#define TARGET_PHYS_ADDR_SPACE_BITS 50
-#define TARGET_VIRT_ADDR_SPACE_BITS 39
+#define TARGET_PHYS_ADDR_SPACE_BITS 56 /* 44-bit PPN */
+#define TARGET_VIRT_ADDR_SPACE_BITS 48 /* sv48 */
 #elif defined(TARGET_RISCV32)
 #define TARGET_LONG_BITS 32
-#define TARGET_PHYS_ADDR_SPACE_BITS 34
-#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#define TARGET_PHYS_ADDR_SPACE_BITS 34 /* 22-bit PPN */
+#define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
 #endif
 
 #define TCG_GUEST_DEFAULT_MO 0
-- 
2.17.1
