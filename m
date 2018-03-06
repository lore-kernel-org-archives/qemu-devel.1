Received: from eggs.gnu.org ([2001:4830:134:3::10]:53523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJfO-0000la-Ab
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJfN-0002tc-Mb
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:34 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJfN-0002tU-H5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:33 -0500
Received: by mail-pl0-x242.google.com with SMTP id 9-v6so7070397ple.11
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:58:33 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:56:26 +1300
Message-Id: <1520369790-38306-17-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369790-38306-1-git-send-email-mjc@sifive.com>
References: <1520369790-38306-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 18/22] RISC-V: Remove braces from satp case
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
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
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
