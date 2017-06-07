Received: from eggs.gnu.org ([2001:4830:134:3::10]:40826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIg1S-0000IQ-RA
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIg1O-0003vE-VU
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIg1O-0003um-PL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:49:34 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 22:49:18 +0400
Message-Id: <20170607184921.28407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] char: fix chardev aliases regression
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

Marc-Andr=C3=A9 Lureau (3):
  char: fix alias devices regression
  chardev: don't use alias names in parse_compat()
  test-char: start a /char/serial test

 chardev/char.c    |  6 ++++--
 tests/test-char.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

--=20
2.13.0.91.g00982b8dd
