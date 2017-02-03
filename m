Received: from eggs.gnu.org ([2001:4830:134:3::10]:60862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZhKl-0004s0-0e
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZhKg-0002kX-Tp
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:07:39 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Feb 2017 09:07:29 -0800
Message-Id: <20170203170729.12399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] test-vmstate: remove yield_until_fd_readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

The function is not needed anymore now that migration is built on
top of QIOChannel.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-vmstate.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 9d87faf..0c2af4d 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -33,17 +33,6 @@
 static char temp_file[] = "/tmp/vmst.test.XXXXXX";
 static int temp_fd;
 
-/* Fake yield_until_fd_readable() implementation so we don't have to pull the
- * coroutine code as dependency.
- */
-void yield_until_fd_readable(int fd)
-{
-    fd_set fds;
-    FD_ZERO(&fds);
-    FD_SET(fd, &fds);
-    select(fd + 1, &fds, NULL, NULL, NULL);
-}
-
 
 /* Duplicate temp_fd and seek to the beginning of the file */
 static QEMUFile *open_test_file(bool write)
-- 
2.9.3
