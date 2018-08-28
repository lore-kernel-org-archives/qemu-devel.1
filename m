Received: from eggs.gnu.org ([2001:4830:134:3::10]:43810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fudC5-0005LB-M4
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fudC1-0006B1-G1
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:34:01 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 28 Aug 2018 14:33:43 +0200
Message-Id: <20180828123346.17548-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] qemu-error: advanced report_once handling
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

Based on previous discussions, I wanted to enhance the recently
merged report_once infrastucture with a way to print a message
once based on a variable instead of globally-once, similar to
what vfio-ccw uses today.

Not really tested, mainly wanted to get this out before my vacation
to get the ball rolling.

Cornelia Huck (3):
  qemu-error: add {error,warn}_report_once_cond
  qemu-error: make use of {error,warn}_report_once_cond
  vfio-ccw: switch to warn_report_once_cond()

 hw/vfio/ccw.c               | 18 +++---------------
 include/qemu/error-report.h | 15 +++++++--------
 util/qemu-error.c           | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 23 deletions(-)

-- 
2.14.4
