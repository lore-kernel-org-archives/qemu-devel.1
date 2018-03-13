Received: from eggs.gnu.org ([2001:4830:134:3::10]:46998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUl-0007C7-Ge
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUi-0000jb-88
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evnUi-0000j1-2r
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC78B7CBBA
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 17:13:47 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-135.rdu2.redhat.com [10.10.121.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 871202026DFD
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 17:13:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:28 -0500
Message-Id: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 00/17] NBD patches for 2018-03-13 (2.12
 softfreeze)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 59667bb167f773965ce6547352f312eff0d4d523:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-03-13 14:02:47 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-03-13

for you to fetch changes up to d3bd7052ce7574998ebd6cb262bad59c2b048396:

  iotests: new test 209 for NBD BLOCK_STATUS (2018-03-13 10:55:17 -0500)

----------------------------------------------------------------
nbd patches for 2018-03-13

- Eric Blake: iotests: Fix stuck NBD process on 33
- Vladimir Sementsov-Ogievskiy: 0/5 nbd server fixing and refactoring before BLOCK_STATUS
- Eric Blake: nbd/server: Honor FUA request on NBD_CMD_TRIM
- Stefan Hajnoczi: 0/2 block: fix nbd-server-stop crash after blockdev-snapshot-sync
- Vladimir Sementsov-Ogievskiy: nbd block status base:allocation

----------------------------------------------------------------
Eric Blake (2):
      iotests: Fix stuck NBD process on 33
      nbd/server: Honor FUA request on NBD_CMD_TRIM

Stefan Hajnoczi (2):
      block: let blk_add/remove_aio_context_notifier() tolerate BDS changes
      iotests: add 208 nbd-server + blockdev-snapshot-sync test case

Vladimir Sementsov-Ogievskiy (13):
      nbd/server: move nbd_co_send_structured_error up
      nbd/server: fix sparse read
      nbd/server: fix: check client->closing before sending reply
      nbd/server: refactor nbd_trip: cmd_read and generic reply
      nbd/server: refactor nbd_trip: split out nbd_handle_request
      nbd/server: add nbd_opt_invalid helper
      nbd/server: add nbd_read_opt_name helper
      nbd: BLOCK_STATUS for standard get_block_status function: server part
      block/nbd-client: save first fatal error in nbd_iter_error
      nbd: BLOCK_STATUS for standard get_block_status function: client part
      iotests.py: tiny refactor: move system imports up
      iotests: add file_path helper
      iotests: new test 209 for NBD BLOCK_STATUS

 block/nbd-client.h            |   6 +
 include/block/nbd.h           |   3 +
 block/block-backend.c         |  63 ++++
 block/nbd-client.c            | 145 ++++++++-
 block/nbd.c                   |   3 +
 nbd/client.c                  | 117 +++++++
 nbd/server.c                  | 725 ++++++++++++++++++++++++++++++++----------
 block/trace-events            |   2 +
 tests/qemu-iotests/033        |   1 +
 tests/qemu-iotests/208        |  55 ++++
 tests/qemu-iotests/208.out    |   9 +
 tests/qemu-iotests/209        |  34 ++
 tests/qemu-iotests/209.out    |   2 +
 tests/qemu-iotests/group      |   2 +
 tests/qemu-iotests/iotests.py |  37 ++-
 15 files changed, 1038 insertions(+), 166 deletions(-)
 create mode 100755 tests/qemu-iotests/208
 create mode 100644 tests/qemu-iotests/208.out
 create mode 100755 tests/qemu-iotests/209
 create mode 100644 tests/qemu-iotests/209.out

-- 
2.14.3
