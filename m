Received: from eggs.gnu.org ([2001:4830:134:3::10]:35029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8HQ-0006lS-WA
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gI8HN-0005TZ-1i
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gI8HL-0005Qp-FK
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 04:24:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  1 Nov 2018 12:24:16 +0400
Message-Id: <20181101082423.26424-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/7] Chardev patches
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

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9=
cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1=
-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/chrdev-pull-request

for you to fetch changes up to 1ad723e98b8499d0690f7f7eafc945908a1db634:

  editorconfig: set emacs mode (2018-11-01 12:13:12 +0400)

----------------------------------------------------------------
- add websocket support
- socket: make 'fd' incompatible with 'reconnect'
- fix a websocket leak
- unrelated editorconfig patch that missed -trivial (included for
  convenience)
- v2: fix commit author field

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
