Received: from eggs.gnu.org ([2001:4830:134:3::10]:55263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3XJH-0005Bi-Dv
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 21:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3XJG-00014z-KC
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 21:01:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 20:01:23 -0500
Message-Id: <20171015010131.12172-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/8] nbd mimimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com

As mentioned in my review of Vladimir's v3 of this series [1],
I had enough tweaks during my review that it's easier to repost
things for another round of discussion, adding some of my patches
in between his.  I did not include his 13/13 "nbd: Minimal structured
read for client", where I had a lot of comments, and suggest that
Vladimir is in the best position to rebase that patch on top of
this v4 series (post it as a 9/8, if desired).

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02755.html

Based-on: <20171015004033.3248-1-eblake@redhat.com>
([PULL 0/9] NBD patches through 14 Oct)

Eric Blake (5):
  nbd: Include error names in trace messages
  nbd: Move nbd_errno_to_system_errno() to public header
  nbd: Expose constants and structs for structured read
  nbd/server: Include human-readable message in structured errors
  nbd: Move nbd_read() to common header

Vladimir Sementsov-Ogievskiy (3):
  nbd: Minimal structured read for server
  nbd/client: refactor nbd_receive_starttls
  nbd/client: prepare nbd_receive_reply for structured reply

 include/block/nbd.h |  94 ++++++++++++++++++++++--
 nbd/nbd-internal.h  |  24 +------
 block/nbd-client.c  |   8 ++-
 nbd/client.c        | 204 +++++++++++++++++++++++++++++++++-------------------
 nbd/common.c        |  84 ++++++++++++++++++++++
 nbd/server.c        | 121 ++++++++++++++++++++++++++++---
 nbd/trace-events    |  15 ++--
 7 files changed, 427 insertions(+), 123 deletions(-)

-- 
2.13.6
