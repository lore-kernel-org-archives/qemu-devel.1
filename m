Received: from eggs.gnu.org ([209.51.188.92]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3Qag-00042z-2O
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3QVh-0005E6-JO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h3QVh-0005De-BB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:22:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91FD63084033
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 19:22:52 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 11 Mar 2019 13:22:50 -0600
Message-ID: <155233206671.8141.2579745444621332750.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/3] vfio updates 2019-03-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 2e35c7738e16452a95aec1fbef5e8b6f38a2d647:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190311-v2-pull-request' into staging (2019-03-11 13:45:37 +0000)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20190311.0

for you to fetch changes up to 8781c701445d83145ac1e69714e76a643f5525da:

  vfio/display: delay link up event (2019-03-11 12:59:59 -0600)

----------------------------------------------------------------
VFIO updates 2019-03-11

 - Resolution support for mdev displays supporting EDID interface
   (Gerd Hoffmann)

----------------------------------------------------------------
Gerd Hoffmann (3):
      vfio/display: add edid support.
      vfio/display: add xres + yres properties
      vfio/display: delay link up event

 hw/vfio/display.c             | 169 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 |  12 +++
 hw/vfio/pci.h                 |   2 +
 hw/vfio/trace-events          |   7 ++
 include/hw/vfio/vfio-common.h |   4 +
 5 files changed, 194 insertions(+)
