Received: from eggs.gnu.org ([208.118.235.92]:40193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eznke-0006er-Fz
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezngT-0003k4-LE
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:18:48 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezngT-0003jg-FR
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:14:29 -0400
Received: by mail-pl0-x241.google.com with SMTP id f5-v6so9367766plj.13
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:14:29 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:13:30 -0700
Message-Id: <1521915220-65389-5-git-send-email-mjc@sifive.com>
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 11/26] RISC-V: Update E order and I
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Section 22.8 Subset Naming Convention of the RISC-V ISA Specification
defines the canonical order for extensions in the ISA string. It is
silent on the position of the E extension however E is a substitute
for I so it must come early in the extension list order. A comment
is added to state E and I are mutually exclusive, as the E extension
will be added to the RISC-V port in the future.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 2 +-
 target/riscv/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9de34d7..ad65b39 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -26,7 +26,7 @@
 
 /* RISC-V CPU definitions */
 
-static const char riscv_exts[26] = "IMAFDQECLBJTPVNSUHKORWXYZG";
+static const char riscv_exts[26] = "IEMAFDQCLBJTPVNSUHKORWXYZG";
 
 const char * const riscv_int_regnames[] = {
   "zero", "ra  ", "sp  ", "gp  ", "tp  ", "t0  ", "t1  ", "t2  ",
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 41e06ac..1fdcd75 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -72,6 +72,7 @@
 #define RV(x) ((target_ulong)1 << (x - 'A'))
 
 #define RVI RV('I')
+#define RVE RV('E') /* E and I are mutually exclusive */
 #define RVM RV('M')
 #define RVA RV('A')
 #define RVF RV('F')
-- 
2.7.0
