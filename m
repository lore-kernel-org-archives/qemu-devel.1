Received: from eggs.gnu.org ([2001:4830:134:3::10]:37764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dvNYz-0005sC-FY
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dvNYu-0005oX-TT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:00:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dvNYu-0005ll-NI
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:00:08 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 22 Sep 2017 15:59:46 +0300
Message-id: <1506085187-24259-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170922130003eucas1p2a29104716255a091990ad0f29cf35cb3@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH] linux-headers: sync against v4.14-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: a.perevalov@samsung.com, dgilbert@redhat.com

This patch contains modification of userfaultfd.h,
necessary for series
"calculate blocktime for postcopy live migration"
it was decided to send it separatelly with another
modifications. 

Build was tested with docker, but it's not fully tested
at runtime.
Based on a664607440511fdf8cff9d1c2afefbdbca1d1295
"Merge remote-tracking branch 'remotes/famz/tags/build-and-test-automation-pull-request' into staging"


Alexey Perevalov (1):
  linux-headers: sync against v4.14-rc1

 include/standard-headers/asm-x86/hyperv.h    | 19 ++++++++++---
 include/standard-headers/linux/pci_regs.h    | 42 ++++++++++++++++------------
 include/standard-headers/linux/virtio_ring.h |  4 +--
 linux-headers/asm-s390/kvm.h                 |  6 ++++
 linux-headers/linux/kvm.h                    |  3 +-
 linux-headers/linux/userfaultfd.h            | 16 ++++++++++-
 6 files changed, 64 insertions(+), 26 deletions(-)

-- 
1.9.1
