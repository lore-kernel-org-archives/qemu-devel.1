Received: from eggs.gnu.org ([2001:4830:134:3::10]:51829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0Ybs-0003xB-I6
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0Ybr-0000HM-Gs
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:20:52 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 26 Mar 2018 22:20:35 +0200
Message-Id: <20180326202039.21070-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Block patches for 2.12.0-rc1
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

The following changes since commit 7b93d78a04aa242d377ae213b79db6c319c71847:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-03-26 15:17:25 +0100)

are available in the Git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2018-03-26

for you to fetch changes up to a77672ea3d95094a0cb4f974de84fb7353c67cc0:

  vmdk: return ERROR when cluster sector is larger than vmdk limitation (2018-03-26 21:17:24 +0200)

----------------------------------------------------------------
A fix for dirty bitmap migration through shared storage, and a VMDK
patch keeping us from creating too large extents.

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (3):
  qcow2-bitmap: add qcow2_reopen_bitmaps_rw_hint()
  qcow2: fix bitmaps loading when bitmaps already exist
  iotests: enable shared migration cases in 169

yuchenlin (1):
  vmdk: return ERROR when cluster sector is larger than vmdk limitation

 block/qcow2.h              |  2 ++
 block/qcow2-bitmap.c       | 15 ++++++++++++++-
 block/qcow2.c              | 17 ++++++++++++++++-
 block/vmdk.c               |  6 ++++++
 tests/qemu-iotests/169     |  8 +++-----
 tests/qemu-iotests/169.out |  4 ++--
 6 files changed, 43 insertions(+), 9 deletions(-)

-- 
2.14.3
