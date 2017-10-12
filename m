Received: from eggs.gnu.org ([2001:4830:134:3::10]:43004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dGG-00017a-Lk
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dGF-0001Dr-Nv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:10:52 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:44 +0300
Message-Id: <dc90db7e9ed182418bb77958e84a7cf2930f409b.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 30/31] qcow2: Rename l2_table in
 count_cow_clusters()
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

This function doesn't need any changes to support L2 slices, but since
it's now dealing with slices intead of full tables, the l2_table
variable is renamed for clarity.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index bc94467733..465140b388 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -999,12 +999,12 @@ err:
  * which must copy from the backing file)
  */
 static int count_cow_clusters(BDRVQcow2State *s, int nb_clusters,
-    uint64_t *l2_table, int l2_index)
+    uint64_t *l2_slice, int l2_index)
 {
     int i;
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t l2_entry = be64_to_cpu(l2_table[l2_index + i]);
+        uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
         QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
 
         switch(cluster_type) {
-- 
2.11.0
