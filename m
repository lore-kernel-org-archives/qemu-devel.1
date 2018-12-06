Received: from eggs.gnu.org ([2001:4830:134:3::10]:55461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gUx87-0000Dx-KJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gUx7u-0002sD-0N
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:07:56 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu,  6 Dec 2018 18:07:31 +0100
Message-Id: <20181206170733.7469-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH-for-4.0 v2 0/2] ARM SMMUv3: Fix ACPI integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shannon.zhaosl@gmail.com
Cc: shameerali.kolothum.thodi@huawei.com

The first patch sets the COHACC override flag in the IORT SMMUv3 node.
This fixes a bug reported while decoding the command queue entries.

The second patch updates the RC and SMMUv3 node structures according to
revision D of the IORT spec and updates the revision fields.

Best Regards

Eric

History:

v1 -> v2:
- split into 2 separate patches
- sets the revision fields

Eric Auger (2):
  hw/arm/virt-acpi-build: Set COHACC override flag in IORT SMMUv3 node
  hw/arm/virt-acpi-build: IORT Update for revision D

 hw/arm/virt-acpi-build.c    |  5 +++++
 include/hw/acpi/acpi-defs.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

-- 
2.17.2
