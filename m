Received: from eggs.gnu.org ([2001:4830:134:3::10]:54373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6k5-0004D6-0M
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6k1-0003oe-6g
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:29 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6k1-0003oI-1J
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:25 -0400
Received: by mail-pg0-x242.google.com with SMTP id e1-v6so6431881pga.6
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:37:24 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:15 +1200
Message-Id: <1525563325-62963-11-git-send-email-mjc@sifive.com>
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/20] RISC-V: Remove EM_RISCV ELF_MACHINE
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Pointless indirection. Other ports use EM_ constants directly.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c | 2 +-
 hw/riscv/sifive_u.c | 2 +-
 hw/riscv/spike.c    | 2 +-
 hw/riscv/virt.c     | 2 +-
 target/riscv/cpu.h  | 1 -
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 22dc526713c2..6fa223818502 100644
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
index 5bb495ab9a6c..84afed4c3b0e 100644
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
index 44eab94e17ef..9e18c618bfbb 100644
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
index 88b9ad509315..7ef9ba26debc 100644
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
index 41e06ac0f91d..9871e6feb1de 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -34,7 +34,6 @@
 
 #define TCG_GUEST_DEFAULT_MO 0
 
-#define ELF_MACHINE EM_RISCV
 #define CPUArchState struct CPURISCVState
 
 #include "qemu-common.h"
-- 
2.7.0
