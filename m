Received: from eggs.gnu.org ([209.51.188.92]:57471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1grkHV-00027L-1q
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1grkHS-00010V-4u
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:03:56 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1grkHR-0000yk-7V
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:03:53 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Feb 2019 16:03:05 +0200
Message-Id: <20190207140316.16103-22-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190207140316.16103-1-samuel.thibault@ens-lyon.org>
References: <20190207140316.16103-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv4 21/32] slirp: replace net/eth.h inclusion with
 own defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip6.h   |  1 -
 slirp/slirp.h |  1 -
 slirp/util.h  | 10 ++++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/slirp/ip6.h b/slirp/ip6.h
index 1e3e329ce6..4e7c366505 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -7,7 +7,6 @@
 #define SLIRP_IP6_H
=20
 #include <glib.h>
-#include "net/eth.h"
=20
 #define ALLNODES_MULTICAST  { .s6_addr =3D \
                             { 0xff, 0x02, 0x00, 0x00,\
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 5707805be2..c9f9143801 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -48,7 +48,6 @@ typedef char *caddr_t;
 #include "util.h"
=20
 #include "qemu/queue.h"
-#include "net/eth.h"
=20
 #include "libslirp.h"
 #include "ip.h"
diff --git a/slirp/util.h b/slirp/util.h
index 4664e8159b..ef75804560 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -50,6 +50,16 @@
=20
 #define SCALE_MS 1000000
=20
+#define ETH_ALEN    6
+#define ETH_HLEN    14
+#define ETH_P_IP                  (0x0800)      /* Internet Protocol pac=
ket  */
+#define ETH_P_ARP                 (0x0806)      /* Address Resolution pa=
cket */
+#define ETH_P_IPV6                (0x86dd)
+#define ETH_P_VLAN                (0x8100)
+#define ETH_P_DVLAN               (0x88a8)
+#define ETH_P_NCSI                (0x88f8)
+#define ETH_P_UNKNOWN             (0xffff)
+
 #ifdef _WIN32
 int slirp_closesocket(int fd);
 int slirp_ioctlsocket(int fd, int req, void *val);
--=20
2.20.1
