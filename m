Received: from eggs.gnu.org ([209.51.188.92]:39200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqR-0002kE-9w
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqP-0007lP-N8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:11 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqP-0007jP-C8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id e74so10065939wmg.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:07 +0100
Message-Id: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/57] qgraph merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lviver@redhat.com

The following changes since commit 3a75ef6a0fe397b0d36930415be6b123750a6afe:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190307-pull-request' into staging (2019-03-07 14:06:42 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream-qgraph

for you to fetch changes up to 15bd8b2cdabbf8f3371f2e30b1ef04cf9fe9ec87:

  qos-test: megasas test node (2019-03-07 17:25:09 +0100)

----------------------------------------------------------------
qgraph project from GSoC 2018

----------------------------------------------------------------
Emanuele Giuseppe Esposito (45):
      tests/libqos: introduce virtio_start_device
      tests/libqos: rename qpci_init_pc and qpci_init_spapr functions
      tests: qgraph API for the qtest driver framework
      tests/libqos: pci-pc driver and interface nodes
      tests/libqos: x86_64/pc machine node
      tests/libqos: sdhci driver and interface nodes
      tests/libqos: arm/raspi2 machine node
      tests/libqos: arm/smdkc210 machine node
      tests/libqos: arm/sabrelite machine node
      tests/libqos: arm/xilinx-zynq-a9 machine node
      tests/libqos: aarch64/xlnx-zcu102 machine node
      qos-test: sdhci test node
      tests/libqos: pci-spapr driver and interface nodes
      tests/qgraph: ppc64/pseries machine node
      tests/libqos: has_buggy_msi flag
      tests/libqos: e1000e driver and interface nodes
      qos-test: e1000e test node
      tests/libqos: virtio-pci driver and interface nodes
      tests/libqos: virtio-mmio driver and interface nodes
      tests/libqos: arm/virt machine node
      tests/libqos: virtio-serial driver and interface nodes
      qos-test: virtio-console and virtio-serial test node
      tests/libqos: virtio-9p driver and interface nodes
      qos-test: virtio-9p test node
      tests/libqos: virtio-balloon driver and interface nodes
      tests/qgraph: remove virtio-balloon-test
      tests/libqos: virtio-rng driver and interface nodes
      qos-test: virtio-rng test node
      tests/libqos: virtio-blk driver and interface nodes
      tests/libqos: virtio-net driver and interface nodes
      qos-test: virtio-net test node
      tests/libqos: virtio-scsi driver and interface nodes
      qos-test: virtio-scsi test node
      qos-test: ac97 test node
      qos-test: tpci200 test node
      qos-test: ipoctal232 test node
      qos-test: ne2k_pci test node
      qos-test: nvme test node
      qos-test: pcnet test node
      qos-test: spapr-phb test node
      qos-test: usb-hcd-ohci test node
      qos-test: vmxnet3 test node
      qos-test: es1370 test node
      qos-test: eepro100 test node
      qos-test: e1000 test node

