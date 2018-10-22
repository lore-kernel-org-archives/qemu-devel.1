Received: from eggs.gnu.org ([2001:4830:134:3::10]:37957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPb-0002Gr-9W
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPV-0002uL-UM
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gEZPV-0002sq-Hm
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B001F3097026
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-34.ams2.redhat.com
	[10.36.117.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 53905105704C
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 Oct 2018 14:33:33 +0200
Message-Id: <20181022123413.28044-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/40] Error reporting patches for 2018-10-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 1b7490446bf41f54130c2d495dd4c8768c8e1c=
e3:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-p=
ull-request' into staging (2018-10-19 11:20:05 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-10-22

for you to fetch changes up to 80313fb53d8048882848b6f63daaeb29dc319765:

  error: Drop bogus "use error_setg() instead" admonitions (2018-10-19 15=
:47:09 +0200)

----------------------------------------------------------------
Error reporting patches for 2018-10-22

* Replace some unwise uses of error_report() & friends
* Print error when using incorrect backend for debugcon

----------------------------------------------------------------
Alberto Garcia (1):
      scripts: Remove check-qerror.sh

Fei Li (1):
      ui: Convert vnc_display_init(), init_keyboard_layout() to Error

Markus Armbruster (37):
      error: Fix use of error_prepend() with &error_fatal, &error_abort
      Use error_fatal to simplify obvious fatal errors (again)
      block: Use warn_report() & friends to report warnings
      cpus hw target: Use warn_report() & friends to report warnings
      vfio: Use warn_report() & friends to report warnings
      vfio: Clean up error reporting after previous commit
      char: Use error_printf() to print help and such
      9pfs: Fix CLI parsing crash on error
      pc: Fix machine property nvdimm-persistence error handling
      ioapic: Fix error handling in realize()
      smbios: Clean up error handling in smbios_add()
      migration: Fix !replay_can_snapshot() error handling
      l2tpv3: Improve -netdev/netdev_add/-net/... error reporting
      net/socket: Fix invalid socket type error handling
      numa: Fix QMP command set-numa-node error handling
      xen/pt: Fix incomplete conversion to realize()
      seccomp: Clean up error reporting in parse_sandbox()
      vl: Clean up error reporting in parse_add_fd()
      qom: Clean up error reporting in user_creatable_add_opts_foreach()
      vl: Clean up error reporting in chardev_init_func()
      vl: Clean up error reporting in machine_set_property()
      vl: Clean up error reporting in mon_init_func()
      vl: Clean up error reporting in parse_fw_cfg()
      vl: Clean up error reporting in device_init_func()
      ui/keymaps: Fix handling of erroneous include files
      vnc: Clean up error reporting in vnc_init_func()
      numa: Clean up error reporting in parse_numa()
      tpm: Clean up error reporting in tpm_init_tpmdev()
      spice: Clean up error reporting in add_channel()
      fsdev: Clean up error reporting in qemu_fsdev_add()
      vl: Assert drive_new() does not fail in default_drive()
      blockdev: Convert drive_new() to Error
      vl: Fix exit status for -drive format=3Dhelp
      vl: Simplify call of parse_name()
      block: Clean up bdrv_img_create()'s error reporting
      vpc: Fail open on bad header checksum
      error: Drop bogus "use error_setg() instead" admonitions

Philippe Mathieu-Daud=C3=A9 (1):
      vl: Print error when using incorrect backend for debugcon

 block.c                                  |   9 +++-----
 block/iscsi.c                            |   2 +-
 block/qcow2.c                            |   4 ++--
 block/qed.c                              |   4 ++--
 block/rbd.c                              |   4 ++--
 block/sheepdog.c                         |   2 +-
 block/vpc.c                              |   8 ++++---
 blockdev.c                               |  27 +++++++++++------------
 chardev/char-pty.c                       |   2 +-
 chardev/char.c                           |   2 +-
 cpus.c                                   |   8 +++----
 device-hotplug.c                         |   5 ++++-
 fsdev/qemu-fsdev-dummy.c                 |   2 +-
 fsdev/qemu-fsdev.c                       |  12 +++++------
 fsdev/qemu-fsdev.h                       |   2 +-
 hw/9pfs/9p-handle.c                      |   6 ++++--
 hw/9pfs/9p-local.c                       |   4 ++--
 hw/9pfs/xen-9p-backend.c                 |   7 +++++-
 hw/display/cg3.c                         |   2 +-
 hw/display/tcx.c                         |   2 +-
 hw/i386/pc.c                             |   5 +++--
 hw/intc/ioapic.c                         |   8 +++----
 hw/intc/xics.c                           |  15 +++++++------
 hw/intc/xics_kvm.c                       |   7 +-----
 hw/misc/ivshmem.c                        |   4 ++--
 hw/net/virtio-net.c                      |   8 +++----
 hw/ppc/pnv_core.c                        |   4 ++--
 hw/ppc/spapr_pci.c                       |   7 +++---
 hw/smbios/smbios.c                       |  90 +++++++++++++++++++++++++=
++++++++++++++++++++++++++++------------------------
 hw/timer/aspeed_timer.c                  |   3 +--
 hw/usb/bus.c                             |   5 +++--
 hw/vfio/pci-quirks.c                     |   4 ++--
 hw/vfio/pci.c                            |  25 +++++++++++-----------
 hw/vfio/platform.c                       |   6 +++---
 hw/virtio/virtio-pci.c                   |   4 ++--
 hw/xen/xen_pt.c                          |   2 +-
 include/hw/vfio/vfio-common.h            |   3 +--
 include/qapi/error.h                     |  14 ++++++++++++
 include/qapi/qmp/qerror.h                |   6 +++---
 include/sysemu/blockdev.h                |   3 ++-
 include/sysemu/numa.h                    |   1 -
 include/sysemu/tpm.h                     |   2 +-
 include/ui/console.h                     |   2 +-
 migration/migration.c                    |  12 +++++------
 migration/savevm.c                       |   8 +++----
 net/l2tpv3.c                             |  25 +++++++++++-----------
 net/socket.c                             |   4 ++--
 numa.c                                   |  21 ++++++++++--------
 qemu-io.c                                |   8 +++----
 qemu-nbd.c                               |  14 ++++--------
 qemu-seccomp.c                           |  18 ++++++++--------
 qom/object_interfaces.c                  |   4 +---
 scripts/check-qerror.sh                  |  22 -------------------
 scripts/coccinelle/use-error_fatal.cocci |  20 ++++++++++++++++++
 stubs/tpm.c                              |   3 +--
 target/i386/cpu.c                        |  17 ++++++++-------
 target/ppc/translate_init.inc.c          |   4 ++--
 tests/qemu-iotests/049.out               |  12 ++++-------
 tpm.c                                    |  22 ++++++++-----------
 ui/curses.c                              |   6 +++---
 ui/keymaps.c                             |  40 +++++++++++++++++++++++--=
----------
 ui/keymaps.h                             |   2 +-
 ui/sdl.c                                 |   6 +++---
 ui/spice-core.c                          |  13 ++++++------
 ui/vnc.c                                 |  19 +++++++++++------
 util/error.c                             |  13 ++++++++++++
 util/qemu-error.c                        |   5 -----
 vl.c                                     | 140 +++++++++++++++++++++++++=
+++++++++++++++++++++----------------------------------------------------=
----------------------
 68 files changed, 414 insertions(+), 386 deletions(-)
 delete mode 100755 scripts/check-qerror.sh
 create mode 100644 scripts/coccinelle/use-error_fatal.cocci

--=20
2.17.2
