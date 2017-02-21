Received: from eggs.gnu.org ([2001:4830:134:3::10]:55184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYu-0005so-3v
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYt-0004MF-Bw
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:08 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Feb 2017 10:40:48 -0500
Message-Id: <20170221154057.20313-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] Block patches
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

The following changes since commit a1cf5fac2b929ffa2abd1285401f2535ff8c6fea:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-block-2017-02-21' into staging (2017-02-21 13:58:50 +0000)

are available in the git repository at:

  git@github.com:codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 6135c5e12606b8413708384e3e7d43f6010c5941:

  qemu-options: Fix broken sheepdog URL (2017-02-21 10:38:09 -0500)

----------------------------------------------------------------
Block patches
----------------------------------------------------------------

Anton Nefedov (1):
  mirror: do not increase offset during initial zero_or_discard phase

Jeff Cody (1):
  QAPI: Fix blockdev-add example documentation

Kevin Wolf (6):
  iscsi: Split URL into individual options
  iscsi: Handle -iscsi user/password in bdrv_parse_filename()
  iscsi: Add initiator-name option
  iscsi: Add header-digest option
  iscsi: Add timeout option
  iscsi: Add blockdev-add support

Thomas Huth (1):
  qemu-options: Fix broken sheepdog URL

 block/iscsi.c        | 353 +++++++++++++++++++++++++++++++--------------------
 block/mirror.c       |   9 +-
 qapi/block-core.json | 125 +++++++++++++-----
 qemu-options.hx      |   2 +-
 4 files changed, 317 insertions(+), 172 deletions(-)

-- 
2.9.3
