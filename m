Received: from eggs.gnu.org ([2001:4830:134:3::10]:58181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zs-000130-HV
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8zr-0002U0-Lu
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fk8zr-00029y-Da
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:18:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fk8ze-0004Ew-Pf
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:17:50 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 15:17:43 +0100
Message-Id: <20180730141748.430-2-peter.maydell@linaro.org>
In-Reply-To: <20180730141748.430-1-peter.maydell@linaro.org>
References: <20180730141748.430-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/6] arm/smmuv3: Fix missing VMSD terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The 'vmstate_smmuv3_queue' is missing the end-of-list marker.

Fixes: 10a83cb9887
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20180727135406.15132-1-dgilbert@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: dropped stray blank line]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 39fbcbf577c..bb6a24e9b84 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1414,6 +1414,7 @@ static const VMStateDescription vmstate_smmuv3_queue = {
         VMSTATE_UINT32(prod, SMMUQueue),
         VMSTATE_UINT32(cons, SMMUQueue),
         VMSTATE_UINT8(log2size, SMMUQueue),
+        VMSTATE_END_OF_LIST(),
     },
 };
 
-- 
2.17.1
