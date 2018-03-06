Received: from eggs.gnu.org ([2001:4830:134:3::10]:53179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJeb-0008Pk-5J
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJea-0002h1-G8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:57:45 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJea-0002gk-9x
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:57:44 -0500
Received: by mail-pf0-x241.google.com with SMTP id j20so10927pfi.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:57:44 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:56:11 +1300
Message-Id: <1520369790-38306-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369790-38306-1-git-send-email-mjc@sifive.com>
References: <1520369790-38306-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 03/22] RISC-V: Make virt board description
 match spike
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

This makes 'qemu-system-riscv64 -machine help' output more tidy
and consistent.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a402856..0055439 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -404,7 +404,7 @@ static const TypeInfo riscv_virt_board_device = {
 
 static void riscv_virt_board_machine_init(MachineClass *mc)
 {
-    mc->desc = "RISC-V VirtIO Board (Privileged spec v1.10)";
+    mc->desc = "RISC-V VirtIO Board (Privileged ISA v1.10)";
     mc->init = riscv_virt_board_init;
     mc->max_cpus = 8; /* hardcoded limit in BBL */
 }
-- 
2.7.0
