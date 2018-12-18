Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pp-0005q8-L1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pm-0007ZS-H2
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ6pm-0007Yk-Aq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:18 -0500
Date: Mon, 17 Dec 2018 23:18:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-22-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 21/31] intel_iommu: remove "x-" prefix for
 "aw-bits"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

We're going to have 57bits aw-bits support sooner.  It's possibly time
to remove the "x-" prefix.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 26cc731c7b..96ef31eb7e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2656,7 +2656,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
-    DEFINE_PROP_UINT8("x-aw-bits", IntelIOMMUState, aw_bits,
+    DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
-- 
MST
