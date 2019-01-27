Received: from eggs.gnu.org ([209.51.188.92]:52857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCQ-0001bG-Tp
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCN-0007hJ-I2
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:06 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCN-0007Se-0i
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:06:03 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:19 +0100
Message-Id: <20190127120526.15457-25-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/31] slirp: replace remaining qemu headers
 dependency
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

Except for the migration code which is gated by WITH_QEMU, only
include our own headers, so libslirp can be built standalone.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/arp_table.c  |  1 -
 slirp/bootp.c      |  1 -
 slirp/cksum.c      |  1 -
 slirp/dhcpv6.c     |  1 -
 slirp/dnssearch.c  |  1 -
 slirp/if.c         |  1 -
 slirp/ip6_icmp.c   |  1 -
 slirp/ip6_input.c  |  1 -
 slirp/ip6_output.c |  2 --
 slirp/ip_icmp.c    |  1 -
 slirp/ip_input.c   |  1 -
 slirp/ip_output.c  |  1 -
 slirp/mbuf.c       |  1 -
 slirp/misc.c       |  2 --
 slirp/ncsi.c       |  1 -
 slirp/ndp_table.c  |  2 --
 slirp/sbuf.c       |  1 -
 slirp/slirp.c      |  2 --
 slirp/socket.c     |  2 --
 slirp/tcp_input.c  |  1 -
 slirp/tcp_output.c |  1 -
 slirp/tcp_subr.c   |  1 -
 slirp/tcp_timer.c  |  1 -
 slirp/tftp.c       |  6 ++++--
 slirp/udp.c        |  1 -
 slirp/udp6.c       |  2 --
 slirp/util.h       | 21 +++++++++++++++++++++
 27 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/slirp/arp_table.c b/slirp/arp_table.c
index bf71b984ad..8ea655f79d 100644
--- a/slirp/arp_table.c
+++ b/slirp/arp_table.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 void arp_table_add(Slirp *slirp, uint32_t ip_addr, uint8_t ethaddr[ETH_A=
LEN])
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 4c9a77eb98..d396849a05 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -21,7 +21,6 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 #if defined(_WIN32)
diff --git a/slirp/cksum.c b/slirp/cksum.c
index 84c858fafb..25bfa67348 100644
--- a/slirp/cksum.c
+++ b/slirp/cksum.c
@@ -30,7 +30,6 @@
  * in_cksum.c,v 1.2 1994/08/02 07:48:16 davidg Exp
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 /*
diff --git a/slirp/dhcpv6.c b/slirp/dhcpv6.c
index e27d9a46f8..9ffba38e8f 100644
--- a/slirp/dhcpv6.c
+++ b/slirp/dhcpv6.c
@@ -20,7 +20,6 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
 #include "dhcpv6.h"
=20
diff --git a/slirp/dnssearch.c b/slirp/dnssearch.c
index 8fb563321b..c459cece8d 100644
--- a/slirp/dnssearch.c
+++ b/slirp/dnssearch.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 static const uint8_t RFC3397_OPT_DOMAIN_SEARCH =3D 119;
diff --git a/slirp/if.c b/slirp/if.c
index 90b9078687..2ad03b8a79 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -5,7 +5,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 static void
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index b3b7e50a31..2a432ebbd4 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -3,7 +3,6 @@
  * Guillaume Subiron, Yann Bordenave, Serigne Modou Wagne.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip6_icmp.h"
=20
diff --git a/slirp/ip6_input.c b/slirp/ip6_input.c
index ab656a0a9d..1b8c003c66 100644
--- a/slirp/ip6_input.c
+++ b/slirp/ip6_input.c
@@ -3,7 +3,6 @@
  * Guillaume Subiron, Yann Bordenave, Serigne Modou Wagne.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip6_icmp.h"
=20
diff --git a/slirp/ip6_output.c b/slirp/ip6_output.c
index 52c88ad691..19d1ae7748 100644
--- a/slirp/ip6_output.c
+++ b/slirp/ip6_output.c
@@ -3,8 +3,6 @@
  * Guillaume Subiron, Yann Bordenave, Serigne Modou Wagne.
  */
