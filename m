Received: from eggs.gnu.org ([208.118.235.92]:38464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eznha-0004Ye-JX
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezngW-0003l5-Is
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:15:38 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:47017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezngW-0003kt-Bt
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:14:32 -0400
Received: by mail-pg0-x241.google.com with SMTP id t12so3988267pgp.13
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:14:32 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:13:33 -0700
Message-Id: <1521915220-65389-8-git-send-email-mjc@sifive.com>
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 18/26] RISC-V: riscv-qemu port supports sv39
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
index 1dcbdbe..cd337ab 100644
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
