Received: from eggs.gnu.org ([2001:4830:134:3::10]:60354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ersXY-0004We-1C
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ersXU-0000Yo-Vz
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:48:32 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 2 Mar 2018 22:43:23 +0100
Message-Id: <20180302214826.1671E7456D8@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] ppc440_uc: Fix unintialized variable warning
 with older gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 4e2523a..976ab2b 100644
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
2.7.6
