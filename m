Received: from eggs.gnu.org ([2001:4830:134:3::10]:46229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7obK-0001Wv-4q
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7obG-0000ur-BH
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g7obG-0000pn-0F
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 17:22:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0118D36887
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 21:22:16 +0000 (UTC)
Received: from red.redhat.com (ovpn-126-73.rdu2.redhat.com [10.10.126.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0AC60F97
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 21:22:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 Oct 2018 16:22:06 -0500
Message-Id: <20181003212211.812374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] NBD patches through 2018-10-03
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

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-10-03

for you to fetch changes up to 7f7dfe2a53446072c136d349e3150c84d322b2bc:

  nbd/server: drop old-style negotiation (2018-10-03 15:52:32 -0500)

----------------------------------------------------------------
nbd patches for 2018-10-03

Fix bug in NBD_CMD_CACHE, drop support for oldstyle NBD server,
minor build and doc fixes

- Vladimir Sementsov-Ogievskiy: 0/2 server: drop old-style negotiation
- Eric Blake: qemu-nbd: Document --tls-creds
- Vladimir Sementsov-Ogievskiy: nbd/server: fix NBD_CMD_CACHE
- Peter Maydell: nbd: Don't take address of fields in packed structs

----------------------------------------------------------------
Eric Blake (1):
      qemu-nbd: Document --tls-creds

Peter Maydell (1):
      nbd: Don't take address of fields in packed structs

Vladimir Sementsov-Ogievskiy (3):
      nbd/server: fix NBD_CMD_CACHE
      qemu-nbd: drop old-style negotiation
      nbd/server: drop old-style negotiation

 include/block/nbd.h |  3 +-
 blockdev-nbd.c      |  3 +-
 nbd/client.c        | 44 ++++++++++++++---------------
 nbd/server.c        | 80 +++++++++++++++++++----------------------------------
 qemu-nbd.c          | 26 +++++------------
 5 files changed, 60 insertions(+), 96 deletions(-)

-- 
2.17.1
