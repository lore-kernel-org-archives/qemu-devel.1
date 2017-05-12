Received: from eggs.gnu.org ([2001:4830:134:3::10]:44118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9Bh7-0004Wn-0I
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9Bh3-0004eS-V6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d9Bh3-0004di-Oe
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:37:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 12 May 2017 10:37:14 -0400
Message-Id: <20170512143717.30391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/3] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c5269=
49:

  maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -04=
00)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 321d1dba8bef9676a77e9399484e3cd8bf2cf16a:

  aio: add missing aio_notify() to aio_enable_external() (2017-05-12 10:3=
6:46 -0400)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (1):
  coroutine: remove GThread implementation

Eric Blake (1):
  block: Simplify BDRV_BLOCK_RAW recursion

Stefan Hajnoczi (1):
  aio: add missing aio_notify() to aio_enable_external()

 configure                |  19 ++---
 include/block/aio.h      |  10 ++-
 block/io.c               |   4 +-
 util/coroutine-gthread.c | 198 -----------------------------------------=
------
 .travis.yml              |   5 +-
 5 files changed, 16 insertions(+), 220 deletions(-)
 delete mode 100644 util/coroutine-gthread.c

--=20
2.9.3
