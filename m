Received: from eggs.gnu.org ([2001:4830:134:3::10]:33377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gH7nb-000677-LI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gH7nb-0007TK-2S
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:41:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 29 Oct 2018 13:41:22 +0000
Message-Id: <20181029134123.3365-2-stefanha@redhat.com>
In-Reply-To: <20181029134123.3365-1-stefanha@redhat.com>
References: <20181029134123.3365-1-stefanha@redhat.com>
Subject: [Qemu-devel] [0 1/2] util: aio-posix: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Li Qiang <liq3ea@gmail.com>, qemu-trivial@nongnu.org

From: Li Qiang <liq3ea@gmail.com>

Cc: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 1538964972-3223-1-git-send-email-liq3ea@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 621b3025d8..51c41ed3c9 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -40,7 +40,7 @@ struct AioHandler
 
 #ifdef CONFIG_EPOLL_CREATE1
 
-/* The fd number threashold to switch to epoll */
+/* The fd number threshold to switch to epoll */
 #define EPOLL_ENABLE_THRESHOLD 64
 
 static void aio_epoll_disable(AioContext *ctx)
-- 
2.17.2
