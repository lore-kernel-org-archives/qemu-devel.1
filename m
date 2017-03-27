Received: from eggs.gnu.org ([2001:4830:134:3::10]:53110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWwn-0001R9-SB
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWwn-0006Bt-7k
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:52:45 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 27 Mar 2017 17:52:28 +0200
Message-Id: <20170327155234.10980-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Block patches for rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit ea2afcf5b6727a577cf561fd8fe0d8c397ecc9=
27:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2017-03-24 14:14:18 +0000)

are available in the git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2017-03-27

for you to fetch changes up to 700f9ce0f9f49675818ac95c8953cbc65aa1d112:

  block/file-posix.c: Fix unused variable warning on OpenBSD (2017-03-27 =
17:28:34 +0200)

----------------------------------------------------------------
Block patches for 2.9-rc2.

----------------------------------------------------------------
Hi Peter,

This pull request contains your build fix for OpenBSD on top so you can
just drop it if you have merged it yourself already.


Thanks,

Max

----------------------------------------------------------------
Kevin Wolf (1):
      file-posix: Make bdrv_flush() failure permanent without O_DIRECT

Paolo Bonzini (1):
      nbd-client: fix handling of hungup connections

Peter Maydell (1):
      block/file-posix.c: Fix unused variable warning on OpenBSD

Stefan Hajnoczi (3):
      qemu-img: show help for invalid global options
      qemu-img: fix switch indentation in img_amend()
      qemu-img: print short help on getopt failure

 block/file-posix.c |  50 ++++++++++----
 block/nbd-client.c |  12 ++--
 nbd/client.c       |   2 +-
 qemu-img.c         | 196 +++++++++++++++++++++++++++++++++++++----------=
------
 4 files changed, 180 insertions(+), 80 deletions(-)

--=20
2.12.1
