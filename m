Received: from eggs.gnu.org ([2001:4830:134:3::10]:43288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqdV2-0002MO-73
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqdUz-0007KI-Lp
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:28:16 -0400
Received: from [59.151.112.132] (port=24619 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqdUz-0007Ju-9x
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:28:13 -0400
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Wed, 22 Mar 2017 18:36:49 +0800
Message-ID: <1490179012-14990-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/3] vfio-pci: support recovery of AER non
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

v2 changelog:
Add the boilerplate code for new eventfd in patch 3. The corresponding
kernel patch is v5.

Test:
Test with func1 passthroughed while func0 doesn't have user.

Cao jin (3):
  pcie aer: verify if AER functionality is available
  vfio pci: new function to init AER capability
  vfio-pci: process non fatal error of AER

 hw/pci/pcie_aer.c          |  28 +++++
 hw/vfio/pci.c              | 288 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.h              |   5 +
 linux-headers/linux/vfio.h |   2 +
 4 files changed, 318 insertions(+), 5 deletions(-)

-- 
1.8.3.1
