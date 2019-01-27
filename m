Received: from eggs.gnu.org ([209.51.188.92]:52577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCD-0001PK-He
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCB-0007SW-Uu
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:53 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCB-0007Pg-Hp
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:14 +0100
Message-Id: <20190127120526.15457-20-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/31] slirp: remove qemu timer.h dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/if.c       | 1 -
 slirp/ip6_icmp.c | 1 -
 slirp/slirp.c    | 1 -
 slirp/util.h     | 2 ++
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/slirp/if.c b/slirp/if.c
index 73e3705740..90b9078687 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -7,7 +7,6 @@
=20
 #include "qemu/osdep.h"
 #include "slirp.h"
-#include "qemu/timer.h"
=20
 static void
 ifs_insque(struct mbuf *ifm, struct mbuf *ifmhead)
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index e72c57a81d..682597e676 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -6,7 +6,6 @@
 #include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip6_icmp.h"
-#include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index b5c4788489..7a5d97c77f 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "migration/register.h"
 #include "slirp.h"
diff --git a/slirp/util.h b/slirp/util.h
index 586517bb30..922077435e 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -48,6 +48,8 @@
 # define SLIRP_PACKED __attribute__((packed))
 #endif
=20
+#define SCALE_MS 1000000
+
 #ifdef _WIN32
 int slirp_closesocket(int fd);
 int slirp_ioctlsocket(int fd, int req, void *val);
--=20
2.20.1
