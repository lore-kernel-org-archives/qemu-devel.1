Received: from eggs.gnu.org ([2001:4830:134:3::10]:33098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4Os-0001sB-0l
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fG4Or-0004Ca-4g
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:19:34 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  8 May 2018 11:19:20 -0400
Message-Id: <20180508151924.18741-1-jcody@redhat.com>
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
Cc: peter.maydell@linaro.org, sheepdog@lists.wpkg.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

The following changes since commit d01beac177d44491d7db8747b79d94e1b53d173b:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180507-pull-request' into staging (2018-05-08 14:23:02 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to a2cb9239b7610ffb00f9ced5cd7640d40b0e1ccf:

  sheepdog: Fix sd_co_create_opts() memory leaks (2018-05-08 10:47:27 -0400)

----------------------------------------------------------------
Block patches
----------------------------------------------------------------

Kevin Wolf (1):
  sheepdog: Fix sd_co_create_opts() memory leaks

Max Reitz (2):
  block/mirror: Make cancel always cancel pre-READY
  iotests: Add test for cancelling a mirror job

Stefan Hajnoczi (1):
  block/mirror: honor ratelimit again

 block/mirror.c             |  14 +++--
 block/sheepdog.c           |   4 +-
 tests/qemu-iotests/185.out |   4 +-
 tests/qemu-iotests/218     | 138 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/218.out |  30 ++++++++++
 tests/qemu-iotests/group   |   1 +
 6 files changed, 183 insertions(+), 8 deletions(-)
 create mode 100644 tests/qemu-iotests/218
 create mode 100644 tests/qemu-iotests/218.out

-- 
2.13.6
