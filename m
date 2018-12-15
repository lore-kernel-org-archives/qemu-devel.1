Received: from eggs.gnu.org ([2001:4830:134:3::10]:38717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hN-0005ge-GY
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hI-0007nq-Eo
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:37 -0500
Received: from m12-12.163.com ([220.181.12.12]:34490)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hH-0007k2-Ev
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:32 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 15 Dec 2018 04:03:51 -0800
Message-Id: <20181215120353.82786-2-liq3ea@163.com>
In-Reply-To: <20181215120353.82786-1-liq3ea@163.com>
References: <20181215120353.82786-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 1/3] tests: vhost-user-test: initialize 'fd'
 in chr_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, mst@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Currently when processing VHOST_USER_SET_VRING_CALL
if 'qemu_chr_fe_get_msgfds' get no fd, the 'fd' will
be a stack uninitialized value.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/vhost-user-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 45d58d8ea2..86039e61e0 100644
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
2.17.1
