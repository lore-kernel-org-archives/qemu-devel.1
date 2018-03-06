Received: from eggs.gnu.org ([2001:4830:134:3::10]:47249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJTV-0006kg-CO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJTU-0003eT-ML
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:17 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJTU-0003eF-Fs
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:16 -0500
Received: by mail-pg0-x244.google.com with SMTP id i14so8760824pgv.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:46:16 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:43:54 +1300
Message-Id: <1520369037-37977-20-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369037-37977-1-git-send-email-mjc@sifive.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 19/22] RISC-V: riscv-qemu port supports sv39
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
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

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
