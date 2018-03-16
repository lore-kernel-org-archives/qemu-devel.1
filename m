Received: from eggs.gnu.org ([2001:4830:134:3::10]:40425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFM-0007a6-QN
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFL-0003po-Kv
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:36 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewvFL-0003pU-EY
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:35 -0400
Received: by mail-pl0-x243.google.com with SMTP id w12-v6so6510973plp.4
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:42:35 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 12:41:16 -0700
Message-Id: <1521229281-73637-20-git-send-email-mjc@sifive.com>
In-Reply-To: <1521229281-73637-1-git-send-email-mjc@sifive.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 19/24] RISC-V: riscv-qemu port supports sv39
 and sv48
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

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7c4482b..f47fc9c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -24,8 +24,8 @@
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
 #if defined(TARGET_RISCV64)
 #define TARGET_LONG_BITS 64
-#define TARGET_PHYS_ADDR_SPACE_BITS 50
-#define TARGET_VIRT_ADDR_SPACE_BITS 39
+#define TARGET_PHYS_ADDR_SPACE_BITS 52
+#define TARGET_VIRT_ADDR_SPACE_BITS 48
 #elif defined(TARGET_RISCV32)
 #define TARGET_LONG_BITS 32
 #define TARGET_PHYS_ADDR_SPACE_BITS 34
-- 
2.7.0
