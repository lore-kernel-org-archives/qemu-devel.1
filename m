Received: from eggs.gnu.org ([2001:4830:134:3::10]:50714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkQa-0001As-4T
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkM7-0000js-Kd
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:25:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Aug 2018 16:24:35 +0200
Message-Id: <20180831142446.22264-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd2415574=
52:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27=
-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2018-08-31

for you to fetch changes up to 40954cc7831c4f95f9ce6402ae3d6761f44f31ff:

  jobs: remove job_defer_to_main_loop (2018-08-31 16:11:27 +0200)

----------------------------------------------------------------
Block patches:
- (Block) job exit refactoring, part 1
  (removing job_defer_to_main_loop())
- Locking fix for the file-posix block driver
- test-bdrv-drain leak fix

----------------------------------------------------------------
Fam Zheng (1):
  file-posix: Skip effectiveless OFD lock operations

John Snow (9):
  jobs: change start callback to run callback
  jobs: canonize Error object
  jobs: add exit shim
  block/commit: utilize job_exit shim
  block/mirror: utilize job_exit shim
  jobs: utilize job_exit shim
  block/backup: make function variables consistently named
  jobs: remove ret argument to job_completed; privatize it
  jobs: remove job_defer_to_main_loop

Marc-Andr=C3=A9 Lureau (1):
  tests: fix bdrv-drain leak

 include/qemu/job.h        | 70 ++++++++++++++++-----------------
 block/backup.c            | 81 ++++++++++++++++-----------------------
 block/commit.c            | 29 +++++---------
 block/create.c            | 19 +++------
 block/file-posix.c        | 41 +++++++++++++++-----
 block/mirror.c            | 39 ++++++++-----------
 block/stream.c            | 29 ++++++--------
 job-qmp.c                 |  5 ++-
 job.c                     | 73 ++++++++++++-----------------------
 tests/test-bdrv-drain.c   | 14 +++----
 tests/test-blockjob-txn.c | 25 +++++-------
 tests/test-blockjob.c     | 17 ++++----
 trace-events              |  2 +-
 13 files changed, 192 insertions(+), 252 deletions(-)

--=20
2.17.1
