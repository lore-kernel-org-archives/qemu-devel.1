Received: from eggs.gnu.org ([2001:4830:134:3::10]:52652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kF-0007vy-TY
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k9-0004Gd-5b
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:31 +1100
Message-Id: <20170202051445.5735-94-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 093/107] target/ppc: Add pcr_supported to POWER9
 cpu class definition
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

pcr_supported is used to define the supported PCR values for a given
processor. A POWER9 processor can support 3.00, 2.07, 2.06 and 2.05
compatibility modes, thus we set this accordingly.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h            | 1 +
 target/ppc/translate_init.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4d72d75..bc2a2ce 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2290,6 +2290,7 @@ enum {
     PCR_COMPAT_2_05     = 1ull << (63-62),
     PCR_COMPAT_2_06     = 1ull << (63-61),
     PCR_COMPAT_2_07     = 1ull << (63-60),
+    PCR_COMPAT_3_00     = 1ull << (63-59),
     PCR_VEC_DIS         = 1ull << (63-0), /* Vec. disable (bit NA since POWER8) */
     PCR_VSX_DIS         = 1ull << (63-1), /* VSX disable (bit NA since POWER8) */
     PCR_TM_DIS          = 1ull << (63-2), /* Trans. memory disable (POWER8) */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 388a3e8..c7f7624 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8797,6 +8797,8 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     dc->props = powerpc_servercpu_properties;
     pcc->pvr_match = ppc_pvr_match_power9;
     pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07;
+    pcc->pcr_supported = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
+                         PCR_COMPAT_2_05;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
     pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
-- 
2.9.3
