Received: from eggs.gnu.org ([2001:4830:134:3::10]:40226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQI-000820-Tk
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZOQD-0004D2-P2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:10 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:41464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZOQC-00046I-7u
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:05:05 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:03:38 +0100
Message-Id: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/64] slirp updates
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

The following changes since commit e85c577158a2e8e252414959da9ef15c12eec6=
3d:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
8-12-17' into staging (2018-12-18 14:31:06 +0000)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 4c2b5ca1b5dd42bb96e954db7a46ebe39fd24620:

  slirp: Mark debugging calls as unlikely (2018-12-18 23:44:35 +0100)

----------------------------------------------------------------
Abstract away slirp toward a libslirp

Gerd Hoffmann (1):
  slirp: add tftp tracing

Marc-Andr=C3=A9 Lureau (61):
  slirp: associate slirp_output callback with the Slirp context
  slirp: remove do_pty from fork_exec()
  slirp: replace ex_pty with ex_chardev
  slirp: use a dedicated field for chardev pointer
  slirp: remove unused EMU_RSH
  slirp: rename /extra/chardev
  slirp: move internal function declarations
  slirp: remove Monitor dependency, return a string for info
  slirp: fix slirp_add_exec() leaks
  slirp: replace the poor-man string split with g_strsplit()
  slirp: remove dead declarations
  slirp: move socket pair creation in helper function
  slirp: remove unused M_TRAILINGSPACE
  slirp: use a callback structure to interface with qemu
  slirp: remove PROBE_CONN dead-code
  slirp: remove FULL_BOLT
  slirp: remove the disabled readv()/writev() code path
  slirp: remove HAVE_SYS_SIGNAL_H
  slirp: remove unused HAVE_SYS_BITYPES_H
  slirp: remove NO_UNIX_SOCKETS
  slirp: remove unused HAVE_SYS_STROPTS_H
  slirp: remove unused HAVE_ARPA_INET_H
  slirp: remove unused HAVE_SYS_WAIT_H
  slirp: remove unused HAVE_SYS_SELECT_H
  slirp: remove HAVE_SYS_IOCTL_H
  slirp: remove HAVE_SYS_FILIO_H
  slirp: remove unused DECLARE_IOVEC
  slirp: remove unused HAVE_INET_ATON
  slirp: replace HOST_WORDS_BIGENDIAN with glib equivalent
  slirp: replace SIZEOF_CHAR_P with glib equivalent
  slirp: replace compile time DO_KEEPALIVE
  slirp: remove unused global slirp_instance
  slirp: replace error_report() with g_critical()
  slirp: improve a bit the debug macros
  slirp: add a callback to log guest errors
  slirp: remove #if notdef dead code
  slirp: remove unused sbflush()
  slirp: NULL is defined by stddef.h
  slirp: remove dead TCP_ACK_HACK code
  slirp: replace ARRAY_SIZE with G_N_ELEMENTS
  net: do not depend on slirp internals
  glib-compat: add g_spawn_async_with_fds() fallback
  slirp: simplify fork_exec()
  slirp: replace error_report() with g_critical()
  slirp: drop <Vista compatibility
  slirp: rename exec_list
  slirp: use virtual time for packet expiration
  slirp: replace a fprintf with g_critical()
  slirp: replace some fprintf() with DEBUG_MISC
  slirp: replace a DEBUG block with WITH_ICMP_ERROR_MSG
  slirp: no need to make DPRINTF conditional on DEBUG
  slirp: always build with debug statements
  slirp: introduce SLIRP_DEBUG environment variable
  slirp: use %p for pointers format
  slirp: remove remaining DEBUG blocks
  slirp: replace DEBUG_ARGS with DEBUG_ARG
  slirp: factor out guestfwd addition checks
  slirp: add clock_get_ns() callback
  build-sys: use a seperate slirp-obj-y && slirp.mo
  slirp: set G_LOG_DOMAIN
  slirp: call into g_debug() for DEBUG macros

Samuel Thibault (2):
  slirp: Enable fork_exec support on Windows
  slirp: Mark debugging calls as unlikely

----------------------------------------------------------------
Gerd Hoffmann (1):
      slirp: add tftp tracing

