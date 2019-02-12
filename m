Received: from eggs.gnu.org ([209.51.188.92]:35737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtb2V-0005PF-6k
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtasW-0000y8-78
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtasU-0000bJ-3e
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:46 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Feb 2019 17:25:21 +0100
Message-Id: <20190212162524.31504-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190212162524.31504-1-marcandre.lureau@redhat.com>
References: <20190212162524.31504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/7] slirp: move sources to src/ subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, peter.maydell@linaro.org

Prepare for making slirp/ a standalone project.

Remove some useless includes while at it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/{ =3D> src}/bootp.h      |  0
 slirp/{ =3D> src}/debug.h      |  0
 slirp/{ =3D> src}/dhcpv6.h     |  0
 slirp/{ =3D> src}/if.h         |  0
 slirp/{ =3D> src}/ip.h         |  0
 slirp/{ =3D> src}/ip6.h        |  0
 slirp/{ =3D> src}/ip6_icmp.h   |  0
 slirp/{ =3D> src}/ip_icmp.h    |  0
 slirp/{ =3D> src}/libslirp.h   |  0
 slirp/{ =3D> src}/main.h       |  0
 slirp/{ =3D> src}/mbuf.h       |  0
 slirp/{ =3D> src}/misc.h       |  0
 slirp/{ =3D> src}/ncsi-pkt.h   |  0
 slirp/{ =3D> src}/qtailq.h     |  0
 slirp/{ =3D> src}/sbuf.h       |  0
 slirp/{ =3D> src}/slirp.h      |  0
 slirp/{ =3D> src}/socket.h     |  0
 slirp/{ =3D> src}/state.h      |  0
 slirp/{ =3D> src}/stream.h     |  0
 slirp/{ =3D> src}/tcp.h        |  0
 slirp/{ =3D> src}/tcp_timer.h  |  0
 slirp/{ =3D> src}/tcp_var.h    |  0
 slirp/{ =3D> src}/tcpip.h      |  0
 slirp/{ =3D> src}/tftp.h       |  0
 slirp/{ =3D> src}/udp.h        |  0
 slirp/{ =3D> src}/util.h       |  0
 slirp/{ =3D> src}/vmstate.h    |  0
 net/slirp.c                  |  2 +-
 slirp/{ =3D> src}/arp_table.c  |  0
 slirp/{ =3D> src}/bootp.c      |  0
 slirp/{ =3D> src}/cksum.c      |  0
 slirp/{ =3D> src}/dhcpv6.c     |  0
 slirp/{ =3D> src}/dnssearch.c  |  0
 slirp/{ =3D> src}/if.c         |  0
 slirp/{ =3D> src}/ip6_icmp.c   |  0
 slirp/{ =3D> src}/ip6_input.c  |  0
 slirp/{ =3D> src}/ip6_output.c |  0
 slirp/{ =3D> src}/ip_icmp.c    |  0
 slirp/{ =3D> src}/ip_input.c   |  0
 slirp/{ =3D> src}/ip_output.c  |  0
 slirp/{ =3D> src}/mbuf.c       |  0
 slirp/{ =3D> src}/misc.c       |  0
 slirp/{ =3D> src}/ncsi.c       |  0
 slirp/{ =3D> src}/ndp_table.c  |  0
 slirp/{ =3D> src}/sbuf.c       |  0
 slirp/{ =3D> src}/slirp.c      |  0
 slirp/{ =3D> src}/socket.c     |  0
 slirp/{ =3D> src}/state.c      |  0
 slirp/{ =3D> src}/stream.c     |  0
 slirp/{ =3D> src}/tcp_input.c  |  0
 slirp/{ =3D> src}/tcp_output.c |  0
 slirp/{ =3D> src}/tcp_subr.c   |  0
 slirp/{ =3D> src}/tcp_timer.c  |  0
 slirp/{ =3D> src}/tftp.c       |  0
 slirp/{ =3D> src}/udp.c        |  0
 slirp/{ =3D> src}/udp6.c       |  0
 slirp/{ =3D> src}/util.c       |  0
 slirp/{ =3D> src}/vmstate.c    |  0
 util/main-loop.c             |  2 --
 vl.c                         |  3 --
 slirp/Makefile.objs          | 60 ++++++++++++++++++------------------
 61 files changed, 31 insertions(+), 36 deletions(-)
 rename slirp/{ =3D> src}/bootp.h (100%)
 rename slirp/{ =3D> src}/debug.h (100%)
 rename slirp/{ =3D> src}/dhcpv6.h (100%)
 rename slirp/{ =3D> src}/if.h (100%)
 rename slirp/{ =3D> src}/ip.h (100%)
 rename slirp/{ =3D> src}/ip6.h (100%)
 rename slirp/{ =3D> src}/ip6_icmp.h (100%)
 rename slirp/{ =3D> src}/ip_icmp.h (100%)
 rename slirp/{ =3D> src}/libslirp.h (100%)
 rename slirp/{ =3D> src}/main.h (100%)
 rename slirp/{ =3D> src}/mbuf.h (100%)
 rename slirp/{ =3D> src}/misc.h (100%)
 rename slirp/{ =3D> src}/ncsi-pkt.h (100%)
 rename slirp/{ =3D> src}/qtailq.h (100%)
 rename slirp/{ =3D> src}/sbuf.h (100%)
 rename slirp/{ =3D> src}/slirp.h (100%)
 rename slirp/{ =3D> src}/socket.h (100%)
 rename slirp/{ =3D> src}/state.h (100%)
 rename slirp/{ =3D> src}/stream.h (100%)
 rename slirp/{ =3D> src}/tcp.h (100%)
 rename slirp/{ =3D> src}/tcp_timer.h (100%)
 rename slirp/{ =3D> src}/tcp_var.h (100%)
 rename slirp/{ =3D> src}/tcpip.h (100%)
 rename slirp/{ =3D> src}/tftp.h (100%)
 rename slirp/{ =3D> src}/udp.h (100%)
 rename slirp/{ =3D> src}/util.h (100%)
 rename slirp/{ =3D> src}/vmstate.h (100%)
 rename slirp/{ =3D> src}/arp_table.c (100%)
 rename slirp/{ =3D> src}/bootp.c (100%)
 rename slirp/{ =3D> src}/cksum.c (100%)
 rename slirp/{ =3D> src}/dhcpv6.c (100%)
 rename slirp/{ =3D> src}/dnssearch.c (100%)
 rename slirp/{ =3D> src}/if.c (100%)
 rename slirp/{ =3D> src}/ip6_icmp.c (100%)
 rename slirp/{ =3D> src}/ip6_input.c (100%)
 rename slirp/{ =3D> src}/ip6_output.c (100%)
 rename slirp/{ =3D> src}/ip_icmp.c (100%)
 rename slirp/{ =3D> src}/ip_input.c (100%)
 rename slirp/{ =3D> src}/ip_output.c (100%)
 rename slirp/{ =3D> src}/mbuf.c (100%)
 rename slirp/{ =3D> src}/misc.c (100%)
 rename slirp/{ =3D> src}/ncsi.c (100%)
 rename slirp/{ =3D> src}/ndp_table.c (100%)
 rename slirp/{ =3D> src}/sbuf.c (100%)
 rename slirp/{ =3D> src}/slirp.c (100%)
 rename slirp/{ =3D> src}/socket.c (100%)
 rename slirp/{ =3D> src}/state.c (100%)
 rename slirp/{ =3D> src}/stream.c (100%)
 rename slirp/{ =3D> src}/tcp_input.c (100%)
 rename slirp/{ =3D> src}/tcp_output.c (100%)
 rename slirp/{ =3D> src}/tcp_subr.c (100%)
 rename slirp/{ =3D> src}/tcp_timer.c (100%)
 rename slirp/{ =3D> src}/tftp.c (100%)
 rename slirp/{ =3D> src}/udp.c (100%)
 rename slirp/{ =3D> src}/udp6.c (100%)
 rename slirp/{ =3D> src}/util.c (100%)
 rename slirp/{ =3D> src}/vmstate.c (100%)

