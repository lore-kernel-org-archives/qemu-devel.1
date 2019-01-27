Received: from eggs.gnu.org ([209.51.188.92]:52561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCD-0001Ou-7E
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCA-0007P8-Br
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:53 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:43228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCA-00072x-0l
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:50 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:04:55 +0100
Message-Id: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/31] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit ad7a21e81231ae64540310384fb0f87ac8758b=
02:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2019-01-25 17:22:20 +0000)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 10163f695fe66f9d3d099a33752996dae70be98c:

  slirp: API is extern C (2019-01-27 13:03:59 +0100)

----------------------------------------------------------------
More work towards libslirp

Marc-Andr=C3=A9 Lureau (27):
  slirp: generalize guestfwd with a callback based approach
  net/slirp: simplify checking for cmd: prefix
  net/slirp: free forwarding rules on cleanup
  net/slirp: fix leaks on forwarding rule registration error
  slirp: add callbacks for timer
  slirp: replace trace functions with DEBUG calls
  slirp: replace QEMU_PACKED with SLIRP_PACKED
  slirp: replace most qemu socket utilities with slirp own version
  slirp: replace qemu_set_nonblock()
  slirp: add unregister_poll_fd() callback
  slirp: replace qemu_notify_event() with a callback
  slirp: move QEMU state saving to a separate unit
  slirp: do not include qemu headers in libslirp.h public API header
  slirp: improve windows headers inclusion
  slirp: add slirp own version of pstrcpy
  slirp: remove qemu timer.h dependency
  slirp: remove now useless QEMU headers inclusions
  slirp: replace net/eth.h inclusion with own defines
  slirp: replace qemu qtailq with slirp own copy
  slirp: replace remaining qemu headers dependency
  slirp: prefer c99 types over BSD kind
  slirp: improve send_packet() callback
  slirp: replace global polling with per-instance & notifier
  slirp: remove slirp_instances list
  slirp: use polling callbacks, drop glib requirement
  slirp: pass opaque to all callbacks
  slirp: API is extern C

Peter Maydell (2):
  slirp: Avoid marking naturally packed structs as QEMU_PACKED
  slirp: Don't mark struct ipq or struct ipasfrag as packed

Samuel Thibault (2):
  slirp: Avoid unaligned 16bit memory access
  slirp: replace QEMU_BUILD_BUG_ON with G_STATIC_ASSERT

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (27):
      slirp: generalize guestfwd with a callback based approach
      net/slirp: simplify checking for cmd: prefix
      net/slirp: free forwarding rules on cleanup
      net/slirp: fix leaks on forwarding rule registration error
      slirp: add callbacks for timer
      slirp: replace trace functions with DEBUG calls
      slirp: replace QEMU_PACKED with SLIRP_PACKED
      slirp: replace most qemu socket utilities with slirp own version
      slirp: replace qemu_set_nonblock()
      slirp: add unregister_poll_fd() callback
      slirp: replace qemu_notify_event() with a callback
      slirp: move QEMU state saving to a separate unit
      slirp: do not include qemu headers in libslirp.h public API header
      slirp: improve windows headers inclusion
      slirp: add slirp own version of pstrcpy
      slirp: remove qemu timer.h dependency
      slirp: remove now useless QEMU headers inclusions
      slirp: replace net/eth.h inclusion with own defines
      slirp: replace qemu qtailq with slirp own copy
      slirp: replace remaining qemu headers dependency
      slirp: prefer c99 types over BSD kind
      slirp: improve send_packet() callback
      slirp: replace global polling with per-instance & notifier
      slirp: remove slirp_instances list
      slirp: use polling callbacks, drop glib requirement
      slirp: pass opaque to all callbacks
      slirp: API is extern C

Peter Maydell (2):
      slirp: Avoid marking naturally packed structs as QEMU_PACKED
      slirp: Don't mark struct ipq or struct ipasfrag as packed

Samuel Thibault (2):
      slirp: Avoid unaligned 16bit memory access
      slirp: replace QEMU_BUILD_BUG_ON with G_STATIC_ASSERT

 Makefile.objs            |   1 -
 include/net/net.h        |   2 +-
 include/qemu/main-loop.h |  15 +
 net/net.c                |   4 +-
 net/slirp.c              | 185 ++++++++-
 slirp/Makefile.objs      |   4 +-
 slirp/arp_table.c        |   1 -
 slirp/bootp.c            |   1 -
 slirp/cksum.c            |   1 -
 slirp/debug.h            |  13 +-
 slirp/dhcpv6.c           |   4 +-
 slirp/dnssearch.c        |   1 -
 slirp/if.c               |   4 +-
 slirp/ip.h               |  17 +-
 slirp/ip6.h              |  13 +-
 slirp/ip6_icmp.c         |  27 +-
 slirp/ip6_icmp.h         |  26 +-
 slirp/ip6_input.c        |   1 -
 slirp/ip6_output.c       |   2 -
 slirp/ip_icmp.c          |  14 +-
 slirp/ip_icmp.h          |  18 +-
 slirp/ip_input.c         |   5 +-
 slirp/ip_output.c        |   1 -
 slirp/libslirp.h         |  71 +++-
 slirp/main.h             |   2 +-
 slirp/mbuf.c             |   1 -
 slirp/mbuf.h             |   2 +-
 slirp/misc.c             |  64 ++--
 slirp/misc.h             |  15 +-
 slirp/ncsi.c             |   3 +-
 slirp/ndp_table.c        |   2 -
 slirp/qtailq.h           | 193 ++++++++++
 slirp/sbuf.c             |   8 +-
 slirp/sbuf.h             |   2 +-
 slirp/slirp.c            | 980 +++++++++++++++--------------------------=
------
 slirp/slirp.h            |  45 +--
 slirp/socket.c           |  33 +-
 slirp/socket.h           |   9 +-
 slirp/state.c            | 394 +++++++++++++++++++
 slirp/state.h            |   9 +
 slirp/tcp_input.c        |  29 +-
 slirp/tcp_output.c       |  13 +-
 slirp/tcp_subr.c         |  49 +--
 slirp/tcp_timer.c        |   3 +-
 slirp/tcp_var.h          |  14 +-
 slirp/tftp.c             |  16 +-
 slirp/trace-events       |   5 -
 slirp/udp.c              |  16 +-
 slirp/udp.h              |   2 +-
 slirp/udp6.c             |   2 -
 slirp/util.c             | 207 ++++++++++
 slirp/util.h             | 127 ++++++
 stubs/Makefile.objs      |   3 +-
 stubs/slirp.c            |  13 -
 util/main-loop.c         |  30 +-
 util/osdep.c             |   2 +-
 56 files changed, 1762 insertions(+), 962 deletions(-)
 create mode 100644 slirp/qtailq.h
 create mode 100644 slirp/state.c
 create mode 100644 slirp/state.h
 delete mode 100644 slirp/trace-events
 create mode 100644 slirp/util.c
 create mode 100644 slirp/util.h
 delete mode 100644 stubs/slirp.c
