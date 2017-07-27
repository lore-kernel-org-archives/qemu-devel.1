Received: from eggs.gnu.org ([2001:4830:134:3::10]:33173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVO-0004jn-MR
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVL-0001c4-E9
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:02 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2017 08:02:05 -0400
Message-Id: <20170727120210.6943-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Trivial fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is a collection of trivial fixes and cleanups.  The only expected
behavior change is in the output on config.log, as per the first
patch.

Cleber Rosa(5):
  configure: remove duplicate single quotes on config.log
  qemu-iotests: get rid of _full_imgproto_details()
  qemu-iotests: remove commented out variables
  qemu-iotests: remove comment about root privileges
  docs: fix broken paths to docs/interop dir

 configure                           |  4 +---
 docs/devel/writing-qmp-commands.txt |  2 +-
 qapi-schema.json                    |  2 +-
 tests/qemu-iotests/check            | 13 +------------
 tests/qemu-iotests/common.rc        |  5 -----
 5 files changed, 4 insertions(+), 22 deletions(-)
