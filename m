Received: from eggs.gnu.org ([2001:4830:134:3::10]:51921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDw-0006fA-7P
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDt-0006QB-4q
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:34 +0300
Message-Id: <429cc0d31f5a5063caedc4567b97999c7191374e.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/14] os-posix: Drop misleading comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Markus Armbruster <armbru@redhat.com>

Comments explaining why we include a header tend to go bad.  This
one's almost comical: not only doesn't qemu-options.hx use
MAP_POPULATE anymore (since commit ef36fa1, v2.0.0, 2013), even the
include it applies to got moved away in commit 02d0e09 (v2.7.0).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 os-posix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/os-posix.c b/os-posix.c
index 92e9d85215..b9c2343b1e 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include <sys/wait.h>
-/*needed for MAP_POPULATE before including qemu-options.h */
 #include <pwd.h>
 #include <grp.h>
 #include <libgen.h>
--=20
2.11.0
