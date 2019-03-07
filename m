Received: from eggs.gnu.org ([209.51.188.92]:36128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1rZ0-0008NP-LF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1rYz-0003Uu-F6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:51:50 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:35466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1rYz-0003TQ-3Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:51:49 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 12:51:30 +0100
Message-Id: <20190307115143.780-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv2 00/12] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com, peter.maydell@linaro.org

The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65=
e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2019-03-06 18:52:19 +0000)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to be1911ff7504be95d5cf2c18bc99ce07246a91e5:

  slirp: remove QEMU Makefile.objs (2019-03-07 12:46:31 +0100)

----------------------------------------------------------------
Slirp updates

Greg Kurz (1):
  slirp: Fix build with gcc 9

Marc-Andr=C3=A9 Lureau (7):
  slirp: adapt a subset of QEMU vmstate code
  slirp: use libslirp migration code
  slirp: use "slirp_" prefix for inet_aton() win32 implementation
  slirp: move sources to src/ subdirectory
  slirp: add a standalone Makefile
  build-sys: link with slirp as an external project
  slirp: remove QEMU Makefile.objs

Samuel Thibault (2):
  slirp: fix big/little endian conversion in ident protocol
  slirp: Mark pieces missing IPv6 support

Vic Lee (1):
  slirp: check for ioctlsocket error and 0-length udp payload.

William Bowling (1):
  slirp: check sscanf result when emulating ident

----------------------------------------------------------------
Greg Kurz (1):
      slirp: Fix build with gcc 9

Marc-Andr=C3=A9 Lureau (7):
      slirp: adapt a subset of QEMU vmstate code
      slirp: use libslirp migration code
      slirp: use "slirp_" prefix for inet_aton() win32 implementation
      slirp: move sources to src/ subdirectory
      slirp: add a standalone Makefile
      build-sys: link with slirp as an external project
      slirp: remove QEMU Makefile.objs

Samuel Thibault (2):
      slirp: fix big/little endian conversion in ident protocol
      slirp: Mark pieces missing IPv6 support

Vic Lee (1):
      slirp: check for ioctlsocket error and 0-length udp payload.

William Bowling (1):
      slirp: check sscanf result when emulating ident

 Makefile                            |   8 +-
 Makefile.objs                       |   1 -
 Makefile.target                     |   5 +-
 configure                           |  65 +++++-
 include/migration/qemu-file-types.h |   2 +
 migration/qemu-file.h               |   1 -
 net/Makefile.objs                   |   2 +
 net/slirp.c                         |  58 ++++-
 slirp/Makefile                      |  47 ++++
 slirp/Makefile.objs                 |  34 ---
 slirp/{ =3D> src}/arp_table.c         |   0
 slirp/{ =3D> src}/bootp.c             |   0
 slirp/{ =3D> src}/bootp.h             |   0
 slirp/{ =3D> src}/cksum.c             |   0
 slirp/{ =3D> src}/debug.h             |   0
 slirp/{ =3D> src}/dhcpv6.c            |   0
 slirp/{ =3D> src}/dhcpv6.h            |   0
 slirp/{ =3D> src}/dnssearch.c         |   0
 slirp/{ =3D> src}/if.c                |   0
 slirp/{ =3D> src}/if.h                |   0
 slirp/{ =3D> src}/ip.h                |   0
 slirp/{ =3D> src}/ip6.h               |   0
 slirp/{ =3D> src}/ip6_icmp.c          |   0
 slirp/{ =3D> src}/ip6_icmp.h          |   0
 slirp/{ =3D> src}/ip6_input.c         |   0
 slirp/{ =3D> src}/ip6_output.c        |   0
 slirp/{ =3D> src}/ip_icmp.c           |   0
 slirp/{ =3D> src}/ip_icmp.h           |   0
 slirp/{ =3D> src}/ip_input.c          |   0
 slirp/{ =3D> src}/ip_output.c         |   0
 slirp/{ =3D> src}/libslirp.h          |  10 +
 slirp/{ =3D> src}/main.h              |   0
 slirp/{ =3D> src}/mbuf.c              |   0
 slirp/{ =3D> src}/mbuf.h              |   0
 slirp/{ =3D> src}/misc.c              |   3 +
 slirp/{ =3D> src}/misc.h              |   0
 slirp/{ =3D> src}/ncsi-pkt.h          |   0
 slirp/{ =3D> src}/ncsi.c              |   0
 slirp/{ =3D> src}/ndp_table.c         |   0
 slirp/{ =3D> src}/qtailq.h            |   0
 slirp/{ =3D> src}/sbuf.c              |   0
 slirp/{ =3D> src}/sbuf.h              |   0
 slirp/{ =3D> src}/slirp.c             |  14 +-
 slirp/{ =3D> src}/slirp.h             |   2 +-
 slirp/{ =3D> src}/socket.c            |  11 +-
 slirp/{ =3D> src}/socket.h            |   0
 slirp/{ =3D> src}/state.c             |  52 ++---
 slirp/src/state.h                   |   0
 slirp/src/stream.c                  | 119 +++++++++++
 slirp/src/stream.h                  |  34 +++
 slirp/{ =3D> src}/tcp.h               |   0
 slirp/{ =3D> src}/tcp_input.c         |   2 +
 slirp/{ =3D> src}/tcp_output.c        |   0
 slirp/{ =3D> src}/tcp_subr.c          |  16 +-
 slirp/{ =3D> src}/tcp_timer.c         |   0
 slirp/{ =3D> src}/tcp_timer.h         |   0
 slirp/{ =3D> src}/tcp_var.h           |   0
 slirp/{ =3D> src}/tcpip.h             |   0
 slirp/{ =3D> src}/tftp.c              |   0
 slirp/{ =3D> src}/tftp.h              |   0
 slirp/{ =3D> src}/udp.c               |   1 +
 slirp/{ =3D> src}/udp.h               |   0
 slirp/{ =3D> src}/udp6.c              |   0
 slirp/{ =3D> src}/util.c              |   4 +-
 slirp/{ =3D> src}/util.h              |   4 +-
 slirp/src/vmstate.c                 | 413 ++++++++++++++++++++++++++++++=
