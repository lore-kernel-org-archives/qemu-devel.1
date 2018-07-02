Received: from eggs.gnu.org ([2001:4830:134:3::10]:40081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa4mU-0002f2-H5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fa4mT-0005vu-O8
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:46:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon,  2 Jul 2018 15:46:28 -0400
Message-Id: <20180702194630.9360-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] block: formalize and test fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, John Snow <jsnow@redhat.com>

This two patch series formalizes a workflow we expect to work for the
purposes of image fleecing. There are some remaining questions on
serialization correctness that we intend to address at a later time,
possibly during the 3.0 soft freeze window.

V4:
 - Replace my 1/2 with Vladimir's, which was more exhaustive.
 - Formatting improvements to 2/2 (Vladimir)
 - Specify the image format on write (Vladimir)

V3:
 - Added explicit zero checking as per Eblake's suggestion
 - Remove stale python code

John Snow (1):
  iotests: add 222 to test basic fleecing

Vladimir Sementsov-Ogievskiy (1):
  blockdev: enable non-root nodes for backup source

 blockdev.c                 |   4 +-
 tests/qemu-iotests/222     | 155 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/222.out |  67 ++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 225 insertions(+), 2 deletions(-)
 create mode 100644 tests/qemu-iotests/222
 create mode 100644 tests/qemu-iotests/222.out

-- 
2.14.4
