Received: from eggs.gnu.org ([2001:4830:134:3::10]:33421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g84h8-0000uC-CS
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g84h4-0000hv-Bv
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:33:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g84h4-0000h3-6B
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:33:34 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AD0F30820C2
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 14:33:33 +0000 (UTC)
Received: from red.redhat.com (ovpn-126-73.rdu2.redhat.com [10.10.126.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF79873224
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 14:33:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  4 Oct 2018 09:33:22 -0500
Message-Id: <20181004143328.955729-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/6] NBD patches through 2018-10-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit dafd95053611aa14dda40266857608d12ddce658:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-02 18:27:18 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-10-03-v2

for you to fetch changes up to df91328adab8490367776d2b21b35d790a606120:

  nbd: fix NBD_FLAG_SEND_CACHE value (2018-10-04 09:08:56 -0500)

Since v1 pull request:
- add one more patch for another NBD_CMD_CACHE bug
(only sending the new content in the v2 thread)

----------------------------------------------------------------
nbd patches for 2018-10-03

Fix bugs in NBD_CMD_CACHE, drop support for oldstyle NBD server,
minor build and doc fixes

- Denis V. Lunev: nbd: fix NBD_CMD_CACHE negitiation... [retitled]
- Vladimir Sementsov-Ogievskiy: 0/2 server: drop old-style negotiation
- Eric Blake: qemu-nbd: Document --tls-creds
- Vladimir Sementsov-Ogievskiy: nbd/server: fix NBD_CMD_CACHE
- Peter Maydell: nbd: Don't take address of fields in packed structs

----------------------------------------------------------------
Denis V. Lunev (1):
      nbd: fix NBD_FLAG_SEND_CACHE value

Eric Blake (1):
      qemu-nbd: Document --tls-creds

Peter Maydell (1):
      nbd: Don't take address of fields in packed structs

Vladimir Sementsov-Ogievskiy (3):
      nbd/server: fix NBD_CMD_CACHE
      qemu-nbd: drop old-style negotiation
      nbd/server: drop old-style negotiation

 include/block/nbd.h |  7 +++--
 blockdev-nbd.c      |  3 +-
 nbd/client.c        | 44 ++++++++++++++---------------
 nbd/server.c        | 80 +++++++++++++++++++----------------------------------
 qemu-nbd.c          | 26 +++++------------
 5 files changed, 63 insertions(+), 97 deletions(-)

-- 
2.17.1
