Received: from eggs.gnu.org ([2001:4830:134:3::10]:52974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeH-0001zx-Lq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeG-00022p-SO
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:47:53 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eykeG-00022V-M1
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:47:52 -0400
Received: by mail-pf0-x243.google.com with SMTP id l27so2455463pfk.12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 13:47:52 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 21 Mar 2018 13:46:39 -0700
Message-Id: <1521665220-3869-4-git-send-email-mjc@sifive.com>
In-Reply-To: <1521665220-3869-1-git-send-email-mjc@sifive.com>
References: <1521665220-3869-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/24] RISC-V: Make virt board description match
 spike
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

This makes 'qemu-system-riscv64 -machine help' output more tidy
and consistent.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
