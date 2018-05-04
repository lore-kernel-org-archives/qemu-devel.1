Received: from eggs.gnu.org ([2001:4830:134:3::10]:38828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fEWZ8-0002mJ-PH
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fEWZ5-0004mo-Pk
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:59:46 -0400
Message-Id: <39f72851afe39e24596a4aa328f4e9672cd37fd8.1525423550.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1525423550.git.balaton@eik.bme.hu>
References: <cover.1525423550.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 04 May 2018 10:45:50 +0200
Subject: [Qemu-devel] [PATCH] ppc440_pcix: Fix a typo in setting a register
 (Coverity CID1390577)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_pcix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index b1307e6..d8af04b 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -257,7 +257,7 @@ static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
         break;
     case PCIX0_PIM2SAL:
         s->pim[2].sa &= 0xffffffff00000000ULL;
-        s->pim[2].sa = val;
+        s->pim[2].sa |= val;
         ppc440_pcix_update_pim(s, 2);
         break;
     case PCIX0_PIM2LAL:
-- 
2.7.6
