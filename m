Received: from eggs.gnu.org ([2001:4830:134:3::10]:34362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tE3-0003H0-8V
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tE2-0002Zt-8w
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:22:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5tE2-0002Ze-5G
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:22:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B06D14075A60
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 13:22:06 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-166.rdu2.redhat.com [10.10.121.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7857110B2B43
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 13:22:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 10 Apr 2018 08:21:57 -0500
Message-Id: <20180410132200.187832-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] QAPI patches for 2018-04-10, 2.12-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit fb4fe32d5b6290deabe752b51cc1cc2a9e8573db:

  Merge remote-tracking branch 'remotes/xtensa/tags/20180409-xtensa' into staging (2018-04-10 10:22:45 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-04-10

for you to fetch changes up to 951702f39c7e31530ce4ea65b11fe25ea1ea9c37:

  monitor: bind dispatch bh to iohandler context (2018-04-10 07:49:43 -0500)

Hopefully the last of the fixes for regressions caused by OOB which
could be observed even when x-oob=on is not used.

----------------------------------------------------------------
qapi patches for 2018-04-10

- Peter Xu: iotests: fix wait_until_completed()
- Peter Xu: iothread: workaround glib bug which hangs qmp-test
- Peter Xu: monitor: bind dispatch bh to iohandler context

----------------------------------------------------------------
Peter Xu (3):
      iotests: fix wait_until_completed()
      iothread: workaround glib bug which hangs qmp-test
      monitor: bind dispatch bh to iohandler context

 iothread.c                    | 18 ++++++++++++++----
 monitor.c                     |  2 +-
 tests/qemu-iotests/iotests.py |  9 +++------
 3 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.14.3
