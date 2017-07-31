Received: from eggs.gnu.org ([2001:4830:134:3::10]:55822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc84X-00062o-Ko
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc84U-0006w9-JK
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:37:13 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:41 +0300
Message-Id: <b208ac07ea8455878bba250796be38dbe58066db.1501496350.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/25] docs: fix broken paths to
 docs/devel/atomics.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

With the move of some docs/ to docs/devel/ on ac06724a71,
a couple of references were not updated.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
+  docs/devel/atomics.txt).  This can be very helpful if concurrent acces=
s to
   the data structure is expected to be rare.
=20
=20
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index e07c7972ab..b6b62fb771 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -8,7 +8,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  *
- * See docs/atomics.txt for discussion about the guarantees each
+ * See docs/devel/atomics.txt for discussion about the guarantees each
  * atomic primitive is meant to provide.
  */
=20
@@ -427,7 +427,7 @@
  * sequentially consistent operations.
  *
  * As long as they are used as paired operations they are safe to
- * use. See docs/atomic.txt for more discussion.
+ * use. See docs/devel/atomics.txt for more discussion.
  */
=20
 #ifndef atomic_mb_read
diff --git a/tcg/README b/tcg/README
index bf49e8242b..03bfb6acd4 100644
--- a/tcg/README
+++ b/tcg/README
@@ -446,7 +446,7 @@ when MTTCG is enabled.
 The guest translators should generate this opcode for all guest instruct=
ions
 which have ordering side effects.
=20
-Please see docs/atomics.txt for more information on memory barriers.
+Please see docs/devel/atomics.txt for more information on memory barrier=
s.
=20
 ********* 64-bit guest on 32-bit host support
=20
--=20
2.11.0
