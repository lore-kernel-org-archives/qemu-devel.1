Received: from eggs.gnu.org ([2001:4830:134:3::10]:40134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evoPz-0000zi-Vn
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evoPv-0007FT-Vq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evoPv-0007FA-RI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:12:55 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 13 Mar 2018 18:12:39 +0000
Message-Id: <20180313181248.16215-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/9] Socket next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit 59667bb167f773965ce6547352f312eff0d4d5=
23:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2018-03-13 14:02:47 +0000)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/socket-next-pull-request

for you to fetch changes up to 0935700f8544033ebbd41e1f13cd528f8a58d24d:

  char: allow passing pre-opened socket file descriptor at startup (2018-=
03-13 18:06:06 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (9):
  char: don't silently skip tn3270 protocol init when TLS is enabled
  cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int
    types
  sockets: pull code for testing IP availability out of specific test
  sockets: strengthen test suite IP protocol availability checks
  sockets: move fd_is_socket() into common sockets code
  sockets: check that the named file descriptor is a socket
  sockets: allow SocketAddress 'fd' to reference numeric file
    descriptors
  char: refactor parsing of socket address information
  char: allow passing pre-opened socket file descriptor at startup

 chardev/char-socket.c          |  34 ++-
 chardev/char.c                 |   3 +
 include/qemu/cutils.h          |   4 +
 include/qemu/sockets.h         |   1 +
 io/channel-util.c              |  13 -
 qapi/sockets.json              |   7 +
 tests/.gitignore               |   1 +
 tests/Makefile.include         |   5 +-
 tests/socket-helpers.c         | 149 ++++++++++
 tests/socket-helpers.h         |  42 +++
 tests/test-char.c              |  47 ++-
 tests/test-cutils.c            | 657 +++++++++++++++++++++++++++++++++++=
++++++
 tests/test-io-channel-socket.c |  72 +----
 tests/test-util-sockets.c      | 266 +++++++++++++++++
 util/cutils.c                  | 109 +++++++
 util/qemu-sockets.c            |  36 ++-
 16 files changed, 1348 insertions(+), 98 deletions(-)
 create mode 100644 tests/socket-helpers.c
 create mode 100644 tests/socket-helpers.h
 create mode 100644 tests/test-util-sockets.c

--=20
2.14.3
