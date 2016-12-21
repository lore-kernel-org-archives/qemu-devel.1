Received: from eggs.gnu.org ([2001:4830:134:3::10]:37396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJc5N-0004kG-8o
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJc5J-0000Cu-TG
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:17:17 -0500
Received: from [59.151.112.132] (port=4212 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJc5J-0000Aa-DE
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:17:13 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Wed, 21 Dec 2016 16:21:29 +0800
Message-ID: <1482308491-25426-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/2] pcie_aer modification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, dmitry@daynix.com, jasowang@redhat.com

Because these 2 patches target to the same function, so put them together.
Cao's patch is simply a copy of v3; Dou's patch is taken from AER series,
rebase on Cao's, it would be no trouble letting it in first.
Both have been reviewed.

v4 changelog:
1. simply put 2 reviewed patch into a series
2. rebase & add the reviewer's R-b.

Test:
1. make check pass.
2. command line test with -device ioh3420,aer_log_max=0xffff/0/10/-1,
   the results meet the expectation.

Cao jin (1):
  pcie_aer: Convert pcie_aer_init to Error

Dou Liyang (1):
  pcie_aer: support configurable AER capa version

 hw/net/e1000e.c                    |  3 ++-
 hw/pci-bridge/ioh3420.c            |  4 +++-
 hw/pci-bridge/xio3130_downstream.c |  4 +++-
 hw/pci-bridge/xio3130_upstream.c   |  4 +++-
 hw/pci/pcie_aer.c                  | 19 ++++++++-----------
 include/hw/pci/pcie_aer.h          |  4 ++--
 6 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.1.0
