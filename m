Received: from eggs.gnu.org ([2001:4830:134:3::10]:52664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXwM7-0005Qt-0D
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXwM6-0007on-6x
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:22:34 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 26 Jun 2018 18:22:24 -0400
Message-Id: <20180626222226.27620-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] iotests: fleecing test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

A simple, hastily-written example of image fleecing over NBD.

John Snow (2):
  block: allow blockdev-backup from any source
  iotests: add 222 to test basic fleecing

 blockdev.c               |   2 +-
 tests/qemu-iotests/222   | 121 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group |   1 +
 3 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 tests/qemu-iotests/222

-- 
2.14.4
