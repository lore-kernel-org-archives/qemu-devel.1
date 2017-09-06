Received: from eggs.gnu.org ([2001:4830:134:3::10]:60216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dpbIV-0008Gj-47
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dpbIQ-0004gV-Hj
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dpbIQ-0004dO-C6
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:14 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  6 Sep 2017 17:26:56 +0300
Message-Id: <20170906142658.58298-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] hw/pcie: disable IO port fwd by default
 for pcie-root-port.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

For most cases the devices attached to PCIe Root Ports
do not need IO ports range, add an 'enable-io-fwd' property
making it false by default. Keep the property true for older
machines.

Add QEMU 2.11 machine if nobody did it yet.

Note that the series may collide with Alexandr's pcie-pci-bridge
series.

Marcel Apfelbaum (2):
  pc: add 2.11 machine types
  hw/pcie: disable IO port fwd by default for pcie-root-port

 hw/i386/pc_piix.c                  | 15 ++++++++++++---
 hw/i386/pc_q35.c                   | 13 +++++++++++--
 hw/pci-bridge/gen_pcie_root_port.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/hw/compat.h                |  6 +++++-
 include/hw/i386/pc.h               |  3 +++
 5 files changed, 69 insertions(+), 6 deletions(-)

-- 
2.13.5
