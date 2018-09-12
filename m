Received: from eggs.gnu.org ([2001:4830:134:3::10]:39560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1g052r-00082M-UN
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 09:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1g052r-000320-4O
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 09:19:01 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 12 Sep 2018 09:18:49 -0400
Message-Id: <20180912131853.1249324-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 8af2eb7b43a1b694fd6d1d090025027d6b72caac:

  block/rbd: add deprecation documentation for filename keyvalue pairs (2018-09-12 08:51:45 -0400)

----------------------------------------------------------------
Block patches for RBD
----------------------------------------------------------------

Jeff Cody (4):
  block/rbd: pull out qemu_rbd_convert_options
  block/rbd: Attempt to parse legacy filenames
  block/rbd: add iotest for rbd legacy keyvalue filename parsing
  block/rbd: add deprecation documentation for filename keyvalue pairs

 block/rbd.c                | 89 ++++++++++++++++++++++++++++++++------
 qemu-deprecated.texi       | 15 +++++++
 tests/qemu-iotests/231     | 62 ++++++++++++++++++++++++++
 tests/qemu-iotests/231.out |  9 ++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 162 insertions(+), 14 deletions(-)
 create mode 100755 tests/qemu-iotests/231
 create mode 100644 tests/qemu-iotests/231.out

-- 
2.17.1
