Received: from eggs.gnu.org ([2001:4830:134:3::10]:51749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecXAe-0004Vm-HA
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecXAZ-0004NN-Jc
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:28 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 19 Jan 2018 16:57:14 +0300
Message-Id: <20180119135719.24745-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 0/5] nbd export qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

v3:
hmp patch deleted
02: tweak commit message and comments
    tweak error message
05: use unix socket instead of tcp (more common practice in iotests,
    and we do not need port)
    rebase on new error message in 02

v2:
01: tweak comment
    add Eric's r-b
02: new patch
03: rewritten, to move form 'bool force' flag to 'enum mode' parameter
04: add Eric's r-b
05: improve commit message
    tweak comment
06: rebase on 03 changes
    make PEP8 happy
    some other tweaks
    I've left nbd_port variable hard-set to 10900. I think all such things
    should be fixed together, and it is simple to change in future
    nbd_port = '10900'
    to
    nbd_port = iotests.get_free_port()
    if needed.

[Unfortunately, qmp query-nbd-server is not finished yet, coming soon,
 but may be after my vocation on the next week]

Vladimir Sementsov-Ogievskiy (5):
  qapi: add name parameter to nbd-server-add
  qapi: add nbd-server-remove
  iotest 147: add cases to test new @name parameter of nbd-server-add
  iotests: implement QemuIoInteractive class
  iotest 201: new test for qmp nbd-server-remove

 qapi/block.json               |  50 +++++++++++++-
 include/block/nbd.h           |   1 +
 blockdev-nbd.c                |  38 ++++++++--
 hmp.c                         |   5 +-
 nbd/server.c                  |  20 ++++++
 tests/qemu-iotests/147        |  68 ++++++++++++++----
 tests/qemu-iotests/147.out    |   4 +-
 tests/qemu-iotests/201        | 156 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/201.out    |   5 ++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  38 ++++++++++
 11 files changed, 362 insertions(+), 24 deletions(-)
 create mode 100644 tests/qemu-iotests/201
 create mode 100644 tests/qemu-iotests/201.out

-- 
2.11.1
