Received: from eggs.gnu.org ([2001:4830:134:3::10]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePBS8-0000sf-1s
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePBS6-00049O-Dx
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ePBS6-00048W-7K
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:08:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4E016014F
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 18:08:16 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 13 Dec 2017 11:08:11 -0700
Message-ID: <20171213180541.10386.38737.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/4] VFIO updates for v2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:

  Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)

are available in the git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20171213.0

for you to fetch changes up to 2fb9636ebf24e695617bf407bf0a345aa223d1ac:

  vfio-pci: Remove unused fields from VFIOMSIXInfo (2017-12-13 10:19:34 -0700)

----------------------------------------------------------------
VFIO updates for v2.12

 - Fix bug failing to register all but the first group attached to
   a container with kvm-vfio device (Alex Williamson)

 - Explicit QLIST init (Yi Lui)

 - SPAPR IOMMU v1 fallback (Alexey Kardashevskiy)

 - Remove unused structure fields (Alexey Kardashevskiy)

----------------------------------------------------------------
Alex Williamson (1):
      vfio: Fix vfio-kvm group registration

Alexey Kardashevskiy (2):
      vfio/spapr: Allow fallback to SPAPR TCE IOMMU v1
      vfio-pci: Remove unused fields from VFIOMSIXInfo

Liu, Yi L (1):
      vfio/common: init giommu_list and hostwin_list of vfio container

 hw/vfio/common.c | 8 ++++++++
 hw/vfio/pci.h    | 2 --
 2 files changed, 8 insertions(+), 2 deletions(-)
