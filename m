Received: from eggs.gnu.org ([2001:4830:134:3::10]:58218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVx-0004fz-Bp
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVw-0007ty-GG
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:01 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVw-0007s6-9E
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:00 -0500
Received: by mail-lf0-x244.google.com with SMTP id x68so11727188lff.0
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:22:00 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:37 +0200
Message-Id: <a4dd3d5172c951e05a7424f14c0f9372522b48f8.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 09/15] linux-user: fix 'finshed' typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9268c3ef69..84e123b67b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6258,7 +6258,7 @@ static void *clone_func(void *arg)
     pthread_mutex_lock(&info->mutex);
     pthread_cond_broadcast(&info->cond);
     pthread_mutex_unlock(&info->mutex);
-    /* Wait until the parent has finshed initializing the tls state.  */
+    /* Wait until the parent has finished initializing the tls state.  */
     pthread_mutex_lock(&clone_lock);
     pthread_mutex_unlock(&clone_lock);
     cpu_loop(env);
-- 
2.14.2
