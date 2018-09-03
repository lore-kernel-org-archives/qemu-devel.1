Received: from eggs.gnu.org ([2001:4830:134:3::10]:56667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwghI-0003EU-Tn
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwghI-0006Fm-3U
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:42:44 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:33336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fwghG-0006Ev-4A
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:42:43 -0400
Received: by mail-pg1-x52b.google.com with SMTP id s7-v6so999219pgc.0
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 21:42:40 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon,  3 Sep 2018 12:39:00 +0800
Message-Id: <20180903043900.28592-20-zhangckid@gmail.com>
In-Reply-To: <20180903043900.28592-1-zhangckid@gmail.com>
References: <20180903043900.28592-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V12 19/19] docs: Add COLO status diagram to
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

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 docs/COLO-FT.txt | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index d7c7dcda8f..d5007895d1 100644
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
