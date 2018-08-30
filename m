Received: from eggs.gnu.org ([2001:4830:134:3::10]:41340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fvOPc-0004cQ-J0
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fvOPb-00012g-Mz
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:59:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 30 Aug 2018 16:59:00 +0200
Message-Id: <20180830145902.27376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] qemu-error: advanced report_once
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

[Markus: I've decided to not include your R-b, as I did too many changes
to feel comfortable with that.]

[Also note that I'm about to disappear on vacation, so don't expect
quick responses. I just want to get it out before I forget about it.]

Based on previous discussions, I wanted to enhance the recently
merged report_once infrastucture with a way to print a message
once based on a variable instead of globally-once, similar to
what vfio-ccw uses today.

Not really tested, mainly wanted to get this out before my vacation
to get the ball rolling.

v1->v2:
- merged patch 3 (use the new function in vfio-ccw) into patch 1
- require a non-NULL 'printed' parameter
- have the functions return whether something was printed and slightly
  simplify the existing macros
- adapt macro formatting to suit my aesthetic sensibilities

Cornelia Huck (2):
  qemu-error: add {error,warn}_report_once_cond
  qemu-error: make use of {error,warn}_report_once_cond

 hw/vfio/ccw.c               | 18 +++--------------
 include/qemu/error-report.h | 39 ++++++++++++++++++------------------
 util/qemu-error.c           | 48 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 35 deletions(-)

-- 
2.14.4
