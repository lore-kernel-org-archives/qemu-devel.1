Received: from eggs.gnu.org ([2001:4830:134:3::10]:39411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaGE-0004yq-KS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaGD-0003lI-H3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:21:27 -0300
Message-Id: <20180606152128.449-11-f4bug@amsat.org>
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] RISC-V: Add trailing '\n' to qemu_log()
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/riscv/op_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 3abf52453c..aec7558e1b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -293,7 +293,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         if ((val_to_write & 3) == 0) {
             env->stvec = val_to_write >> 2 << 2;
         } else {
-            qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported");
+            qemu_log_mask(LOG_UNIMP,
+                          "CSR_STVEC: vectored traps not supported\n");
         }
         break;
     case CSR_SCOUNTEREN:
@@ -320,7 +321,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         if ((val_to_write & 3) == 0) {
             env->mtvec = val_to_write >> 2 << 2;
         } else {
-            qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported");
+            qemu_log_mask(LOG_UNIMP,
+                          "CSR_MTVEC: vectored traps not supported\n");
         }
         break;
     case CSR_MCOUNTEREN:
-- 
2.17.1
