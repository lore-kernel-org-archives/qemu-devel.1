Received: from eggs.gnu.org ([2001:4830:134:3::10]:52971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Oa-0001mH-A9
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7OX-0001YD-3g
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dn7OW-0001Y3-Tw
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 017544E4D1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 18:07:16 +0000 (UTC)
Received: from red.redhat.com (ovpn-122-186.rdu2.redhat.com [10.10.122.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB9E173A6
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 18:07:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:00 -0500
Message-Id: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] NBD patches for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec:

  Update version for v2.10.0 release (2017-08-30 17:02:54 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-08-30

for you to fetch changes up to f35dff7e13b84d3fffe1103c2c69afd81df5e4f5:

  block/nbd-client: refactor request send/receive (2017-08-30 13:00:38 -0500)

----------------------------------------------------------------
nbd patches for 2017-08-30

- Kashyap Chamarthy: qemu-iotests: Extend non-shared storage migration test (194)
- Stefan Hajnaczi: 0/3 nbd-client: enter read_reply_co during init to avoid crash
- Vladimir Sementsov-Ogievskiy: portions of 0/17 nbd client refactoring and fixing

----------------------------------------------------------------
Kashyap Chamarthy (1):
      qemu-iotests: Extend non-shared storage migration test (194)

Stefan Hajnoczi (3):
      nbd-client: avoid read_reply_co entry if send failed
      qemu-iotests: improve nbd-fault-injector.py startup protocol
      qemu-iotests: test NBD over UNIX domain sockets in 083

Vladimir Sementsov-Ogievskiy (7):
      nbd/client: fix nbd_opt_go
      nbd/client: refactor nbd_read_eof
      nbd/client: refactor nbd_receive_reply
      nbd/client: fix nbd_send_request to return int
      block/nbd-client: get rid of ssize_t
      block/nbd-client: rename nbd_recv_coroutines_enter_all
      block/nbd-client: refactor request send/receive

 include/block/nbd.h                      |   4 +-
 nbd/nbd-internal.h                       |  33 +++++--
 block/nbd-client.c                       | 102 ++++++++-------------
 nbd/client.c                             |  21 +++--
 tests/qemu-iotests/common.filter         |   4 +-
 tests/qemu-iotests/083                   | 138 +++++++++++++++++-----------
 tests/qemu-iotests/083.out               | 149 +++++++++++++++++++++++++++----
 tests/qemu-iotests/194                   |  23 +++--
 tests/qemu-iotests/194.out               |  11 ++-
 tests/qemu-iotests/nbd-fault-injector.py |   4 +
 10 files changed, 319 insertions(+), 170 deletions(-)

-- 
2.13.5
