Received: from eggs.gnu.org ([2001:4830:134:3::10]:49291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f83P5-00008h-0k
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f83P4-0008Ih-7c
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:38:39 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Apr 2018 14:38:20 +0200
Message-Id: <20180416123822.11744-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches for 2.12.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit ae2b1b4e1bb89ea949446597c8776255da0a79d3:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2018-04-16 10:11:17 +0100)

are available in the Git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2018-04-16

for you to fetch changes up to 25bf2426f3b27857afa35194227040eab821a047:

  iotests: fix 169 (2018-04-16 13:35:32 +0200)

----------------------------------------------------------------
A fix for handling dirty bitmaps stored in qcow2 files.  This is not
absolutely necessary for 2.12, but if there is an rc4, it should go in.

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (2):
  qcow2: try load bitmaps only once
  iotests: fix 169

 block/qcow2.h          |  1 +
 block/qcow2.c          | 16 ++++++++--------
 tests/qemu-iotests/169 | 48 +++++++++++++++++++++++++++---------------------
 3 files changed, 36 insertions(+), 29 deletions(-)

-- 
2.14.3
