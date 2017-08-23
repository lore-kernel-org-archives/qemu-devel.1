Received: from eggs.gnu.org ([2001:4830:134:3::10]:48063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkYbL-0008GH-Fe
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkYbK-0005OF-JO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkYbK-0005Ny-DH
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6612A5F7AD
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 16:33:53 +0000 (UTC)
Received: from red.redhat.com (ovpn-124-155.rdu2.redhat.com [10.10.124.155])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08DE4614FE
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 16:33:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 23 Aug 2017 11:33:43 -0500
Message-Id: <20170823163349.11663-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] NBD pull request for 2.10-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3da2bd8c4a80178fb115c70b858cecbfb1eb1067:

  numa: Move numa_legacy_auto_assign_ram to pc-i440fx-2.9 (2017-08-23 13:53:15 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-08-23

for you to fetch changes up to 40f4a21895b5a7eae4011593837069f63460d983:

  nbd-client: avoid spurious qio_channel_yield() re-entry (2017-08-23 11:22:15 -0500)

----------------------------------------------------------------
nbd patches for 2017-08-23

- Fam Zheng: 0/4 block: Fix non-shared storage migration
- Stefan Hajnoczi: qemu-iotests: add 194 non-shared storage migration test
- Stefan Hajnoczi: nbd-client: avoid spurious qio_channel_yield() re-entry

----------------------------------------------------------------
Fam Zheng (3):
      block-backend: Refactor inactivate check
      block-backend: Allow more "can inactivate" cases
      mirror: Mark target BB as "force allow inactivate"

Stefan Hajnoczi (3):
      block: Update open_flags after ->inactivate() callback
      qemu-iotests: add 194 non-shared storage migration test
      nbd-client: avoid spurious qio_channel_yield() re-entry

 block/nbd-client.h             |  7 +++-
 include/sysemu/block-backend.h |  1 +
 block.c                        |  7 ++--
 block/block-backend.c          | 31 +++++++++++++++---
 block/mirror.c                 | 14 ++++++--
 block/nbd-client.c             | 35 ++++++++++++--------
 tests/qemu-iotests/194         | 73 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/194.out     | 13 ++++++++
 tests/qemu-iotests/group       |  1 +
 tests/qemu-iotests/iotests.py  | 13 ++++++++
 10 files changed, 170 insertions(+), 25 deletions(-)
 create mode 100755 tests/qemu-iotests/194
 create mode 100644 tests/qemu-iotests/194.out

-- 
2.13.5
