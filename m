Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIyBe-0004m9-Iq
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIyBb-0008NT-DM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIyBb-0008Ml-7E
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:13:19 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  8 Jun 2017 18:13:10 +0400
Message-Id: <20170608141313.27588-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Char patches
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

The following changes since commit 64175afc695c0672876fbbfc31b299c86d562c=
b4:

  arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-0=
7 17:21:44 +0100)

are available in the git repository at:

  https://github.com/elmarco/qemu.git tags/char-pull-request

for you to fetch changes up to 27d4c3789ddde40e1c7280150b46eb20a6a892e6:

  test-char: start a /char/serial test (2017-06-08 17:58:13 +0400)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (3):
  char: fix alias devices regression
  chardev: don't use alias names in parse_compat()
  test-char: start a /char/serial test

 include/chardev/char-parallel.h |  5 -----
 include/chardev/char-serial.h   |  8 --------
 include/qemu/osdep.h            | 13 +++++++++++++
 chardev/char.c                  |  4 ++--
 tests/test-char.c               | 29 +++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 15 deletions(-)

--=20
2.13.0.91.g00982b8dd
