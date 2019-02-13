Received: from eggs.gnu.org ([209.51.188.92]:39211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG6-00045X-Cx
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG2-0005KJ-4n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49227)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxG1-00058S-F6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:18:48 +0100
Message-Id: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/25] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc=
06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-02-12 10:53:37 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/chardev-pull-request

for you to fetch changes up to f7ea2038bea04628eaa55156fc34edf9d0c4a2bb:

  char-pty: remove write_lock usage (2019-02-13 16:46:39 +0100)

----------------------------------------------------------------
Chardev fixes

----------------------------------------------------------------

Artem Pisarenko (2):
  chardev: fix mess in OPENED/CLOSED events when muxed
  tests/test-char: add muxed chardev testing for open/close

Daniel P. Berrang=C3=A9 (16):
  io: store reference to thread information in the QIOTask struct
  io: add qio_task_wait_thread to join with a background thread
  chardev: fix validation of options for QMP created chardevs
  chardev: forbid 'reconnect' option with server sockets
  chardev: forbid 'wait' option with client sockets
  chardev: remove many local variables in qemu_chr_parse_socket
  chardev: ensure qemu_chr_parse_compat reports missing driver error
  chardev: remove unused 'sioc' variable & cleanup paths
  chardev: split tcp_chr_wait_connected into two methods
  chardev: split up qmp_chardev_open_socket connection code
  chardev: use a state machine for socket connection state
  chardev: honour the reconnect setting in tcp_chr_wait_connected
  chardev: disallow TLS/telnet/websocket with tcp_chr_wait_connected
  chardev: fix race with client connections in tcp_chr_wait_connected
  tests: expand coverage of socket chardev test
  chardev: ensure termios is fully initialized

Marc-Andr=C3=A9 Lureau (5):
  char: update the mux handlers in class callback
  terminal3270: do not use backend timer sources
  chardev: add a note about frontend sources and context switch
  char-pty: remove the check for connection on write
  char-pty: remove write_lock usage

Paolo Bonzini (1):
  char: allow specifying a GMainContext at opening time

Philippe Mathieu-Daud=C3=A9 (1):
  chardev/wctablet: Fix a typo

 include/chardev/char-fe.h      |  21 +-
 include/chardev/char-mux.h     |   1 -
 include/chardev/char.h         |  16 +-
 include/io/task.h              |  29 +-
 chardev/char-fe.c              |  35 +-
 chardev/char-mux.c             |  19 +-
 chardev/char-pty.c             |  56 +--
 chardev/char-serial.c          |   2 +-
 chardev/char-socket.c          | 490 +++++++++++++++------
 chardev/char.c                 |  34 +-
 chardev/wctablet.c             |   2 +-
 gdbstub.c                      |   4 +-
 hmp.c                          |   2 +-
 hw/arm/omap2.c                 |   2 +-
 hw/bt/hci-csr.c                |   2 +-
 hw/char/omap_uart.c            |   4 +-
 hw/char/terminal3270.c         |  15 +-
 hw/char/xen_console.c          |   3 +-
 hw/isa/isa-superio.c           |   4 +-
 hw/mips/boston.c               |   2 +-
 hw/mips/mips_malta.c           |   2 +-
 hw/usb/dev-serial.c            |   2 +-
 io/task.c                      | 101 +++--
 net/slirp.c                    |   2 +-
 qtest.c                        |   2 +-
 tests/ivshmem-test.c           |   2 +-
 tests/libqtest.c               |   4 +-
 tests/test-char.c              | 757 +++++++++++++++++++++++++--------
 tests/test-filter-redirector.c |   4 +-
 tests/vhost-user-test.c        |   2 +-
 vl.c                           |   8 +-
 io/trace-events                |   2 +
 32 files changed, 1150 insertions(+), 481 deletions(-)

--=20
2.21.0.rc0.1.g036caf7885
