Received: from eggs.gnu.org ([2001:4830:134:3::10]:51838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa4Hz-00010a-Ta
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa4Hy-0006oe-Ta
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:15:07 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  2 Jul 2018 14:14:56 -0500
Message-Id: <20180702191458.28741-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] test NBD bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com

This is a less hacky version of my first attempt:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05993.html

The worst part of the hack (taking a semicolon-separated list of
requests to hand the server) is completely dropped, the member
field is renamed to reflect what it is doing, and I've added an
iotests to help us in regression testing.

I'd REALLY like to send a pull request before soft freeze (tomorrow
morning is approaching fast!) that includes these patches, so that
qemu 3.0 at least has experimental access to all the pieces needed
for playing with incremental backups.

Eric Blake (2):
  nbd/client: Add x-dirty-bitmap to query bitmap from server
  iotests: New test 223 for exporting dirty bitmap over NBD

 qapi/block-core.json       |   7 ++-
 block/nbd-client.h         |   1 +
 include/block/nbd.h        |   1 +
 block/nbd-client.c         |   3 +
 block/nbd.c                |  10 +++-
 nbd/client.c               |   4 +-
 tests/qemu-iotests/223     | 138 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/223.out |  49 ++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 9 files changed, 209 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/223
 create mode 100644 tests/qemu-iotests/223.out

-- 
2.14.4
