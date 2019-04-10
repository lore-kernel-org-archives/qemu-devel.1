Received: from eggs.gnu.org ([209.51.188.92]:59001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hEJME-0000x2-Pf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hEJMD-0005wO-Rc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:58:06 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:46382
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1hEJMD-0005w5-Jf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:58:05 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Wed, 10 Apr 2019 21:48:38 +0200
Message-Id: <20190410194838.10123-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] tci: Add implementation for INDEX_op_ld16u_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>

This fixes "make check-tcg" on a Debian x86_64 host.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 tcg/tci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tcg/tci.c b/tcg/tci.c
index 33edca1903..a6208653e8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -127,6 +127,12 @@ static void tci_write_reg8(tcg_target_ulong *regs, TCGReg index, uint8_t value)
     tci_write_reg(regs, index, value);
 }
 
+static void
+tci_write_reg16(tcg_target_ulong *regs, TCGReg index, uint16_t value)
+{
+    tci_write_reg(regs, index, value);
+}
+
 static void
 tci_write_reg32(tcg_target_ulong *regs, TCGReg index, uint32_t value)
 {
@@ -585,6 +591,8 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
             break;
         case INDEX_op_ld8s_i32:
+            TODO();
+            break;
         case INDEX_op_ld16u_i32:
             TODO();
             break;
@@ -854,7 +862,14 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
             break;
         case INDEX_op_ld8s_i64:
+            TODO();
+            break;
         case INDEX_op_ld16u_i64:
+            t0 = *tb_ptr++;
+            t1 = tci_read_r(regs, &tb_ptr);
+            t2 = tci_read_s32(&tb_ptr);
+            tci_write_reg16(regs, t0, *(uint16_t *)(t1 + t2));
+            break;
         case INDEX_op_ld16s_i64:
             TODO();
             break;
-- 
2.20.1
