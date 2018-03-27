Received: from eggs.gnu.org ([2001:4830:134:3::10]:51513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0pnA-0007xJ-LF
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0pn8-0000zW-E2
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f0pn8-0000zK-AJ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 27 Mar 2018 15:41:24 +0100
Message-Id: <20180327144124.32533-5-stefanha@redhat.com>
In-Reply-To: <20180327144124.32533-1-stefanha@redhat.com>
References: <20180327144124.32533-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] MAINTAINERS: add include/block/aio-wait.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The include/block/aio-wait.h header file was added by commit
7719f3c968c59e1bcda7e177679dc765b59e578f ("block: extract
AIO_WAIT_WHILE() from BlockDriverState") without updating MAINTAINERS.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180312132204.23683-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6fa36c7a2d..24b70169bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1351,6 +1351,7 @@ F: util/aio-*.c
 F: block/io.c
 F: migration/block*
 F: include/block/aio.h
+F: include/block/aio-wait.h
 F: scripts/qemugdb/aio.py
 T: git git://github.com/stefanha/qemu.git block
 
-- 
2.14.3
