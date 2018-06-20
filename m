Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVf10-0000SQ-1A
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVf0v-00066P-4W
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:27:22 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Jun 2018 18:27:13 +0300
Message-Id: <20180620152713.27309-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] qapi: drop x- from
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, mreitz@redhat.com, armbru@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nshirokovskiy@virtuozzo.com

Libvirt part is ready, let's drop x- prefix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 4 ++--
 blockdev.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cc3ede0630..dfaa050651 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -483,7 +483,7 @@
   'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
 
 ##
-# @x-block-latency-histogram-set:
+# @block-latency-histogram-set:
 #
 # Manage read, write and flush latency histograms for the device.
 #
@@ -547,7 +547,7 @@
 #      "arguments": { "device": "drive0" } }
 # <- { "return": {} }
 ##
-{ 'command': 'x-block-latency-histogram-set',
+{ 'command': 'block-latency-histogram-set',
   'data': {'device': 'str',
            '*boundaries': ['uint64'],
            '*boundaries-read': ['uint64'],
diff --git a/blockdev.c b/blockdev.c
index 58d7570932..6d4ae77041 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4299,7 +4299,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     aio_context_release(old_context);
 }
 
-void qmp_x_block_latency_histogram_set(
+void qmp_block_latency_histogram_set(
     const char *device,
     bool has_boundaries, uint64List *boundaries,
     bool has_boundaries_read, uint64List *boundaries_read,
-- 
2.11.1
