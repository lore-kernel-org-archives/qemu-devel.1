Received: from eggs.gnu.org ([2001:4830:134:3::10]:46108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqN-0002Id-I6
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dEKqM-0005rR-Jf
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:24:15 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 26 May 2017 15:23:52 -0400
Message-Id: <20170526192404.32186-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 223a23c198787328ae75bc65d84edf5fde33c0b6:

  block/gluster: glfs_lseek() workaround (2017-05-24 16:44:46 -0400)

----------------------------------------------------------------
Block patches
----------------------------------------------------------------

Jeff Cody (1):
  block/gluster: glfs_lseek() workaround

Paolo Bonzini (11):
  blockjob: remove unnecessary check
  blockjob: remove iostatus_reset callback
  blockjob: introduce block_job_early_fail
  blockjob: introduce block_job_pause/resume_all
  blockjob: separate monitor and blockjob APIs
  blockjob: move iostatus reset inside block_job_user_resume
  blockjob: introduce block_job_cancel_async, check iostatus invariants
  blockjob: group BlockJob transaction functions together
  blockjob: strengthen a bit test-blockjob-txn
  blockjob: reorganize block_job_completed_txn_abort
  blockjob: use deferred_to_main_loop to indicate the coroutine has
    ended

 block/backup.c               |   2 +-
 block/commit.c               |   2 +-
 block/gluster.c              |  18 +-
 block/io.c                   |  19 +-
 block/mirror.c               |   2 +-
 blockdev.c                   |   1 -
 blockjob.c                   | 750 ++++++++++++++++++++++++-------------=
------
 include/block/blockjob.h     |  16 -
 include/block/blockjob_int.h |  27 +-
 tests/test-blockjob-txn.c    |   7 +-
 tests/test-blockjob.c        |  10 +-
 11 files changed, 463 insertions(+), 391 deletions(-)

--=20
2.9.3
