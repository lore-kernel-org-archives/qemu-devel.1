Received: from eggs.gnu.org ([2001:4830:134:3::10]:50350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fYHHu-0004tp-F6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fYHHp-0007MJ-IP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:43:38 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:32843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fYHHp-0007LC-Bm
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:43:33 -0400
Received: by mail-pg0-x235.google.com with SMTP id e11-v6so1433594pgq.0
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:43:33 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 28 Jun 2018 04:41:36 +0800
Message-Id: <20180627204136.4177-21-zhangckid@gmail.com>
In-Reply-To: <20180627204136.4177-1-zhangckid@gmail.com>
References: <20180627204136.4177-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V9 20/20] docs: Add COLO status diagram to
 COLO-FT.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

This diagram make user better understand COLO.
Suggested by Markus Armbruster.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 docs/COLO-FT.txt | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index e289be2f41..caa68f0a9a 100644
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
+COLO use the qmp command switching and report operation status.
+The diagram just write the main qmp command, you can get the detail
+in test procedure.
+
 == Test procedure ==
 1. Startup qemu
 Primary:
-- 
2.17.GIT
