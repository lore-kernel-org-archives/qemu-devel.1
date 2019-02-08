Received: from eggs.gnu.org ([209.51.188.92]:45796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsCxK-0001RY-NC
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsCxJ-0004Ho-0M
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:41:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gsCxI-0004Dt-MB
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:41:00 -0500
From: marcandre.lureau@redhat.com
Date: Fri,  8 Feb 2019 19:11:18 +0100
Message-Id: <20190208181122.23393-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190208181122.23393-1-marcandre.lureau@redhat.com>
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH slirp 1/5] Extract slirp/ from qemu repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

$ git filter-branch --tree-filter "git ls-files '*.c' '*.h' | xargs
clang-format -i" -f --subdirectory-filter "slirp" --prune-empty
--tag-name-filter cat -- --all
$ git rm Makefiles.objs
$ mkdir src && git mv *.c *.h src/
$ git tag --no-merged | xargs git tag -d
$ git reflog expire --expire=3Dnow --all
$ git gc --prune=3Dnow --aggressive

This results in a 1.3M repostory with the tags, previewed here:
https://gitlab.freedesktop.org/elmarco/slirp

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.objs                    | 34 --------------------------------
 arp_table.c =3D> src/arp_table.c   |  0
 bootp.c =3D> src/bootp.c           |  0
 bootp.h =3D> src/bootp.h           |  0
 cksum.c =3D> src/cksum.c           |  0
 debug.h =3D> src/debug.h           |  0
 dhcpv6.c =3D> src/dhcpv6.c         |  0
 dhcpv6.h =3D> src/dhcpv6.h         |  0
 dnssearch.c =3D> src/dnssearch.c   |  0
 if.c =3D> src/if.c                 |  0
 if.h =3D> src/if.h                 |  0
 ip.h =3D> src/ip.h                 |  0
 ip6.h =3D> src/ip6.h               |  0
 ip6_icmp.c =3D> src/ip6_icmp.c     |  0
 ip6_icmp.h =3D> src/ip6_icmp.h     |  0
 ip6_input.c =3D> src/ip6_input.c   |  0
 ip6_output.c =3D> src/ip6_output.c |  0
 ip_icmp.c =3D> src/ip_icmp.c       |  0
 ip_icmp.h =3D> src/ip_icmp.h       |  0
 ip_input.c =3D> src/ip_input.c     |  0
 ip_output.c =3D> src/ip_output.c   |  0
 libslirp.h =3D> src/libslirp.h     |  0
 main.h =3D> src/main.h             |  0
 mbuf.c =3D> src/mbuf.c             |  0
 mbuf.h =3D> src/mbuf.h             |  0
 misc.c =3D> src/misc.c             |  0
 misc.h =3D> src/misc.h             |  0
 ncsi-pkt.h =3D> src/ncsi-pkt.h     |  0
 ncsi.c =3D> src/ncsi.c             |  0
 ndp_table.c =3D> src/ndp_table.c   |  0
 qtailq.h =3D> src/qtailq.h         |  0
 sbuf.c =3D> src/sbuf.c             |  0
 sbuf.h =3D> src/sbuf.h             |  0
 slirp.c =3D> src/slirp.c           |  0
 slirp.h =3D> src/slirp.h           |  0
 socket.c =3D> src/socket.c         |  0
 socket.h =3D> src/socket.h         |  0
 state.c =3D> src/state.c           |  0
 state.h =3D> src/state.h           |  0
 tcp.h =3D> src/tcp.h               |  0
 tcp_input.c =3D> src/tcp_input.c   |  0
 tcp_output.c =3D> src/tcp_output.c |  0
 tcp_subr.c =3D> src/tcp_subr.c     |  0
 tcp_timer.c =3D> src/tcp_timer.c   |  0
 tcp_timer.h =3D> src/tcp_timer.h   |  0
 tcp_var.h =3D> src/tcp_var.h       |  0
 tcpip.h =3D> src/tcpip.h           |  0
 tftp.c =3D> src/tftp.c             |  0
 tftp.h =3D> src/tftp.h             |  0
 udp.c =3D> src/udp.c               |  0
 udp.h =3D> src/udp.h               |  0
 udp6.c =3D> src/udp6.c             |  0
 util.c =3D> src/util.c             |  0
 util.h =3D> src/util.h             |  0
 54 files changed, 34 deletions(-)
 delete mode 100644 Makefile.objs
 rename arp_table.c =3D> src/arp_table.c (100%)
 rename bootp.c =3D> src/bootp.c (100%)
 rename bootp.h =3D> src/bootp.h (100%)
 rename cksum.c =3D> src/cksum.c (100%)
 rename debug.h =3D> src/debug.h (100%)
 rename dhcpv6.c =3D> src/dhcpv6.c (100%)
 rename dhcpv6.h =3D> src/dhcpv6.h (100%)
 rename dnssearch.c =3D> src/dnssearch.c (100%)
 rename if.c =3D> src/if.c (100%)
 rename if.h =3D> src/if.h (100%)
 rename ip.h =3D> src/ip.h (100%)
 rename ip6.h =3D> src/ip6.h (100%)
 rename ip6_icmp.c =3D> src/ip6_icmp.c (100%)
 rename ip6_icmp.h =3D> src/ip6_icmp.h (100%)
 rename ip6_input.c =3D> src/ip6_input.c (100%)
 rename ip6_output.c =3D> src/ip6_output.c (100%)
 rename ip_icmp.c =3D> src/ip_icmp.c (100%)
 rename ip_icmp.h =3D> src/ip_icmp.h (100%)
 rename ip_input.c =3D> src/ip_input.c (100%)
 rename ip_output.c =3D> src/ip_output.c (100%)
 rename libslirp.h =3D> src/libslirp.h (100%)
 rename main.h =3D> src/main.h (100%)
 rename mbuf.c =3D> src/mbuf.c (100%)
 rename mbuf.h =3D> src/mbuf.h (100%)
 rename misc.c =3D> src/misc.c (100%)
 rename misc.h =3D> src/misc.h (100%)
 rename ncsi-pkt.h =3D> src/ncsi-pkt.h (100%)
 rename ncsi.c =3D> src/ncsi.c (100%)
 rename ndp_table.c =3D> src/ndp_table.c (100%)
 rename qtailq.h =3D> src/qtailq.h (100%)
 rename sbuf.c =3D> src/sbuf.c (100%)
 rename sbuf.h =3D> src/sbuf.h (100%)
 rename slirp.c =3D> src/slirp.c (100%)
 rename slirp.h =3D> src/slirp.h (100%)
 rename socket.c =3D> src/socket.c (100%)
 rename socket.h =3D> src/socket.h (100%)
 rename state.c =3D> src/state.c (100%)
 rename state.h =3D> src/state.h (100%)
 rename tcp.h =3D> src/tcp.h (100%)
 rename tcp_input.c =3D> src/tcp_input.c (100%)
 rename tcp_output.c =3D> src/tcp_output.c (100%)
 rename tcp_subr.c =3D> src/tcp_subr.c (100%)
 rename tcp_timer.c =3D> src/tcp_timer.c (100%)
 rename tcp_timer.h =3D> src/tcp_timer.h (100%)
 rename tcp_var.h =3D> src/tcp_var.h (100%)
 rename tcpip.h =3D> src/tcpip.h (100%)
 rename tftp.c =3D> src/tftp.c (100%)
 rename tftp.h =3D> src/tftp.h (100%)
 rename udp.c =3D> src/udp.c (100%)
 rename udp.h =3D> src/udp.h (100%)
 rename udp6.c =3D> src/udp6.c (100%)
 rename util.c =3D> src/util.c (100%)
 rename util.h =3D> src/util.h (100%)

