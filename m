Received: from eggs.gnu.org ([2001:4830:134:3::10]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CNc-0006HJ-Ua
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CNZ-0004d9-T2
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:52:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:32 +0300
Message-Id: <f3245d63a0df51184fdf12f483436329ef322d35.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/14] futex: add missing header guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: "Emilio G. Cota" <cota@braap.org>

The header file was introduced by fbcc3e5 ("qemu-thread: optimize QemuLoc=
kCnt
with futexes on Linux", 2017-01-16) without header guards. Add them.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qemu/futex.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index bb7dc9e296..91ae88966e 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -11,6 +11,9 @@
  *
  */
=20
+#ifndef QEMU_FUTEX_H
+#define QEMU_FUTEX_H
+
 #include <sys/syscall.h>
 #include <linux/futex.h>
=20
@@ -34,3 +37,5 @@ static inline void qemu_futex_wait(void *f, unsigned va=
l)
         }
     }
 }
+
+#endif /* QEMU_FUTEX_H */
--=20
2.11.0
