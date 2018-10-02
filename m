Received: from eggs.gnu.org ([2001:4830:134:3::10]:56050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7Ivn-0005YO-W5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7Ivl-00018j-C2
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  2 Oct 2018 14:33:25 +0300
Message-Id: <20181002113325.12911-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181002113325.12911-1-vsementsov@virtuozzo.com>
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] qapi: drop x- from
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
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com, jsnow@redhat.com

Libvirt part is ready, let's drop x- prefix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 4 ++--
 blockdev.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4efd60d8ab..e9c0079933 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -482,7 +482,7 @@
   'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
 
 ##
-# @x-block-latency-histogram-set:
+# @block-latency-histogram-set:
 #
 # Manage read, write and flush latency histograms for the device.
 #
@@ -548,7 +548,7 @@
 #      "arguments": { "device": "drive0" } }
 # <- { "return": {} }
 ##
-{ 'command': 'x-block-latency-histogram-set',
+{ 'command': 'block-latency-histogram-set',
   'data': {'*device': 'str', '*id': 'str',
            '*boundaries': ['uint64'],
            '*boundaries-read': ['uint64'],
diff --git a/blockdev.c b/blockdev.c
index 87f4ab3316..bc579d8f81 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4367,7 +4367,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     aio_context_release(old_context);
 }
 
-void qmp_x_block_latency_histogram_set(
+void qmp_block_latency_histogram_set(
     bool has_device, const char *device,
     bool has_id, const char *id,
     bool has_boundaries, uint64List *boundaries,
-- 
2.18.0
