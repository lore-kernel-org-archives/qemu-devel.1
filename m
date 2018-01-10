Received: from eggs.gnu.org ([2001:4830:134:3::10]:44784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPLb-0001Zk-Vf
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPLY-0004Wn-Rf
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:59:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZPLY-0004Ux-Ja
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:59:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00D488762D
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:59:47 +0000 (UTC)
Received: from red.redhat.com (ovpn-124-124.rdu2.redhat.com [10.10.124.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F19418954
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:59:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 16:59:42 -0600
Message-Id: <20180110225944.17920-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] nbd patches for 10 Jan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3cee4db661ab9c0fce7937b3bbfa188a1845f31f:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-08' into staging (2018-01-09 15:22:47 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-01-10

for you to fetch changes up to 420a4e955909788263a33d11600839e93480dfd3:

  nbd: rename nbd_option and nbd_opt_reply (2018-01-10 12:11:23 -0600)

Not much time elapsed since my last pull request, but my last request
was delayed due the holiday break, and I've now got other patches that
will be easier to post if I can do a Based-on: against this pull request,
rather than the larger in-progress series they were extracted from.

----------------------------------------------------------------
nbd patches for 2018-01-10

- Vladimir Sementsov-Ogievskiy: nbd: rename nbd_option and nbd_opt_reply
- Vladimir Sementsov-Ogievskiy: nbd/server: add additional assert to nbd_export_put

----------------------------------------------------------------
Vladimir Sementsov-Ogievskiy (2):
      nbd/server: add additional assert to nbd_export_put
      nbd: rename nbd_option and nbd_opt_reply

 include/block/nbd.h |  8 ++++----
 nbd/client.c        | 12 ++++++------
 nbd/server.c        |  6 ++++++
 3 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.14.3
