Received: from eggs.gnu.org ([2001:4830:134:3::10]:38225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqM5n-00043Y-VG
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqM5k-0008Lv-PS
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55218 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqM5k-0008LZ-La
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:32 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 26 Feb 2018 10:57:21 -0600
Message-Id: <20180226165723.17818-1-eblake@redhat.com>
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/2] nbd block status initial patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com

Here's the bits of 3/9 and 5/9 that I liked, but where I made further
changes.  I'd like to take these two, plus the original 2/9 as-is,
as part of my next NBD PULL request, but want to make sure you are
okay with my changes.

Yes, I still need to follow up on the upstream NBD list what we
are going to do about the disagreement on values for the constants
between the early Virtuozzo implementation and the current wording
in the NBD extension branch.

Vladimir Sementsov-Ogievskiy (2):
  nbd: BLOCK_STATUS constants
  nbd/client: fix error messages in nbd_handle_reply_err

 include/block/nbd.h | 31 +++++++++++++++++++++++++++++++
 nbd/client.c        | 20 ++++++++++----------
 nbd/common.c        | 10 ++++++++++
 nbd/server.c        |  4 ++--
 nbd/trace-events    |  8 ++++----
 5 files changed, 57 insertions(+), 16 deletions(-)

-- 
2.14.3
