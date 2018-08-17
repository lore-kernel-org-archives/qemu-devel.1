Received: from eggs.gnu.org ([2001:4830:134:3::10]:60011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fqiEa-0000co-3f
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fqiEV-0007So-Mr
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fqiEV-0007SS-GU
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0202D401DECE
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 17:08:19 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 17 Aug 2018 11:08:16 -0600
Message-ID: <153452552631.13804.12031418293966530953.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/4] VFIO update 2018-08-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d19428:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-08-17 09:46:00 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180817.0

for you to fetch changes up to 238e91728503d400e1c4e644e3a9b80f9e621682:

  vfio/ccw/pci: Allow devices to opt-in for ballooning (2018-08-17 09:27:16 -0600)

----------------------------------------------------------------
VFIO update 2018-08-17

 - Enhance balloon inhibitor for multiple users and use around vfio
   device assignment (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (4):
      balloon: Allow multiple inhibit users
      kvm: Use inhibit to prevent ballooning without synchronous mmu
      vfio: Inhibit ballooning based on group attachment to a container
      vfio/ccw/pci: Allow devices to opt-in for ballooning

 accel/kvm/kvm-all.c           |  4 ++++
 balloon.c                     | 13 ++++++++---
 hw/vfio/ccw.c                 |  9 ++++++++
 hw/vfio/common.c              | 51 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 26 +++++++++++++++++++++-
 hw/vfio/trace-events          |  1 +
 hw/virtio/virtio-balloon.c    |  4 +---
 include/hw/vfio/vfio-common.h |  2 ++
 8 files changed, 103 insertions(+), 7 deletions(-)
