Received: from eggs.gnu.org ([2001:4830:134:3::10]:52953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCmuN-0000Gb-BU
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCmuH-0006IN-A1
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:34:47 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 17:33:48 +0300
Message-Id: <cover.1539786605.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/3] Misc Quorum fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi,

Here's a couple of small fixes for the Quorum driver plus new test
cases. See the individual patches for details.

Regards,

Berto

Alberto Garcia (3):
  quorum: Remove quorum_err()
  quorum: Return an error if the blkverify mode has invalid settings
  iotest: Test the blkverify mode of the Quorum driver

 block/quorum.c             | 37 +++++++++++--------------------------
 tests/qemu-iotests/081     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/081.out | 16 ++++++++++++++++
 3 files changed, 57 insertions(+), 26 deletions(-)

-- 
2.11.0
