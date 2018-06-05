Received: from eggs.gnu.org ([2001:4830:134:3::10]:54764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQIDf-0003Q1-Ve
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQIDb-0002qd-Bp
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fQIDb-0002ot-4Y
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31B94307C974
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 20:06:10 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 05 Jun 2018 14:06:07 -0600
Message-ID: <20180605200425.24323.56023.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/6] VFIO updates 2018-06-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 41feb5b955f0d7c9d071b2c5adbc404ae2895c7a:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-06-05 10:38:33 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180605.0

for you to fetch changes up to 8151a9c56d31eeeea872b8103c8b86d03c411667:

  vfio/pci: Default display option to "off" (2018-06-05 08:28:09 -0600)

----------------------------------------------------------------
VFIO updates 2018-06-05

 - Removed unused DPRINTF (Tiwei Bie)
 - KVM & VFIO ioeventfd support for NVIDIA MSI ACK (Alex Williamson)
 - Default vfio-pci display support to "off" (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (5):
      vfio/quirks: Add common quirk alloc helper
      vfio/quirks: Add quirk reset callback
      vfio/quirks: ioeventfd quirk acceleration
      vfio/quirks: Enable ioeventfd quirks to be handled by vfio directly
      vfio/pci: Default display option to "off"

Tiwei Bie (1):
      vfio: remove DPRINTF() definition from vfio-common.h

 hw/vfio/pci-quirks.c          | 268 +++++++++++++++++++++++++++++++++++++-----
 hw/vfio/pci.c                 |   8 +-
 hw/vfio/pci.h                 |  18 +++
 hw/vfio/trace-events          |   3 +
 include/hw/vfio/vfio-common.h |   9 --
 5 files changed, 267 insertions(+), 39 deletions(-)
