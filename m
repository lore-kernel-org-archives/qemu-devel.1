Received: from eggs.gnu.org ([2001:4830:134:3::10]:41059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLq-0005Bp-82
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLj-0004VN-97
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmLf-0004QO-9D
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:37 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:05 -0200
Message-Id: <20181211180129.7661-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/24] Machine queue post-3.1.0 (including 4.0
 machine-types)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The following changes since commit 32a1a94dd324d33578dca1dc96d7896a0244d7=
68:

  Update version for v3.1.0 release (2018-12-11 17:18:37 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 37fdb2c56c603378b85466d1dd64fb4c95f9deb7:

  qom: remove unimplemented class_finalize (2018-12-11 15:45:23 -0200)

----------------------------------------------------------------
Machine queue post-3.1.0 (including 4.0 machine-types)

Features:
* Add 4.0 machine-types to q35/440fx/arm/spapr (Alex Williamson)

Documentation:
* Document vCPU hotplug procedure (Kashyap Chamarthy)
* Deprecate `cpu-add` monitor commands (Kashyap Chamarthy)

Bug fixes:
* A small sun4v_rtc_write() tracing fix that fell through the cracks
  (Eduardo Habkost)
* Validation of "host-nodes" option on memory backends (Eduardo Habkost)
* memory-device fixes and cleanups (David Hildenbrand)

Cleanups:
* Machine-type code cleanup (remove unnecessary instance_init functions)
  (Eduardo Habkost)
* qdev, qom, and global property code cleanups (Marc-Andr=C3=A9 Lureau)
* PCMachineState field renames (Corey Minyard)
* numa: Match struct to typedef name (Eric Blake)
* hostmem-file: remove object id from pmem error message (Zhang Yi)

----------------------------------------------------------------

Queue for Machine Core patches


Alex Williamson (1):
  q35/440fx/arm/spapr: Add QEMU 4.0 machine type

Corey Minyard (1):
  i386: Rename bools in PCMachineState to end in _enabled

David Hildenbrand (3):
  range: pass const pointer where possible
  memory-device: use QEMU_IS_ALIGNED
  memory-device: avoid overflows on very huge devices

Eduardo Habkost (7):
  hw/timer/sun4v-rtc: Fix tracing at sun4v_rtc_write()
  hostmem: Validate host-nodes before setting bitmap
  virt: Eliminate separate instance_init functions
  spapr: Use default_machine_opts to set use_hotplug_event_source
  spapr: Use default_machine_opts to set suppress_vmdesc
  spapr: Delete instance_options functions
  pc: Use default_machine_opts to set suppress_vmdesc

Eric Blake (1):
  numa: Match struct to typedef name

Gerd Hoffmann (1):
  move ObjectClass to typedefs.h

Kashyap Chamarthy (3):
  docs: Document vCPU hotplug procedure
  Deprecate QMP `cpu-add`
  Deprecate HMP `cpu-add`

Marc-Andr=C3=A9 Lureau (6):
  tests: qdev_prop_check_globals() doesn't return "all_used"
  qom: make interface types abstract
  qom: make user_creatable_complete() specific to UserCreatable
  accel: register global_props like machine globals
  qdev: move qdev_prop_register_global_list() to tests
  qom: remove unimplemented class_finalize

Zhang Yi (1):
  hostmem-file: remove object id from pmem error message

 docs/cpu-hotplug.rst                 | 142 +++++++++++++++++++++++++++
 qapi/misc.json                       |   8 +-
 include/hw/acpi/acpi_dev_interface.h |   6 +-
 include/hw/arm/linux-boot-if.h       |   5 +-
 include/hw/compat.h                  |   3 +
 include/hw/fw-path-provider.h        |   4 +-
 include/hw/hotplug.h                 |   6 +-
 include/hw/i386/pc.h                 |   9 +-
 include/hw/intc/intc.h               |   4 +-
 include/hw/ipmi/ipmi.h               |   4 +-
 include/hw/isa/isa.h                 |   4 -
 include/hw/mem/memory-device.h       |   4 +-
 include/hw/nmi.h                     |   4 +-
 include/hw/qdev-properties.h         |  30 ------
 include/hw/stream.h                  |   4 +-
 include/hw/timer/m48t59.h            |   4 +-
 include/qemu/range.h                 |   6 +-
 include/qemu/typedefs.h              |   3 +-
 include/qom/object.h                 |   8 +-
 include/qom/object_interfaces.h      |  10 +-
 include/sysemu/numa.h                |   2 +-
 include/sysemu/tpm.h                 |   4 +-
 target/arm/idau.h                    |   4 +-
 accel/accel.c                        |   9 +-
 backends/hostmem-file.c              |  14 +--
 backends/hostmem.c                   |  17 +++-
 hmp.c                                |   2 +
 hw/arm/virt.c                        |  94 ++++++------------
 hw/core/machine.c                    |  11 ---
 hw/core/qdev-properties.c            |  30 ------
 hw/i386/pc.c                         |  18 ++--
 hw/i386/pc_piix.c                    |  20 +++-
 hw/i386/pc_q35.c                     |  19 +++-
 hw/mem/memory-device.c               |   9 +-
 hw/misc/ivshmem.c                    |   2 +-
 hw/ppc/spapr.c                       | 102 ++++---------------
 hw/timer/sun4v-rtc.c                 |   2 +-
 hw/virtio/virtio-rng.c               |   2 +-
 qom/object.c                         |  14 +--
 qom/object_interfaces.c              |  14 +--
 tests/check-qom-interface.c          |   4 +-
 tests/test-qdev-global-props.c       |  30 ++++--
 hmp-commands.hx                      |   6 +-
 qemu-deprecated.texi                 |   5 +
 44 files changed, 344 insertions(+), 358 deletions(-)
 create mode 100644 docs/cpu-hotplug.rst

--=20
2.18.0.rc1.1.g3f1ff2140
