Received: from eggs.gnu.org ([2001:4830:134:3::10]:45543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gL4zu-0006bJ-0A
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gL4zs-0000Fv-CB
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:30:45 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  9 Nov 2018 12:29:40 +0100
Message-Id: <20181109112957.10067-2-eric.auger@redhat.com>
In-Reply-To: <20181109112957.10067-1-eric.auger@redhat.com>
References: <20181109112957.10067-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v8 01/18] update-linux-headers: Import
 virtio_iommu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: kevin.tian@intel.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com

Update the script to update the virtio_iommu.h header.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 scripts/update-linux-headers.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe240..55fd271a32 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -159,6 +159,9 @@ fi
 cat <<EOF >$output/linux-headers/linux/virtio_config.h
 #include "standard-headers/linux/virtio_config.h"
 EOF
+cat <<EOF >$output/linux-headers/linux/virtio_iommu.h
+#include "standard-headers/linux/virtio_iommu.h"
+EOF
 cat <<EOF >$output/linux-headers/linux/virtio_ring.h
 #include "standard-headers/linux/virtio_ring.h"
 EOF
-- 
2.17.2
