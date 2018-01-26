Received: from eggs.gnu.org ([2001:4830:134:3::10]:52738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef7fx-0007u9-Uq
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef7ft-0000Fr-1X
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:20:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ef7fs-0000Eb-NL
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:20:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1492D5551
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 16:04:13 +0000 (UTC)
Received: from red.redhat.com (ovpn-124-3.rdu2.redhat.com [10.10.124.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9027D5D720
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 16:04:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 26 Jan 2018 10:04:03 -0600
Message-Id: <20180126160411.4033-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] NBD patches through 26 Jan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit e607bbee553cfe73072870cef458cfa4e78133e2:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-01-26.for-upstream' into staging (2018-01-26 14:24:25 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-01-26

for you to fetch changes up to 9776f0db6a19a0510e89b7aae38190b4811c95ba:

  nbd: implement bdrv_get_info callback (2018-01-26 09:58:46 -0600)

----------------------------------------------------------------
nbd patches for 2018-01-26

- Vladimir Sementsov-Ogievskiy - nbd export qmp interface
- Eric Blake - hmp: Add nbd_server_remove to mirror QMP command
- Edgar Kaziakhmedov - nbd: implement bdrv_get_info callback

----------------------------------------------------------------
Edgar Kaziakhmedov (1):
      nbd: implement bdrv_get_info callback

Eric Blake (2):
      hmp: Add name parameter to nbd_server_add
      hmp: Add nbd_server_remove to mirror QMP command

Vladimir Sementsov-Ogievskiy (5):
      qapi: add name parameter to nbd-server-add
      qapi: add nbd-server-remove
      iotest 147: add cases to test new @name parameter of nbd-server-add
      iotests: implement QemuIoInteractive class
      iotest 205: new test for qmp nbd-server-remove

 qapi/block.json               |  50 +++++++++++++-
 hmp.h                         |   1 +
 include/block/nbd.h           |   1 +
 block/nbd.c                   |  11 +++
 blockdev-nbd.c                |  38 ++++++++--
 hmp.c                         |  20 ++++--
 nbd/server.c                  |  13 ++++
 hmp-commands.hx               |  26 +++++--
 tests/qemu-iotests/147        |  68 ++++++++++++++----
 tests/qemu-iotests/147.out    |   4 +-
 tests/qemu-iotests/205        | 156 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/205.out    |   5 ++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  38 ++++++++++
 14 files changed, 401 insertions(+), 31 deletions(-)
 create mode 100644 tests/qemu-iotests/205
 create mode 100644 tests/qemu-iotests/205.out

-- 
2.14.3
