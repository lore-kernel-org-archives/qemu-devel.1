Received: from eggs.gnu.org ([2001:4830:134:3::10]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eCxD8-00031h-N0
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 19:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eCxD5-0005Eg-Jr
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 19:30:18 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41931)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eCxD5-0005Ay-7Z
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 19:30:15 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  9 Nov 2017 19:30:11 -0500
Message-Id: <1510273811-13419-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] thread-posix: fix qemu_rec_mutex_trylock macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

We never noticed because it has no users.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/thread-posix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index f4296d3..f3f47e4 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -7,7 +7,7 @@
 typedef QemuMutex QemuRecMutex;
 #define qemu_rec_mutex_destroy qemu_mutex_destroy
 #define qemu_rec_mutex_lock qemu_mutex_lock
-#define qemu_rec_mutex_try_lock qemu_mutex_try_lock
+#define qemu_rec_mutex_trylock qemu_mutex_trylock
 #define qemu_rec_mutex_unlock qemu_mutex_unlock
 
 struct QemuMutex {
-- 
2.7.4
