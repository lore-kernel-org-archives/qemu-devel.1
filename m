Received: from eggs.gnu.org ([2001:4830:134:3::10]:53696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fj3CB-0004m0-2A
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fj3C7-0007XW-4R
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:54:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fj3C6-0007VA-VJ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:54:11 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 27 Jul 2018 14:54:06 +0100
Message-Id: <20180727135406.15132-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] arm/smmuv3: Fix missing VMSD terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, prem.mallappa@broadcom.com, peter.maydell@linaro.org, eric.auger@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The 'vmstate_smmuv3_queue' is missing the end-of-list marker.

Fixes: 10a83cb9887
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/arm/smmuv3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 39fbcbf577..40a86c1895 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1414,6 +1414,8 @@ static const VMStateDescription vmstate_smmuv3_queue = {
         VMSTATE_UINT32(prod, SMMUQueue),
         VMSTATE_UINT32(cons, SMMUQueue),
         VMSTATE_UINT8(log2size, SMMUQueue),
+
+        VMSTATE_END_OF_LIST(),
     },
 };
 
-- 
2.17.1
