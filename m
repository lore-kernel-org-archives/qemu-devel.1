Received: from eggs.gnu.org ([2001:4830:134:3::10]:47038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6M-0005vo-Kt
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6L-0003bG-NQ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:14 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 22 Mar 2017 13:30:58 -0400
Message-Id: <20170322173102.18180-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/4] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:

  Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)

are available in the git repository at:

  https://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 600ac6a0ef5c06418446ef2f37407bddcc51b21c:

  blockjob: add devops to blockjob backends (2017-03-22 13:26:27 -0400)

----------------------------------------------------------------
Block patches for 2.9
----------------------------------------------------------------

John Snow (3):
  blockjob: add block_job_start_shim
  block-backend: add drained_begin / drained_end ops
  blockjob: add devops to blockjob backends

Paolo Bonzini (1):
  blockjob: avoid recursive AioContext locking

 block/block-backend.c          | 24 ++++++++++++++--
 blockjob.c                     | 63 ++++++++++++++++++++++++++++++++----------
 include/sysemu/block-backend.h |  8 ++++++
 3 files changed, 79 insertions(+), 16 deletions(-)

-- 
2.9.3
