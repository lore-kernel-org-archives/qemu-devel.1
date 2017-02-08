Received: from eggs.gnu.org ([2001:4830:134:3::10]:38148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cbVgY-00033V-OH
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cbVgW-0005v8-4C
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:05:38 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed,  8 Feb 2017 12:05:33 -0500
Message-Id: <20170208170533.28822-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] ide: remove undefined behavior in ide-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

trivial: initialize the dirty buffer with a random-ish byte.
Stops valgrind from whining about uninitialized buffers.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/ide-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 2fa97bc..139ebc0 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -550,6 +550,7 @@ static void make_dirty(uint8_t device)
 
     guest_buf = guest_alloc(guest_malloc, len);
     buf = g_malloc(len);
+    memset(buf, rand() % 255 + 1, len);
     g_assert(guest_buf);
     g_assert(buf);
 
-- 
2.9.3
