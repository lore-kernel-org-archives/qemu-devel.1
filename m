Received: from eggs.gnu.org ([209.51.188.92]:52799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCO-0001Xc-Ht
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCN-0007gW-3d
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:04 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCM-0007Ri-IQ
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:02 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:15 +0100
Message-Id: <20190127120526.15457-21-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/31] slirp: remove now useless QEMU headers
 inclusions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Some of those could have been squashed earlier, but it is easier to do
it all here.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/dhcpv6.c   | 1 -
 slirp/ip6_icmp.c | 2 --
 slirp/misc.c     | 2 --
 slirp/sbuf.c     | 1 -
 slirp/slirp.c    | 4 ----
 slirp/slirp.h    | 1 -
 slirp/tftp.c     | 1 -
 slirp/util.h     | 2 --
 8 files changed, 14 deletions(-)

diff --git a/slirp/dhcpv6.c b/slirp/dhcpv6.c
index 752df40536..e27d9a46f8 100644
--- a/slirp/dhcpv6.c
+++ b/slirp/dhcpv6.c
@@ -21,7 +21,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu/log.h"
 #include "slirp.h"
 #include "dhcpv6.h"
=20
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 682597e676..b3b7e50a31 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -6,8 +6,6 @@
 #include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip6_icmp.h"
-#include "qemu/error-report.h"
-#include "qemu/log.h"
=20
 #define NDP_Interval g_rand_int_range(slirp->grand, \
         NDP_MinRtrAdvInterval, NDP_MaxRtrAdvInterval)
diff --git a/slirp/misc.c b/slirp/misc.c
index 4ee20a10e4..a77cc34b30 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -8,8 +8,6 @@
 #include "qemu/osdep.h"
 #include "slirp.h"
 #include "libslirp.h"
-#include "qemu/error-report.h"
-#include "qemu/main-loop.h"
=20
 inline void
 insque(void *a, void *b)
diff --git a/slirp/sbuf.c b/slirp/sbuf.c
index 17f28e97a6..c83e4dd8ed 100644
--- a/slirp/sbuf.c
+++ b/slirp/sbuf.c
@@ -7,7 +7,6 @@
=20
 #include "qemu/osdep.h"
 #include "slirp.h"
-#include "qemu/main-loop.h"
=20
 static void sbappendsb(struct sbuf *sb, struct mbuf *m);
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 7a5d97c77f..ec1f606d72 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -23,11 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qemu/error-report.h"
-#include "migration/register.h"
 #include "slirp.h"
-#include "hw/hw.h"
-#include "qemu/cutils.h"
=20
 #ifdef WITH_QEMU
 #include "state.h"
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 5a830ddcb8..5707805be2 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -48,7 +48,6 @@ typedef char *caddr_t;
 #include "util.h"
=20
 #include "qemu/queue.h"
-#include "qemu/sockets.h"
 #include "net/eth.h"
=20
 #include "libslirp.h"
diff --git a/slirp/tftp.c b/slirp/tftp.c
index f0bcc72c92..5c31886190 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "slirp.h"
 #include "qemu-common.h"
-#include "qemu/cutils.h"
=20
 static inline int tftp_session_in_use(struct tftp_session *spt)
 {
diff --git a/slirp/util.h b/slirp/util.h
index 922077435e..4664e8159b 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -53,9 +53,7 @@
 #ifdef _WIN32
 int slirp_closesocket(int fd);
 int slirp_ioctlsocket(int fd, int req, void *val);
-#ifndef WITH_QEMU
 int inet_aton(const char *cp, struct in_addr *ia);
-#endif
 #define slirp_getsockopt(sockfd, level, optname, optval, optlen) \
     getsockopt(sockfd, level, optname, (void *)optval, optlen)
 #define slirp_setsockopt(sockfd, level, optname, optval, optlen)        =
\
--=20
2.20.1
