Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekE2C-0006jS-9o
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekE27-0008VV-I3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:08:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ekE27-0008VJ-D9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:08:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1295D7CBDB
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 19:08:27 +0000 (UTC)
Received: from red.redhat.com (ovpn-122-122.rdu2.redhat.com [10.10.122.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D2404100F9EC
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 19:08:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  9 Feb 2018 13:08:22 -0600
Message-Id: <20180209190824.32221-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] NBD patches through 2018-02-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit c7b02d7d032d6022060e4b393827c963c93ce63f:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-090218-1' into staging (2018-02-09 16:12:34 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-02-09

for you to fetch changes up to e24d813b29d3a478a9309078487efc8ce8599f22:

  block: Simplify bdrv_can_write_zeroes_with_unmap() (2018-02-09 12:32:44 -0600)

----------------------------------------------------------------
nbd patches for 2018-02-09

- Vladimir Sementsov-Ogievskiy: iotests: 205: support luks format
- Eric Blake: block: Simplify bdrv_can_write_zeroes_with_unmap()

----------------------------------------------------------------
Eric Blake (1):
      block: Simplify bdrv_can_write_zeroes_with_unmap()

Vladimir Sementsov-Ogievskiy (1):
      iotests: 205: support luks format

 include/block/block.h         | 11 -----------
 block.c                       |  8 +-------
 block/crypto.c                |  1 -
 block/file-posix.c            |  3 +--
 block/iscsi.c                 |  6 ++++--
 block/nbd.c                   | 11 -----------
 block/qcow2.c                 |  3 +--
 block/qed.c                   |  1 -
 tests/qemu-iotests/205        |  4 ++--
 tests/qemu-iotests/iotests.py | 31 +++++++++++++++++++++++++++++++
 10 files changed, 40 insertions(+), 39 deletions(-)

-- 
2.14.3
