Received: from eggs.gnu.org ([2001:4830:134:3::10]:58026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Mb0-0006qV-Ko
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Mav-0001V3-PR
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:03:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8Mav-0001Ul-KQ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:03:37 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 10 May 2017 16:01:54 +0800
Message-Id: <1494403315-12760-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1494403315-12760-1-git-send-email-peterx@redhat.com>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/12] intel_iommu: turn off pt before 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

This is for compatibility.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/compat.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 846b90e..ff08ec8 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,11 @@
 #define HW_COMPAT_H
 
 #define HW_COMPAT_2_9 \
-    /* empty */
+    {\
+        .driver   = "intel-iommu",\
+        .property = "pt",\
+        .value    = "off",\
+    },
 
 #define HW_COMPAT_2_8 \
     {\
-- 
2.7.4
