Received: from eggs.gnu.org ([2001:4830:134:3::10]:38514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYbDx-00083R-UZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYbDw-0003s7-TL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:00:54 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 28 Jun 2018 14:00:40 -0400
Message-Id: <20180628180042.3881-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] block: formalize and test fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Formalize the fleecing workflow in patch one,
test that it works in patch two.

John Snow (2):
  block: allow blockdev-backup from any source
  iotests: add 222 to test basic fleecing

 blockdev.c                 |   2 +-
 tests/qemu-iotests/222     | 149 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/222.out |  60 ++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 tests/qemu-iotests/222
 create mode 100644 tests/qemu-iotests/222.out

-- 
2.14.4
