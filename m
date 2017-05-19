Received: from eggs.gnu.org ([2001:4830:134:3::10]:35735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYTQ-0007Cf-EM
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYTP-0005kG-LL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBYTP-0005jm-8w
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:21:03 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 11:19:48 +0800
Message-Id: <1495163989-9994-10-git-send-email-peterx@redhat.com>
In-Reply-To: <1495163989-9994-1-git-send-email-peterx@redhat.com>
References: <1495163989-9994-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/10] intel_iommu: turn off pt before 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

This is for compatibility.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/compat.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 55b1765..4c53d60 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -6,6 +6,10 @@
         .driver   = "pci-bridge",\
         .property = "shpc",\
         .value    = "off",\
+    },{\
+        .driver   = "intel-iommu",\
+        .property = "pt",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_8 \
-- 
2.7.4
