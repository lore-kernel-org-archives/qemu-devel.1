Received: from eggs.gnu.org ([2001:4830:134:3::10]:56999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG6uV-0007pz-QP
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG6uR-000419-TX
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:51 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:36563 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dG6uR-000407-H9
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 31 May 2017 19:55:29 +0300
Message-Id: <20170531165541.47338-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 00/12] nbd refactoring part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is based on my "nbd: error path refactoring" series.
This is an update of first part of my "nbd errors and traces refactoring"

changes from patches 01-10 of "nbd errors and traces refactoring" (mostly
proposed by Eric):
01 new patch
02-03 - split of old 01
08 and 12 - minor changes in commit messages
04-12 - add r-b by Eric

also, of course, renaming in 01 is "visible" in other patches.

Vladimir Sementsov-Ogievskiy (12):
  nbd: rename read_sync and friends
  nbd: make nbd_drop public
  nbd/server: get rid of nbd_negotiate_read and friends
  nbd/server: get rid of ssize_t
  nbd/server: refactor nbd_co_send_reply
  nbd/server: get rid of EAGAIN dead code
  nbd/server: refactor nbd_co_receive_request
  nbd/server: remove NBDClientNewData
  nbd/server: nbd_negotiate: fix error path
  nbd/server: get rid of fail: return rc
  nbd/server: rename rc to ret
  nbd/server: refactor nbd_trip

 block/nbd-client.c  |   8 +-
 include/block/nbd.h |   8 +-
 nbd/client.c        |  64 ++++-------
 nbd/common.c        |  34 +++++-
 nbd/nbd-internal.h  |  28 ++---
 nbd/server.c        | 319 +++++++++++++++++-----------------------------------
 6 files changed, 172 insertions(+), 289 deletions(-)

-- 
2.11.1
