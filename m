Received: from eggs.gnu.org ([2001:4830:134:3::10]:34285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4wPX-0000Sr-EX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4wPU-0003o9-5M
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:01:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 18 Oct 2017 18:01:41 -0400
Message-Id: <1508364103-16131-3-git-send-email-cota@braap.org>
In-Reply-To: <1508364103-16131-1-git-send-email-cota@braap.org>
References: <1508364103-16131-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/4] linux-user: fix 'finshed' typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9d4cc4c..47b4a79 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6231,7 +6231,7 @@ static void *clone_func(void *arg)
     pthread_mutex_lock(&info->mutex);
     pthread_cond_broadcast(&info->cond);
     pthread_mutex_unlock(&info->mutex);
-    /* Wait until the parent has finshed initializing the tls state.  */
+    /* Wait until the parent has finished initializing the tls state.  */
     pthread_mutex_lock(&clone_lock);
     pthread_mutex_unlock(&clone_lock);
     cpu_loop(env);
-- 
2.7.4