=20
-#include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "slirp.h"
=20
 /* Number of packets queued before we start sending
diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 19e247f773..6b6344b776 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -30,7 +30,6 @@
  * ip_icmp.c,v 1.7 1995/05/30 08:09:42 rgrimes Exp
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip_icmp.h"
=20
diff --git a/slirp/ip_input.c b/slirp/ip_input.c
index d360620838..774ce662e6 100644
--- a/slirp/ip_input.c
+++ b/slirp/ip_input.c
@@ -38,7 +38,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip_icmp.h"
=20
diff --git a/slirp/ip_output.c b/slirp/ip_output.c
index db403f04c1..f6ec141df5 100644
--- a/slirp/ip_output.c
+++ b/slirp/ip_output.c
@@ -38,7 +38,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 /* Number of packets queued before we start sending
diff --git a/slirp/mbuf.c b/slirp/mbuf.c
index d8d275e0e7..521c02c967 100644
--- a/slirp/mbuf.c
+++ b/slirp/mbuf.c
@@ -15,7 +15,6 @@
  * the flags
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 #define MBUF_THRESH 30
diff --git a/slirp/misc.c b/slirp/misc.c
index a77cc34b30..4662071be0 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -5,9 +5,7 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
-#include "libslirp.h"
=20
 inline void
 insque(void *a, void *b)
diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index 8594382270..327f17543c 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -6,7 +6,6 @@
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
  */
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 #include "ncsi-pkt.h"
diff --git a/slirp/ndp_table.c b/slirp/ndp_table.c
index b7b73722f7..34ea4fdf1f 100644
--- a/slirp/ndp_table.c
+++ b/slirp/ndp_table.c
@@ -3,8 +3,6 @@
  * Guillaume Subiron, Yann Bordenave, Serigne Modou Wagne.
  */
=20
-#include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "slirp.h"
=20
 void ndp_table_add(Slirp *slirp, struct in6_addr ip_addr,
diff --git a/slirp/sbuf.c b/slirp/sbuf.c
index c83e4dd8ed..51a9f0cc7d 100644
--- a/slirp/sbuf.c
+++ b/slirp/sbuf.c
@@ -5,7 +5,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 static void sbappendsb(struct sbuf *sb, struct mbuf *m);
diff --git a/slirp/slirp.c b/slirp/slirp.c
index ec1f606d72..730b78255c 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -21,8 +21,6 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
-#include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "slirp.h"
=20
 #ifdef WITH_QEMU
diff --git a/slirp/socket.c b/slirp/socket.c
index 2e8dc22fb6..dea201f5ce 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -5,8 +5,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "slirp.h"
 #include "ip_icmp.h"
 #ifdef __sun__
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 7c1fe18fec..864da7d857 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -38,7 +38,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip_icmp.h"
=20
diff --git a/slirp/tcp_output.c b/slirp/tcp_output.c
index 6dd1ecf5d9..2b4335eb34 100644
--- a/slirp/tcp_output.c
+++ b/slirp/tcp_output.c
@@ -38,7 +38,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 static const u_char  tcp_outflags[TCP_NSTATES] =3D {
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index d8846a33b0..879a7dcd29 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -38,7 +38,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 /* patchable/settable parameters for tcp */
diff --git a/slirp/tcp_timer.c b/slirp/tcp_timer.c
index a843e57a2b..703907eb37 100644
--- a/slirp/tcp_timer.c
+++ b/slirp/tcp_timer.c
@@ -30,7 +30,6 @@
  * tcp_timer.c,v 1.2 1994/08/02 07:49:10 davidg Exp
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
=20
 static struct tcpcb *tcp_timers(register struct tcpcb *tp, int timer);
diff --git a/slirp/tftp.c b/slirp/tftp.c
index 5c31886190..2d8f978786 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -22,9 +22,11 @@
  * THE SOFTWARE.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
-#include "qemu-common.h"
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
=20
 static inline int tftp_session_in_use(struct tftp_session *spt)
 {
diff --git a/slirp/udp.c b/slirp/udp.c
index 3915971b50..ac42be0d8e 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -38,7 +38,6 @@
  * terms and conditions of the copyright.
  */
=20
-#include "qemu/osdep.h"
 #include "slirp.h"
 #include "ip_icmp.h"
=20
diff --git a/slirp/udp6.c b/slirp/udp6.c
index fa531e03c4..be5cba1f54 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -3,8 +3,6 @@
  * Guillaume Subiron
  */
=20
-#include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "slirp.h"
 #include "udp.h"
 #include "dhcpv6.h"
diff --git a/slirp/util.h b/slirp/util.h
index ef75804560..4963747aef 100644
--- a/slirp/util.h
+++ b/slirp/util.h
@@ -48,6 +48,27 @@
 # define SLIRP_PACKED __attribute__((packed))
 #endif
=20
+#ifndef DIV_ROUND_UP
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+#endif
+
+#ifndef container_of
+#define container_of(ptr, type, member) __extension__ ({    \
+    void *__mptr =3D (void *)(ptr);               \
+    ((type *)(__mptr - offsetof(type, member))); })
+#endif
+
+#if defined(_WIN32) /* CONFIG_IOVEC */
+# if !defined(IOV_MAX) /* XXX: to avoid duplicate with QEMU osdep.h */
+struct iovec {
+    void *iov_base;
+    size_t iov_len;
+};
+# endif
+#else
+#include <sys/uio.h>
+#endif
+
 #define SCALE_MS 1000000
=20
 #define ETH_ALEN    6
--=20
2.20.1
