Received: from eggs.gnu.org ([2001:4830:134:3::10]:50533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9Yt3-0004N7-8k
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9Ysy-0007nu-Df
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:55:33 -0400
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:54904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9Ysy-0007mo-8W
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:55:28 -0400
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Tue, 31 Oct 2017 11:54:33 -0400
Message-ID: <20171031155435.4618-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] Fix eepro100 simple transmission,
 add i82559 chipset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, marcel@redhat.com, Mike
	Nawrocki <michael.nawrocki@gtri.gatech.edu>

This patch set does two things. First, it fixes the simple transmission mode
for the eepro100 chipset. Second, it adds and uses the PCI ID for the i82559
chipset, and enables selection of this chipset.

Mike Nawrocki (2):
  Fix eepro100 simple transmission mode
  Add i82559a eepro100 interface

 hw/net/eepro100.c    | 20 ++++----------------
 hw/pci/pci.c         |  2 ++
 include/hw/pci/pci.h |  1 +
 qemu-options.hx      |  2 +-
 4 files changed, 8 insertions(+), 17 deletions(-)

-- 
2.14.2
