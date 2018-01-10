Received: from eggs.gnu.org ([2001:4830:134:3::10]:50371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPU5-0006Ac-4x
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPU3-00065a-K5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:37 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 17:08:19 -0600
Message-Id: <20180110230825.18321-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] NBD server refactoring before
 BLOCK_STATUS
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

This is my promised revision of Vladimir's v1 posted here:
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04119.html

Sorry for my delay; it was due in part to an embargo while dealing
with 2 bounds-check CVEs in the NBD code that I discovered while
reviewing his v1 (fixed in time for 2.11), then waiting for the
2.12 tree to reopen, coupled with my holiday break.  I'm hoping
we can get actual BLOCK_STATUS code reviewed and applied much
faster than this preliminary series has gone.

Based-on: <20180110225944.17920-1-eblake@redhat.com>

Since v1:
- original patch 4/5 now in a pull request
- replace original 2-3/5 with a single patch, giving more useful
semantics to nbd_opt_drop/nbd_opt_read
- add a couple of other easy fixes while touching the file

Eric Blake (4):
  nbd/server: Hoist nbd_reject_length() earlier
  nbd/server: Better error for NBD_OPT_EXPORT_NAME failure
  nbd/server: Add va_list form of nbd_negotiate_send_rep_err()
  nbd/server: Add helper functions for parsing option payload

Vladimir Sementsov-Ogievskiy (2):
  nbd/server: refactor negotiation functions parameters
  nbd/server: structurize option reply sending

 nbd/server.c | 341 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 171 insertions(+), 170 deletions(-)

-- 
2.14.3
