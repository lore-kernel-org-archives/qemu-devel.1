Received: from eggs.gnu.org ([2001:4830:134:3::10]:46980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIw6Q-0004l6-Jr
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIw6L-0003E1-Q7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:59:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIw6L-0003DH-Jx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:59:45 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  8 Jun 2017 15:59:36 +0400
Message-Id: <20170608115939.30985-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] char: fix chardev aliases regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The patch "char: move CharBackend handling in char-fe unit" broke
chardev aliases. Here is a small series to fix it, and add a simple
unit test to check the alias keep working.

v2:
- move HAVE_CHARDEV_* in osdep.h (Markus Armbruster)
- add r-b tags from Eric for the patches that didn't change

Marc-Andr=C3=A9 Lureau (3):
  char: fix alias devices regression
  chardev: don't use alias names in parse_compat()
  test-char: start a /char/serial test

 include/chardev/char-parallel.h |  5 -----
 include/chardev/char-serial.h   |  8 --------
 include/qemu/osdep.h            | 13 +++++++++++++
 chardev/char.c                  |  4 ++--
 tests/test-char.c               | 30 ++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 15 deletions(-)

--=20
2.13.0.91.g00982b8dd
