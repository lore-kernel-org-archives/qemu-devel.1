Received: from eggs.gnu.org ([209.51.188.92]:53160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu9GR-0003Mk-7s
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu9GF-0003xr-Pc
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:08:39 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:39607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gu9GE-0003nQ-T0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:08:35 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Feb 2019 16:08:06 +1100
Message-Id: <20190214050808.16653-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Some small cleanups and corrections to
 PCI-E handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

Here are a couple of cleanups for PCI-E handling which arose out of
some other work I have in progress.  At least the first of these
patches has been posted before as part of a different series, but
wasn't ready to go at the time.

David Gibson (2):
  pci: Simplify pci_bus_is_root()
  pcie: Don't allow extended config space access via conventional PCI
    bridges

 hw/pci-bridge/pci_expander_bridge.c |  6 -----
 hw/pci/pci.c                        | 40 ++++++++++++++++++++++-------
 hw/virtio/virtio-pci.c              |  1 +
 include/hw/pci/pci.h                |  5 ++--
 include/hw/pci/pci_bus.h            | 13 ++++++++++
 5 files changed, 48 insertions(+), 17 deletions(-)

--=20
2.20.1
