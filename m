Received: from eggs.gnu.org ([2001:4830:134:3::10]:53039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvM0-00060S-La
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvLv-0001v1-O4
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:48 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:09 +1100
Message-Id: <1484288903-18807-4-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 03/17] target/ppc: Add pcr_supported to
 POWER9 cpu class definition
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

pcr_supported is used to define the supported PCR values for a given
processor. A POWER9 processor can support 3.00, 2.07, 2.06 and 2.05
compatibility modes, thus we set this accordingly.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h            | 1 +
 target/ppc/translate_init.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2a50c43..afb7ddb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2250,6 +2250,7 @@ enum {
     PCR_COMPAT_2_05     = 1ull << (63-62),
     PCR_COMPAT_2_06     = 1ull << (63-61),
     PCR_COMPAT_2_07     = 1ull << (63-60),
+    PCR_COMPAT_3_00     = 1ull << (63-59),
     PCR_VEC_DIS         = 1ull << (63-0), /* Vec. disable (bit NA since POWER8) */
     PCR_VSX_DIS         = 1ull << (63-1), /* VSX disable (bit NA since POWER8) */
     PCR_TM_DIS          = 1ull << (63-2), /* Trans. memory disable (POWER8) */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 626e031..bfc1f24 100644
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
2.5.5
