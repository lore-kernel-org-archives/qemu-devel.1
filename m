Received: from eggs.gnu.org ([2001:4830:134:3::10]:59532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1L-0001N8-5X
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1I-0004fP-7w
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP1I-0004da-1Q
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DEA240201A1
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B3D1D2024CA2
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  7 Feb 2018 13:39:49 +0100
Message-Id: <20180207124009.12376-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/20] Miscellaneous patches for 2018-02-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 20e0d439a6ded635ec89f6135c08cd5541c689=
62:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180204' into=
 staging (2018-02-06 14:21:41 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-02-07

for you to fetch changes up to 35aeba9964fca0c698352eeebbc9410c3d299c77:

  Move include qemu/option.h from qemu-common.h to actual users (2018-02-=
07 13:00:03 +0100)

----------------------------------------------------------------
Miscellaneous patches for 2018-02-07

----------------------------------------------------------------
Gerd Hoffmann (1):
      vnc: use stubs for CONFIG_VNC=3Dn dummy functions

Markus Armbruster (19):
      Use #include "..." for our own headers, <...> for others
      Clean up includes
      Drop superfluous includes of qapi-types.h and test-qapi-types.h
      Include qapi/error.h exactly where needed
      Drop superfluous includes of qapi/qmp/qerror.h
      Include qmp-commands.h exactly where needed
      Typedef the subtypes of QObject in qemu/typedefs.h, too
      Eliminate qapi/qmp/types.h
      qdict qlist: Make most helper macros functions
      Include qapi/qmp/qobject.h exactly where needed
      Include qapi/qmp/qlist.h exactly where needed
      Include qapi/qmp/qdict.h exactly where needed
      Include qapi/qmp/qstring.h exactly where needed
      Include qapi/qmp/qbool.h exactly where needed
      Include qapi/qmp/qnum.h exactly where needed
      Include qapi/qmp/qnull.h exactly where needed
      Drop superfluous includes of qapi/qmp/dispatch.h
      Drop superfluous includes of qapi/qmp/qjson.h
      Move include qemu/option.h from qemu-common.h to actual users

 accel/accel.c                                      |  2 +-
 audio/wavcapture.c                                 |  1 +
 backends/cryptodev.c                               |  1 -
 backends/hostmem.c                                 |  1 -
 backends/tpm.c                                     |  1 -
 balloon.c                                          |  2 +-
 block.c                                            |  6 ++++--
 block/blkdebug.c                                   |  2 +-
 block/blkverify.c                                  |  1 +
 block/block-backend.c                              |  2 ++
 block/crypto.c                                     |  2 ++
 block/curl.c                                       |  5 +++--
 block/file-posix.c                                 |  2 ++
 block/file-win32.c                                 |  3 +++
 block/gluster.c                                    |  3 +++
 block/iscsi-opts.c                                 |  1 +
 block/iscsi.c                                      |  3 ++-
 block/nbd.c                                        |  2 +-
 block/nfs.c                                        |  2 +-
 block/null.c                                       |  1 +
 block/parallels.c                                  |  3 ++-
 block/parallels.h                                  |  1 -
 block/qapi.c                                       |  6 +++++-
 block/qcow.c                                       |  5 +++--
 block/qcow2-cluster.c                              |  1 -
 block/qcow2.c                                      |  6 ++++--
 block/qed.c                                        |  2 +-
 block/quorum.c                                     |  4 ++--
 block/rbd.c                                        |  3 +++
 block/replication.c                                |  2 +-
 block/sheepdog.c                                   |  1 +
 block/snapshot.c                                   |  2 ++
 block/ssh.c                                        |  2 ++
 block/throttle.c                                   |  1 +
 block/vdi.c                                        |  1 +
 block/vhdx.c                                       |  2 +-
 block/vmdk.c                                       |  1 +
 block/vpc.c                                        |  3 ++-
 block/vvfat.c                                      |  4 +++-
 block/write-threshold.c                            |  2 +-
 blockdev-nbd.c                                     |  2 +-
 blockdev.c                                         |  5 ++++-
 blockjob.c                                         |  3 +--
 chardev/char-file.c                                |  3 ++-
 chardev/char-mux.c                                 |  3 ++-
 chardev/char-parallel.c                            |  2 ++
 chardev/char-pipe.c                                |  2 ++
 chardev/char-ringbuf.c                             |  3 +++
 chardev/char-serial.c                              |  2 ++
 chardev/char-socket.c                              |  2 ++
 chardev/char-stdio.c                               |  3 ++-
 chardev/char-udp.c                                 |  2 ++
 chardev/char.c                                     |  3 +++
 chardev/spice.c                                    |  2 ++
 contrib/ivshmem-server/main.c                      |  2 +-
 contrib/vhost-user-scsi/vhost-user-scsi.c          |  4 ++--
 cpus.c                                             |  4 ++--
 crypto/hash.c                                      |  1 -
 crypto/hmac.c                                      |  1 -
 crypto/ivgen-essiv.c                               |  1 -
 crypto/ivgen-plain.c                               |  1 -
 crypto/ivgen-plain64.c                             |  1 -
 crypto/random-gnutls.c                             |  1 +
 crypto/random-platform.c                           |  1 +
 device-hotplug.c                                   |  2 ++
 device_tree.c                                      |  2 +-
 docs/devel/qapi-code-gen.txt                       |  2 --
 dump.c                                             |  1 +
 fsdev/qemu-fsdev-throttle.c                        |  1 +
 fsdev/qemu-fsdev-throttle.h                        |  1 -
 fsdev/qemu-fsdev.c                                 |  5 +++--
 fsdev/qemu-fsdev.h                                 |  1 -
 hmp.c                                              |  1 +
 hmp.h                                              |  2 --
 hw/9pfs/9p-handle.c                                |  1 +
 hw/9pfs/9p-local.c                                 |  3 ++-
 hw/9pfs/9p-proxy.c                                 |  3 +++
 hw/9pfs/xen-9p-backend.c                           |  1 +
 hw/acpi/acpi-stub.c                                |  2 +-
 hw/acpi/core.c                                     |  3 +++
 hw/acpi/memory_hotplug.c                           |  1 +
 hw/acpi/vmgenid.c                                  |  1 +
 hw/adc/stm32f2xx_adc.c                             |  1 -
 hw/arm/boot.c                                      |  1 +
 hw/block/vhost-user-blk.c                          |  1 -
 hw/char/mcf_uart.c                                 |  1 -
 hw/char/virtio-console.c                           |  1 +
 hw/core/qdev.c                                     |  3 ++-
 hw/display/milkymist-tmu2.c                        |  1 +
 hw/display/qxl.c                                   |  1 +
 hw/display/virtio-gpu-3d.c                         |  1 -
 hw/display/virtio-gpu-pci.c                        |  2 ++
 hw/display/xlnx_dp.c                               |  1 +
 hw/i2c/ppc4xx_i2c.c                                |  1 -
 hw/i386/acpi-build.c                               |  1 +
 hw/i386/multiboot.c                                |  2 +-
 hw/i386/pc.c                                       |  3 +++
 hw/i386/pc_piix.c                                  |  1 +
 hw/i386/pc_q35.c                                   |  2 ++
 hw/i386/pc_sysfw.c                                 |  1 +
 hw/i386/xen/xen-hvm.c                              |  2 +-
 hw/ide/core.c                                      |  2 ++
 hw/ide/sii3112.c                                   |  4 ++--
 hw/intc/xics_pnv.c                                 |  1 -
 hw/intc/xics_spapr.c                               |  1 -
 hw/ipmi/ipmi.c                                     |  1 +
 hw/mips/mips_jazz.c                                |  1 +
 hw/mips/mips_malta.c                               |  1 +
 hw/misc/exynos4210_rng.c                           |  1 +
 hw/misc/mips_cmgcr.c                               |  1 -
 hw/misc/mps2-scc.c                                 |  1 -
 hw/net/rocker/qmp-norocker.c                       |  1 +
 hw/net/rocker/rocker.c                             |  1 +
 hw/net/rocker/rocker_of_dpa.c                      |  1 +
 hw/net/virtio-net.c                                |  2 +-
 hw/nios2/cpu_pic.c                                 |  1 -
 hw/nvram/eeprom_at24c.c                            |  3 +--
 hw/nvram/fw_cfg.c                                  |  2 ++
 hw/pci-bridge/i82801b11.c                          |  2 --
 hw/pci-bridge/ioh3420.c                            |  1 -
 hw/pci-bridge/xio3130_upstream.c                   |  1 -
 hw/pci-host/sabre.c                                |  1 -
 hw/pci/pci-stub.c                                  |  1 +
 hw/pci/pci.c                                       |  2 ++
 hw/pci/pcie_aer.c                                  |  3 +--
 hw/ppc/e500.c                                      |  2 +-
 hw/ppc/fdt.c                                       |  1 -
 hw/ppc/pnv_bmc.c                                   |  1 -
 hw/ppc/pnv_xscom.c                                 |  1 -
 hw/ppc/ppc.c                                       |  1 -
 hw/ppc/spapr.c                                     |  1 -
 hw/ppc/spapr_drc.c                                 |  1 +
 hw/ppc/spapr_pci_vfio.c                            |  1 -
 hw/ppc/spapr_rtc.c                                 |  3 ++-
 hw/ppc/virtex_ml507.c                              |  1 +
 hw/s390x/s390-ccw.c                                |  3 ++-
 hw/s390x/s390-skeys.c                              |  1 +
 hw/s390x/s390-stattrib.c                           |  2 +-
 hw/s390x/s390-virtio-ccw.c                         |  3 +--
 hw/scsi/esp.c                                      |  1 -
 hw/scsi/scsi-bus.c                                 |  1 +
 hw/scsi/vhost-scsi-common.c                        |  1 -
 hw/sd/sdhci.c                                      |  1 -
 hw/smbios/smbios-stub.c                            |  2 +-
 hw/smbios/smbios.c                                 |  1 +
 hw/sparc64/niagara.c                               |  1 -
 hw/sparc64/sun4u_iommu.c                           |  1 -
 hw/ssi/stm32f2xx_spi.c                             |  1 -
 hw/timer/m48t59.c                                  |  1 -
 hw/timer/mc146818rtc.c                             |  2 ++
 hw/tpm/tpm_emulator.c                              |  5 -----
 hw/tpm/tpm_int.h                                   |  2 --
 hw/tpm/tpm_ioctl.h                                 |  2 --
 hw/usb/ccid-card-passthru.c                        |  1 -
 hw/usb/xen-usb.c                                   |  4 ++--
 hw/vfio/pci.c                                      |  1 +
 hw/virtio/virtio-balloon.c                         |  1 +
 hw/watchdog/watchdog.c                             |  2 +-
 hw/xen/xen-common.c                                |  1 -
 hw/xen/xen_devconfig.c                             |  1 +
 hw/xtensa/xtensa_memory.h                          |  1 -
 hw/xtensa/xtfpga.c                                 |  2 +-
 include/block/block.h                              |  4 +---
 include/block/block_int.h                          |  2 --
 include/block/dirty-bitmap.h                       |  1 +
 include/block/nbd.h                                |  2 --
 include/block/qapi.h                               |  1 -
 include/block/snapshot.h                           |  2 --
 include/chardev/char.h                             |  2 --
 include/crypto/random.h                            |  2 --
 include/crypto/xts.h                               |  2 --
 include/exec/tb-lookup.h                           |  2 --
 include/hw/acpi/acpi.h                             |  1 -
 include/hw/acpi/acpi_dev_interface.h               |  1 -
 include/hw/block/block.h                           |  1 +
 include/hw/block/fdc.h                             |  1 +
 include/hw/ide/internal.h                          |  1 -
 include/hw/intc/xlnx-pmu-iomod-intc.h              |  1 -
 include/hw/intc/xlnx-zynqmp-ipi.h                  |  1 -
 include/hw/loader-fit.h                            |  2 +-
 include/hw/loader.h                                |  1 -
 include/hw/nvram/fw_cfg.h                          |  1 -
 include/hw/pci-bridge/simba.h                      |  1 -
 include/hw/qdev-core.h                             |  1 -
 include/hw/registerfields.h                        |  2 +-
 include/hw/s390x/storage-attributes.h              |  2 +-
 include/hw/smbios/smbios.h                         |  1 -
 include/hw/xtensa/xtensa-isa.h                     |  2 --
 include/migration/colo.h                           |  1 +
 include/monitor/monitor.h                          |  1 -
 include/net/net.h                                  |  5 +----
 include/net/slirp.h                                |  4 ----
 include/net/tap.h                                  |  1 -
 include/qapi/clone-visitor.h                       |  1 -
 include/qapi/opts-visitor.h                        |  1 -
 include/qapi/qmp-event.h                           |  1 -
 include/qapi/qmp/dispatch.h                        |  3 +--
 include/qapi/qmp/json-parser.h                     |  1 -
 include/qapi/qmp/qbool.h                           |  4 ++--
 include/qapi/qmp/qdict.h                           | 21 ++++++----------=
--
 include/qapi/qmp/qjson.h                           |  3 ---
 include/qapi/qmp/qlist.h                           | 19 ++++++----------
 include/qapi/qmp/qlit.h                            |  1 -
 include/qapi/qmp/qnum.h                            |  4 ++--
 include/qapi/qmp/qstring.h                         |  4 ++--
 include/qapi/qmp/types.h                           | 24 ----------------=
-----
 include/qapi/qobject-input-visitor.h               |  1 -
 include/qapi/qobject-output-visitor.h              |  1 -
 include/qapi/visitor.h                             |  2 +-
 include/qemu-common.h                              |  2 --
 include/qemu/config-file.h                         |  2 --
 include/qemu/option.h                              |  1 -
 include/qemu/throttle.h                            |  1 +
 include/qemu/typedefs.h                            |  7 +++++-
 include/qom/object_interfaces.h                    |  1 -
 include/scsi/pr-manager.h                          |  1 -
 include/sysemu/arch_init.h                         |  3 +--
 include/sysemu/dump.h                              |  1 -
 include/sysemu/hostmem.h                           |  1 -
 include/sysemu/hvf.h                               |  2 --
 include/sysemu/numa.h                              |  1 -
 include/sysemu/replay.h                            |  1 -
 include/sysemu/sysemu.h                            |  2 --
 include/sysemu/tpm.h                               |  1 -
 include/sysemu/tpm_backend.h                       |  1 -
 include/ui/console.h                               | 25 ----------------=
------
 include/ui/qemu-spice.h                            |  1 -
 io/channel-websock.c                               |  3 ---
 iothread.c                                         |  1 +
 linux-user/syscall.c                               |  1 -
 migration/colo-failover.c                          |  1 +
 migration/colo.c                                   |  1 +
 migration/exec.c                                   |  1 -
 migration/fd.c                                     |  1 -
 migration/migration.c                              |  2 ++
 migration/migration.h                              |  1 -
 migration/ram.c                                    |  2 ++
 migration/ram.h                                    |  1 +
 migration/savevm.c                                 |  1 +
 monitor.c                                          |  8 ++++---
 nbd/common.c                                       |  1 -
 net/clients.h                                      |  1 -
 net/colo-compare.c                                 |  1 -
 net/filter-mirror.c                                |  1 -
 net/filter-replay.c                                |  1 -
 net/filter-rewriter.c                              |  2 --
 net/net.c                                          |  4 +++-
 net/slirp.c                                        |  2 ++
 net/vhost-user.c                                   |  2 ++
 numa.c                                             |  1 +
 qapi/qapi-dealloc-visitor.c                        |  2 +-
 qapi/qapi-visit-core.c                             |  1 -
 qapi/qmp-dispatch.c                                |  4 +---
 qapi/qmp-event.c                                   |  1 +
 qapi/qobject-input-visitor.c                       |  7 +++++-
 qapi/qobject-output-visitor.c                      |  7 +++++-
 qdev-monitor.c                                     |  2 ++
 qemu-img.c                                         |  5 +++--
 qemu-io-cmds.c                                     |  1 +
 qemu-io.c                                          |  3 ++-
 qemu-keymap.c                                      |  1 -
 qemu-nbd.c                                         |  3 ++-
 qga/commands-posix.c                               |  1 +
 qga/commands-win32.c                               |  2 ++
 qga/commands.c                                     |  1 +
 qga/guest-agent-core.h                             |  2 +-
 qga/main.c                                         |  5 ++++-
 qga/vss-win32.c                                    |  1 +
 qmp.c                                              |  3 ++-
 qobject/json-parser.c                              |  7 +++++-
 qobject/qbool.c                                    |  1 -
 qobject/qdict.c                                    | 23 ++++++++++++++++=
+++-
 qobject/qjson.c                                    |  6 +++++-
 qobject/qlist.c                                    | 25 ++++++++++++++++=
+++++-
 qobject/qlit.c                                     |  6 +++++-
 qobject/qnum.c                                     |  2 --
 qobject/qobject.c                                  |  7 +++++-
 qobject/qstring.c                                  |  1 -
 qom/object.c                                       |  2 +-
 qom/object_interfaces.c                            |  2 ++
 replay/replay-input.c                              |  1 -
 replay/replay.c                                    |  2 +-
 scripts/qapi-commands.py                           |  4 ++--
 scripts/qapi-event.py                              |  2 +-
 scsi/pr-helper.h                                   |  2 --
 stubs/arch-query-cpu-def.c                         |  1 +
 stubs/arch-query-cpu-model-baseline.c              |  1 +
 stubs/arch-query-cpu-model-comparison.c            |  1 +
 stubs/arch-query-cpu-model-expansion.c             |  1 +
 stubs/dump.c                                       |  1 -
 stubs/vmgenid.c                                    |  1 +
 target/i386/cpu.c                                  |  5 +++--
 target/i386/hax-all.c                              |  1 -
 target/i386/hvf/hvf.c                              |  1 -
 target/i386/hvf/vmx.h                              |  1 -
 target/i386/hvf/x86_decode.c                       |  1 -
 target/i386/hvf/x86_mmu.c                          |  6 ++----
 target/i386/hvf/x86_task.c                         |  1 -
 target/i386/hvf/x86hvf.c                           |  3 ---
 target/i386/monitor.c                              |  2 ++
 target/i386/xsave_helper.c                         |  1 -
 target/nios2/helper.c                              |  1 -
 target/ppc/mmu-book3s-v3.c                         |  1 -
 target/ppc/mmu-hash64.c                            |  1 -
 target/ppc/mmu-radix64.c                           |  1 -
 target/ppc/mmu_helper.c                            |  1 -
 target/ppc/translate_init.c                        |  2 ++
 target/s390x/cpu_models.c                          |  2 +-
 target/s390x/excp_helper.c                         |  1 -
 target/s390x/gen-features.c                        |  6 ++----
 target/s390x/helper.c                              |  1 -
 target/s390x/kvm.c                                 |  2 +-
 target/xtensa/core-dc232b/xtensa-modules.c         |  3 ++-
 target/xtensa/core-dc233c/xtensa-modules.c         |  3 ++-
 target/xtensa/core-de212/xtensa-modules.c          |  3 ++-
 target/xtensa/core-fsf/xtensa-modules.c            |  3 ++-
 .../xtensa/core-sample_controller/xtensa-modules.c |  3 ++-
 target/xtensa/xtensa-isa.c                         |  4 +---
 target/xtensa/xtensa-isa.h                         |  2 +-
 tests/ahci-test.c                                  |  1 +
 tests/check-qdict.c                                |  4 +++-
 tests/check-qjson.c                                |  5 ++++-
 tests/check-qlist.c                                |  1 -
 tests/check-qlit.c                                 |  3 +--
 tests/check-qnum.c                                 |  1 -
 tests/check-qobject.c                              |  9 ++++++--
 tests/cpu-plug-test.c                              |  2 +-
 tests/device-introspect-test.c                     |  2 +-
 tests/drive_del-test.c                             |  1 +
 tests/io-channel-helpers.c                         |  1 -
 tests/libqos/libqos.c                              |  1 +
 tests/libqos/pci-pc.c                              |  2 +-
 tests/libqtest.c                                   |  5 ++++-
 tests/libqtest.h                                   |  2 --
 tests/migration-test.c                             |  1 +
 tests/migration/stress.c                           | 10 +--------
 tests/numa-test.c                                  |  2 ++
 tests/ptimer-test.c                                |  4 ++--
 tests/pvpanic-test.c                               |  1 +
 tests/q35-test.c                                   |  1 +
 tests/qmp-test.c                                   |  2 ++
 tests/qom-test.c                                   |  3 ++-
 tests/tco-test.c                                   |  2 ++
 tests/test-aio-multithread.c                       |  1 -
 tests/test-char.c                                  |  2 +-
 tests/test-clone-visitor.c                         |  2 --
 tests/test-keyval.c                                |  2 ++
 tests/test-netfilter.c                             |  1 +
 tests/test-qapi-util.c                             |  1 -
 tests/test-qemu-opts.c                             |  2 ++
 tests/test-qga.c                                   |  2 ++
 tests/test-qmp-commands.c                          |  6 ++++--
 tests/test-qmp-event.c                             |  8 ++++---
 tests/test-qobject-input-visitor.c                 |  7 ++++--
 tests/test-qobject-output-visitor.c                |  9 +++++---
 tests/test-replication.c                           |  2 ++
 tests/test-string-input-visitor.c                  |  2 --
 tests/test-string-output-visitor.c                 |  2 --
 tests/test-visitor-serialization.c                 |  4 +---
 tests/test-x86-cpuid-compat.c                      |  2 +-
 tests/tmp105-test.c                                |  1 +
 tests/vhost-user-test.c                            |  1 +
 tests/virtio-net-test.c                            |  1 +
 tests/vmgenid-test.c                               |  1 +
 tests/wdt_ib700-test.c                             |  1 +
 tpm.c                                              |  2 ++
 trace/control-internal.h                           |  2 --
 trace/control.c                                    |  1 +
 trace/qmp.c                                        |  1 +
 ui/Makefile.objs                                   |  1 +
 ui/cocoa.m                                         |  1 -
 ui/console.c                                       |  4 +++-
 ui/gtk.c                                           |  1 +
 ui/input-legacy.c                                  |  1 -
 ui/input.c                                         |  2 +-
 ui/spice-core.c                                    |  6 ++----
 ui/spice-display.c                                 |  2 +-
 ui/vnc-palette.h                                   |  1 -
 ui/vnc-stubs.c                                     | 21 ++++++++++++++++=
++
 ui/vnc.c                                           |  4 ++--
 ui/vnc.h                                           |  1 -
 util/keyval.c                                      |  2 ++
 util/qemu-config.c                                 |  2 ++
 util/qemu-option.c                                 |  5 ++++-
 vl.c                                               |  5 +++--
 385 files changed, 509 insertions(+), 435 deletions(-)
 delete mode 100644 include/qapi/qmp/types.h
 create mode 100644 ui/vnc-stubs.c

--=20
2.13.6
