Received: from eggs.gnu.org ([2001:4830:134:3::10]:52958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kN-00084k-3V
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kF-0004P1-Ij
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:40 +1100
Message-Id: <20170202051445.5735-103-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 102/107] target/ppc/debug: Print LPCR register
 value if register exists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

It can be useful when debugging to print the LPCR value.

Thus we add the LPCR to the "info registers" output if the register had
been defined.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 772929e..5934185 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6830,6 +6830,9 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     }
 #endif
 
+    if (env->spr_cb[SPR_LPCR].name)
+        cpu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
+
     switch (env->mmu_model) {
     case POWERPC_MMU_32B:
     case POWERPC_MMU_601:
-- 
2.9.3
