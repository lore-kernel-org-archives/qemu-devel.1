Received: from eggs.gnu.org ([2001:4830:134:3::10]:49429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSYbj-0007m5-Bw
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSYbf-0005iQ-BJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:32:43 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 29 Nov 2018 20:32:29 -0600
Message-Id: <20181130023232.3079982-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1? 0/3] NBD dirty bitmap cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-stable@nongnu.org

I'm working on a larger series for 4.0 that will add
'qemu-nbd --list' to show all possible information about a
server's exports, to make it easier to diagnose if the right
exports and bitmaps are present.  But in the process, I found
a few bugs that may be worth fixing in 3.1.  By itself, this
series does not warrant -rc4 (particularly since all of the
problems exist in the 3.0 release, so this is not a regression
fix), but if we have -rc4 for other reasons, these would make
incremental backup support a bit more reliable.

Eric Blake (3):
  nbd/server: Advertise all contexts in response to bare LIST
  nbd/client: Make x-dirty-bitmap more reliable
  nbd/client: Send NBD_CMD_DISC if open fails after connect

 block/nbd-client.c | 21 ++++++++++++++++++++-
 nbd/server.c       |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.17.2
