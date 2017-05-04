Received: from eggs.gnu.org ([2001:4830:134:3::10]:45749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6F9f-0002G3-Lp
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d6F9b-0004Bh-BK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d6F9b-0004BW-57
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:42:39 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 15:42:11 +0400
Message-Id: <20170504114232.20318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] Chr tests patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:

  Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)

are available in the git repository at:

  https://github.com/elmarco/qemu.git tags/chr-tests-pull-request

for you to fetch changes up to 79c8db5a13c0f4b73f930be0fcff9bbc1237c258:

  tests: add /char/console test (2017-05-04 15:34:42 +0400)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (21):
  char: remove qemu_chr_be_generic_open
  mux: simplfy muxes_realize_done
  xen: use a better chardev type check
  container: don't leak container reference
  char: add a /chardevs container
  vl: add todo note about root container cleanup
  char: use /chardevs container instead of chardevs list
  char: remove qemu_chardev_add
  char: remove chardevs list
  char: useless NULL check
  char-socket: introduce update_disconnected_filename()
  char-socket: update local address after listen
  char-socket: add 'addr' property
  char-socket: add 'connected' property
  char-udp: flush as much buffer as possible
  tests: add alias check in /char/ringbuf
  tests: add /char/pipe test
  tests: add /char/file test
  tests: add /char/socket test
  tests: add /char/udp test
  tests: add /char/console test

 chardev/char-mux.h          |   2 +-
 include/sysemu/char.h       |  10 --
 chardev/char-mux.c          |  11 +-
 chardev/char-pty.c          |   2 +-
 chardev/char-socket.c       |  46 +++++-
 chardev/char-udp.c          |  26 ++--
 chardev/char.c              | 148 ++++++++----------
 gdbstub.c                   |   4 +-
 hw/usb/ccid-card-passthru.c |   2 +-
 hw/usb/redirect.c           |   2 +-
 hw/xen/xen-common.c         |   2 +-
 net/vhost-user.c            |   2 +-
 qom/container.c             |   1 +
 tests/test-char.c           | 366 ++++++++++++++++++++++++++++++++++++++=
+++++-
 tests/vhost-user-test.c     |   2 +-
 ui/console.c                |   2 +-
 ui/gtk.c                    |   2 +-
 vl.c                        |   1 +
 18 files changed, 504 insertions(+), 127 deletions(-)

--=20
2.12.0.191.gc5d8de91d
