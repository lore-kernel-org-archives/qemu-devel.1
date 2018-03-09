Received: from eggs.gnu.org ([2001:4830:134:3::10]:55847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qp-0004Q6-MJ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qo-00075X-HQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:59 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9Qo-00075E-AY
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:58 -0500
Received: by mail-pl0-x241.google.com with SMTP id v9-v6so4592915plp.12
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:14:58 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:38 +1300
Message-Id: <1520568765-58189-17-git-send-email-mjc@sifive.com>
In-Reply-To: <1520568765-58189-1-git-send-email-mjc@sifive.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 16/23] RISC-V: Remove EM_RISCV ELF_MACHINE
 indirection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Pointless indirection. Other ports use EM_ constants directly.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_e.c | 2 +-
 hw/riscv/sifive_u.c | 2 +-
 hw/riscv/spike.c    | 2 +-
 hw/riscv/virt.c     | 2 +-
 target/riscv/cpu.h  | 1 -
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 4872b68..39e4cb4 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -88,7 +88,7 @@ static uint64_t load_kernel(const char *kernel_filename)
 
     if (load_elf(kernel_filename, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
-                 0, ELF_MACHINE, 1, 0) < 0) {
+                 0, EM_RISCV, 1, 0) < 0) {
         error_report("qemu: could not load kernel '%s'", kernel_filename);
         exit(1);
     }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 57b4f4f..0e633a0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -74,7 +74,7 @@ static uint64_t load_kernel(const char *kernel_filename)
 
     if (load_elf(kernel_filename, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
-                 0, ELF_MACHINE, 1, 0) < 0) {
+                 0, EM_RISCV, 1, 0) < 0) {
         error_report("qemu: could not load kernel '%s'", kernel_filename);
         exit(1);
     }
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index c7d937b..70e697c 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -64,7 +64,7 @@ static uint64_t load_kernel(const char *kernel_filename)
     uint64_t kernel_entry, kernel_high;
 
     if (load_elf_ram_sym(kernel_filename, NULL, NULL,
-            &kernel_entry, NULL, &kernel_high, 0, ELF_MACHINE, 1, 0,
+            &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0,
             NULL, true, htif_symbol_callback) < 0) {
         error_report("qemu: could not load kernel '%s'", kernel_filename);
         exit(1);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d680cbd..e3f8bb7 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -68,7 +68,7 @@ static uint64_t load_kernel(const char *kernel_filename)
 
     if (load_elf(kernel_filename, NULL, NULL,
                  &kernel_entry, NULL, &kernel_high,
-                 0, ELF_MACHINE, 1, 0) < 0) {
+                 0, EM_RISCV, 1, 0) < 0) {
         error_report("qemu: could not load kernel '%s'", kernel_filename);
         exit(1);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3a0ca2f..7c4482b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -34,7 +34,6 @@
 
 #define TCG_GUEST_DEFAULT_MO 0
 
-#define ELF_MACHINE EM_RISCV
 #define CPUArchState struct CPURISCVState
 
 #include "qemu-common.h"
-- 
2.7.0
