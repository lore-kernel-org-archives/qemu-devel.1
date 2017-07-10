Received: from eggs.gnu.org ([2001:4830:134:3::10]:39080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dUe4e-0004Fo-On
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dUe4b-0001kD-JX
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dUe4b-0001jY-DM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFFE9C00C11D
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 19:10:18 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 10 Jul 2017 13:10:16 -0600
Message-ID: <20170710190904.32728.74078.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/2] VFIO fixes 2017-07-10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f33d:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2'
into staging (2017-07-10 16:12:47 +0100)

are available in the git repository at:


  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170710.0

for you to fetch changes up to 47985727e383eee191a39cc007541c17cd8680ee:

  vfio/pci: Fixup v0 PCIe capabilities (2017-07-10 10:39:43 -0600)

----------------------------------------------------------------
VFIO fixes 2017-07-10

 - Don't iterate over non-realized devices (Alex Williamson)
 - Add PCIe capability version fixup (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (2):
      vfio: Test realized when using VFIOGroup.device_list iterator
      vfio/pci: Fixup v0 PCIe capabilities

 hw/vfio/common.c              |  6 ++++--
 hw/vfio/pci.c                 | 19 +++++++++++++++++--
 hw/vfio/platform.c            |  1 +
 include/hw/vfio/vfio-common.h |  1 +
 4 files changed, 23 insertions(+), 4 deletions(-)
