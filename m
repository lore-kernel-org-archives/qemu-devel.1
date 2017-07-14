Received: from eggs.gnu.org ([2001:4830:134:3::10]:36981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dW0gj-0007nq-2G
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dW0ge-0001WV-6l
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:31:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dW0gd-0001Vq-UA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:31:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 14 Jul 2017 14:31:11 +0100
Message-Id: <20170714133111.27359-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] trace: update old trace events in docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wang Dong <dongdwdw@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

Commit c5f1ad429cdf26023cf331075a7d327708e3db6d ("block: Remove
bdrv_aio_readv/writev/flush()") removed
bdrv_aio_readv()/bdrv_aio_writev() so the example in the tracing
documentation is no longer valid.

Reported-by: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/tracing.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 8c0029b..5768a0b 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -14,8 +14,7 @@ for debugging, profiling, and observing execution.
 
 2. Create a file with the events you want to trace:
 
-   echo bdrv_aio_readv   > /tmp/events
-   echo bdrv_aio_writev >> /tmp/events
+   echo memory_region_ops_read >/tmp/events
 
 3. Run the virtual machine to produce a trace file:
 
-- 
2.9.4
