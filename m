Received: from eggs.gnu.org ([2001:4830:134:3::10]:53700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHXwj-0007eo-1g
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHXwb-0008UL-DD
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:36:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gHXwX-0008Ne-Pg
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:36:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Oct 2018 21:36:20 +0400
Message-Id: <20181030173627.7711-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit 3f3285491dd52014852a56135c90e428c8b507=
ea:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2018-10-30 14:09:25 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/chrdev-pull-request

for you to fetch changes up to 22333dd533e2a93d9da18479aee5fb49302c7933:

  editorconfig: set emacs mode (2018-10-30 21:30:22 +0400)

----------------------------------------------------------------
- add websocket support
- socket: make 'fd' incompatible with 'reconnect'
- fix a websocket leak
- unrelated editorconfig patch that missed -trivial (included for
  convenience)

----------------------------------------------------------------

Julia Suvorova (3):
  chardev/char-socket: Function headers refactoring
  chardev: Add websocket support
  tests/test-char: Check websocket chardev functionality

Marc-Andr=C3=A9 Lureau (4):
  websock: fix handshake leak
  char-socket: correctly set has_reconnect when parsing QemuOpts
  char-socket: make 'fd' incompatible with 'reconnect'
  editorconfig: set emacs mode

 qapi/char.json        |   3 +
 chardev/char-socket.c | 123 ++++++++++++++++++++++++++++++-----------
 chardev/char.c        |   8 ++-
 io/channel-websock.c  |   1 +
 tests/test-char.c     | 125 ++++++++++++++++++++++++++++++++++++++++++
 .editorconfig         |  21 ++++++-
 qemu-options.hx       |  13 ++++-
 7 files changed, 257 insertions(+), 37 deletions(-)

--=20
2.19.1.708.g4ede3d42df
