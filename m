Received: from eggs.gnu.org ([2001:4830:134:3::10]:44055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqybv-0004uD-JV
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqybs-00073F-JZ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:00:47 -0400
Received: from [59.151.112.132] (port=34027 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqybs-00070x-85
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:00:44 -0400
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Thu, 23 Mar 2017 17:09:20 +0800
Message-ID: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/3] vfio-pci: support recovery of AER non
 fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com, mst@redhat.com

v3 changelog:
1. Address all comments from MST in patch 3, include remove the flag
   pci_aer_non_fatal & passive_reset, also the boilerplate code.
   The corresponding kernel patch is v6.

Test:
Test with func1 passthroughed while func0 doesn't have user.

Cao jin (3):
  pcie aer: verify if AER functionality is available
  vfio pci: new function to init AER capability
  vfio-pci: process non fatal error of AER

 hw/pci/pcie_aer.c          |  28 ++++++
 hw/vfio/pci.c              | 243 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.h              |   3 +
 linux-headers/linux/vfio.h |   2 +
 4 files changed, 271 insertions(+), 5 deletions(-)

-- 
1.8.3.1
