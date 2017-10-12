Received: from eggs.gnu.org ([2001:4830:134:3::10]:45596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dKo-0004zo-TV
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dKl-00078z-27
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:15:34 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:15 +0300
Message-Id: <cdf8272cbea126258594f775ce11755d2aca8073.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 01/31] qcow2: Fix documentation of
 get_cluster_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

This function has not been returning the offset of the L2 table since
commit 3948d1d4876065160583e79533bf604481063833

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0e5aec81cb..b926549816 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -640,8 +640,7 @@ fail:
  * for a given disk offset, load (and allocate if needed)
  * the l2 table.
  *
- * the l2 table offset in the qcow2 file and the cluster index
- * in the l2 table are given to the caller.
+ * the cluster index in the l2 table is given to the caller.
  *
  * Returns 0 on success, -errno in failure case
  */
-- 
2.11.0