diff --git a/Makefile.objs b/Makefile.objs
deleted file mode 100644
index 88340a5..0000000
--- a/Makefile.objs
+++ /dev/null
@@ -1,34 +0,0 @@
-slirp-obj-y =3D slirp.mo
-
-slirp.mo-objs =3D \
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
-	tcp_input.o \
-	tcp_output.o \
-	tcp_subr.o \
-	tcp_timer.o \
-	tftp.o \
-	udp.o \
-	udp6.o \
-	util.o \
-	$(NULL)
-
-slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\" -DWITH_QEMU
diff --git a/arp_table.c b/src/arp_table.c
similarity index 100%
rename from arp_table.c
rename to src/arp_table.c
diff --git a/bootp.c b/src/bootp.c
similarity index 100%
rename from bootp.c
rename to src/bootp.c
diff --git a/bootp.h b/src/bootp.h
similarity index 100%
rename from bootp.h
rename to src/bootp.h
diff --git a/cksum.c b/src/cksum.c
similarity index 100%
rename from cksum.c
rename to src/cksum.c
diff --git a/debug.h b/src/debug.h
similarity index 100%
rename from debug.h
rename to src/debug.h
diff --git a/dhcpv6.c b/src/dhcpv6.c
similarity index 100%
rename from dhcpv6.c
rename to src/dhcpv6.c
diff --git a/dhcpv6.h b/src/dhcpv6.h
similarity index 100%
rename from dhcpv6.h
rename to src/dhcpv6.h
diff --git a/dnssearch.c b/src/dnssearch.c
similarity index 100%
rename from dnssearch.c
rename to src/dnssearch.c
diff --git a/if.c b/src/if.c
similarity index 100%
rename from if.c
rename to src/if.c
diff --git a/if.h b/src/if.h
similarity index 100%
rename from if.h
rename to src/if.h
diff --git a/ip.h b/src/ip.h
similarity index 100%
rename from ip.h
rename to src/ip.h
diff --git a/ip6.h b/src/ip6.h
similarity index 100%
rename from ip6.h
rename to src/ip6.h
diff --git a/ip6_icmp.c b/src/ip6_icmp.c
similarity index 100%
rename from ip6_icmp.c
rename to src/ip6_icmp.c
diff --git a/ip6_icmp.h b/src/ip6_icmp.h
similarity index 100%
rename from ip6_icmp.h
rename to src/ip6_icmp.h
diff --git a/ip6_input.c b/src/ip6_input.c
similarity index 100%
rename from ip6_input.c
rename to src/ip6_input.c
diff --git a/ip6_output.c b/src/ip6_output.c
similarity index 100%
rename from ip6_output.c
rename to src/ip6_output.c
diff --git a/ip_icmp.c b/src/ip_icmp.c
similarity index 100%
rename from ip_icmp.c
rename to src/ip_icmp.c
diff --git a/ip_icmp.h b/src/ip_icmp.h
similarity index 100%
rename from ip_icmp.h
rename to src/ip_icmp.h
diff --git a/ip_input.c b/src/ip_input.c
similarity index 100%
rename from ip_input.c
rename to src/ip_input.c
diff --git a/ip_output.c b/src/ip_output.c
similarity index 100%
rename from ip_output.c
rename to src/ip_output.c
diff --git a/libslirp.h b/src/libslirp.h
similarity index 100%
rename from libslirp.h
rename to src/libslirp.h
diff --git a/main.h b/src/main.h
similarity index 100%
rename from main.h
rename to src/main.h
diff --git a/mbuf.c b/src/mbuf.c
similarity index 100%
rename from mbuf.c
rename to src/mbuf.c
diff --git a/mbuf.h b/src/mbuf.h
similarity index 100%
rename from mbuf.h
rename to src/mbuf.h
diff --git a/misc.c b/src/misc.c
similarity index 100%
rename from misc.c
rename to src/misc.c
diff --git a/misc.h b/src/misc.h
similarity index 100%
rename from misc.h
rename to src/misc.h
diff --git a/ncsi-pkt.h b/src/ncsi-pkt.h
similarity index 100%
rename from ncsi-pkt.h
rename to src/ncsi-pkt.h
diff --git a/ncsi.c b/src/ncsi.c
similarity index 100%
rename from ncsi.c
rename to src/ncsi.c
diff --git a/ndp_table.c b/src/ndp_table.c
similarity index 100%
rename from ndp_table.c
rename to src/ndp_table.c
diff --git a/qtailq.h b/src/qtailq.h
similarity index 100%
rename from qtailq.h
rename to src/qtailq.h
diff --git a/sbuf.c b/src/sbuf.c
similarity index 100%
rename from sbuf.c
rename to src/sbuf.c
diff --git a/sbuf.h b/src/sbuf.h
similarity index 100%
rename from sbuf.h
rename to src/sbuf.h
diff --git a/slirp.c b/src/slirp.c
similarity index 100%
rename from slirp.c
rename to src/slirp.c
diff --git a/slirp.h b/src/slirp.h
similarity index 100%
rename from slirp.h
rename to src/slirp.h
diff --git a/socket.c b/src/socket.c
similarity index 100%
rename from socket.c
rename to src/socket.c
diff --git a/socket.h b/src/socket.h
similarity index 100%
rename from socket.h
rename to src/socket.h
diff --git a/state.c b/src/state.c
similarity index 100%
rename from state.c
rename to src/state.c
diff --git a/state.h b/src/state.h
similarity index 100%
rename from state.h
rename to src/state.h
diff --git a/tcp.h b/src/tcp.h
similarity index 100%
rename from tcp.h
rename to src/tcp.h
diff --git a/tcp_input.c b/src/tcp_input.c
similarity index 100%
rename from tcp_input.c
rename to src/tcp_input.c
diff --git a/tcp_output.c b/src/tcp_output.c
similarity index 100%
rename from tcp_output.c
rename to src/tcp_output.c
diff --git a/tcp_subr.c b/src/tcp_subr.c
similarity index 100%
rename from tcp_subr.c
rename to src/tcp_subr.c
diff --git a/tcp_timer.c b/src/tcp_timer.c
similarity index 100%
rename from tcp_timer.c
rename to src/tcp_timer.c
diff --git a/tcp_timer.h b/src/tcp_timer.h
similarity index 100%
rename from tcp_timer.h
rename to src/tcp_timer.h
diff --git a/tcp_var.h b/src/tcp_var.h
similarity index 100%
rename from tcp_var.h
rename to src/tcp_var.h
diff --git a/tcpip.h b/src/tcpip.h
similarity index 100%
rename from tcpip.h
rename to src/tcpip.h
diff --git a/tftp.c b/src/tftp.c
similarity index 100%
rename from tftp.c
rename to src/tftp.c
diff --git a/tftp.h b/src/tftp.h
similarity index 100%
rename from tftp.h
rename to src/tftp.h
diff --git a/udp.c b/src/udp.c
similarity index 100%
rename from udp.c
rename to src/udp.c
diff --git a/udp.h b/src/udp.h
similarity index 100%
rename from udp.h
rename to src/udp.h
diff --git a/udp6.c b/src/udp6.c
similarity index 100%
rename from udp6.c
rename to src/udp6.c
diff --git a/util.c b/src/util.c
similarity index 100%
rename from util.c
rename to src/util.c
diff --git a/util.h b/src/util.h
similarity index 100%
rename from util.h
rename to src/util.h
--=20
2.21.0.rc0.1.g036caf7885
