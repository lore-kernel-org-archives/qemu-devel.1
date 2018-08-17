Received: from eggs.gnu.org ([2001:4830:134:3::10]:50065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqj7A-0004mh-Nq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqj76-0006cH-0g
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 21:04:40 +0300
Message-Id: <20180817180440.49687-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180817180440.49687-1-vsementsov@virtuozzo.com>
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/3] not-for-commit: example of new command
 usage for debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/222 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 0ead56d574..c2e647fa83 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -137,6 +137,9 @@ with iotests.FilePath('base.img') as base_img_path, \
     log('--- Cleanup ---')
     log('')
 
+    from render_block_graph import render_block_graph
+    render_block_graph(vm, '/tmp/out.dot')
+    render_block_graph(vm, '/tmp/out.pointers.dot', pointers=True)
     log(vm.qmp('block-job-cancel', device=src_node))
     log(vm.event_wait('BLOCK_JOB_CANCELLED'),
         filters=[iotests.filter_qmp_event])
-- 
2.11.1
