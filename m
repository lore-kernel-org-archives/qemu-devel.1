Received: from eggs.gnu.org ([209.51.188.92]:44715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4p-0005YC-Gw
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4j-0007NR-1I
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4g-0007Lp-U8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:32 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:01:57 +0100
Message-Id: <1547460140-1473-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 02/25] tests: vhost-user-test: initialize 'fd'
 in chr_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Currently when processing VHOST_USER_SET_VRING_CALL
if 'qemu_chr_fe_get_msgfds' get no fd, the 'fd' will
be a stack uninitialized value.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vhost-user-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 54982f6..84e50d8 100644
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
1.8.3.1
