Received: from eggs.gnu.org ([2001:4830:134:3::10]:52003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erVM5-0005ge-AS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erVM4-0003zZ-0t
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:03:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erVM3-0003zH-O1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 16:03:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53A924040856
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 21:02:55 +0000 (UTC)
Received: from red.redhat.com (ovpn-122-122.rdu2.redhat.com [10.10.122.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDC72026E04
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 21:02:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 15:02:45 -0600
Message-Id: <20180301210249.14872-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] nbd patches for 2018-03-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0dc8ae5e8e693737dfe65ba02d0c6eccb58a9c67:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180301-v2' into staging (2018-03-01 17:08:16 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-03-01

for you to fetch changes up to 28fb494f9b8827c6087d515e20a3c78baaf443cc:

  nbd/client: fix error messages in nbd_handle_reply_err (2018-03-01 14:48:23 -0600)

----------------------------------------------------------------
nbd patches for 2018-03-01

- Eric Blake: nbd: Honor server's advertised minimum block size
- Vladimir Sementsov-Ogievskiy: partial: nbd block status base:allocation

----------------------------------------------------------------
Eric Blake (1):
      nbd: Honor server's advertised minimum block size

Vladimir Sementsov-Ogievskiy (3):
      nbd: change indenting in nbd.h
      nbd: BLOCK_STATUS constants
      nbd/client: fix error messages in nbd_handle_reply_err

 include/block/nbd.h | 53 ++++++++++++++++++++++++++++++++++++++++++-----------
 block/nbd-client.c  |  3 ---
 block/nbd.c         |  2 ++
 nbd/client.c        | 24 ++++++++++++------------
 nbd/common.c        | 10 ++++++++++
 nbd/server.c        |  4 ++--
 nbd/trace-events    |  8 ++++----
 7 files changed, 72 insertions(+), 32 deletions(-)

-- 
2.14.3