diff --git a/slirp/bootp.h b/slirp/src/bootp.h
similarity index 100%
rename from slirp/bootp.h
rename to slirp/src/bootp.h
diff --git a/slirp/debug.h b/slirp/src/debug.h
similarity index 100%
rename from slirp/debug.h
rename to slirp/src/debug.h
diff --git a/slirp/dhcpv6.h b/slirp/src/dhcpv6.h
similarity index 100%
rename from slirp/dhcpv6.h
rename to slirp/src/dhcpv6.h
diff --git a/slirp/if.h b/slirp/src/if.h
similarity index 100%
rename from slirp/if.h
rename to slirp/src/if.h
diff --git a/slirp/ip.h b/slirp/src/ip.h
similarity index 100%
rename from slirp/ip.h
rename to slirp/src/ip.h
diff --git a/slirp/ip6.h b/slirp/src/ip6.h
similarity index 100%
rename from slirp/ip6.h
rename to slirp/src/ip6.h
diff --git a/slirp/ip6_icmp.h b/slirp/src/ip6_icmp.h
similarity index 100%
rename from slirp/ip6_icmp.h
rename to slirp/src/ip6_icmp.h
diff --git a/slirp/ip_icmp.h b/slirp/src/ip_icmp.h
similarity index 100%
rename from slirp/ip_icmp.h
rename to slirp/src/ip_icmp.h
diff --git a/slirp/libslirp.h b/slirp/src/libslirp.h
similarity index 100%
rename from slirp/libslirp.h
rename to slirp/src/libslirp.h
diff --git a/slirp/main.h b/slirp/src/main.h
similarity index 100%
rename from slirp/main.h
rename to slirp/src/main.h
diff --git a/slirp/mbuf.h b/slirp/src/mbuf.h
similarity index 100%
rename from slirp/mbuf.h
rename to slirp/src/mbuf.h
diff --git a/slirp/misc.h b/slirp/src/misc.h
similarity index 100%
rename from slirp/misc.h
rename to slirp/src/misc.h
diff --git a/slirp/ncsi-pkt.h b/slirp/src/ncsi-pkt.h
similarity index 100%
rename from slirp/ncsi-pkt.h
rename to slirp/src/ncsi-pkt.h
diff --git a/slirp/qtailq.h b/slirp/src/qtailq.h
similarity index 100%
rename from slirp/qtailq.h
rename to slirp/src/qtailq.h
diff --git a/slirp/sbuf.h b/slirp/src/sbuf.h
similarity index 100%
rename from slirp/sbuf.h
rename to slirp/src/sbuf.h
diff --git a/slirp/slirp.h b/slirp/src/slirp.h
similarity index 100%
rename from slirp/slirp.h
rename to slirp/src/slirp.h
diff --git a/slirp/socket.h b/slirp/src/socket.h
similarity index 100%
rename from slirp/socket.h
rename to slirp/src/socket.h
diff --git a/slirp/state.h b/slirp/src/state.h
similarity index 100%
rename from slirp/state.h
rename to slirp/src/state.h
diff --git a/slirp/stream.h b/slirp/src/stream.h
similarity index 100%
rename from slirp/stream.h
rename to slirp/src/stream.h
diff --git a/slirp/tcp.h b/slirp/src/tcp.h
similarity index 100%
rename from slirp/tcp.h
rename to slirp/src/tcp.h
diff --git a/slirp/tcp_timer.h b/slirp/src/tcp_timer.h
similarity index 100%
rename from slirp/tcp_timer.h
rename to slirp/src/tcp_timer.h
diff --git a/slirp/tcp_var.h b/slirp/src/tcp_var.h
similarity index 100%
rename from slirp/tcp_var.h
rename to slirp/src/tcp_var.h
diff --git a/slirp/tcpip.h b/slirp/src/tcpip.h
similarity index 100%
rename from slirp/tcpip.h
rename to slirp/src/tcpip.h
diff --git a/slirp/tftp.h b/slirp/src/tftp.h
similarity index 100%
rename from slirp/tftp.h
rename to slirp/src/tftp.h
diff --git a/slirp/udp.h b/slirp/src/udp.h
similarity index 100%
rename from slirp/udp.h
rename to slirp/src/udp.h
diff --git a/slirp/util.h b/slirp/src/util.h
similarity index 100%
rename from slirp/util.h
rename to slirp/src/util.h
diff --git a/slirp/vmstate.h b/slirp/src/vmstate.h
similarity index 100%
rename from slirp/vmstate.h
rename to slirp/src/vmstate.h
diff --git a/net/slirp.c b/net/slirp.c
index bcd91475d2..b3bb1880c7 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -37,7 +37,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-#include "slirp/libslirp.h"
+#include "slirp/src/libslirp.h"
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
diff --git a/slirp/arp_table.c b/slirp/src/arp_table.c
similarity index 100%
rename from slirp/arp_table.c
rename to slirp/src/arp_table.c
diff --git a/slirp/bootp.c b/slirp/src/bootp.c
similarity index 100%
rename from slirp/bootp.c
rename to slirp/src/bootp.c
diff --git a/slirp/cksum.c b/slirp/src/cksum.c
similarity index 100%
rename from slirp/cksum.c
rename to slirp/src/cksum.c
diff --git a/slirp/dhcpv6.c b/slirp/src/dhcpv6.c
similarity index 100%
rename from slirp/dhcpv6.c
rename to slirp/src/dhcpv6.c
diff --git a/slirp/dnssearch.c b/slirp/src/dnssearch.c
similarity index 100%
rename from slirp/dnssearch.c
rename to slirp/src/dnssearch.c
diff --git a/slirp/if.c b/slirp/src/if.c
similarity index 100%
rename from slirp/if.c
rename to slirp/src/if.c
diff --git a/slirp/ip6_icmp.c b/slirp/src/ip6_icmp.c
similarity index 100%
rename from slirp/ip6_icmp.c
rename to slirp/src/ip6_icmp.c
diff --git a/slirp/ip6_input.c b/slirp/src/ip6_input.c
similarity index 100%
rename from slirp/ip6_input.c
rename to slirp/src/ip6_input.c
diff --git a/slirp/ip6_output.c b/slirp/src/ip6_output.c
similarity index 100%
rename from slirp/ip6_output.c
rename to slirp/src/ip6_output.c
diff --git a/slirp/ip_icmp.c b/slirp/src/ip_icmp.c
similarity index 100%
rename from slirp/ip_icmp.c
rename to slirp/src/ip_icmp.c
diff --git a/slirp/ip_input.c b/slirp/src/ip_input.c
similarity index 100%
rename from slirp/ip_input.c
rename to slirp/src/ip_input.c
diff --git a/slirp/ip_output.c b/slirp/src/ip_output.c
similarity index 100%
rename from slirp/ip_output.c
rename to slirp/src/ip_output.c
diff --git a/slirp/mbuf.c b/slirp/src/mbuf.c
similarity index 100%
rename from slirp/mbuf.c
rename to slirp/src/mbuf.c
diff --git a/slirp/misc.c b/slirp/src/misc.c
similarity index 100%
rename from slirp/misc.c
rename to slirp/src/misc.c
diff --git a/slirp/ncsi.c b/slirp/src/ncsi.c
similarity index 100%
rename from slirp/ncsi.c
rename to slirp/src/ncsi.c
diff --git a/slirp/ndp_table.c b/slirp/src/ndp_table.c
similarity index 100%
rename from slirp/ndp_table.c
rename to slirp/src/ndp_table.c
diff --git a/slirp/sbuf.c b/slirp/src/sbuf.c
similarity index 100%
rename from slirp/sbuf.c
rename to slirp/src/sbuf.c
diff --git a/slirp/slirp.c b/slirp/src/slirp.c
similarity index 100%
rename from slirp/slirp.c
rename to slirp/src/slirp.c
diff --git a/slirp/socket.c b/slirp/src/socket.c
similarity index 100%
rename from slirp/socket.c
rename to slirp/src/socket.c
diff --git a/slirp/state.c b/slirp/src/state.c
similarity index 100%
rename from slirp/state.c
rename to slirp/src/state.c
diff --git a/slirp/stream.c b/slirp/src/stream.c
similarity index 100%
rename from slirp/stream.c
rename to slirp/src/stream.c
diff --git a/slirp/tcp_input.c b/slirp/src/tcp_input.c
similarity index 100%
rename from slirp/tcp_input.c
rename to slirp/src/tcp_input.c
diff --git a/slirp/tcp_output.c b/slirp/src/tcp_output.c
similarity index 100%
rename from slirp/tcp_output.c
rename to slirp/src/tcp_output.c
diff --git a/slirp/tcp_subr.c b/slirp/src/tcp_subr.c
similarity index 100%
rename from slirp/tcp_subr.c
rename to slirp/src/tcp_subr.c
diff --git a/slirp/tcp_timer.c b/slirp/src/tcp_timer.c
similarity index 100%
rename from slirp/tcp_timer.c
rename to slirp/src/tcp_timer.c
diff --git a/slirp/tftp.c b/slirp/src/tftp.c
similarity index 100%
rename from slirp/tftp.c
rename to slirp/src/tftp.c
diff --git a/slirp/udp.c b/slirp/src/udp.c
similarity index 100%
rename from slirp/udp.c
rename to slirp/src/udp.c
diff --git a/slirp/udp6.c b/slirp/src/udp6.c
similarity index 100%
rename from slirp/udp6.c
rename to slirp/src/udp6.c
diff --git a/slirp/util.c b/slirp/src/util.c
similarity index 100%
rename from slirp/util.c
rename to slirp/src/util.c
diff --git a/slirp/vmstate.c b/slirp/src/vmstate.c
similarity index 100%
rename from slirp/vmstate.c
rename to slirp/src/vmstate.c
diff --git a/util/main-loop.c b/util/main-loop.c
index d4a521caeb..e1e349ca5c 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -26,11 +26,9 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
-#include "qemu/sockets.h"	// struct in_addr needed for libslirp.h
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "sysemu/replay.h"
-#include "slirp/libslirp.h"
 #include "qemu/main-loop.h"
 #include "block/aio.h"
 #include "qemu/error-report.h"
