Received: from eggs.gnu.org ([2001:4830:134:3::10]:48800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhyE5-0006Nv-79
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhyE4-0007rd-8B
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:23:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 24 Jul 2018 15:23:30 +0100
Message-Id: <20180724142331.14669-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>

The following changes since commit 768cef2974fb1fa30dd188b043ea737e13fea477:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-07-24 10:37:52 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 042b757cc77c9580b99ef2781cfb0a2d1bf495a6:

  block/file-posix: add bdrv_attach_aio_context callback for host dev and cdrom (2018-07-24 14:27:41 +0100)

----------------------------------------------------------------
Pull request

Regression fix for host block devices with the file-posix driver when aio=native is in use.

----------------------------------------------------------------

Nishanth Aravamudan (1):
  block/file-posix: add bdrv_attach_aio_context callback for host dev
    and cdrom

 block/file-posix.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.17.1
