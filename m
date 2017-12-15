Received: from eggs.gnu.org ([2001:4830:134:3::10]:55458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVG-0000Wd-4s
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003J6-TK
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:14 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:29 +0100
Message-Id: <cc1ca55a4f93a0eaf582286ce1f1f93b2a94d727.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 01/32] qcow2: Fix documentation of
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

This function has not been returning the offset of the L2 table since
commit 3948d1d4876065160583e79533bf604481063833

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a3fec27bf9..8163983d28 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -648,8 +648,7 @@ fail:
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
