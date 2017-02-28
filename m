Received: from eggs.gnu.org ([2001:4830:134:3::10]:42960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibX1-0001oJ-Ld
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibWy-0003E2-KY
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:45:07 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:49 +0300
Message-Id: <6048018ef6112476b529807ad603015314151bb2.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 06/14] ide: remove undefined behavior in ide-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: John Snow <jsnow@redhat.com>

trivial: initialize the dirty buffer with a random-ish byte.
Stops valgrind from whining about uninitialized buffers.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/ide-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index fb541f8..b57c2b1 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -544,6 +544,7 @@ static void make_dirty(uint8_t device)
 
     guest_buf = guest_alloc(guest_malloc, len);
     buf = g_malloc(len);
+    memset(buf, rand() % 255 + 1, len);
     g_assert(guest_buf);
     g_assert(buf);
 
-- 
2.1.4
