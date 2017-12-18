Received: from eggs.gnu.org ([2001:4830:134:3::10]:59613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eE-0001ka-Qb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eD-0003FV-2q
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:30 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 18 Dec 2017 16:08:09 -0500
Message-Id: <20171218210819.31576-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 00/10] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org

The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfabe259:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-12-15-1' into staging (2017-12-17 15:27:41 +0000)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 996922de45299878cdc4c15b72b19edf2bc618a4:

  block/curl: fix minor memory leaks (2017-12-18 15:44:39 -0500)

----------------------------------------------------------------
Blockjob and protocol patches
----------------------------------------------------------------

Jeff Cody (4):
  block/sheepdog: remove spurious NULL check
  block/sheepdog: code beautification
  block/curl: check error return of curl_global_init()
  block/curl: fix minor memory leaks

John Snow (1):
  blockjob: kick jobs on set-speed

Vladimir Sementsov-Ogievskiy (5):
  hbitmap: add next_zero function
  backup: move from done_bitmap to copy_bitmap
  backup: init copy_bitmap from sync_bitmap for incremental
  backup: simplify non-dirty bits progress processing
  backup: use copy_bitmap in incremental backup

 block/backup.c               | 116 +++++++++++++++++-------------
 block/curl.c                 |  24 +++++--
 block/dirty-bitmap.c         |   5 ++
 block/sheepdog.c             | 166 +++++++++++++++++++++----------------------
 blockjob.c                   |  30 +++++++-
 include/block/dirty-bitmap.h |   1 +
 include/qemu/hbitmap.h       |   8 +++
 tests/test-hbitmap.c         |  61 ++++++++++++++++
 util/hbitmap.c               |  39 ++++++++++
 9 files changed, 309 insertions(+), 141 deletions(-)

-- 
2.9.5
