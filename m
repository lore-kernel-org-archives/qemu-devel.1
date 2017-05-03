Received: from eggs.gnu.org ([2001:4830:134:3::10]:40541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d61yu-0003Xn-9z
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d61yt-000417-AG
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:38:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d61yt-00040V-49
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2BD9804EC
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 21:38:41 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 03 May 2017 15:38:39 -0600
Message-ID: <20170503213659.11828.39423.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/3] VFIO fixes 2017-05-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d60:

  Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into staging (2017-05-02 15:16:29 +0100)

are available in the git repository at:


  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170503.0

for you to fetch changes up to 6e4e6f0d403b1fb25f9dfdbe17754c643997753d:

  vfio/pci: Fix incorrect error message (2017-05-03 14:52:35 -0600)

----------------------------------------------------------------
VFIO fixes 2017-05-03

 - Enable 8-byte memory region accesses (Jose Ricardo Ziviani)
 - Fix vfio-pci error message (Dong Jia Shi)

----------------------------------------------------------------
Dong Jia Shi (1):
      vfio/pci: Fix incorrect error message

Jose Ricardo Ziviani (2):
      vfio: Set MemoryRegionOps:max_access_size and min_access_size
      vfio: enable 8-byte reads/writes to vfio

 hw/vfio/common.c | 14 ++++++++++++++
 hw/vfio/pci.c    |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)
