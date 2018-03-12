Received: from eggs.gnu.org ([2001:4830:134:3::10]:50642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evNPI-0007gO-MI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evNPH-0004Un-Ox
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:22:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 12 Mar 2018 13:22:04 +0000
Message-Id: <20180312132204.23683-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: add include/block/aio-wait.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The include/block/aio-wait.h header file was added by commit
7719f3c968c59e1bcda7e177679dc765b59e578f ("block: extract
AIO_WAIT_WHILE() from BlockDriverState") without updating MAINTAINERS.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f409f3b158..7adc04e477 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1331,6 +1331,7 @@ F: util/aio-*.c
 F: block/io.c
 F: migration/block*
 F: include/block/aio.h
+F: include/block/aio-wait.h
 F: scripts/qemugdb/aio.py
 T: git git://github.com/stefanha/qemu.git block
 
-- 
2.14.3
