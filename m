Received: from eggs.gnu.org ([209.51.188.92]:53386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsDCs-0003WO-Hr
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsDCr-0000KN-Ab
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:57:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gsDCr-0000Jj-2u
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:57:05 -0500
From: marcandre.lureau@redhat.com
Date: Fri,  8 Feb 2019 19:11:17 +0100
Message-Id: <20190208181122.23393-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH slirp 0/5] Make it a standalone project
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

Hi,

As discussed earlier in "[PATCH for-3.2 00/41] RFC: slirp: make it
again a standalone project" and other threads, it would be useful to
make slirp a separate project (the submodule approach was discarded)
for various projects to share.

The first patch describes how to filter the qemu repository for the
slirp/ content, and initial layout.

The following patches add meson build system (if necessary for older
distros, autotools could be added - however I believe python & ninja
are generally available on the QEMU supported platforms)

Finally, to be able to provide migration handling (currently handled
by QEMU), I ported a subset of the QEMU state saving/loading code in
"slirp: add state saving/loading" and added some slirp API.

Where should this new project be hosted? (I suggest some gitlab
instance, because of the nice ui/CI/issues/milestone...)

thanks

Marc-Andr=C3=A9 Lureau (5):
  Extract slirp/ from qemu repository
  build-sys: add a meson build
  build-sys: add version tooling
  slirp: add state saving/loading
  Add .gitlab-ci.yml

 .gitlab-ci.yml                   |  20 ++
 Makefile.objs                    |  34 ---
 meson.build                      | 127 ++++++++++
 arp_table.c =3D> src/arp_table.c   |   0
 bootp.c =3D> src/bootp.c           |   0
 bootp.h =3D> src/bootp.h           |   0
 cksum.c =3D> src/cksum.c           |   0
 debug.h =3D> src/debug.h           |   0
 dhcpv6.c =3D> src/dhcpv6.c         |   0
 dhcpv6.h =3D> src/dhcpv6.h         |   0
 dnssearch.c =3D> src/dnssearch.c   |   0
 if.c =3D> src/if.c                 |   0
 if.h =3D> src/if.h                 |   0
 ip.h =3D> src/ip.h                 |   0
 ip6.h =3D> src/ip6.h               |   0
 ip6_icmp.c =3D> src/ip6_icmp.c     |   0
 ip6_icmp.h =3D> src/ip6_icmp.h     |   0
 ip6_input.c =3D> src/ip6_input.c   |   0
 ip6_output.c =3D> src/ip6_output.c |   0
 ip_icmp.c =3D> src/ip_icmp.c       |   0
 ip_icmp.h =3D> src/ip_icmp.h       |   0
 ip_input.c =3D> src/ip_input.c     |   0
 ip_output.c =3D> src/ip_output.c   |   0
 src/libslirp-version.h.in        |  22 ++
 libslirp.h =3D> src/libslirp.h     |  13 +
 src/libslirp.map                 |  21 ++
 main.h =3D> src/main.h             |   0
 mbuf.c =3D> src/mbuf.c             |   0
 mbuf.h =3D> src/mbuf.h             |   0
 misc.c =3D> src/misc.c             |   0
 misc.h =3D> src/misc.h             |   0
 ncsi-pkt.h =3D> src/ncsi-pkt.h     |   0
 ncsi.c =3D> src/ncsi.c             |   0
 ndp_table.c =3D> src/ndp_table.c   |   0
 qtailq.h =3D> src/qtailq.h         |   0
 sbuf.c =3D> src/sbuf.c             |   0
 sbuf.h =3D> src/sbuf.h             |   0
 slirp.c =3D> src/slirp.c           |   9 -
 slirp.h =3D> src/slirp.h           |   0
 socket.c =3D> src/socket.c         |   0
 socket.h =3D> src/socket.h         |   0
 state.c =3D> src/state.c           |  50 ++--
 src/state.h                      |   0
 src/stream.c                     | 119 +++++++++
 src/stream.h                     |  34 +++
 tcp.h =3D> src/tcp.h               |   0
 tcp_input.c =3D> src/tcp_input.c   |   0
 tcp_output.c =3D> src/tcp_output.c |   0
 tcp_subr.c =3D> src/tcp_subr.c     |   0
 tcp_timer.c =3D> src/tcp_timer.c   |   0
 tcp_timer.h =3D> src/tcp_timer.h   |   0
 tcp_var.h =3D> src/tcp_var.h       |   0
 tcpip.h =3D> src/tcpip.h           |   0
 tftp.c =3D> src/tftp.c             |   0
 tftp.h =3D> src/tftp.h             |   0
 udp.c =3D> src/udp.c               |   0
 udp.h =3D> src/udp.h               |   0
 udp6.c =3D> src/udp6.c             |   0
 util.c =3D> src/util.c             |   0
 util.h =3D> src/util.h             |   3 +
 src/version.c                    |  33 +++
 src/vmstate.c                    | 401 +++++++++++++++++++++++++++++++
 src/vmstate.h                    | 396 ++++++++++++++++++++++++++++++
 state.h                          |   9 -
 64 files changed, 1211 insertions(+), 80 deletions(-)
 create mode 100644 .gitlab-ci.yml
 delete mode 100644 Makefile.objs
 create mode 100644 meson.build
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
 create mode 100644 src/libslirp-version.h.in
 rename libslirp.h =3D> src/libslirp.h (91%)
 create mode 100644 src/libslirp.map
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
 rename slirp.c =3D> src/slirp.c (99%)
 rename slirp.h =3D> src/slirp.h (100%)
 rename socket.c =3D> src/socket.c (100%)
 rename socket.h =3D> src/socket.h (100%)
 rename state.c =3D> src/state.c (93%)
 create mode 100644 src/state.h
 create mode 100644 src/stream.c
 create mode 100644 src/stream.h
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
 rename util.h =3D> src/util.h (98%)
 create mode 100644 src/version.c
 create mode 100644 src/vmstate.c
 create mode 100644 src/vmstate.h
 delete mode 100644 state.h

--=20
2.21.0.rc0.1.g036caf7885
