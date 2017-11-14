Received: from eggs.gnu.org ([2001:4830:134:3::10]:60364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYay-0002N3-4G
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEYau-0004A3-O9
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEYau-00049X-HT
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:37:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 14 Nov 2017 10:37:16 +0000
Message-Id: <20171114103721.13869-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11-rc2 0/5] Block patches
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

The following changes since commit 508ba0f7e2092d3ca56e3f75e894d52d8b94818e:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20171109' into staging (2017-11-13 11:41:47 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 0761562687e0d8135310a94b1d3e08376387c027:

  qemu-iotests: Test I/O limits with removable media (2017-11-13 15:46:26 +0000)

----------------------------------------------------------------
Pull request

The following disk I/O throttling fixes solve recent bugs.

----------------------------------------------------------------

Alberto Garcia (3):
  block: Check for inserted BlockDriverState in blk_io_limits_disable()
  block: Leave valid throttle timers when removing a BDS from a backend
  qemu-iotests: Test I/O limits with removable media

Stefan Hajnoczi (1):
  throttle-groups: drain before detaching ThrottleState

Zhengui (1):
  block: all I/O should be completed before removing throttle timers.

 block/block-backend.c      | 36 ++++++++++++++++++---------
 block/throttle-groups.c    |  6 +++++
 tests/qemu-iotests/093     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/093.out |  4 +--
 4 files changed, 94 insertions(+), 14 deletions(-)

-- 
2.13.6