Marc-Andr=C3=A9 Lureau (61):
      slirp: associate slirp_output callback with the Slirp context
      slirp: remove do_pty from fork_exec()
      slirp: replace ex_pty with ex_chardev
      slirp: use a dedicated field for chardev pointer
      slirp: remove unused EMU_RSH
      slirp: rename /extra/chardev
      slirp: move internal function declarations
      slirp: remove Monitor dependency, return a string for info
      slirp: fix slirp_add_exec() leaks
      slirp: replace the poor-man string split with g_strsplit()
      slirp: remove dead declarations
      slirp: move socket pair creation in helper function
      slirp: remove unused M_TRAILINGSPACE
      slirp: use a callback structure to interface with qemu
      slirp: remove PROBE_CONN dead-code
      slirp: remove FULL_BOLT
      slirp: remove the disabled readv()/writev() code path
      slirp: remove HAVE_SYS_SIGNAL_H
      slirp: remove unused HAVE_SYS_BITYPES_H
      slirp: remove NO_UNIX_SOCKETS
      slirp: remove unused HAVE_SYS_STROPTS_H
      slirp: remove unused HAVE_ARPA_INET_H
      slirp: remove unused HAVE_SYS_WAIT_H
      slirp: remove unused HAVE_SYS_SELECT_H
      slirp: remove HAVE_SYS_IOCTL_H
      slirp: remove HAVE_SYS_FILIO_H
      slirp: remove unused DECLARE_IOVEC
      slirp: remove unused HAVE_INET_ATON
      slirp: replace HOST_WORDS_BIGENDIAN with glib equivalent
      slirp: replace SIZEOF_CHAR_P with glib equivalent
      slirp: replace compile time DO_KEEPALIVE
      slirp: remove unused global slirp_instance
      slirp: replace error_report() with g_critical()
      slirp: improve a bit the debug macros
      slirp: add a callback to log guest errors
      slirp: remove #if notdef dead code
      slirp: remove unused sbflush()
      slirp: NULL is defined by stddef.h
      slirp: remove dead TCP_ACK_HACK code
      slirp: replace ARRAY_SIZE with G_N_ELEMENTS
      net: do not depend on slirp internals
      glib-compat: add g_spawn_async_with_fds() fallback
      slirp: simplify fork_exec()
      slirp: replace error_report() with g_critical()
      slirp: drop <Vista compatibility
      slirp: rename exec_list
      slirp: use virtual time for packet expiration
      slirp: replace a fprintf with g_critical()
      slirp: replace some fprintf() with DEBUG_MISC
      slirp: replace a DEBUG block with WITH_ICMP_ERROR_MSG
      slirp: no need to make DPRINTF conditional on DEBUG
      slirp: always build with debug statements
      slirp: introduce SLIRP_DEBUG environment variable
      slirp: use %p for pointers format
      slirp: remove remaining DEBUG blocks
      slirp: replace DEBUG_ARGS with DEBUG_ARG
      slirp: factor out guestfwd addition checks
      slirp: add clock_get_ns() callback
      build-sys: use a seperate slirp-obj-y && slirp.mo
      slirp: set G_LOG_DOMAIN
      slirp: call into g_debug() for DEBUG macros

Samuel Thibault (2):
      slirp: Enable fork_exec support on Windows
      slirp: Mark debugging calls as unlikely

 Makefile.objs         |   4 +-
 Makefile.target       |   5 +-
 include/glib-compat.h |  56 ++++++++++
 net/colo-compare.c    |  11 +-
 net/colo.c            |   1 +
 net/colo.h            |   7 +-
 net/filter-rewriter.c |   9 +-
 net/slirp.c           |  61 +++++------
 net/util.h            |  55 ++++++++++
 slirp/Makefile.objs   |  37 ++++++-
 slirp/arp_table.c     |  12 +--
 slirp/bootp.c         |  10 +-
 slirp/cksum.c         |   8 +-
 slirp/debug.h         |  47 +++++----
 slirp/dhcpv6.c        |  17 ++-
 slirp/if.c            |   4 +-
 slirp/ip.h            |  10 +-
 slirp/ip6.h           |   3 +-
 slirp/ip6_icmp.c      |  27 +++--
 slirp/ip6_icmp.h      |   6 +-
 slirp/ip6_input.c     |   2 +-
 slirp/ip6_output.c    |   4 +-
 slirp/ip_icmp.c       |  31 +++---
 slirp/ip_input.c      | 200 -----------------------------------
 slirp/libslirp.h      |  27 +++--
 slirp/main.h          |  33 ------
 slirp/mbuf.c          |   2 +-
 slirp/mbuf.h          |   1 -
 slirp/misc.c          | 286 ++++++++++++++++++++------------------------=
------
 slirp/misc.h          |  13 ++-
 slirp/ncsi.c          |   4 +-
 slirp/ndp_table.c     |  32 +++---
 slirp/sbuf.h          |   1 -
 slirp/slirp.c         | 177 +++++++++++++++----------------
 slirp/slirp.h         |  45 ++------
 slirp/slirp_config.h  |  86 ---------------
 slirp/socket.c        |  53 +++-------
 slirp/socket.h        |   2 +-
 slirp/tcp.h           |   4 +-
 slirp/tcp_input.c     |  84 ++-------------
 slirp/tcp_output.c    |   2 +-
 slirp/tcp_subr.c      |  17 ++-
 slirp/tcp_timer.c     |   2 +-
 slirp/tftp.c          |   7 +-
 slirp/trace-events    |   5 +
 slirp/udp.c           |   5 +-
 slirp/udp6.c          |  11 +-
 stubs/slirp.c         |   2 +-
 48 files changed, 595 insertions(+), 933 deletions(-)
 delete mode 100644 slirp/slirp_config.h
 create mode 100644 slirp/trace-events
