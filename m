Received: from eggs.gnu.org ([2001:4830:134:3::10]:35617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2h-0002fg-Gw
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2g-0002CY-K0
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:26:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 27 Jul 2017 22:25:42 -0300
Message-Id: <20170728012542.29975-9-f4bug@amsat.org>
In-Reply-To: <20170728012542.29975-1-f4bug@amsat.org>
References: <20170728012542.29975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 8/8] docs: fix broken paths to
 docs/spin/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/spin/aio_notify.promela        | 6 +++---
 docs/spin/aio_notify_accept.promela | 4 ++--
 docs/spin/aio_notify_bug.promela    | 4 ++--
 docs/spin/tcg-exclusive.promela     | 2 +-
 include/block/aio.h                 | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/docs/spin/aio_notify.promela b/docs/spin/aio_notify.promela
index fccc7ee1c3..a8f032560d 100644
--- a/docs/spin/aio_notify.promela
+++ b/docs/spin/aio_notify.promela
@@ -8,15 +8,15 @@
  * the WTFPL will do.
  *
  * To simulate it:
- *     spin -p docs/aio_notify.promela
+ *     spin -p docs/spin/aio_notify.promela
  *
  * To verify it:
- *     spin -a docs/aio_notify.promela
+ *     spin -a docs/spin/aio_notify.promela
  *     gcc -O2 pan.c
  *     ./a.out -a
  *
  * To verify it (with a bug planted in the model):
- *     spin -a -DBUG docs/aio_notify.promela
+ *     spin -a -DBUG docs/spin/aio_notify.promela
  *     gcc -O2 pan.c
  *     ./a.out -a
  */
diff --git a/docs/spin/aio_notify_accept.promela b/docs/spin/aio_notify_accept.promela
index 9cef2c955d..491f36a59c 100644
--- a/docs/spin/aio_notify_accept.promela
+++ b/docs/spin/aio_notify_accept.promela
@@ -8,13 +8,13 @@
  * the WTFPL will do.
  *
  * To verify the buggy version:
- *     spin -a -DBUG1 docs/aio_notify_bug.promela
+ *     spin -a -DBUG1 docs/spin/aio_notify_bug.promela
  *     gcc -O2 pan.c
  *     ./a.out -a -f
  * (or -DBUG2)
  *
  * To verify the fixed version:
- *     spin -a docs/aio_notify_bug.promela
+ *     spin -a docs/spin/aio_notify_bug.promela
  *     gcc -O2 pan.c
  *     ./a.out -a -f
  *
diff --git a/docs/spin/aio_notify_bug.promela b/docs/spin/aio_notify_bug.promela
index b3bfca1ca4..49c69cee3d 100644
--- a/docs/spin/aio_notify_bug.promela
+++ b/docs/spin/aio_notify_bug.promela
@@ -8,12 +8,12 @@
  * the WTFPL will do.
  *
  * To verify the buggy version:
- *     spin -a -DBUG docs/aio_notify_bug.promela
+ *     spin -a -DBUG docs/spin/aio_notify_bug.promela
  *     gcc -O2 pan.c
  *     ./a.out -a -f
  *
  * To verify the fixed version:
- *     spin -a docs/aio_notify_bug.promela
+ *     spin -a docs/spin/aio_notify_bug.promela
  *     gcc -O2 pan.c
  *     ./a.out -a -f
  *
diff --git a/docs/spin/tcg-exclusive.promela b/docs/spin/tcg-exclusive.promela
index c91cfca9f7..50a084c5c4 100644
--- a/docs/spin/tcg-exclusive.promela
+++ b/docs/spin/tcg-exclusive.promela
@@ -9,7 +9,7 @@
  * the WTFPL will do.
  *
  * To verify it:
- *     spin -a docs/tcg-exclusive.promela
+ *     spin -a docs/spin/tcg-exclusive.promela
  *     gcc pan.c -O2
  *     ./a.out -a
  *
diff --git a/include/block/aio.h b/include/block/aio.h
index e9aeeaec94..386d7f24dc 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -104,7 +104,7 @@ struct AioContext {
      *
      * Note that event_notifier_set *cannot* be optimized the same way.  For
      * more information on the problem that would result, see "#ifdef BUG2"
-     * in the docs/aio_notify_accept.promela formal model.
+     * in the docs/spin/aio_notify_accept.promela formal model.
      */
     bool notified;
     EventNotifier notifier;
-- 
2.13.3
