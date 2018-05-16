Received: from eggs.gnu.org ([2001:4830:134:3::10]:33298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fJ0Ro-0006oV-Ms
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fJ0Rn-0006mE-UY
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:42:44 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 16 May 2018 13:42:30 -0400
Message-Id: <20180516174234.311-1-jcody@redhat.com>
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
Cc: peter.maydell@linaro.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit c416eecea5f3aea863ab8fda5a36a24157b8f704:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-05-15 17:02:00 +0100)

are available in the git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to c82be42cc803b36fd7aed5dceec68312c7056fd5:

  nfs: Remove processed options from QDict (2018-05-16 13:37:47 -0400)

----------------------------------------------------------------
Block patches
----------------------------------------------------------------

Kevin Wolf (2):
  nfs: Fix error path in nfs_options_qdict_to_qapi()
  nfs: Remove processed options from QDict

Stefan Hajnoczi (2):
  qemu-iotests: reduce chance of races in 185
  blockjob: do not cancel timer in resume

 block/nfs.c                |  8 ++++++++
 blockjob.c                 | 22 +++++++++++++++-------
 tests/qemu-iotests/185     | 17 +++++++++++++----
 tests/qemu-iotests/185.out | 12 +++++-------
 4 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.13.6
