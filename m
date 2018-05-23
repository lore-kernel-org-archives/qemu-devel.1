Received: from eggs.gnu.org ([2001:4830:134:3::10]:41936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSV-0007lD-2L
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHST-0000SG-OF
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:16:51 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:45291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHST-0000Rw-Hn
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:16:49 -0400
Received: by mail-pg0-x236.google.com with SMTP id w3-v6so8563017pgv.12
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:16:49 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:14:48 +1200
Message-Id: <1527034517-7851-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 01/30] RISC-V: Update address bits to
 support sv39 and sv48
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34abc383e3d4..e0608e6d5f08 100644
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
2.7.0
