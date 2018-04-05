Received: from eggs.gnu.org ([2001:4830:134:3::10]:49927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f49pA-0007Tk-LW
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 14:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f49p6-0005J3-EF
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 14:41:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1f49p6-0005Ir-7W
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 14:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4089785A01
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 18:41:23 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 05 Apr 2018 12:41:22 -0600
Message-ID: <152295356408.13263.6740252773525355794.stgit@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL for-2.12 0/1] vfio fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:

  Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20180405.0

for you to fetch changes up to 5c08600547c059e3fd072995f9f367cdaf3c7d9d:

  vfio: Use a trace point when a RAM section cannot be DMA mapped (2018-04-05 10:48:52 -0600)

----------------------------------------------------------------
VFIO fixes 2018-04-05

 - Convert over zealous error_report to trace point and make more
   meaningful (Eric Auger)

----------------------------------------------------------------
Eric Auger (1):
      vfio: Use a trace point when a RAM section cannot be DMA mapped

 hw/vfio/common.c     | 11 +++++------
 hw/vfio/trace-events |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)
