Received: from eggs.gnu.org ([2001:4830:134:3::10]:54300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6jt-00041o-Ru
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6jr-0003hG-BG
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:17 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6jr-0003gT-4N
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:15 -0400
Received: by mail-pg0-x242.google.com with SMTP id l2-v6so17772190pgc.7
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:37:15 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:12 +1200
Message-Id: <1525563325-62963-8-git-send-email-mjc@sifive.com>
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/20] RISC-V: Fix missing break statement in
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, Peter Maydell <peter.maydell@linaro.org>

This fixes an issue when disassembling rv128 c.sqsp,
where the code erroneously fell through to c.swsp.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 disas/riscv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 2cecf0d8558d..7fd1019623ee 100644
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
