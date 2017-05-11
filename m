Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAv-0002oJ-M8
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAu-00084x-Mj
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:50 +0200
Message-Id: <1494513181-7900-48-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 47/58] qcow2: Use consistent switch indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Fix a couple of inconsistent indentations, before an upcoming
patch further tweaks the switch statements.
(best viewed with 'git diff -b').

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170507000552.20847-3-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c  | 32 +++++++++----------
 block/qcow2-refcount.c | 84 +++++++++++++++++++++++++-------------------------
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 31077d8..335a505 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1504,25 +1504,25 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
          * but rather fall through to the backing file.
          */
         switch (qcow2_get_cluster_type(old_l2_entry)) {
-            case QCOW2_CLUSTER_UNALLOCATED:
-                if (full_discard || !bs->backing) {
-                    continue;
-                }
-                break;
+        case QCOW2_CLUSTER_UNALLOCATED:
+            if (full_discard || !bs->backing) {
+                continue;
+            }
+            break;
 
-            case QCOW2_CLUSTER_ZERO:
-                /* Preallocated zero clusters should be discarded in any case */
-                if (!full_discard && (old_l2_entry & L2E_OFFSET_MASK) == 0) {
-                    continue;
-                }
-                break;
+        case QCOW2_CLUSTER_ZERO:
+            /* Preallocated zero clusters should be discarded in any case */
+            if (!full_discard && (old_l2_entry & L2E_OFFSET_MASK) == 0) {
+                continue;
+            }
+            break;
 
-            case QCOW2_CLUSTER_NORMAL:
-            case QCOW2_CLUSTER_COMPRESSED:
-                break;
+        case QCOW2_CLUSTER_NORMAL:
+        case QCOW2_CLUSTER_COMPRESSED:
+            break;
 
-            default:
-                abort();
+        default:
+            abort();
         }
 
         /* First remove L2 entries */
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index db0af2c..908dbe5 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1128,61 +1128,61 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 offset = entry & L2E_OFFSET_MASK;
 
                 switch (qcow2_get_cluster_type(entry)) {
-                    case QCOW2_CLUSTER_COMPRESSED:
-                        nb_csectors = ((entry >> s->csize_shift) &
-                                       s->csize_mask) + 1;
-                        if (addend != 0) {
-                            ret = update_refcount(bs,
+                case QCOW2_CLUSTER_COMPRESSED:
+                    nb_csectors = ((entry >> s->csize_shift) &
+                                   s->csize_mask) + 1;
+                    if (addend != 0) {
+                        ret = update_refcount(bs,
                                 (entry & s->cluster_offset_mask) & ~511,
                                 nb_csectors * 512, abs(addend), addend < 0,
                                 QCOW2_DISCARD_SNAPSHOT);
-                            if (ret < 0) {
-                                goto fail;
-                            }
-                        }
-                        /* compressed clusters are never modified */
-                        refcount = 2;
-                        break;
-
-                    case QCOW2_CLUSTER_NORMAL:
-                    case QCOW2_CLUSTER_ZERO:
-                        if (offset_into_cluster(s, offset)) {
-                            qcow2_signal_corruption(bs, true, -1, -1, "Data "
-                                                    "cluster offset %#" PRIx64
-                                                    " unaligned (L2 offset: %#"
-                                                    PRIx64 ", L2 index: %#x)",
-                                                    offset, l2_offset, j);
-                            ret = -EIO;
+                        if (ret < 0) {
                             goto fail;
                         }
+                    }
+                    /* compressed clusters are never modified */
+                    refcount = 2;
+                    break;
+
+                case QCOW2_CLUSTER_NORMAL:
+                case QCOW2_CLUSTER_ZERO:
+                    if (offset_into_cluster(s, offset)) {
+                        qcow2_signal_corruption(bs, true, -1, -1, "Data "
+                                                "cluster offset %#" PRIx64
+                                                " unaligned (L2 offset: %#"
+                                                PRIx64 ", L2 index: %#x)",
+                                                offset, l2_offset, j);
+                        ret = -EIO;
+                        goto fail;
+                    }
 
-                        cluster_index = offset >> s->cluster_bits;
-                        if (!cluster_index) {
-                            /* unallocated */
-                            refcount = 0;
-                            break;
-                        }
-                        if (addend != 0) {
-                            ret = qcow2_update_cluster_refcount(bs,
+                    cluster_index = offset >> s->cluster_bits;
+                    if (!cluster_index) {
+                        /* unallocated */
+                        refcount = 0;
+                        break;
+                    }
+                    if (addend != 0) {
+                        ret = qcow2_update_cluster_refcount(bs,
                                     cluster_index, abs(addend), addend < 0,
                                     QCOW2_DISCARD_SNAPSHOT);
-                            if (ret < 0) {
-                                goto fail;
-                            }
-                        }
-
-                        ret = qcow2_get_refcount(bs, cluster_index, &refcount);
                         if (ret < 0) {
                             goto fail;
                         }
-                        break;
+                    }
 
-                    case QCOW2_CLUSTER_UNALLOCATED:
-                        refcount = 0;
-                        break;
+                    ret = qcow2_get_refcount(bs, cluster_index, &refcount);
+                    if (ret < 0) {
+                        goto fail;
+                    }
+                    break;
+
+                case QCOW2_CLUSTER_UNALLOCATED:
+                    refcount = 0;
+                    break;
 
-                    default:
-                        abort();
+                default:
+                    abort();
                 }
 
                 if (refcount == 1) {
-- 
1.8.3.1
