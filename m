Received: from eggs.gnu.org ([2001:4830:134:3::10]:46688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fCvba-0001l9-PT
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fCvbX-0006XM-K6
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:19:42 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fCvbX-0006X6-Dv
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 19:19:39 -0400
Received: by mail-pf0-x241.google.com with SMTP id f15so5354310pfn.0
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 16:19:39 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Mon, 30 Apr 2018 11:18:08 +1200
Message-Id: <1525043888-90983-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH] RISC-V: Fix missing break statement in
 disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>

This fixes an issue when disassembling rv128 c.sqsp,
where the code erroneously fell through to c.swsp.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 disas/riscv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 74ad16eacdd3..ea19f6fbe2b1 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1470,8 +1470,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             if (isa == rv128) {
                 op = rv_op_c_sqsp;
             } else {
-                op = rv_op_c_fsdsp; break;
+                op = rv_op_c_fsdsp;
             }
+            break;
         case 6: op = rv_op_c_swsp; break;
         case 7:
             if (isa == rv32) {
-- 
2.7.0