Paolo Bonzini (12):
      chardev-socket: do not blindly reset handlers when switching GMainContext
      tests/libqos: embed allocators instead of malloc-ing them separately
      tests/qgraph: add generic PCI testcases
      tests/libqos: remove global_qtest from virtio endianness checks
      tests/qgraph: add generic virtio testcases
      qos-test: virtio-blk test node
      tests/libqos: support multiqueue for virtio-net
      vhost-user-test: always use 256 MiB of guest memory
      qos-test: vhost-user test node
      tests/libqos: remove pre-qgraph QVirtioPCIDevice API
      tests: move virtio entirely to qos-test
      qos-test: megasas test node

 chardev/char-socket.c                      |   2 +-
 configure                                  |   2 +-
 include/qemu/module.h                      |   2 +
 tests/Makefile.include                     | 129 +++--
 tests/ac97-test.c                          |  47 +-
 tests/ahci-test.c                          |   6 +-
 tests/drive_del-test.c                     |  25 +-
 tests/e1000-test.c                         |  64 ++-
 tests/e1000e-test.c                        | 358 +++-----------
 tests/eepro100-test.c                      |  65 ++-
 tests/es1370-test.c                        |  46 +-
 tests/i440fx-test.c                        |   2 +-
 tests/ide-test.c                           |  19 +-
 tests/ipoctal232-test.c                    |  35 +-
 tests/libqos/aarch64-xlnx-zcu102-machine.c |  94 ++++
 tests/libqos/ahci.c                        |   2 +-
 tests/libqos/arm-raspi2-machine.c          |  91 ++++
 tests/libqos/arm-sabrelite-machine.c       |  91 ++++
 tests/libqos/arm-smdkc210-machine.c        |  91 ++++
 tests/libqos/arm-virt-machine.c            |  90 ++++
 tests/libqos/arm-xilinx-zynq-a9-machine.c  |  94 ++++
 tests/libqos/e1000e.c                      | 260 ++++++++++
 tests/libqos/e1000e.h                      |  53 ++
 tests/libqos/libqos-pc.c                   |   5 +-
 tests/libqos/libqos-spapr.c                |   5 +-
 tests/libqos/libqos.c                      |  13 +-
 tests/libqos/libqos.h                      |  13 +-
 tests/libqos/malloc-generic.c              |  39 --
 tests/libqos/malloc-generic.h              |  21 -
 tests/libqos/malloc-pc.c                   |  18 +-
 tests/libqos/malloc-pc.h                   |   4 +-
 tests/libqos/malloc-spapr.c                |  19 +-
 tests/libqos/malloc-spapr.h                |   4 +-
 tests/libqos/malloc.c                      |  42 +-
 tests/libqos/malloc.h                      |  21 +-
 tests/libqos/pci-pc.c                      |  86 ++--
 tests/libqos/pci-pc.h                      |  29 +-
 tests/libqos/pci-spapr.c                   | 119 +++--
 tests/libqos/pci-spapr.h                   |  26 +-
 tests/libqos/pci.c                         |  46 +-
 tests/libqos/pci.h                         |  16 +
 tests/libqos/ppc64_pseries-machine.c       | 111 +++++
 tests/libqos/qgraph.c                      | 753 +++++++++++++++++++++++++++++
 tests/libqos/qgraph.h                      | 575 ++++++++++++++++++++++
 tests/libqos/qgraph_internal.h             | 257 ++++++++++
 tests/libqos/sdhci.c                       | 163 +++++++
 tests/libqos/sdhci.h                       |  70 +++
 tests/libqos/tpci200.c                     |  65 +++
 tests/libqos/virtio-9p.c                   | 173 +++++++
 tests/libqos/virtio-9p.h                   |  42 ++
 tests/libqos/virtio-balloon.c              | 113 +++++
 tests/libqos/virtio-balloon.h              |  39 ++
 tests/libqos/virtio-blk.c                  | 124 +++++
 tests/libqos/virtio-blk.h                  |  40 ++
 tests/libqos/virtio-mmio.c                 | 116 +++--
 tests/libqos/virtio-mmio.h                 |   6 +-
 tests/libqos/virtio-net.c                  | 195 ++++++++
 tests/libqos/virtio-net.h                  |  41 ++
 tests/libqos/virtio-pci.c                  | 187 ++++---
 tests/libqos/virtio-pci.h                  |  18 +-
 tests/libqos/virtio-rng.c                  | 110 +++++
 tests/libqos/virtio-rng.h                  |  39 ++
 tests/libqos/virtio-scsi.c                 | 117 +++++
 tests/libqos/virtio-scsi.h                 |  39 ++
 tests/libqos/virtio-serial.c               | 110 +++++
 tests/libqos/virtio-serial.h               |  39 ++
 tests/libqos/virtio.c                      |  24 +-
 tests/libqos/virtio.h                      |  11 +-
 tests/libqos/x86_64_pc-machine.c           | 114 +++++
 tests/libqtest.h                           |   6 +
 tests/megasas-test.c                       |  80 +--
 tests/ne2000-test.c                        |  46 +-
 tests/nvme-test.c                          |  78 +--
 tests/pci-test.c                           |  25 +
 tests/pcnet-test.c                         |  46 +-
 tests/q35-test.c                           |   4 +-
 tests/qos-test.c                           | 445 +++++++++++++++++
 tests/rtas-test.c                          |   2 +-
 tests/rtl8139-test.c                       |   2 +-
 tests/sdhci-test.c                         | 185 +------
 tests/spapr-phb-test.c                     |  32 +-
 tests/tco-test.c                           |   2 +-
 tests/test-char.c                          | 102 +++-
 tests/test-qgraph.c                        | 434 +++++++++++++++++
 tests/tpci200-test.c                       |  31 --
 tests/usb-hcd-ehci-test.c                  |   2 +-
 tests/usb-hcd-ohci-test.c                  |  54 ++-
 tests/vhost-user-test.c                    | 385 ++++++---------
 tests/virtio-9p-test.c                     | 220 +++------
 tests/virtio-balloon-test.c                |  33 --
 tests/virtio-blk-test.c                    | 471 +++++++-----------
 tests/virtio-console-test.c                |  38 --
 tests/virtio-net-test.c                    | 226 +++------
 tests/virtio-rng-test.c                    |  27 +-
 tests/virtio-scsi-test.c                   | 145 +++---
 tests/virtio-serial-test.c                 |  27 +-
 tests/virtio-test.c                        |  25 +
 tests/vmxnet3-test.c                       |  46 +-
 98 files changed, 6885 insertions(+), 2219 deletions(-)
 create mode 100644 tests/libqos/aarch64-xlnx-zcu102-machine.c
 create mode 100644 tests/libqos/arm-raspi2-machine.c
 create mode 100644 tests/libqos/arm-sabrelite-machine.c
 create mode 100644 tests/libqos/arm-smdkc210-machine.c
 create mode 100644 tests/libqos/arm-virt-machine.c
 create mode 100644 tests/libqos/arm-xilinx-zynq-a9-machine.c
 create mode 100644 tests/libqos/e1000e.c
 create mode 100644 tests/libqos/e1000e.h
 delete mode 100644 tests/libqos/malloc-generic.c
 delete mode 100644 tests/libqos/malloc-generic.h
 create mode 100644 tests/libqos/ppc64_pseries-machine.c
 create mode 100644 tests/libqos/qgraph.c
 create mode 100644 tests/libqos/qgraph.h
 create mode 100644 tests/libqos/qgraph_internal.h
 create mode 100644 tests/libqos/sdhci.c
 create mode 100644 tests/libqos/sdhci.h
 create mode 100644 tests/libqos/tpci200.c
 create mode 100644 tests/libqos/virtio-9p.c
 create mode 100644 tests/libqos/virtio-9p.h
 create mode 100644 tests/libqos/virtio-balloon.c
 create mode 100644 tests/libqos/virtio-balloon.h
 create mode 100644 tests/libqos/virtio-blk.c
 create mode 100644 tests/libqos/virtio-blk.h
 create mode 100644 tests/libqos/virtio-net.c
 create mode 100644 tests/libqos/virtio-net.h
 create mode 100644 tests/libqos/virtio-rng.c
 create mode 100644 tests/libqos/virtio-rng.h
 create mode 100644 tests/libqos/virtio-scsi.c
 create mode 100644 tests/libqos/virtio-scsi.h
 create mode 100644 tests/libqos/virtio-serial.c
 create mode 100644 tests/libqos/virtio-serial.h
 create mode 100644 tests/libqos/x86_64_pc-machine.c
 create mode 100644 tests/pci-test.c
 create mode 100644 tests/qos-test.c
 create mode 100644 tests/test-qgraph.c
 delete mode 100644 tests/tpci200-test.c
 delete mode 100644 tests/virtio-balloon-test.c
 delete mode 100644 tests/virtio-console-test.c
 create mode 100644 tests/virtio-test.c
-- 
1.8.3.1
