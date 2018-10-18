Received: from eggs.gnu.org ([2001:4830:134:3::10]:33341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gD49c-00010s-0x
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gD49Y-0008Ea-Kt
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:59:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 18 Oct 2018 11:59:02 +0300
Message-Id: <cover.1539852875.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/2] Forbid adding children to a Quorum in
 blkverify mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi,

as pointed out by Kevin, the Quorum driver should not allow adding new
children when running in blkverify mode.

This series fixes that and also adds a couple of basic iotests for the
x-blockdev-change QMP command.

Berto

Alberto Garcia (2):
  quorum: Forbid adding children in blkverify mode
  iotest: Test x-blockdev-change on a Quorum

 block/quorum.c             |  8 +++++
 tests/qemu-iotests/081     | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/081.out | 54 +++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

-- 
2.11.0
