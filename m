Received: from eggs.gnu.org ([2001:4830:134:3::10]:48427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3891006ae=anthony.perard@citrix.com>)
	id 1dgBbK-0005Iz-Tr
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3891006ae=anthony.perard@citrix.com>)
	id 1dgBbF-0000iC-US
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:11:50 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:58291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3891006ae=anthony.perard@citrix.com>)
	id 1dgBbF-0000i5-Nt
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:11:45 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Fri, 11 Aug 2017 16:11:36 +0100
Message-ID: <20170811151138.29405-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 0/2] Fix hotplug of PCI passthrought
 device on Xen
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

Anthony PERARD (2):
  hw/acpi: Call acpi_set_pci_info when no ACPI tables needed
  Revert "ACPI: don't call acpi_pcihp_device_plug_cb on xen"

 hw/acpi/piix4.c      | 11 +++--------
 hw/i386/acpi-build.c |  4 ++--
 2 files changed, 5 insertions(+), 10 deletions(-)

-- 
Anthony PERARD
