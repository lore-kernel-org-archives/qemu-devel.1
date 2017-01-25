Received: from eggs.gnu.org ([2001:4830:134:3::10]:44625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRaL-0004Si-VH
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRaL-0005gQ-5E
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:42:18 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 25 Jan 2017 12:42:01 -0500
Message-Id: <cover.1485365834.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, berrange@redhat.com, pbonzini@redhat.com

This adds blockdev-add support to the iscsi block driver.

Picked this series up from Kevin.  I've tested it on my local iscsi setup.

There are only a few minor changes:

* In patch 2, fixed the segfault pointed out by Daniel
* In patch 6, placed the ':' after the command header as now required
* New patch 7, to fix some out of date documentation in the qapi schema


Jeff Cody (1):
  QAPI: Fix blockdev-add example documentation

Kevin Wolf (6):
  iscsi: Split URL into individual options
  iscsi: Handle -iscsi user/password in bdrv_parse_filename()
  iscsi: Add initiator-name option
  iscsi: Add header-digest option
  iscsi: Add timeout option
  iscsi: Add blockdev-add support

 block/iscsi.c        | 349 +++++++++++++++++++++++++++++++--------------------
 qapi/block-core.json |  92 +++++++++++---
 2 files changed, 288 insertions(+), 153 deletions(-)

-- 
2.9.3
