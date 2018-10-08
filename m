Received: from eggs.gnu.org ([2001:4830:134:3::10]:51624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9L5t-0002qI-9Y
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9L5p-0003Xs-Cm
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:16:25 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Sun,  7 Oct 2018 19:16:12 -0700
Message-Id: <1538964972-3223-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] util: aio-posix: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>

Cc: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 util/aio-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 621b302..51c41ed 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -40,7 +40,7 @@ struct AioHandler
 
 #ifdef CONFIG_EPOLL_CREATE1
 
-/* The fd number threashold to switch to epoll */
+/* The fd number threshold to switch to epoll */
 #define EPOLL_ENABLE_THRESHOLD 64
 
 static void aio_epoll_disable(AioContext *ctx)
-- 
1.8.3.1
