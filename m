Received: from eggs.gnu.org ([2001:4830:134:3::10]:42961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gYnQ5-00048a-0e
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gYnNa-00030i-Ox
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:31:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gYnNa-000302-If
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:31:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEFFEC0524FB
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 07:31:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Dec 2018 15:31:13 +0800
Message-Id: <20181217073114.11984-5-peterx@redhat.com>
In-Reply-To: <20181217073114.11984-1-peterx@redhat.com>
References: <20181217073114.11984-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] intel_iommu: remove "x-" prefix for
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

We're going to have 57bits aw-bits support sooner.  It's possibly time
to remove the "x-" prefix.

Signed-off-by: Peter Xu <peterx@redhat.com>
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
2.17.1
