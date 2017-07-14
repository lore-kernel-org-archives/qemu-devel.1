Received: from eggs.gnu.org ([2001:4830:134:3::10]:40698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW5OD-0004ub-Ud
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW5OD-0005bb-34
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:32:33 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 13:32:22 -0500
Message-Id: <20170714183224.7209-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] NBD fixes before softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com

Paolo's inclusion of my NBD series in his miscellaneous tree
ended up with a couple of bugs that were pointed out in the
thread after the pull request was first created; these are the
fixes.  They are small enough that I don't mind using maintainer
status to bundle them up as a PULL request for NBD sometime on
Monday (in order to make soft freeze), whether or not they've
been reviewed by then; but of course, review is appreciated.

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01983.html
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01981.html

Eric Blake (2):
  nbd: Trace client command being sent
  nbd: Fix server reply to NBD_OPT_EXPORT_NAME of older clients

 nbd/client.c     | 3 ++-
 nbd/server.c     | 4 ++--
 nbd/trace-events | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.9.4
