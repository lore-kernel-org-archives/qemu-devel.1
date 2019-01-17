Received: from eggs.gnu.org ([209.51.188.92]:57660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk675-0006IU-9q
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk674-0005Za-D8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk671-0005T6-GU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:45:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:48 +0400
Message-Id: <20190117114359.5164-17-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/27] slirp: remove qemu timer.h dependency
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/util.h     | 2 ++
 slirp/if.c       | 1 -
 slirp/ip6_icmp.c | 1 -
 slirp/slirp.c    | 1 -
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/slirp/util.h b/slirp/util.h
index e3332cdcd60..4664e8159ba 100644
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
diff --git a/slirp/if.c b/slirp/if.c
index 73e3705740f..90b9078687f 100644
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
index e72c57a81dc..682597e6762 100644
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
index 9e38d3f8cb3..8067b624eaf 100644
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
--=20
2.20.1.98.gecbdaf0899
