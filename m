Received: from eggs.gnu.org ([2001:4830:134:3::10]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fa8YL-0008UK-Nq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fa8YL-0007HJ-2L
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fa8YK-0007GX-TN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:17 -0400
Date: Tue, 3 Jul 2018 02:48:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180702234631.12268-3-mst@redhat.com>
References: <20180702234631.12268-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702234631.12268-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] hw/i386: Fix AMDVI GATS and HATS encodings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

We support up to 6 levels, but those are encoded as 10b according to the
AMD IOMMU spec (chapter 3.3.1, Extended Feature Register).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
