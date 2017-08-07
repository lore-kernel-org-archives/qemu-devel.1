Received: from eggs.gnu.org ([2001:4830:134:3::10]:47749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpL-0005yI-Fv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpG-0005ht-No
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpG-0005h2-Jb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:18 -0400
Message-Id: <1502149958-23381-3-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 02/22] linux-user: fix 'finshed' typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bbf7913..b1e993f 100644
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
