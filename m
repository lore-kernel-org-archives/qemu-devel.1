Received: from eggs.gnu.org ([2001:4830:134:3::10]:55927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qx-0004YW-FM
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qu-000786-9F
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:07 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:39670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9Qu-00077g-3k
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:04 -0500
Received: by mail-pl0-x243.google.com with SMTP id s13-v6so4604663plq.6
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:15:04 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:40 +1300
Message-Id: <1520568765-58189-19-git-send-email-mjc@sifive.com>
In-Reply-To: <1520568765-58189-1-git-send-email-mjc@sifive.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 18/23] RISC-V: Remove braces from satp case
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
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

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
