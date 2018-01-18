Received: from eggs.gnu.org ([2001:4830:134:3::10]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebzub-0005XE-4x
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebzuX-0000za-4N
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:26:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebzuW-0000z5-UH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:26:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 053AE7E425
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 02:26:36 +0000 (UTC)
Received: from red.redhat.com (ovpn-126-198.rdu2.redhat.com [10.10.126.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C53E5C8AF
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 02:26:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 17 Jan 2018 20:26:19 -0600
Message-Id: <20180118022625.6462-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] NBD patches through 17 Jan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-01-17

for you to fetch changes up to 1d17922a28f5b9a8adcea3c93f49086e0a751e86:

  nbd/server: structurize option reply sending (2018-01-17 20:14:12 -0600)

I'm still waiting for v3 of Vladimir's "0/6 nbd export qmp interface",
but it's been a week since my last pull, so it's worth flushing the queue.

----------------------------------------------------------------
pull-nbd-2018-01-17

- Vladimir Sementsov-Ogievskiy/Eric Blake: 0/6 NBD server refactoring

----------------------------------------------------------------
Eric Blake (4):
      nbd/server: Hoist nbd_reject_length() earlier
      nbd/server: Better error for NBD_OPT_EXPORT_NAME failure
      nbd/server: Add va_list form of nbd_negotiate_send_rep_err()
      nbd/server: Add helper functions for parsing option payload

Vladimir Sementsov-Ogievskiy (2):
      nbd/server: refactor negotiation functions parameters
      nbd/server: structurize option reply sending

 nbd/server.c | 342 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 171 insertions(+), 171 deletions(-)

-- 
2.14.3
