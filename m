Received: from eggs.gnu.org ([2001:4830:134:3::10]:42343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKjz-000599-N6
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKjv-0005li-Pq
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKjv-0005lG-Jq
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:21:55 +0100
Message-Id: <20170831082210.8362-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.10 00/15] Block patches
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

The following changes since commit 248b23735645f7cbb503d9be6f5bf825f2a603=
ab:

  Update version for v2.10.0-rc4 release (2017-08-24 17:34:26 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 3e4c705212abfe8c9882a00beb2d1466a8a53cec:

  qcow2: allocate cluster_cache/cluster_data on demand (2017-08-30 18:02:=
10 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Alberto Garcia (8):
  throttle: Fix wrong variable name in the header documentation
  throttle: Update the throttle_fix_bucket() documentation
  throttle: Make throttle_is_valid() a bit less verbose
  throttle: Remove throttle_fix_bucket() / throttle_unfix_bucket()
  throttle: Make LeakyBucket.avg and LeakyBucket.max integer types
  throttle: Make burst_length 64bit and add range checks
  throttle: Test the valid range of config values
  misc: Remove unused Error variables

Dan Aloni (1):
  nvme: Fix get/set number of queues feature, again

Eduardo Habkost (1):
  oslib-posix: Print errors before aborting on qemu_alloc_stack()

Fred Rolland (1):
  qemu-doc: Add UUID support in initiator name

Stefan Hajnoczi (4):
  scripts: add argparse module for Python 2.6 compatibility
  docker.py: Python 2.6 argparse compatibility
  tests: migration/guestperf Python 2.6 argparse compatibility
  qcow2: allocate cluster_cache/cluster_data on demand

 include/qemu/throttle.h            |    8 +-
 block/qcow.c                       |   12 +-
 block/qcow2-cluster.c              |   17 +
 block/qcow2.c                      |   20 +-
 dump.c                             |    4 +-
 hw/block/nvme.c                    |    4 +-
 tests/test-throttle.c              |   80 +-
 util/oslib-posix.c                 |    2 +
 util/throttle.c                    |   86 +-
 COPYING.PYTHON                     |  270 ++++
 qemu-doc.texi                      |    5 +-
 scripts/argparse.py                | 2406 ++++++++++++++++++++++++++++++=
++++++
 tests/docker/docker.py             |    4 +-
 tests/migration/guestperf/shell.py |    8 +-
 14 files changed, 2831 insertions(+), 95 deletions(-)
 create mode 100644 COPYING.PYTHON
 create mode 100644 scripts/argparse.py

--=20
2.13.5
