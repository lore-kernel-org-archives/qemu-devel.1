Received: from eggs.gnu.org ([2001:4830:134:3::10]:58749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fRem6-0007eK-K2
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fRem5-0004Nr-R0
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:23:26 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  9 Jun 2018 16:23:11 +0200
Message-Id: <1528554193-27270-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] ARM virt: Silence dtc warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

When running dtc on the guest /proc/device-tree, we get the
following warnings: "Warning (unit_address_vs_reg): Node <name>
has a reg or ranges property, but no unit name", with name:
/intc, /intc/its, /intc/v2m, /memory.

This series removes those warnings by adding the unit address to
the corresponding node names.

Best Regards

Eric

Eric Auger (2):
  hw/arm/virt: Silence dtc /intc warnings
  hw/arm/virt: Silence dtc /memory warning

 hw/arm/boot.c | 20 ++++++++++++------
 hw/arm/virt.c | 65 ++++++++++++++++++++++++++++++++++-------------------------
 2 files changed, 51 insertions(+), 34 deletions(-)

-- 
2.5.5
