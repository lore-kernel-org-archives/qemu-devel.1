Received: from eggs.gnu.org ([2001:4830:134:3::10]:54841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYs1-0004Nm-Ca
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYrx-0001ko-Ad
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:45 -0400
Received: from [62.254.189.133] (port=38662 helo=centos.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDYrw-0001dZ-Up
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:10:41 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 24 May 2017 17:09:59 +0100
Message-Id: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH 0/4] migration: autoconverge counter fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Felipe Franciosi <felipe@nutanix.com>

As discussed in the ML [1], there are some issues around the way ram.c accounts
for transferred data and dirty pages for the auto convergence calculations. The
patches in these series fix that by:

- Keeping bytes_xfer_prev zeroed until it's used
- Ensure bytes_xfer_* counters are accounted for the same period as
  dirty_pages_* counters
- Start throttling in a consistent manner

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg05524.html

Felipe Franciosi (4):
  migration: keep bytes_xfer_prev init'd to zero
  migration: set dirty_pages_rate before autoconverge logic
  migration: set bytes_xfer_* outside of autoconverge logic
  migration: use dirty_rate_high_cnt more aggressively

 migration/ram.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
1.9.5
