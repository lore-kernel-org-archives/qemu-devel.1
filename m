Received: from eggs.gnu.org ([2001:4830:134:3::10]:44783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqLx4-0007L7-59
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqLx3-0001cW-EK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:20:50 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 16 Aug 2018 20:20:27 +0300
Message-Id: <1534440027-10528-5-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
References: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] not-for-commit: example of new command
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
 tests/qemu-iotests/222 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 0ead56d574..6e2d96cd72 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -137,6 +137,7 @@ with iotests.FilePath('base.img') as base_img_path, \
     log('--- Cleanup ---')
     log('')
 
+    vm.render_block_graph('/tmp/out.dot')
     log(vm.qmp('block-job-cancel', device=src_node))
     log(vm.event_wait('BLOCK_JOB_CANCELLED'),
         filters=[iotests.filter_qmp_event])
-- 
2.11.1
