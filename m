Received: from eggs.gnu.org ([209.51.188.92]:49819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gx3TJ-0002Ep-V2
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gx3TI-0004mR-N5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gx3TI-0004e4-CY
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3833459471
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 05:33:44 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 21 Feb 2019 22:33:41 -0700
Message-ID: <155081340903.23160.4034617687275790161.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/2] vfio updates 2019-02-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20190221.0

for you to fetch changes up to 2b6326c0bf2c686ae83d6904899cb80e9ad7a6fb:

  hw/vfio/common: Refactor container initialization (2019-02-21 21:07:03 -0700)

----------------------------------------------------------------
VFIO updates 2019-02-21

 - Workaround kernel overflow bug in vfio type1 DMA unmap
   (Alex Williamson)

 - Refactor vfio container initialization (Eric Auger)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/common: Work around kernel overflow bug in DMA unmap

Eric Auger (1):
      hw/vfio/common: Refactor container initialization

 hw/vfio/common.c     | 134 ++++++++++++++++++++++++++++++++++-----------------
 hw/vfio/trace-events |   1 +
 2 files changed, 90 insertions(+), 45 deletions(-)
