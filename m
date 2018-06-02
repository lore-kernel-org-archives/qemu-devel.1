Received: from eggs.gnu.org ([2001:4830:134:3::10]:39042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fP2Hw-00014w-0B
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fP2Hs-0007Ak-3K
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:53:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fP2Hr-00076l-VW
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:53:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat,  2 Jun 2018 09:52:59 +0100
Message-Id: <20180602085259.17853-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] main-loop: document IOCanReadHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jusual@mail.ru, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/main-loop.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 6b4b60bf6d..721aa2416a 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -168,6 +168,20 @@ void qemu_del_wait_object(HANDLE handle, WaitObjectFunc *func, void *opaque);
 /* async I/O support */
 
 typedef void IOReadHandler(void *opaque, const uint8_t *buf, int size);
+
+/**
+ * IOCanReadHandler: Return the number of bytes that #IOReadHandler can accept
+ *
+ * This function reports how many bytes #IOReadHandler is prepared to accept.
+ * #IOReadHandler may be invoked with up to this number of bytes.  If this
+ * function returns 0 then #IOReadHandler is not invoked.
+ *
+ * This function is typically called from an event loop.  If the number of
+ * bytes changes outside the event loop (e.g. because a vcpu thread drained the
+ * buffer), then it is necessary to kick the event loop so that this function
+ * is called again.  aio_notify() or qemu_notify_event() can be used to kick
+ * the event loop.
+ */
 typedef int IOCanReadHandler(void *opaque);
 
 /**
-- 
2.17.0
