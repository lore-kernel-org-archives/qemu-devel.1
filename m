Received: from eggs.gnu.org ([2001:4830:134:3::10]:55488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWM1f-0007ZK-Q0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWM1e-0004p3-Uu
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:22:55 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 22 Jun 2018 15:22:42 +0200
Message-Id: <1529673765-16627-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] ARM virt: Silence dtc warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, crosthwaite.peter@gmail.com, agraf@suse.de

When running dtc on the guest /proc/device-tree, we get the
following warnings: "Warning (unit_address_vs_reg): Node <name>
has a reg or ranges property, but no unit name", with name:
/intc, /intc/its, /intc/v2m, /memory.

This series removes those warnings by adding the unit address to
the corresponding node names.

Best Regards

Eric

History:
v2 -> v3:
- only nop root /memory and /memory@unit-address nodes
- remove a deprecated comment

v1 -> v2:
- nop existing node-name and node-name@unit-address nodes and
  add our owns.
- added 1st patch device_tree: Add qemu_fdt_node_unit_path

Eric Auger (3):
  device_tree: Add qemu_fdt_node_unit_path
  hw/arm/virt: Silence dtc /intc warnings
  hw/arm/virt: Silence dtc /memory warning

 device_tree.c                | 55 ++++++++++++++++++++++++++++++++++++
 hw/arm/boot.c                | 41 +++++++++++++++------------
 hw/arm/virt.c                | 66 +++++++++++++++++++++++++-------------------
 include/sysemu/device_tree.h | 16 +++++++++++
 4 files changed, 132 insertions(+), 46 deletions(-)

-- 
2.5.5
