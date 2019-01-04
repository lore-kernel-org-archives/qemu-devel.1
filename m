Received: from eggs.gnu.org ([208.118.235.92]:51368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNY7-0002IY-TW
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNY7-0005Jg-8K
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:21:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  4 Jan 2019 11:21:41 +0000
Message-Id: <20190104112145.12413-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org

The following changes since commit 20d6c7312f1b812bb9c750f4087f69ac8485cc=
90:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-=
part1' into staging (2019-01-03 13:26:30 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 39a0408e768cd00142f5b57d27ab234282bf4df5:

  dmg: don't skip zero chunk (2019-01-04 11:15:09 +0000)

----------------------------------------------------------------
Pull request

Bug fixes for the .dmg image file format.

----------------------------------------------------------------

Julio Faracco (1):
  dmg: Fixing wrong dmg block type value for block terminator.

yuchenlin (3):
  dmg: fix binary search
  dmg: use enumeration type instead of hard coding number
  dmg: don't skip zero chunk

 block/dmg.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--=20
2.20.1
