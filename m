Received: from eggs.gnu.org ([2001:4830:134:3::10]:51032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxt-0002DO-KO
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxs-0005Ar-Nm
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 23 Jul 2018 18:45:23 +0200
Message-Id: <20180723164530.26599-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

The following changes since commit 55b1f14cefcb19ce6d5e28c4c83404230888aa7e:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-07-23 14:03:14 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 3e31b4e17064d22e533071aaa57d3f01499ef910:

  block/vvfat: Disable debug message by default (2018-07-23 16:50:43 +0200)

----------------------------------------------------------------
Block layer patches:

- vvfat: Disable debug message by default
- qemu-iotests fixes
- Fix typos in comments

----------------------------------------------------------------
John Snow (1):
      iotests: remove LUKS support from test 226

Kevin Wolf (1):
      qemu-iotests: Use host_device instead of file in 149

Max Reitz (2):
      iotest: Fix filtering order in 226
      iotests: Disallow compat=0.10 in 223

Peter Lieven (1):
      qemu-img: avoid overflow of min_sparse parameter

Stefan Weil (1):
      block: Fix typos in comments (found by codespell)

Thomas Huth (1):
      block/vvfat: Disable debug message by default

 block.c                    |   2 +-
 block/backup.c             |   4 +-
 block/curl.c               |   2 +-
 block/gluster.c            |   2 +-
 block/vhdx.c               |   2 +-
 block/vvfat.c              |   4 +-
 qemu-img.c                 |  16 ++-
 tests/qemu-iotests/149     |   2 +-
 tests/qemu-iotests/149.out | 344 ++++++++++++++++++++++-----------------------
 tests/qemu-iotests/223     |   2 +
 tests/qemu-iotests/226     |   7 +-
 11 files changed, 199 insertions(+), 188 deletions(-)
