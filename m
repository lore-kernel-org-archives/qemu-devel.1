Received: from eggs.gnu.org ([2001:4830:134:3::10]:37804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAO-00073O-5D
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAN-0008UK-4S
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:20 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:46757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAM-0008R8-MZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:19 -0400
Received: by mail-wr0-x231.google.com with SMTP id t6-v6so6664887wrq.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:14 +0200
Message-Id: <1530216310-52873-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/60] main-loop: document IOCanReadHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180602085259.17853-1-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/main-loop.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 6b4b60b..721aa24 100644
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
1.8.3.1
