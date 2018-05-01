Received: from eggs.gnu.org ([2001:4830:134:3::10]:55245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDYMs-0003rK-06
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDYMo-00075f-2V
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:43:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fDYMn-000754-RQ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:43:01 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 01 May 2018 10:42:47 -0600
Message-ID: <20180501162901.28940.1075.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/4] vfio/quirks: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, eric.auger@redhat.com, peterx@redhat.com

Now that vfio ioeventfd support is in v4.17-rc kernels, let's push
forward with this series.  I've posted the linux-headers update
separate as it was rather an ordeal with conflicting defines, non-
upstream defines, and inveted types that don't exist.  Dependencies
to build this series:

https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg00097.html

Which depends on MST's:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg02510.html

The first two patches are unchanged and I've kept previous reviews.
The change to the latter two patches is the addition of trace events
and options for disabling both vfio and KVM ioeventfds.  These are
both experimental options which are useful for debugging and
evaluating any performance differences, not intended for support.
Please review.  Thanks,

Alex

---

Alex Williamson (4):
      vfio/quirks: Add common quirk alloc helper
      vfio/quirks: Add quirk reset callback
      vfio/quirks: ioeventfd quirk acceleration
      vfio/quirks: Enable ioeventfd quirks to be handled by vfio directly


 hw/vfio/pci-quirks.c |  273 +++++++++++++++++++++++++++++++++++++++++++++-----
 hw/vfio/pci.c        |    6 +
 hw/vfio/pci.h        |   19 +++
 hw/vfio/trace-events |    3 +
 4 files changed, 272 insertions(+), 29 deletions(-)
