Received: from eggs.gnu.org ([2001:4830:134:3::10]:36193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f5VDk-00067r-Sg
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f5VDh-0001CS-Qx
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:44:24 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Apr 2018 14:44:16 +0300
Message-Id: <20180409114418.16615-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/2] iotests: blacklist bochs and cloop for
 205 and 208
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com

v2: move from unsupported_fmts to support "generic", like in bash tests.

Vladimir Sementsov-Ogievskiy (2):
  iotests.py: improve verify_image_format helper
  iotests: blacklist bochs and cloop for 205 and 208

 tests/qemu-iotests/205        |  2 +-
 tests/qemu-iotests/208        |  2 ++
 tests/qemu-iotests/iotests.py | 14 +++++++++++---
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.11.1
