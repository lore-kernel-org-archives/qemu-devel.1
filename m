Received: from eggs.gnu.org ([2001:4830:134:3::10]:53403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMY-0006Xt-3S
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMX-00025c-AU
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:22 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:20 +1100
Message-Id: <1484288903-18807-15-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 14/17] target/ppc/debug: Print LPCR
 register value if register exists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

It can be useful when debugging to print the LPCR value.

Thus we add the LPCR to the "info registers" output if the register had
been defined.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 521aed3..5d63254 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6910,6 +6910,9 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     }
 #endif
 
+    if (env->spr_cb[SPR_LPCR].name)
+        cpu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
+
     switch (env->mmu_model) {
     case POWERPC_MMU_32B:
     case POWERPC_MMU_601:
-- 
2.5.5
