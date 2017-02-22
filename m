Received: from eggs.gnu.org ([2001:4830:134:3::10]:38105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVD-0003AK-8g
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVA-0008Ci-8I
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:15 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:32 +1100
Message-Id: <20170222063348.32176-28-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 27/43] target/ppc: Fix LPCR DPFD mask define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The DPFD field in the LPCR is 3 bits wide. This has always been defined
as 0x3 << shift which indicates a 2 bit field, which is incorrect.
Correct this.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bc2a2ce..bb96dd5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -381,7 +381,7 @@ struct ppc_slb_t {
 #define LPCR_ISL          (1ull << (63 - 2))
 #define LPCR_KBV          (1ull << (63 - 3))
 #define LPCR_DPFD_SHIFT   (63 - 11)
-#define LPCR_DPFD         (0x3ull << LPCR_DPFD_SHIFT)
+#define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
 #define LPCR_VRMASD_SHIFT (63 - 16)
 #define LPCR_VRMASD       (0x1full << LPCR_VRMASD_SHIFT)
 #define LPCR_RMLS_SHIFT   (63 - 37)
-- 
2.9.3
