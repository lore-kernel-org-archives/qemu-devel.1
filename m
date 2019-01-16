Received: from eggs.gnu.org ([209.51.188.92]:49777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjbnJ-00030d-Lr
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjbZH-0002vG-2U
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:08:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gjbZG-0002sx-LB
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:08:38 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 16 Jan 2019 11:08:13 +0800
Message-Id: <20190116030815.27273-3-peterx@redhat.com>
In-Reply-To: <20190116030815.27273-1-peterx@redhat.com>
References: <20190116030815.27273-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] intel_iommu: reset intr_enabled when
 system reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

This is found when I was debugging another problem.  Until now no bug
is reported with this but we'd better reset the IR status correctly
after a system reset.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6d5cc1d039..ee22e754f0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3138,6 +3138,7 @@ static void vtd_init(IntelIOMMUState *s)
     s->root = 0;
     s->root_extended = false;
     s->dmar_enabled = false;
+    s->intr_enabled = false;
     s->iq_head = 0;
     s->iq_tail = 0;
     s->iq = 0;
-- 
2.17.1
