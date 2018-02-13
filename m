Received: from eggs.gnu.org ([2001:4830:134:3::10]:53350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2J-0003e5-Q7
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2I-0005qj-DY
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:25 +0100
Message-Id: <20180213170529.10858-52-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 51/55] qcow2: Rename l2_table in
 count_cow_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This function doesn't need any changes to support L2 slices, but since
it's now dealing with slices intead of full tables, the l2_table
variable is renamed for clarity.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 6107001fc79e6739242f1de7d191375e4f130aac.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 074a4aaf1e..e406b0f3b9 100644
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
2.13.6
