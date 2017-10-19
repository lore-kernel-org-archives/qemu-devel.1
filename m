Received: from eggs.gnu.org ([2001:4830:134:3::10]:35947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5JH8-00058M-8b
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5JH7-0003zz-1g
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:26:50 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 19 Oct 2017 17:26:26 -0500
Message-Id: <20171019222637.17890-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/11] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, pbonzini@redhat.com, qemu-block@nongnu.org

I've incorporated a few more tweaks since v4:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03305.html

I tried to call out the biggest changes in the various commits, but
it includes bug fixes from my testing, and fixing places spotted
by Vladimir.  I still haven't validated the behavior of the client
against a server that sends more than one chunk per reply, but this
is looking closer to a pull request, hopefully in time for soft freeze.

001/11:[0002] [FC] 'nbd: Include error names in trace messages'
002/11:[----] [-C] 'nbd: Move nbd_errno_to_system_errno() to public header'
003/11:[----] [--] 'nbd: Expose constants and structs for structured read'
004/11:[down] 'nbd/server: Report error for write to read-only export'
005/11:[down] 'nbd/server: Refactor zero-length option check'
006/11:[0014] [FC] 'nbd: Minimal structured read for server'
007/11:[0016] [FC] 'nbd/server: Include human-readable message in structured errors'
008/11:[0023] [FC] 'nbd/client: refactor nbd_receive_starttls'
009/11:[0004] [FC] 'nbd/client: prepare nbd_receive_reply for structured reply'
010/11:[----] [--] 'nbd: Move nbd_read() to common header'
011/11:[0282] [FC] 'nbd: Minimal structured read for client'

Eric Blake (7):
  nbd: Include error names in trace messages
  nbd: Move nbd_errno_to_system_errno() to public header
  nbd: Expose constants and structs for structured read
  nbd/server: Report error for write to read-only export
  nbd/server: Refactor zero-length option check
  nbd/server: Include human-readable message in structured errors
  nbd: Move nbd_read() to common header

Vladimir Sementsov-Ogievskiy (4):
  nbd: Minimal structured read for server
  nbd/client: refactor nbd_receive_starttls
  nbd/client: prepare nbd_receive_reply for structured reply
  nbd: Minimal structured read for client

 include/block/nbd.h | 106 +++++++++++-
 nbd/nbd-internal.h  |  23 +--
 block/nbd-client.c  | 491 ++++++++++++++++++++++++++++++++++++++++++++++++----
 nbd/client.c        | 215 +++++++++++++++--------
 nbd/common.c        |  84 +++++++++
 nbd/server.c        | 194 +++++++++++++++------
 nbd/trace-events    |  15 +-
 7 files changed, 934 insertions(+), 194 deletions(-)

-- 
2.13.6
