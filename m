Received: from eggs.gnu.org ([2001:4830:134:3::10]:33824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fg9vI-0000Th-R5
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fg9vI-0000Ph-1o
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:28:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 19 Jul 2018 15:28:42 +0100
Message-Id: <20180719142843.30230-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-v3.0 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit ea6abffa8a08d832feb759d359d5b935e3087cf7:

  Update version for v3.0.0-rc1 release (2018-07-17 18:15:19 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 6fccbb475bc6effc313ee9481726a1748b6dae57:

  throttle-groups: fix hang when group member leaves (2018-07-19 13:08:26 +0100)

----------------------------------------------------------------
Pull request

This fix prevents hangs when a drive leaves a throttling group.

----------------------------------------------------------------

Stefan Hajnoczi (1):
  throttle-groups: fix hang when group member leaves

 block/throttle-groups.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.17.1
