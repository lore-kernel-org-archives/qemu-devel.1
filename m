Received: from eggs.gnu.org ([2001:4830:134:3::10]:57123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfmu-00026L-F6
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFflG-0006XS-Ai
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:33:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:18 -0300
Message-Id: <20181025133301.16578-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/43] Machine queue, 2018-10-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

Changes v1 -> v2:
* Fix 'make check' warnings (Igor)


The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966b=
a3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22=
' into staging (2018-10-23 17:20:23 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 8fa922c241e63f018f5b55c03ac494ae3d5fe594:

  net: xgmac: convert SysBus init method to a realize method (2018-10-24 =
06:44:59 -0300)

----------------------------------------------------------------
Machine queue, 2018-10-25

* sysbus init/realize cleanups
  (C=C3=A9dric Le Goater, Philippe Mathieu-Daud=C3=A9)
* memory-device refactoring (David Hildenbrand)
* -smp: deprecate incorrect CPUs topology (Igor Mammedov)
* -numa parsing cleanups (Markus Armbruster)
* Fix hostmem-file memory leak (Zhang Yi)
* Typo fix (Li Qiang)

----------------------------------------------------------------

Queue for Machine Core patches


C=C3=A9dric Le Goater (11):
  net: etraxfs_eth: convert SysBus init method to a realize method
  net: etraxfs_eth: add a reset method
  net: lan9118: convert SysBus init method to a realize method
  net: lance: convert SysBus init method to a realize method
  net: milkymist_minimac2: convert SysBus init method to a realize
    method
  net: mipsnet: convert SysBus init method to a realize method
  net: opencores_eth: convert SysBus init method to a realize method
  net: smc91c111: convert SysBus init method to a realize method
  net: stellaris_enet: convert SysBus init method to a realize method
  net: stellaris_enet: add a reset method
  net: xgmac: convert SysBus init method to a realize method

David Hildenbrand (16):
  memory-device: fix alignment error message
  memory-device: fix error message when hinted address is too small
  memory-device: improve "range conflicts" error message
  pc-dimm: pass PCDIMMDevice to pc_dimm_.*plug
  memory-device: use memory device terminology in error messages
  memory-device: introduce separate config option
  memory-device: forward errors in get_region_size()/get_plugged_size()
  memory-device: document MemoryDeviceClass
  memory-device: add and use memory_device_get_region_size()
  memory-device: factor out get_memory_region() from pc-dimm
  memory-device: drop get_region_size()
  memory-device: add device class function set_addr()
  memory-device: complete factoring out pre_plug handling
  memory-device: complete factoring out plug handling
  memory-device: complete factoring out unplug handling
  memory-device: trace when pre_plugging/plugging/unplugging

Igor Mammedov (2):
  vl.c deprecate incorrect CPUs topology
  vl:c: make sure that sockets are calculated correctly in '-smp X' case

Li Qiang (1):
  machine: fix a typo

Philippe Mathieu-Daud=C3=A9 (12):
  trace-events: Fix copy/paste typo
  hw/timer/sun4v-rtc: Convert from DPRINTF() macro to trace events
  hw/timer/sun4v-rtc: Use DeviceState::realize rather than
    SysBusDevice::init
  hw/ssi/xilinx_spi: Use DeviceState::realize rather than
    SysBusDevice::init
  hw/sh4/sh_pci: Use DeviceState::realize rather than SysBusDevice::init
  hw/pci-host/bonito: Use DeviceState::realize rather than
    SysBusDevice::init
  hw/mips/gt64xxx_pci: Convert gt64120_reset() function into Device
    reset method
  hw/mips/gt64xxx_pci: Mark as bridge device
  hw/sparc64/niagara: Model the I/O Bridge with the
    'unimplemented_device'
  hw/alpha/typhoon: Remove unuseful code
  hw/hppa/dino: Remove unuseful code
  hw/mips/malta: Remove unuseful code

Zhang Yi (1):
  hostmem-file: fixed the memory leak while get pmem path.

 default-configs/i386-softmmu.mak    |   3 +-
 default-configs/ppc64-softmmu.mak   |   3 +-
 default-configs/sparc64-softmmu.mak |   1 -
 qapi/misc.json                      |   2 +-
 include/hw/mem/memory-device.h      |  74 +++++++++++++++++---
 include/hw/mem/pc-dimm.h            |  10 +--
 backends/hostmem-file.c             |  10 ++-
 hw/alpha/typhoon.c                  |  13 ----
 hw/core/machine.c                   |   2 +-
 hw/hppa/dino.c                      |   7 --
 hw/i386/pc.c                        |   6 +-
 hw/mem/memory-device.c              | 103 ++++++++++++++++++++++------
 hw/mem/nvdimm.c                     |   9 ++-
 hw/mem/pc-dimm.c                    |  84 ++++++++---------------
 hw/mips/gt64xxx_pci.c               |  18 ++---
 hw/mips/mips_malta.c                |  13 ----
 hw/net/etraxfs_eth.c                |  44 ++++++++----
 hw/net/lan9118.c                    |   9 +--
 hw/net/lance.c                      |   8 +--
 hw/net/milkymist-minimac2.c         |   9 +--
 hw/net/mipsnet.c                    |   9 +--
 hw/net/opencores_eth.c              |   8 +--
 hw/net/smc91c111.c                  |   8 +--
 hw/net/stellaris_enet.c             |  15 ++--
 hw/net/xgmac.c                      |   9 +--
 hw/pci-host/bonito.c                |   9 +--
 hw/ppc/spapr.c                      |  29 +++-----
 hw/sh4/sh_pci.c                     |  20 +++---
 hw/sparc64/niagara.c                |   4 +-
 hw/ssi/xilinx_spi.c                 |   9 +--
 hw/timer/sun4v-rtc.c                |  23 +++----
 tests/cpu-plug-test.c               |  18 ++---
 vl.c                                |  12 +++-
 hw/Makefile.objs                    |   2 +-
 hw/mem/Makefile.objs                |   4 +-
 hw/mem/trace-events                 |   5 +-
 hw/timer/trace-events               |   6 +-
 qemu-deprecated.texi                |  12 ++++
 38 files changed, 344 insertions(+), 286 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
