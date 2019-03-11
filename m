Received: from eggs.gnu.org ([209.51.188.92]:34413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qb2-0004H6-1A
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007WE-67
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:35216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007TU-L4
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:54 +0100
Message-Id: <20190311191602.25796-4-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/11] target/hppa: report ITLB_EXCP_MISS for
 ITLB misses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/mem_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f30824f4e1..07ecfaf092 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -96,9 +96,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     if (ent == NULL || !ent->entry_valid) {
         phys = 0;
         prot = 0;
-        /* ??? Unconditionally report data tlb miss,
-           even if this is an instruction fetch.  */
-        ret = EXCP_DTLB_MISS;
+        ret = (type == PAGE_EXEC) ? EXCP_ITLB_MISS : EXCP_DTLB_MISS;
         goto egress;
     }
 
-- 
2.20.1
