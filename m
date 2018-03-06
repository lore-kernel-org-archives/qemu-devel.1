Received: from eggs.gnu.org ([2001:4830:134:3::10]:53397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJf4-0000Tp-UP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJf4-0002pc-8P
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:15 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJf4-0002pB-1v
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:14 -0500
Received: by mail-pl0-x242.google.com with SMTP id w22-v6so12292pll.2
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:58:13 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:56:20 +1300
Message-Id: <1520369790-38306-11-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369790-38306-1-git-send-email-mjc@sifive.com>
References: <1520369790-38306-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 12/22] RISC-V: Update E order and I
 extension order
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

Section 22.8 Subset Naming Convention of the RISC-V ISA Specification
defines the canonical order for extensions in the ISA string. It is
silent on the position of the E extension however E is a substitute
for I so it must come early in the extension list order. A comment
is added to state E and I are mutually exclusive, as the E extension
will be added to the RISC-V port in the future.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 2 +-
 target/riscv/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4851890..d2ae56a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -26,7 +26,7 @@
 
 /* RISC-V CPU definitions */
 
-static const char riscv_exts[26] = "IMAFDQECLBJTPVNSUHKORWXYZG";
+static const char riscv_exts[26] = "IEMAFDQCLBJTPVNSUHKORWXYZG";
 
 const char * const riscv_int_regnames[] = {
   "zero", "ra  ", "sp  ", "gp  ", "tp  ", "t0  ", "t1  ", "t2  ",
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index cff02a2..3a0ca2f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -71,6 +71,7 @@
 #define RV(x) ((target_ulong)1 << (x - 'A'))
 
 #define RVI RV('I')
+#define RVE RV('E') /* E and I are mutually exclusive */
 #define RVM RV('M')
 #define RVA RV('A')
 #define RVF RV('F')
-- 
2.7.0
