Received: from eggs.gnu.org ([2001:4830:134:3::10]:34759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqg-0005zr-P0
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqf-0000mS-TH
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:29:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 12 May 2018 10:28:16 +0100
Message-Id: <20180512092824.13848-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 31be8a2a97ecba7d31a82932286489cac318e9e9:

  block/file-posix: add x-check-page-cache=on|off option (2018-05-11 16:43:05 +0100)

----------------------------------------------------------------
Block pull request

 * Support -drive cache.direct=off live migration for POSIX files

----------------------------------------------------------------

Joe Perches (4):
  checkpatch: add a --strict check for utf-8 in commit logs
  checkpatch: ignore email headers better
  checkpatch: emit a warning on file add/move/delete
  checkpatch: reduce MAINTAINERS update message frequency

Pasi Savanainen (1):
  checkpatch: check utf-8 content from a commit log when it's missing
    from charset

Stefan Hajnoczi (3):
  blockjob: drop block_job_pause/resume_all()
  block/file-posix: implement bdrv_co_invalidate_cache() on Linux
  block/file-posix: add x-check-page-cache=on|off option

 qapi/block-core.json         |   7 +-
 include/block/blockjob_int.h |  14 ----
 block/file-posix.c           | 146 ++++++++++++++++++++++++++++++++++-
 blockjob.c                   |  27 -------
 scripts/checkpatch.pl        |  56 +++++++++++++-
 5 files changed, 202 insertions(+), 48 deletions(-)

-- 
2.17.0
