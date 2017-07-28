Received: from eggs.gnu.org ([2001:4830:134:3::10]:35479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2W-0002UH-OL
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2V-00025X-Q1
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:26:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 27 Jul 2017 22:25:38 -0300
Message-Id: <20170728012542.29975-5-f4bug@amsat.org>
In-Reply-To: <20170728012542.29975-1-f4bug@amsat.org>
References: <20170728012542.29975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 4/8] docs: fix broken paths to
 docs/devel/atomics.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 docs/devel/lockcnt.txt | 2 +-
 include/qemu/atomic.h  | 4 ++--
 tcg/README             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/devel/lockcnt.txt b/docs/devel/lockcnt.txt
index 2a79b3205b..7c099bc6c8 100644
--- a/docs/devel/lockcnt.txt
+++ b/docs/devel/lockcnt.txt
@@ -145,7 +145,7 @@ can also be more efficient in two ways:
 - on some platforms, one can implement QemuLockCnt to hold the lock
   and the mutex in a single word, making the fast path no more expensive
   than simply managing a counter using atomic operations (see
-  docs/atomics.txt).  This can be very helpful if concurrent access to
+  docs/devel/atomics.txt).  This can be very helpful if concurrent access to
   the data structure is expected to be rare.
 
 
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index e07c7972ab..b6b62fb771 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -8,7 +8,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  *
- * See docs/atomics.txt for discussion about the guarantees each
+ * See docs/devel/atomics.txt for discussion about the guarantees each
  * atomic primitive is meant to provide.
  */
 
@@ -427,7 +427,7 @@
  * sequentially consistent operations.
  *
  * As long as they are used as paired operations they are safe to
- * use. See docs/atomic.txt for more discussion.
+ * use. See docs/devel/atomics.txt for more discussion.
  */
 
 #ifndef atomic_mb_read
diff --git a/tcg/README b/tcg/README
index bf49e8242b..03bfb6acd4 100644
--- a/tcg/README
+++ b/tcg/README
@@ -446,7 +446,7 @@ when MTTCG is enabled.
 The guest translators should generate this opcode for all guest instructions
 which have ordering side effects.
 
-Please see docs/atomics.txt for more information on memory barriers.
+Please see docs/devel/atomics.txt for more information on memory barriers.
 
 ********* 64-bit guest on 32-bit host support
 
-- 
2.13.3
