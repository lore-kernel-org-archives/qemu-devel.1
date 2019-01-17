Received: from eggs.gnu.org ([209.51.188.92]:57729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk678-0006LZ-GD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk677-0005gm-Hl
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk677-0005eW-77
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:37 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:49 +0400
Message-Id: <20190117114359.5164-18-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/27] slirp: remove now useless QEMU headers
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
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Some of those could have been squashed earlier, but it is easier to do
it all here.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/slirp.h    | 1 -
 slirp/dhcpv6.c   | 1 -
 slirp/ip6_icmp.c | 2 --
 slirp/misc.c     | 2 --
 slirp/sbuf.c     | 1 -
 slirp/slirp.c    | 4 ----
 slirp/tftp.c     | 1 -
 7 files changed, 12 deletions(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 5a830ddcb86..5707805be22 100644
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
diff --git a/slirp/dhcpv6.c b/slirp/dhcpv6.c
index 752df405361..e27d9a46f84 100644
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
index 682597e6762..b3b7e50a311 100644
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
index 4ee20a10e44..a77cc34b305 100644
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
index 17f28e97a63..c83e4dd8ed1 100644
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
index 8067b624eaf..cfce82bbb5b 100644
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
diff --git a/slirp/tftp.c b/slirp/tftp.c
index f0bcc72c925..5c31886190f 100644
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
--=20
2.20.1.98.gecbdaf0899
