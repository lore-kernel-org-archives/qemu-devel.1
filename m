Received: from eggs.gnu.org ([2001:4830:134:3::10]:55383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0000WS-FH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVB-0003GF-PR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:58 +0100
Message-Id: <9848848136be0af6e4c2c7a51effd88fbd8e6126.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 30/32] qcow2: Rename l2_table in
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

This function doesn't need any changes to support L2 slices, but since
it's now dealing with slices intead of full tables, the l2_table
variable is renamed for clarity.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index b40a2e32e0..d3be86afa4 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1008,12 +1008,12 @@ err:
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
