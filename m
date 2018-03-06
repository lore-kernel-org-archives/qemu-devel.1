Received: from eggs.gnu.org ([2001:4830:134:3::10]:49175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3no-0001OP-Ch
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nk-0004NH-7b
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:26 +1100
Message-Id: <20180306040154.3669-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/30] ppc440_uc: Fix unintialized variable
 warning with older gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 4e2523a64f..976ab2b5d8 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1050,6 +1050,9 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
     case DCRN_PCIE1_BASE:
         id = 1;
         break;
+    default:
+        error_setg(errp, "invalid PCIe DCRN base");
+        return;
     }
     snprintf(buf, sizeof(buf), "pcie%d-io", id);
     memory_region_init(&s->iomem, OBJECT(s), buf, UINT64_MAX);
-- 
2.14.3
