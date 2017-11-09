Received: from eggs.gnu.org ([2001:4830:134:3::10]:39428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqB9-0002uL-Ad
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCqB5-0000hs-Fh
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eCqB5-0000hJ-AC
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:59:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6926C49029
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 16:59:42 +0000 (UTC)
Received: from red.redhat.com (ovpn-125-14.rdu2.redhat.com [10.10.125.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0849160F8B
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 16:59:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  9 Nov 2017 10:59:31 -0600
Message-Id: <20171109165939.23154-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] NBD patches for 2.11-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-11-09

for you to fetch changes up to ef8c887ee01a4e4c8c5c28c86ea5b45162c51bcd:

  nbd/server: Fix structured read of length 0 (2017-11-09 10:25:11 -0600)

----------------------------------------------------------------
nbd patches for 2017-11-09

- Vladimir Sementsov-Ogievskiy: nbd/server: fix nbd_negotiate_handle_info
- Eric Blake: 0/7 various NBD fixes for 2.11

----------------------------------------------------------------
Eric Blake (7):
      nbd-client: Fix error message typos
      nbd-client: Refuse read-only client with BDRV_O_RDWR
      nbd/client: Nicer trace of structured reply
      nbd: Fix struct name for structured reads
      nbd-client: Short-circuit 0-length operations
      nbd-client: Stricter enforcing of structured reply spec
      nbd/server: Fix structured read of length 0

Vladimir Sementsov-Ogievskiy (1):
      nbd/server: fix nbd_negotiate_handle_info

 include/block/nbd.h    | 18 +++++++++++++-----
 block/nbd-client.c     | 37 +++++++++++++++++++++++++++++++------
 nbd/client.c           |  4 +++-
 nbd/server.c           | 26 +++++++++++++++++++++++---
 nbd/trace-events       |  3 ++-
 tests/qemu-iotests/058 |  8 ++++----
 tests/qemu-iotests/140 |  4 ++--
 tests/qemu-iotests/147 |  1 +
 8 files changed, 79 insertions(+), 22 deletions(-)

-- 
2.13.6
