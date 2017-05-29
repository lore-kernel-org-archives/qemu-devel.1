Received: from eggs.gnu.org ([2001:4830:134:3::10]:59380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Oj-0000GR-LE
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Og-0006HC-Gr
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dF8Og-0006Fv-BB
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:58 -0400
Date: Mon, 29 May 2017 03:18:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496017081-24032-10-git-send-email-mst@redhat.com>
References: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496017081-24032-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 09/13] intel_iommu: turn off pt before 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Peter Xu <peterx@redhat.com>

This is for compatibility.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
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
MST
