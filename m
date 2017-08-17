Received: from eggs.gnu.org ([2001:4830:134:3::10]:40617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaM-0005cS-2q
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaJ-0003BY-00
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:23:54 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:43939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaI-0003Av-QV
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:23:50 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 17 Aug 2017 17:23:44 +0100
Message-ID: <20170817162347.1590-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 v3 0/3] Fix hotplug of PCI
 passthrought device on Xen
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

 hw/acpi/pcihp.c      | 33 ++++++++++++++++++++++++++++++++-
 hw/acpi/piix4.c      | 11 +++--------
 hw/i386/acpi-build.c | 32 --------------------------------
 3 files changed, 35 insertions(+), 41 deletions(-)

-- 
Anthony PERARD
