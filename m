Received: from eggs.gnu.org ([2001:4830:134:3::10]:38105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhdT2-000413-2m
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhdSy-0002Vy-TS
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:09:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhdSy-0002Vi-NN
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:09:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B83087CDEA
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 15:09:11 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-22.rdu2.redhat.com [10.10.121.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A7EC61B79
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 15:09:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 15 Aug 2017 10:09:00 -0500
Message-Id: <20170815150907.21495-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL for 2.10-rc3 0/7] NBD changes for 2.10-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 47025a0193f1f910300adfa443305ccf8482ef87:

  qxl: call qemu_spice_display_init_common for secondary devices (2017-08-15 15:04:51 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-08-15

for you to fetch changes up to 72b6ffc76653214b69a94a7b1643ff80df134486:

  nbd-client: Fix regression when server sends garbage (2017-08-15 10:03:28 -0500)

----------------------------------------------------------------
nbd patches for 2017-08-15

- Eric Blake: nbd: Fix trace message for disconnect
- Stefan Hajnoczi: qemu-iotests: step clock after each test iteration
- Fam Zheng: 0/4 block: Fix non-shared storage migration
- Eric Blake: nbd-client: Fix regression when server sends garbage

----------------------------------------------------------------
Eric Blake (2):
      nbd: Fix trace message for disconnect
      nbd-client: Fix regression when server sends garbage

Fam Zheng (3):
      stubs: Add vm state change handler stubs
      block-backend: Defer shared_perm tightening migration completion
      iotests: Add non-shared storage migration case 192

Kevin Wolf (1):
      nbd: Fix order of bdrv_set_perm and bdrv_invalidate_cache

Stefan Hajnoczi (1):
      qemu-iotests: step clock after each test iteration

 block/nbd-client.h           |  1 +
 block/block-backend.c        | 41 ++++++++++++++++++++++++++++
 block/nbd-client.c           | 17 +++++++++---
 nbd/common.c                 |  2 +-
 nbd/server.c                 | 20 +++++++-------
 stubs/change-state-handler.c | 14 ++++++++++
 stubs/Makefile.objs          |  1 +
 tests/qemu-iotests/093       |  4 +++
 tests/qemu-iotests/192       | 63 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/192.out   |  7 +++++
 tests/qemu-iotests/group     |  1 +
 11 files changed, 157 insertions(+), 14 deletions(-)
 create mode 100644 stubs/change-state-handler.c
 create mode 100755 tests/qemu-iotests/192
 create mode 100644 tests/qemu-iotests/192.out

-- 
2.13.5
