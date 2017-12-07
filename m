Received: from eggs.gnu.org ([2001:4830:134:3::10]:47236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySW-0003bl-VR
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMyST-0008Ay-R5
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:37 -0500
Received: from [195.214.232.25] (port=16744 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eMyST-00086b-FK
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:33 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Dec 2017 18:50:56 +0300
Message-Id: <20171207155102.66622-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/6] nbd export qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Here:
    1. separate export name from device name
    1.1 several exports per device possible
    2. add nbd-server-remove

v2:
01: add r-bs by Max and Eric, add comment to code (hope you don't mind)
03: address export by its name, not by device name
    make it possible to force-remove export, which is already
    non-force-removed (thourh new "hidden" field)
other patches are new

v1:
Add command to remove nbd export, pair to nbd-server-add.
The whole thing and description are in patch 02.


Vladimir Sementsov-Ogievskiy (6):
  nbd/server: add additional assert to nbd_export_put
  qapi: add name parameter to nbd-server-add
  qapi: add nbd-server-remove
  iotest 147: add cases to test new @name parameter of nbd-server-add
  iotests: implement QemuIoInteractive class
  iotest 201: new test for qmp nbd-server-remove

 qapi/block.json               |  27 ++++++++-
 include/block/nbd.h           |   3 +-
 blockdev-nbd.c                |  41 +++++++++++--
 hmp.c                         |   5 +-
 nbd/server.c                  |  31 +++++++++-
 tests/qemu-iotests/147        |  68 +++++++++++++++++-----
 tests/qemu-iotests/147.out    |   4 +-
 tests/qemu-iotests/201        | 130 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/201.out    |   5 ++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  38 ++++++++++++
 11 files changed, 325 insertions(+), 28 deletions(-)
 create mode 100644 tests/qemu-iotests/201
 create mode 100644 tests/qemu-iotests/201.out

-- 
2.11.1
