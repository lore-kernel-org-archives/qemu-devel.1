Received: from eggs.gnu.org ([209.51.188.92]:59658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmCR-0007dT-3E
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmCP-0006IW-0Z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:06:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grmCO-0005yi-Nt
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:06:48 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  7 Feb 2019 17:05:59 +0100
Message-Id: <20190207160617.1142-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peter.maydell@linaro.org

The following changes since commit 632351e0e1a861f2eaf709b053c53f96a12258=
25:

  Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request' i=
nto staging (2019-02-07 14:20:46 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/chardev-pull-request

for you to fetch changes up to df3afdedd23ade0c9de55cadeb1d85055689023f:

  tests/test-char: add muxed chardev testing for open/close (2019-02-07 1=
6:18:25 +0100)

----------------------------------------------------------------
Various chardev fixes

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

 include/chardev/char-fe.h      |  18 +-
 include/io/task.h              |  29 +-
 chardev/char-fe.c              |  33 +-
 chardev/char-mux.c             |  16 +-
 chardev/char-serial.c          |   2 +-
 chardev/char-socket.c          | 487 ++++++++++++++++------
 chardev/char.c                 |   2 +
 io/task.c                      |  98 +++--
 tests/ivshmem-test.c           |   2 +-
 tests/libqtest.c               |   4 +-
 tests/test-char.c              | 723 +++++++++++++++++++++++++--------
 tests/test-filter-redirector.c |   4 +-
 io/trace-events                |   2 +
 13 files changed, 1061 insertions(+), 359 deletions(-)

--=20
2.20.1.519.g8feddda32c