++++++
 slirp/src/vmstate.h                 | 396 ++++++++++++++++++++++++++++++=
++++
 slirp/state.h                       |   9 -
 util/Makefile.objs                  |   1 +
 util/main-loop.c                    |   2 -
 vl.c                                |   3 -
 71 files changed, 1208 insertions(+), 111 deletions(-)
 create mode 100644 slirp/Makefile
 delete mode 100644 slirp/Makefile.objs
 rename slirp/{ =3D> src}/arp_table.c (100%)
 rename slirp/{ =3D> src}/bootp.c (100%)
 rename slirp/{ =3D> src}/bootp.h (100%)
 rename slirp/{ =3D> src}/cksum.c (100%)
 rename slirp/{ =3D> src}/debug.h (100%)
 rename slirp/{ =3D> src}/dhcpv6.c (100%)
 rename slirp/{ =3D> src}/dhcpv6.h (100%)
 rename slirp/{ =3D> src}/dnssearch.c (100%)
 rename slirp/{ =3D> src}/if.c (100%)
 rename slirp/{ =3D> src}/if.h (100%)
 rename slirp/{ =3D> src}/ip.h (100%)
 rename slirp/{ =3D> src}/ip6.h (100%)
 rename slirp/{ =3D> src}/ip6_icmp.c (100%)
 rename slirp/{ =3D> src}/ip6_icmp.h (100%)
 rename slirp/{ =3D> src}/ip6_input.c (100%)
 rename slirp/{ =3D> src}/ip6_output.c (100%)
 rename slirp/{ =3D> src}/ip_icmp.c (100%)
 rename slirp/{ =3D> src}/ip_icmp.h (100%)
 rename slirp/{ =3D> src}/ip_input.c (100%)
 rename slirp/{ =3D> src}/ip_output.c (100%)
 rename slirp/{ =3D> src}/libslirp.h (92%)
 rename slirp/{ =3D> src}/main.h (100%)
 rename slirp/{ =3D> src}/mbuf.c (100%)
 rename slirp/{ =3D> src}/mbuf.h (100%)
 rename slirp/{ =3D> src}/misc.c (99%)
 rename slirp/{ =3D> src}/misc.h (100%)
 rename slirp/{ =3D> src}/ncsi-pkt.h (100%)
 rename slirp/{ =3D> src}/ncsi.c (100%)
 rename slirp/{ =3D> src}/ndp_table.c (100%)
 rename slirp/{ =3D> src}/qtailq.h (100%)
 rename slirp/{ =3D> src}/sbuf.c (100%)
 rename slirp/{ =3D> src}/sbuf.h (100%)
 rename slirp/{ =3D> src}/slirp.c (99%)
 rename slirp/{ =3D> src}/slirp.h (99%)
 rename slirp/{ =3D> src}/socket.c (99%)
 rename slirp/{ =3D> src}/socket.h (100%)
 rename slirp/{ =3D> src}/state.c (91%)
 create mode 100644 slirp/src/state.h
 create mode 100644 slirp/src/stream.c
 create mode 100644 slirp/src/stream.h
 rename slirp/{ =3D> src}/tcp.h (100%)
 rename slirp/{ =3D> src}/tcp_input.c (99%)
 rename slirp/{ =3D> src}/tcp_output.c (100%)
 rename slirp/{ =3D> src}/tcp_subr.c (98%)
 rename slirp/{ =3D> src}/tcp_timer.c (100%)
 rename slirp/{ =3D> src}/tcp_timer.h (100%)
 rename slirp/{ =3D> src}/tcp_var.h (100%)
 rename slirp/{ =3D> src}/tcpip.h (100%)
 rename slirp/{ =3D> src}/tftp.c (100%)
 rename slirp/{ =3D> src}/tftp.h (100%)
 rename slirp/{ =3D> src}/udp.c (99%)
 rename slirp/{ =3D> src}/udp.h (100%)
 rename slirp/{ =3D> src}/udp6.c (100%)
 rename slirp/{ =3D> src}/util.c (98%)
 rename slirp/{ =3D> src}/util.h (98%)
 create mode 100644 slirp/src/vmstate.c
 create mode 100644 slirp/src/vmstate.h
 delete mode 100644 slirp/state.h
