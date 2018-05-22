Received: from eggs.gnu.org ([2001:4830:134:3::10]:46290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fL1Oq-0002NK-Do
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fL1On-0002Vs-80
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:08:00 -0400
Received: from goliath.siemens.de ([192.35.17.28]:48557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1fL1Om-0002V6-T2
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:07:57 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fb84398b-f6c1-b18b-0db1-c22038309180@siemens.com>
Date: Tue, 22 May 2018 09:07:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] hw/i386: Fix AMDVI GATS and HATS encodings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

We support up to 6 levels, but those are encoded as 10b according to the
AMD IOMMU spec (chapter 3.3.1, Extended Feature Register).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/i386/amd_iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index aeef802364..874030582d 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -165,8 +165,8 @@
 #define AMDVI_DTE_UPPER_QUAD_RESERVED  0x08f0000000000000
 
 /* AMDVI paging mode */
-#define AMDVI_GATS_MODE                 (6ULL <<  12)
-#define AMDVI_HATS_MODE                 (6ULL <<  10)
+#define AMDVI_GATS_MODE                 (2ULL <<  12)
+#define AMDVI_HATS_MODE                 (2ULL <<  10)
 
 /* IOTLB */
 #define AMDVI_IOTLB_MAX_SIZE 1024
-- 
2.13.6
