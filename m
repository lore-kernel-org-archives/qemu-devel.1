Received: from eggs.gnu.org ([209.51.188.92]:33629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxJ-0006Nw-6Z
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxH-0002QU-9v
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxG-00026M-Qg
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:59 -0500
Date: Tue, 15 Jan 2019 15:04:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-6-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 05/49] tests: vhost-user-test: initialize
 'fd' in chr_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Li Qiang <liq3ea@163.com>

Currently when processing VHOST_USER_SET_VRING_CALL
if 'qemu_chr_fe_get_msgfds' get no fd, the 'fd' will
be a stack uninitialized value.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/vhost-user-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 54982f68e7..84e50d84e7 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -309,7 +309,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     CharBackend *chr = &s->chr;
     VhostUserMsg msg;
     uint8_t *p = (uint8_t *) &msg;
-    int fd;
+    int fd = -1;
 
     if (s->test_fail) {
         qemu_chr_fe_disconnect(chr);
-- 
MST
