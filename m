Received: from eggs.gnu.org ([2001:4830:134:3::10]:53615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eC8il-00087L-FI
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eC8ig-0003CI-Ib
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:35:35 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:43729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eC8ig-0003BR-BS
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:35:30 -0500
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Tue, 7 Nov 2017 13:35:01 -0500
Message-ID: <20171107183503.6800-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/2] Fix eepro100 simple transmission,
 add i82559 PCI ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, marcel@redhat.com, Mike
	Nawrocki <michael.nawrocki@gtri.gatech.edu>

This patch set does two things. First, it fixes the simple transmission mode
for the eepro100 chipset. Second, it adds the PCI device ID 0x1030 for the
i82559a chipset. This ID is set as the "alternate" PCI device ID for that
chipset, and is selected by default using the new "x-use-alternate-device-id"
property. This property is set to the compat value of false in
"hw/include/compat.h"

Mike Nawrocki (2):
  Fix eepro100 simple transmission mode
  Add new PCI ID for i82559a

 hw/net/eepro100.c    | 31 ++++++++++++++++---------------
 include/hw/compat.h  |  4 ++++
 include/hw/pci/pci.h |  1 +
 qemu-options.hx      |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

-- 
2.14.2
