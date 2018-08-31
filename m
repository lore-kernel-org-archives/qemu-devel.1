Received: from eggs.gnu.org ([2001:4830:134:3::10]:52411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkTo-0004gn-CP
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkTn-0004GV-HT
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:32:56 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Aug 2018 16:32:31 +0200
Message-Id: <20180831143241.31787-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/10] Block patches
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

  https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2018-08-31-v2

for you to fetch changes up to e21a1c9831fc80ae3f3c1affdfa43350035d8588:

  jobs: remove job_defer_to_main_loop (2018-08-31 16:28:33 +0200)

----------------------------------------------------------------
Block patches:
- (Block) job exit refactoring, part 1
  (removing job_defer_to_main_loop())
- test-bdrv-drain leak fix

----------------------------------------------------------------
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
 block/mirror.c            | 39 ++++++++-----------
 block/stream.c            | 29 ++++++--------
 job-qmp.c                 |  5 ++-
 job.c                     | 73 ++++++++++++-----------------------
 tests/test-bdrv-drain.c   | 14 +++----
 tests/test-blockjob-txn.c | 25 +++++-------
 tests/test-blockjob.c     | 17 ++++----
 trace-events              |  2 +-
 12 files changed, 161 insertions(+), 242 deletions(-)

--=20
2.17.1
