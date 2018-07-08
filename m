Received: from eggs.gnu.org ([2001:4830:134:3::10]:45762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbyvj-0000Jq-OM
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 21:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbyve-00055x-Oq
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 21:56:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fbyve-00055d-KD
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 21:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E81D881A4EBA
	for <qemu-devel@nongnu.org>; Sun,  8 Jul 2018 01:55:57 +0000 (UTC)
Received: from red.redhat.com (ovpn-123-105.rdu2.redhat.com [10.10.123.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB9D5111E411
	for <qemu-devel@nongnu.org>; Sun,  8 Jul 2018 01:55:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Sat,  7 Jul 2018 20:55:53 -0500
Message-Id: <20180708015554.297823-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] NBD patches for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300f8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-07-06 18:18:08 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-07-07

for you to fetch changes up to 0c0eaed14721f8a9db334deb35316411c512059a:

  nbd/server: fix nbd_co_send_block_status (2018-07-07 20:30:09 -0500)

Not much since my last pull request, but since I will be offline until
after rc1, I thought I'd get this one in now.

----------------------------------------------------------------
nbd patches for 2018-07-07

Minor improvement for tracing of NBD block status

- Vladimir Sementsov-Ogievskiy: nbd/server: fix nbd_co_send_block_status

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (1):
      nbd/server: fix nbd_co_send_block_status

 nbd/server.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.14.4
