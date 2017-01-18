Received: from eggs.gnu.org ([2001:4830:134:3::10]:42182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTsux-0005G6-2p
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTsut-0005kz-Uu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:16:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTsut-0005kh-Og
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:16:55 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC66179DDA
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:16:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 18 Jan 2017 10:16:47 -0600
Message-Id: <20170118161653.19296-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] qapi-related cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is a subset of my earlier post "Rip out dynamic JSON parsing"[1],
hence the v2 marking.  It focuses only on the patches that are worth
having whether or not we decide that ripping out dynamic JSON is the
way to go (code cleanups and testsuite improvements).  I've rebased
it to the current master.

We may still want patch 2 to be subdivided.

[1] https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05425.html

001/6:[----] [--] 'pci: Use struct instead of QDict to pass back parameters'
002/6:[0028] [FC] 'qdict: Add convenience helpers for wrapped puts'
003/6:[----] [--] 'qlist: Add convenience helpers for wrapped appends'
004/6:[----] [--] 'fdc-test: Avoid deprecated 'change' command'
005/6:[----] [--] 'test-qga: Actually test 0xff sync bytes'
006/6:[----] [-C] 'qapi: Promote blockdev-change-medium arguments to QAPI type'

Eric Blake (6):
  pci: Use struct instead of QDict to pass back parameters
  qdict: Add convenience helpers for wrapped puts
  qlist: Add convenience helpers for wrapped appends
  fdc-test: Avoid deprecated 'change' command
  test-qga: Actually test 0xff sync bytes
  qapi: Promote blockdev-change-medium arguments to QAPI type

 qapi/block-core.json                |  11 ++-
 include/qapi/qmp/qdict.h            |   8 ++
 include/qapi/qmp/qlist.h            |   8 ++
 block.c                             |  59 ++++++---------
 block/archipelago.c                 |   4 +-
 block/blkdebug.c                    |   6 +-
 block/blkverify.c                   |  11 ++-
 block/curl.c                        |   2 +-
 block/file-posix.c                  |   8 +-
 block/file-win32.c                  |   4 +-
 block/iscsi.c                       |   2 +-
 block/nbd.c                         |  41 +++++------
 block/nfs.c                         |  43 +++++------
 block/null.c                        |   2 +-
 block/qcow2.c                       |   4 +-
 block/quorum.c                      |  13 ++--
 block/ssh.c                         |  16 ++--
 block/vvfat.c                       |  10 +--
 blockdev.c                          |  28 +++----
 hw/block/xen_disk.c                 |   2 +-
 hw/pci/pcie_aer.c                   |  36 +++++----
 hw/usb/xen-usb.c                    |  12 +--
 monitor.c                           |  18 ++---
 qapi/qmp-event.c                    |   2 +-
 qemu-img.c                          |   6 +-
 qemu-io.c                           |   2 +-
 qemu-nbd.c                          |   2 +-
 qobject/qdict.c                     |   2 +-
 target/s390x/cpu_models.c           |   4 +-
 tests/check-qdict.c                 | 142 ++++++++++++++++++------------------
 tests/check-qlist.c                 |   2 +-
 tests/fdc-test.c                    |   5 +-
 tests/libqtest.c                    |   8 ++
 tests/test-qga.c                    |  12 +--
 tests/test-qmp-commands.c           |  30 ++++----
 tests/test-qmp-event.c              |  30 ++++----
 tests/test-qobject-output-visitor.c |   6 +-
 util/qemu-option.c                  |   6 +-
 38 files changed, 304 insertions(+), 303 deletions(-)

-- 
2.9.3
