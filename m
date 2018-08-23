Received: from eggs.gnu.org ([2001:4830:134:3::10]:40821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fsrp9-0002jm-SX
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fsrp6-0007SE-KY
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:47:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 23 Aug 2018 18:46:55 +0300
Message-Id: <20180823154655.40188-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180823154655.40188-1-vsementsov@virtuozzo.com>
References: <20180823154655.40188-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 3/3] not-for-commit: example of new command
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
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/222 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 0ead56d574..91d88aa5c0 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -137,6 +137,8 @@ with iotests.FilePath('base.img') as base_img_path, \
     log('--- Cleanup ---')
     log('')
 
+    from render_block_graph import render_block_graph
+    render_block_graph(vm, '/tmp/out.dot')
     log(vm.qmp('block-job-cancel', device=src_node))
     log(vm.event_wait('BLOCK_JOB_CANCELLED'),
         filters=[iotests.filter_qmp_event])
-- 
2.18.0
