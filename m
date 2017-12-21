Received: from eggs.gnu.org ([2001:4830:134:3::10]:33633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRpmJ-0007Hk-Ke
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRpmG-0001Qy-HW
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRpmG-0001Pw-BR
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:36:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF40681DF0
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 01:36:02 +0000 (UTC)
Received: from red.redhat.com (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 821A55C88F
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 01:36:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 20 Dec 2017 19:35:56 -0600
Message-Id: <20171221013600.17648-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] NBD patches through 20 Dec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 4da5c51cac8363f86ec92dc99c38f9382d617647:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-12-20' into staging (2017-12-20 20:38:36 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-12-20

for you to fetch changes up to fab45bb24a35b4791deecf3ec732d64b0b987662:

  qmp: add nbd-server-remove (2017-12-20 16:55:32 -0600)

----------------------------------------------------------------
nbd patches for 2017-12-20

- Eric Blake: 0/2 Optimize sparse reads over NBD
- Vladimir Sementsov-Ogievskiy: 0/2 add qmp nbd-server-remove

----------------------------------------------------------------
Eric Blake (2):
      nbd/server: Implement sparse reads atop structured reply
      nbd/server: Optimize final chunk of sparse read

Vladimir Sementsov-Ogievskiy (2):
      nbd/server: add additional assert to nbd_export_put
      qmp: add nbd-server-remove

 qapi/block.json  | 20 ++++++++++++++
 blockdev-nbd.c   | 27 +++++++++++++++++++
 nbd/server.c     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 nbd/trace-events |  1 +
 4 files changed, 125 insertions(+), 3 deletions(-)

-- 
2.14.3
