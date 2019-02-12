Received: from eggs.gnu.org ([209.51.188.92]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtb2X-00059p-9v
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtasW-0000xo-63
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtasU-0000Tg-25
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:25:46 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 12 Feb 2019 17:25:17 +0100
Message-Id: <20190212162524.31504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/7] slirp: make it a standalone project
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

Hi,

As discussed earlier in "[PATCH for-3.2 00/41] RFC: slirp: make it
again a standalone project" and other threads, it would be useful to
make slirp a separate project.

In the previous thread "[PATCH slirp 0/5] Make it a standalone
project", it was recommended by Peter that we keep the submodule build
for a while, until libslirp is released with stability commitments.

This patch series is to be applied on QEMU source tree, and modify
slirp/ to make it easily submodule-able or build QEMU against a system
installed version.

Based-on: <20190212160953.29051-1-marcandre.lureau@redhat.com>

Marc-Andr=C3=A9 Lureau (7):
  slirp: adapt a subset of QEMU vmstate code
  slirp: use libslirp migration code
  slirp: use "slirp_" prefix for inet_aton() win32 implementation
  slirp: move sources to src/ subdirectory
  slirp: add a standalone Makefile
  build-sys: link with slirp as an external project
  slirp: remove QEMU Makefile.objs

 include/migration/qemu-file-types.h |   2 +
 migration/qemu-file.h               |   1 -
 slirp/{ =3D> src}/bootp.h             |   0
 slirp/{ =3D> src}/debug.h             |   0
 slirp/{ =3D> src}/dhcpv6.h            |   0
 slirp/{ =3D> src}/if.h                |   0
 slirp/{ =3D> src}/ip.h                |   0
 slirp/{ =3D> src}/ip6.h               |   0
 slirp/{ =3D> src}/ip6_icmp.h          |   0
 slirp/{ =3D> src}/ip_icmp.h           |   0
 slirp/{ =3D> src}/libslirp.h          |   9 +
 slirp/{ =3D> src}/main.h              |   0
 slirp/{ =3D> src}/mbuf.h              |   0
 slirp/{ =3D> src}/misc.h              |   0
 slirp/{ =3D> src}/ncsi-pkt.h          |   0
 slirp/{ =3D> src}/qtailq.h            |   0
 slirp/{ =3D> src}/sbuf.h              |   0
 slirp/{ =3D> src}/slirp.h             |   0
 slirp/{ =3D> src}/socket.h            |   0
 slirp/src/state.h                   |   0
 slirp/src/stream.h                  |  34 +++
 slirp/{ =3D> src}/tcp.h               |   0
 slirp/{ =3D> src}/tcp_timer.h         |   0
 slirp/{ =3D> src}/tcp_var.h           |   0
 slirp/{ =3D> src}/tcpip.h             |   0
 slirp/{ =3D> src}/tftp.h              |   0
 slirp/{ =3D> src}/udp.h               |   0
 slirp/{ =3D> src}/util.h              |   4 +-
 slirp/src/vmstate.h                 | 396 +++++++++++++++++++++++++++
 slirp/state.h                       |   9 -
 net/slirp.c                         |  57 +++-
 slirp/{ =3D> src}/arp_table.c         |   0
 slirp/{ =3D> src}/bootp.c             |   0
 slirp/{ =3D> src}/cksum.c             |   0
 slirp/{ =3D> src}/dhcpv6.c            |   0
 slirp/{ =3D> src}/dnssearch.c         |   0
 slirp/{ =3D> src}/if.c                |   0
 slirp/{ =3D> src}/ip6_icmp.c          |   0
 slirp/{ =3D> src}/ip6_input.c         |   0
 slirp/{ =3D> src}/ip6_output.c        |   0
 slirp/{ =3D> src}/ip_icmp.c           |   0
 slirp/{ =3D> src}/ip_input.c          |   0
 slirp/{ =3D> src}/ip_output.c         |   0
 slirp/{ =3D> src}/mbuf.c              |   0
 slirp/{ =3D> src}/misc.c              |   0
 slirp/{ =3D> src}/ncsi.c              |   0
 slirp/{ =3D> src}/ndp_table.c         |   0
 slirp/{ =3D> src}/sbuf.c              |   0
 slirp/{ =3D> src}/slirp.c             |   9 -
 slirp/{ =3D> src}/socket.c            |   0
 slirp/{ =3D> src}/state.c             |  52 ++--
 slirp/src/stream.c                  | 119 +++++++++
 slirp/{ =3D> src}/tcp_input.c         |   0
 slirp/{ =3D> src}/tcp_output.c        |   0
 slirp/{ =3D> src}/tcp_subr.c          |   0
 slirp/{ =3D> src}/tcp_timer.c         |   0
 slirp/{ =3D> src}/tftp.c              |   0
 slirp/{ =3D> src}/udp.c               |   0
 slirp/{ =3D> src}/udp6.c              |   0
 slirp/{ =3D> src}/util.c              |   4 +-
 slirp/src/vmstate.c                 | 401 ++++++++++++++++++++++++++++
 util/main-loop.c                    |   2 -
 vl.c                                |   3 -
 Makefile                            |   8 +-
 Makefile.objs                       |   1 -
 Makefile.target                     |   5 +-
 configure                           |  65 ++++-
 net/Makefile.objs                   |   2 +
 slirp/Makefile                      |  47 ++++
 slirp/Makefile.objs                 |  34 ---
 util/Makefile.objs                  |   1 +
 71 files changed, 1162 insertions(+), 103 deletions(-)
 rename slirp/{ =3D> src}/bootp.h (100%)
 rename slirp/{ =3D> src}/debug.h (100%)
 rename slirp/{ =3D> src}/dhcpv6.h (100%)
 rename slirp/{ =3D> src}/if.h (100%)
 rename slirp/{ =3D> src}/ip.h (100%)
 rename slirp/{ =3D> src}/ip6.h (100%)
 rename slirp/{ =3D> src}/ip6_icmp.h (100%)
 rename slirp/{ =3D> src}/ip_icmp.h (100%)
 rename slirp/{ =3D> src}/libslirp.h (93%)
 rename slirp/{ =3D> src}/main.h (100%)
 rename slirp/{ =3D> src}/mbuf.h (100%)
 rename slirp/{ =3D> src}/misc.h (100%)
 rename slirp/{ =3D> src}/ncsi-pkt.h (100%)
 rename slirp/{ =3D> src}/qtailq.h (100%)
 rename slirp/{ =3D> src}/sbuf.h (100%)
 rename slirp/{ =3D> src}/slirp.h (100%)
 rename slirp/{ =3D> src}/socket.h (100%)
 create mode 100644 slirp/src/state.h
 create mode 100644 slirp/src/stream.h
 rename slirp/{ =3D> src}/tcp.h (100%)
 rename slirp/{ =3D> src}/tcp_timer.h (100%)
 rename slirp/{ =3D> src}/tcp_var.h (100%)
 rename slirp/{ =3D> src}/tcpip.h (100%)
 rename slirp/{ =3D> src}/tftp.h (100%)
 rename slirp/{ =3D> src}/udp.h (100%)
 rename slirp/{ =3D> src}/util.h (98%)
 create mode 100644 slirp/src/vmstate.h
 delete mode 100644 slirp/state.h
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
 rename slirp/{ =3D> src}/slirp.c (99%)
 rename slirp/{ =3D> src}/socket.c (100%)
 rename slirp/{ =3D> src}/state.c (91%)
 create mode 100644 slirp/src/stream.c
 rename slirp/{ =3D> src}/tcp_input.c (100%)
 rename slirp/{ =3D> src}/tcp_output.c (100%)
 rename slirp/{ =3D> src}/tcp_subr.c (100%)
 rename slirp/{ =3D> src}/tcp_timer.c (100%)
 rename slirp/{ =3D> src}/tftp.c (100%)
 rename slirp/{ =3D> src}/udp.c (100%)
 rename slirp/{ =3D> src}/udp6.c (100%)
 rename slirp/{ =3D> src}/util.c (98%)
 create mode 100644 slirp/src/vmstate.c
 create mode 100644 slirp/Makefile
 delete mode 100644 slirp/Makefile.objs

--=20
2.21.0.rc0.1.g036caf7885
