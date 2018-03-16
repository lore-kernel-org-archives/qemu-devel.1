Received: from eggs.gnu.org ([2001:4830:134:3::10]:40408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFL-0007Yc-EG
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFK-0003pA-Ku
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:35 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewvFK-0003oo-FM
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:34 -0400
Received: by mail-pf0-x242.google.com with SMTP id d26so4547904pfn.5
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:42:34 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 12:41:15 -0700
Message-Id: <1521229281-73637-19-git-send-email-mjc@sifive.com>
In-Reply-To: <1521229281-73637-1-git-send-email-mjc@sifive.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 18/24] RISC-V: Remove braces from satp case
 statement
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

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/riscv/op_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index dd3e417..f79716a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -240,7 +240,7 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         csr_write_helper(env, next_mie, CSR_MIE);
         break;
     }
-    case CSR_SATP: /* CSR_SPTBR */ {
+    case CSR_SATP: /* CSR_SPTBR */
         if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
             break;
         }
@@ -258,7 +258,6 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
             env->satp = val_to_write;
         }
         break;
-    }
     case CSR_SEPC:
         env->sepc = val_to_write;
         break;
-- 
2.7.0
