Received: from eggs.gnu.org ([209.51.188.92]:33155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr44f-0005fy-1j
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr44c-0005v9-Dg
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:52 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gr44b-0005lf-Eo
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:59:49 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Tue,  5 Feb 2019 18:58:55 +0200
Message-Id: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv2 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a356e15=
9d:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pull-requ=
est' into staging (2019-02-05 14:01:29 +0000)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to cf20be34d44a953c9b52a4d5cf6f4232968e6f3c:

  slirp: API is extern C (2019-02-05 18:56:17 +0200)

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

Samuel Thibault (3):
  slirp: Avoid unaligned 16bit memory access
  slirp: replace QEMU_BUILD_BUG_ON with G_STATIC_ASSERT
  slirp: Move g_spawn_async_with_fds_qemu compatibility to slirp/

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

Samuel Thibault (3):
      slirp: Avoid unaligned 16bit memory access
      slirp: replace QEMU_BUILD_BUG_ON with G_STATIC_ASSERT
      slirp: Move g_spawn_async_with_fds_qemu compatibility to slirp/

 Makefile.objs            |   1 -
 include/glib-compat.h    |  57 ---
 include/net/net.h        |   2 +-
 include/qemu/main-loop.h |  15 +
 net/net.c                |   4 +-
 net/slirp.c              | 185 ++++++++-
 slirp/Makefile.objs      |   4 +-
 slirp/arp_table.c        |   3 +-
 slirp/bootp.c            |   1 -
 slirp/cksum.c            |   1 -
 slirp/debug.h            |  13 +-
 slirp/dhcpv6.c           |   4 +-
 slirp/dnssearch.c        |   1 -
 slirp/if.c               |   4 +-
 slirp/ip.h               |  17 +-
 slirp/ip6.h              |  14 +-
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
 slirp/misc.c             | 126 ++++--
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
 57 files changed, 1827 insertions(+), 1019 deletions(-)
 create mode 100644 slirp/qtailq.h
 create mode 100644 slirp/state.c
 create mode 100644 slirp/state.h
 delete mode 100644 slirp/trace-events
 create mode 100644 slirp/util.c
 create mode 100644 slirp/util.h
 delete mode 100644 stubs/slirp.c
