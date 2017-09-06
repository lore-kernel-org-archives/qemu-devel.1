Received: from eggs.gnu.org ([2001:4830:134:3::10]:42545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpaZj-0004aM-8h
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpaZd-0004mR-LB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:41:03 -0400
Received: from smtp.citrix.com ([66.165.176.89]:63080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpaZd-0004m8-Ez
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:40:57 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Wed, 6 Sep 2017 14:40:30 +0100
Message-ID: <20170906134033.13348-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/3] Fix hotplug of PCI passthrought device
 on Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Adding PCI passthrough before the guest start works fine (broken in 2.9 but now
fixed), but hotplug does not work anymore.

Anthony PERARD (3):
  hw/acpi: Limit hotplug to root bus on legacy mode
  hw/acpi: Move acpi_set_pci_info to pcihp
  Revert "ACPI: don't call acpi_pcihp_device_plug_cb on xen"

 hw/acpi/pcihp.c       | 40 +++++++++++++++++++++++++++++++++++++++-
 hw/acpi/piix4.c       | 11 +++--------
 hw/i386/acpi-build.c  | 32 --------------------------------
 stubs/Makefile.objs   |  1 +
 stubs/pci-host-piix.c |  6 ++++++
 5 files changed, 49 insertions(+), 41 deletions(-)
 create mode 100644 stubs/pci-host-piix.c

-- 
Anthony PERARD
