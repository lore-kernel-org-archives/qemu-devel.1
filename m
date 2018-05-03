Received: from eggs.gnu.org ([2001:4830:134:3::10]:57641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGU-00039N-Jx
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGT-0003Fu-F2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:42 -0400
Date: Thu, 3 May 2018 22:51:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-61-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 60/67] hw/s390x: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

This way they are easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/s390x/ccw-device.h        | 1 +
 include/hw/s390x/ipl.h               | 1 +
 include/hw/s390x/s390-pci-bus.h      | 1 +
 include/hw/s390x/s390-pci-inst.h     | 1 +
 include/hw/s390x/s390-virtio-hcall.h | 1 +
 include/hw/s390x/virtio-ccw.h        | 1 +
 6 files changed, 6 insertions(+)
 create mode 100644 include/hw/s390x/ccw-device.h
 create mode 100644 include/hw/s390x/ipl.h
 create mode 100644 include/hw/s390x/s390-pci-bus.h
 create mode 100644 include/hw/s390x/s390-pci-inst.h
 create mode 100644 include/hw/s390x/s390-virtio-hcall.h
 create mode 100644 include/hw/s390x/virtio-ccw.h

diff --git a/include/hw/s390x/ccw-device.h b/include/hw/s390x/ccw-device.h
new file mode 100644
index 0000000..ab761b3
--- /dev/null
+++ b/include/hw/s390x/ccw-device.h
@@ -0,0 +1 @@
+#include_next "../hw/s390x/ccw-device.h"
diff --git a/include/hw/s390x/ipl.h b/include/hw/s390x/ipl.h
new file mode 100644
index 0000000..21a3c5f
--- /dev/null
+++ b/include/hw/s390x/ipl.h
@@ -0,0 +1 @@
+#include_next "../hw/s390x/ipl.h"
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
new file mode 100644
index 0000000..67ead13
--- /dev/null
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -0,0 +1 @@
+#include_next "../hw/s390x/s390-pci-bus.h"
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
new file mode 100644
index 0000000..f4f0106
--- /dev/null
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -0,0 +1 @@
+#include_next "../hw/s390x/s390-pci-inst.h"
diff --git a/include/hw/s390x/s390-virtio-hcall.h b/include/hw/s390x/s390-virtio-hcall.h
new file mode 100644
index 0000000..4d7a2ed
--- /dev/null
+++ b/include/hw/s390x/s390-virtio-hcall.h
@@ -0,0 +1 @@
+#include_next "../hw/s390x/s390-virtio-hcall.h"
diff --git a/include/hw/s390x/virtio-ccw.h b/include/hw/s390x/virtio-ccw.h
new file mode 100644
index 0000000..4f22f9d
--- /dev/null
+++ b/include/hw/s390x/virtio-ccw.h
@@ -0,0 +1 @@
+#include_next "../hw/s390x/virtio-ccw.h"
-- 
MST
