Received: from eggs.gnu.org ([2001:4830:134:3::10]:60787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1frit7-0005jP-5p
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1frit3-0002Qj-T0
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:25 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:01:57 +0200
Message-Id: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 00/16] qtest: converted sdhci-test and most nop
 test to qgraph framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Keith Busch <keith.busch@intel.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

This series continues the QEMU tests conversion using the qgraph
framework started in the previous series.

Add the missing machines required to complete the sdhci-test started previously,
and convert most of the nop tests.

Based-on: 20180813101453.10200-1-e.emanuelegiuseppe@gmail.com
Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Emanuele Giuseppe Esposito (16):
  test/qgraph: arm/smdkc210 machine node
  test/qgraph: arm/sabrelite machine node
  test/qgraph: arm/xlinx-zynq-a9 machine node
  test/qgraph: aarch64/xlnx-zcu102 machine node
  test/qgraph: ac97 test node
  test/qgraph: tpci200 test node
  test/qgraph: ipoctal232 test node
  test/qgraph: ne2k_pci test node
  test/qgraph: nvme test node
  test/qgraph: pcnet test node
  test/qgraph: spapr-phb test node
  test/qgraph: usb-hcd-ohci test node
  test/qgraph: vmxnet3 test node
  test/qgraph: es1370 test node
  test/qgraph: eepro100 test node
  test/qgraph: e1000 test node

 tests/Makefile.include                | 48 +++++++--------
 tests/ac97-test.c                     | 39 ++++++++++---
 tests/e1000-test.c                    | 60 ++++++++++++-------
 tests/eepro100-test.c                 | 61 ++++++++++++-------
 tests/es1370-test.c                   | 39 ++++++++++---
 tests/ipoctal232-test.c               | 42 +++++++++++---
 tests/libqos/sabrelite-machine.c      | 82 ++++++++++++++++++++++++++
 tests/libqos/smdkc210-machine.c       | 82 ++++++++++++++++++++++++++
 tests/libqos/xilinx-zynq-a9-machine.c | 84 +++++++++++++++++++++++++++
 tests/libqos/xlnx-zcu102-machine.c    | 83 ++++++++++++++++++++++++++
 tests/ne2000-test.c                   | 39 ++++++++++---
 tests/nvme-test.c                     | 43 ++++++++++----
 tests/pcnet-test.c                    | 39 ++++++++++---
 tests/sdhci-test.c                    | 49 ----------------
 tests/spapr-phb-test.c                | 28 ++++-----
 tests/tpci200-test.c                  | 60 ++++++++++++++++---
 tests/usb-hcd-ohci-test.c             | 46 +++++++++++----
 tests/vmxnet3-test.c                  | 39 ++++++++++---
 18 files changed, 744 insertions(+), 219 deletions(-)
 create mode 100644 tests/libqos/sabrelite-machine.c
 create mode 100644 tests/libqos/smdkc210-machine.c
 create mode 100644 tests/libqos/xilinx-zynq-a9-machine.c
 create mode 100644 tests/libqos/xlnx-zcu102-machine.c

-- 
2.17.1
