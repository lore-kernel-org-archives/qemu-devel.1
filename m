Received: from eggs.gnu.org ([2001:4830:134:3::10]:55206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6qX-0006So-4l
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6oH-0005KI-9q
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:23:33 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:22:54 +0200
Message-Id: <20180901142312.11662-3-eric.auger@redhat.com>
In-Reply-To: <20180901142312.11662-1-eric.auger@redhat.com>
References: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 02/20] update-linux-headers: Import iommu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, cdall@kernel.org, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com

Update the script to import the new iommu.h uapi header.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe240..3f11e49758 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -125,7 +125,7 @@ done
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-for header in kvm.h vfio.h vfio_ccw.h vhost.h \
+for header in kvm.h vfio.h iommu.h vfio_ccw.h vhost.h \
               psci.h psp-sev.h userfaultfd.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
-- 
2.17.1
