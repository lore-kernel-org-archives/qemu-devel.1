Received: from eggs.gnu.org ([2001:4830:134:3::10]:42859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4Y-0000dL-56
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4X-0002Pw-3E
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:02 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:21 -0500
Message-Id: <20170313195547.21466-5-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/30] trace: Fix parameter types in block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/trace-events b/block/trace-events
index 0bc5c0a..acd12f9 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -57,7 +57,7 @@ paio_submit_co(int64_t offset, int count, int type) "offset %"PRId64" count %d t
 paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"

 # block/qcow2.c
-qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset %" PRIx64 " bytes %d"
+qcow2_writev_start_req(void *co, int64_t offset, uint64_t bytes) "co %p offset %" PRIx64 " bytes %"PRIu64
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
 qcow2_writev_start_part(void *co) "co %p"
 qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
@@ -69,7 +69,7 @@ qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset %" PRIx64
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset %" PRIx64 " bytes %d"
 qcow2_handle_copied(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " bytes %" PRIx64
 qcow2_handle_alloc(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " bytes %" PRIx64
-qcow2_do_alloc_clusters_offset(void *co, uint64_t guest_offset, uint64_t host_offset, int nb_clusters) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " nb_clusters %d"
+qcow2_do_alloc_clusters_offset(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t nb_clusters) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " nb_clusters %" PRIu64
 qcow2_cluster_alloc_phys(void *co) "co %p"
 qcow2_cluster_link_l2(void *co, int nb_clusters) "co %p nb_clusters %d"

-- 
2.9.3
