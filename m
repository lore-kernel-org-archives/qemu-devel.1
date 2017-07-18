Received: from eggs.gnu.org ([2001:4830:134:3::10]:51651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dXVKi-0000ZW-Cz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dXVKh-00013I-4T
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:26:48 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 17:26:31 +0100
Message-Id: <1500395194-21455-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10 1/4] bsd-user/mmap.c: Move __thread
 attribute to right place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

Avoid a compiler warning on OpenBSD:
bsd-user/mmap.c:28:1: warning: '__thread' is not at beginning of declaration [-Wold-style-declaration]
by moving the __thread attribute to its proper place.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 bsd-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 7f2018e..20cd29d 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -25,7 +25,7 @@
 //#define DEBUG_MMAP
 
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
-static int __thread mmap_lock_count;
+static __thread int mmap_lock_count;
 
 void mmap_lock(void)
 {
-- 
2.7.4
