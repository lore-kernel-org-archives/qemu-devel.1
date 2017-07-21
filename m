Received: from eggs.gnu.org ([2001:4830:134:3::10]:33704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYOv6-00043F-HY
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYOv5-0002QV-T0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:48:04 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 20 Jul 2017 23:47:27 -0400
Message-Id: <20170721034730.25612-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] build configuration query tool and
 conditional (qemu-io)test skip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

This is a follow up to a previous discussion about reported failures when
running some qemu-iotests.  Turns out the failures were due to missing
libraries, which in turn, reflected on the host build configuration.

This series introduces a tool that can check both host and target level
build configurations.  On top of that, it adds a function to to be used
on qemu-iotests.  Finally, as an example, it sets a test to be skipped
if the required feature is not enable on the host build configuration.

Cleber Rosa (3):
  scripts: introduce buildconf.py
  qemu-iotests: add _require_feature() function
  qemu-iotests: require CONFIG_LINUX_AIO for test 087

 scripts/buildconf.py         | 278 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/087       |   1 +
 tests/qemu-iotests/check     |   2 +
 tests/qemu-iotests/common.rc |   7 ++
 4 files changed, 288 insertions(+)
