Received: from eggs.gnu.org ([2001:4830:134:3::10]:59739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxw6E-0007y7-VL
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxw69-0002Yl-9H
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:44:50 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Apr 2017 15:44:32 +0200
Message-Id: <20170411134435.27271-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Block patches for 2.9.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit aa388ddc36e8032f41cd17bef88cc3ebaeba77c9:

  Merge remote-tracking branch 'remotes/famz/tags/block-pull-request' into staging (2017-04-11 13:27:05 +0100)

are available in the git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2017-04-11

for you to fetch changes up to 2ec9a782d159e2bc6655fc0b783deda197bbe0b7:

  iscsi: Fix iscsi_create (2017-04-11 15:33:00 +0200)

----------------------------------------------------------------
Block patches for 2.9.0-rc4

----------------------------------------------------------------
Dong Jia Shi (1):
      block: pass the right options for BlockDriver.bdrv_open()

Eric Blake (1):
      throttle: Remove block from group on hot-unplug

Fam Zheng (1):
      iscsi: Fix iscsi_create

 block/block-backend.c |  3 +++
 block/iscsi.c         | 10 ++++++++--
 block/snapshot.c      | 26 +++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.12.2
