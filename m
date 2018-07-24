Received: from eggs.gnu.org ([2001:4830:134:3::10]:35684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhwGv-00052T-Q5
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhwGu-0006HA-JC
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:33 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Tue, 24 Jul 2018 15:17:51 +0300
Message-Id: <20180724121753.5753-3-lbloch@janustech.com>
In-Reply-To: <20180724121753.5753-1-lbloch@janustech.com>
References: <20180724121753.5753-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/4] docs: Fix an inaccuracy due to recent
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 docs/qcow2-cache.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 8a09a5cc5f..a0a1267482 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -97,9 +97,9 @@ need:
    l2_cache_size = disk_size_GB * 131072
    refcount_cache_size = disk_size_GB * 32768
 
-QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
-cache of 256KB (262144 bytes), so using the formulas we've just seen
-we have
+QEMU has a default L2 cache of 1MB (1048576 bytes) or 8 clusters (whichever
+is larger) and a refcount cache of 256KB (262144 bytes), so using the
+formulas we've just seen we have (assuming the L2 cache is 1MB):
 
    1048576 / 131072 = 8 GB of virtual disk covered by that cache
     262144 /  32768 = 8 GB
-- 
2.14.1
