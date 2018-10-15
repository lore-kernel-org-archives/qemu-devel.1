Received: from eggs.gnu.org ([2001:4830:134:3::10]:45641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXC-0004Vk-Bi
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX9-0004Jj-7W
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByX8-0004Hu-ST
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:27 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:19 +0800
Message-Id: <1539593186-32183-20-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 19/26] docs: Add COLO status diagram to
 COLO-FT.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <chen.zhang@intel.com>

This diagram make user better understand COLO.
Suggested by Markus Armbruster.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 docs/COLO-FT.txt | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index 70cfb9c..6302469 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -110,6 +110,40 @@ Note:
 HeartBeat has not been implemented yet, so you need to trigger failover process
 by using 'x-colo-lost-heartbeat' command.
 
+== COLO operation status ==
+
++-----------------+
+|                 |
+|    Start COLO   |
+|                 |
++--------+--------+
+         |
+         |  Main qmp command:
+         |  migrate-set-capabilities with x-colo
+         |  migrate
+         |
+         v
++--------+--------+
+|                 |
+|  COLO running   |
+|                 |
++--------+--------+
+         |
+         |  Main qmp command:
+         |  x-colo-lost-heartbeat
+         |  or
+         |  some error happened
+         v
++--------+--------+
+|                 |  send qmp event:
+|  COLO failover  |  COLO_EXIT
+|                 |
++-----------------+
+
+COLO use the qmp command to switch and report operation status.
+The diagram just shows the main qmp command, you can get the detail
+in test procedure.
+
 == Test procedure ==
 1. Startup qemu
 Primary:
-- 
2.5.0
