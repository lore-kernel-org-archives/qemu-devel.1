Received: from eggs.gnu.org ([2001:4830:134:3::10]:58125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYeQK-0007tN-9Z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYeQJ-0006dH-JP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:25:52 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 28 Jun 2018 17:25:42 -0400
Message-Id: <20180628212544.21854-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] block: formalize and test fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Formalize the fleecing workflow in patch one,
test that it works in patch two.

V3:
 - Added explicit zero checking as per Eblake's suggestion
 - Remove stale python code

John Snow (2):
  block: allow blockdev-backup from any source
  iotests: add 222 to test basic fleecing

 blockdev.c                 |   2 +-
 tests/qemu-iotests/222     | 152 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/222.out |  66 ++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 tests/qemu-iotests/222
 create mode 100644 tests/qemu-iotests/222.out

-- 
2.14.4
