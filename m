Received: from eggs.gnu.org ([2001:4830:134:3::10]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehihN-00040f-PY
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 16:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehihM-0000Gy-Un
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 16:16:41 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  2 Feb 2018 22:16:25 +0100
Message-Id: <20180202211628.3661-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block/iscsi: fix ioctl cancel
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Patches 1 & 2 are cleanups.

Patch 3 fixes cancellation of ioctls.  Felipe showed me a trace where an acb is
cancelled and then completes twice.  The second time around crashes QEMU.

Compile-tested only.

Felipe: Please let us know if this fixes the issue you are seeing.  Thanks!

Stefan Hajnoczi (3):
  block/iscsi: drop unused IscsiAIOCB->buf field
  block/iscsi: take iscsilun->mutex in iscsi_timed_check_events()
  block/iscsi: fix ioctl cancel use-after-free

 block/iscsi.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

-- 
2.14.3
