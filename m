Received: from eggs.gnu.org ([2001:4830:134:3::10]:33795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpU-0001gD-R4
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpU-00008i-4H
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFIpT-00007H-Tt
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:36 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Nov 2017 12:59:19 +0100
Message-Id: <20171116115926.16627-5-pbonzini@redhat.com>
In-Reply-To: <20171116115926.16627-1-pbonzini@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/11] thread-posix: fix qemu_rec_mutex_trylock
 macro
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

We never noticed because it has no users.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1510273811-13419-1-git-send-email-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/thread-posix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index f4296d31c4..f3f47e426f 100644
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
2.14.3