diff --git a/vl.c b/vl.c
index 9e4dba7f92..33396da49a 100644
--- a/vl.c
+++ b/vl.c
@@ -106,9 +106,6 @@ int main(int argc, char **argv)
=20
 #include "disas/disas.h"
=20
-
-#include "slirp/libslirp.h"
-
 #include "trace-root.h"
 #include "trace/control.h"
 #include "qemu/queue.h"
diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index e91daf0e91..0250229dfa 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -1,36 +1,36 @@
 slirp-obj-y =3D slirp.mo
=20
 slirp.mo-objs =3D \
-	arp_table.o \
-	bootp.o \
-	cksum.o \
-	dhcpv6.o \
-	dnssearch.o \
-	if.o \
-	ip6_icmp.o \
-	ip6_input.o \
-	ip6_output.o \
-	ip_icmp.o \
-	ip_input.o \
-	ip_output.o \
-	mbuf.o \
-	misc.o \
-	ncsi.o \
-	ndp_table.o \
-	sbuf.o \
-	slirp.o \
-	socket.o \
-	state.o \
-	stream.o \
-	tcp_input.o \
-	tcp_output.o \
-	tcp_subr.o \
-	tcp_timer.o \
-	tftp.o \
-	udp.o \
-	udp6.o \
-	util.o \
-	vmstate.o \
+	src/arp_table.o \
+	src/bootp.o \
+	src/cksum.o \
+	src/dhcpv6.o \
+	src/dnssearch.o \
+	src/if.o \
+	src/ip6_icmp.o \
+	src/ip6_input.o \
+	src/ip6_output.o \
+	src/ip_icmp.o \
+	src/ip_input.o \
+	src/ip_output.o \
+	src/mbuf.o \
+	src/misc.o \
+	src/ncsi.o \
+	src/ndp_table.o \
+	src/sbuf.o \
+	src/slirp.o \
+	src/socket.o \
+	src/state.o \
+	src/stream.o \
+	src/tcp_input.o \
+	src/tcp_output.o \
+	src/tcp_subr.o \
+	src/tcp_timer.o \
+	src/tftp.o \
+	src/udp.o \
+	src/udp6.o \
+	src/util.o \
+	src/vmstate.o \
 	$(NULL)
=20
 slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\"
--=20
2.21.0.rc0.1.g036caf7885
