Received: from eggs.gnu.org ([2001:4830:134:3::10]:53228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcol-0006wP-9U
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcog-00062T-DM
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcog-000628-4l
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:17:34 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 699D24E327
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 17:17:34 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-138.ams2.redhat.com
	[10.36.117.138])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0KHHWHh030768
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 12:17:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 18:17:31 +0100
Message-Id: <20170120171732.32055-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 00/35] Misc patches for 2017-01-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit d1c82f7cc34443841095f490345f86c9d8baca=
34:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170120-v2' in=
to staging (2017-01-20 15:53:58 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2a381ce2e166ddb23061946d56d912d3e9d391c6:

  pc.h: move x-mach-use-reliable-get-clock compat entry to PC_COMPAT_2_8 =
(2017-01-20 18:16:02 +0100)

----------------------------------------------------------------
* QOM interface fix (Eduardo)
* RTC fixes (Gaohuai, Igor)
* Memory leak fixes (Li Qiang, me)
* Ctrl-a b regression (Marc-Andr=C3=A9)
* Stubs cleanups and fixes (Leif, me)
* hxtool tweak (me)
* HAX support (Vincent)
* QemuThread, exec.c and SCSI fixes (Roman, Xinhua, me)
* PC_COMPAT_2_8 fix (Marcelo)
* stronger bitmap assertions (Peter)

----------------------------------------------------------------
Caoxinhua (1):
      qemu-thread: fix qemu_thread_set_name() race in qemu_thread_create(=
)

Eduardo Habkost (1):
      qom: Make all interface types abstract

Igor Mammedov (1):
      pc: fix crash in rtc_set_memory() if initial cpu is marked as hotpl=
ugged

Leif Lindholm (1):
      smbios: filter based on CONFIG_SMBIOS rather than TARGET

Li Qiang (1):
      serial: fix memory leak in serial exit

Marc-Andr=C3=A9 Lureau (2):
      char: fix ctrl-a b not working
      Revert "win32: don't run subprocess tests on Mingw32 platform"

Marcelo Tosatti (1):
      pc.h: move x-mach-use-reliable-get-clock compat entry to PC_COMPAT_=
2_8

Paolo Bonzini (17):
      megasas: fix guest-triggered memory leak
      stubs: merge all monitor stubs in one file, remove monitor_cur_is_q=
mp stub
      stubs: move smbios stubs to hw/smbios
      stubs: move acpi stubs to hw/acpi
      stubs: remove unused stub for serial_hd
      hw: move reset handlers from vl.c to hw/core
      stubs: group stubs for user-mode emulation
      stubs: group all monitor_fdset_* functions in a single file
      stubs: move vhost stubs to stubs/vhost.o
      event_notifier: cleanups around event_notifier_set_handler
      build: remove --enable-colo/--disable-colo
      stubs: remove stubs/kvm.c
      acpi: filter based on CONFIG_ACPI_X86 rather than TARGET
      scsi-block: fix direction of BYTCHK test for VERIFY commands
      hxtool: emit Texinfo headings as @subsection
      ramblock-notifier: new
      KVM: PPC: eliminate unnecessary duplicate constants

Peter Lieven (1):
      bitmap: assert that start and nr are non negative

Peter Xu (3):
      x86: ioapic: add traces for ioapic
      x86: ioapic: dump version for "info ioapic"
      x86: ioapic: fix fail migration when irqchip=3Dsplit

Roman Kapl (1):
      exec: Add missing rcu_read_unlock

Vincent Palatin (4):
      kvm: move cpu synchronization code
      target/i386: Add Intel HAX files
      Plumb the HAXM-based hardware acceleration support
      hax: add Darwin support

hangaohuai (1):
      bugfix: vm halt when in reset looping

 MAINTAINERS                                        |    1 +
 Makefile.target                                    |    5 +-
 arch_init.c                                        |   21 -
 configure                                          |   27 +-
 cpus.c                                             |   79 +-
 exec.c                                             |    6 +
 gdbstub.c                                          |    1 +
 hax-stub.c                                         |   34 +
 hw/Makefile.objs                                   |    6 +-
 hw/acpi/Makefile.objs                              |   17 +-
 hw/acpi/acpi-stub.c                                |   29 +
 stubs/ipmi.c =3D> hw/acpi/ipmi-stub.c                |    0
 hw/char/serial.c                                   |   10 +
 hw/core/Makefile.objs                              |    2 +-
 hw/core/reset.c                                    |   72 ++
 hw/i386/kvm/apic.c                                 |    1 +
 hw/i386/kvmvapic.c                                 |    1 +
 hw/i386/pc.c                                       |    4 +-
 hw/intc/apic_common.c                              |    3 +-
 hw/intc/ioapic.c                                   |   22 +-
 hw/intc/ioapic_common.c                            |    3 +-
 hw/intc/trace-events                               |    7 +
 hw/misc/vmport.c                                   |    2 +-
 hw/ppc/pnv_xscom.c                                 |    2 +-
 hw/ppc/ppce500_spin.c                              |    4 +-
 hw/ppc/spapr.c                                     |    2 +-
 hw/ppc/spapr_hcall.c                               |    2 +-
 hw/s390x/s390-pci-inst.c                           |    1 +
 hw/scsi/megasas.c                                  |   11 +-
 hw/scsi/scsi-disk.c                                |    2 +-
 hw/smbios/Makefile.objs                            |   12 +-
 hw/smbios/smbios-stub.c                            |   31 +
 hw/smbios/smbios.c                                 |    2 +-
 .../smbios/smbios_type_38-stub.c                   |    0
 hw/timer/mc146818rtc.c                             |   12 +
 hw/usb/ccid-card-emulated.c                        |    2 +-
 hw/virtio/Makefile.objs                            |    6 +-
 stubs/vhost.c =3D> hw/virtio/vhost-stub.c            |    0
 hw/virtio/virtio.c                                 |   10 +-
 include/exec/memory.h                              |    6 +-
 include/exec/ram_addr.h                            |   46 +-
 include/exec/ramlist.h                             |   72 ++
 include/hw/hw.h                                    |    6 +-
 include/hw/i386/pc.h                               |    7 +-
 include/hw/smbios/smbios.h                         |    2 +-
 include/qemu/event_notifier.h                      |    3 -
 include/qemu/main-loop.h                           |   15 +
 include/qom/cpu.h                                  |    5 +
 include/sysemu/arch_init.h                         |    2 -
 include/sysemu/hax.h                               |   56 +
 include/sysemu/hw_accel.h                          |   48 +
 include/sysemu/kvm.h                               |   23 -
 include/sysemu/reset.h                             |   10 +
 include/sysemu/sysemu.h                            |    1 -
 iohandler.c                                        |    8 +
 migration/Makefile.objs                            |    3 +-
 monitor.c                                          |    2 +-
 numa.c                                             |   29 +
 qemu-char.c                                        |   15 +-
 qemu-options-wrapper.h                             |    2 +-
 qemu-options.hx                                    |   42 +-
 qom/cpu.c                                          |    2 +-
 qom/object.c                                       |    6 +
 scripts/hxtool                                     |   11 +-
 stubs/Makefile.objs                                |   19 +-
 stubs/cpus.c                                       |   11 -
 stubs/fdset-add-fd.c                               |    8 -
 stubs/fdset-find-fd.c                              |    8 -
 stubs/fdset-get-fd.c                               |    8 -
 stubs/fdset-remove-fd.c                            |    7 -
 stubs/fdset.c                                      |   22 +
 stubs/get-next-serial.c                            |    4 -
 stubs/iohandler.c                                  |    8 -
 stubs/kvm.c                                        |    8 -
 stubs/migration-colo.c                             |   46 -
 stubs/mon-is-qmp.c                                 |   10 -
 stubs/monitor-init.c                               |    7 -
 stubs/{get-fd.c =3D> monitor.c}                      |    6 +
 stubs/replay-user.c                                |   33 -
 stubs/reset.c                                      |   14 -
 target/arm/cpu.c                                   |    2 +-
 target/i386/Makefile.objs                          |    7 +
 target/i386/hax-all.c                              | 1155 ++++++++++++++=
++++++
 target/i386/hax-darwin.c                           |  316 ++++++
 target/i386/hax-darwin.h                           |   63 ++
 target/i386/hax-i386.h                             |   94 ++
 target/i386/hax-interface.h                        |  361 ++++++
 target/i386/hax-mem.c                              |  289 +++++
 target/i386/hax-windows.c                          |  479 ++++++++
 target/i386/hax-windows.h                          |   89 ++
 target/i386/helper.c                               |    1 +
 target/i386/hyperv.c                               |    7 +-
 target/i386/kvm.c                                  |    1 +
 target/mips/kvm.c                                  |    5 +
 target/ppc/kvm.c                                   |    7 +-
 target/ppc/kvm_ppc.h                               |   12 -
 target/ppc/mmu-hash64.c                            |    2 +-
 target/ppc/translate_init.c                        |    2 +-
 target/s390x/gdbstub.c                             |    1 +
 target/s390x/kvm.c                                 |    5 +
 tests/Makefile.include                             |    1 +
 tests/device-introspect-test.c                     |   60 +-
 user-exec-stub.c                                   |   34 +
 util/bitmap.c                                      |    8 +
 util/event_notifier-posix.c                        |    9 -
 util/event_notifier-win32.c                        |   12 -
 util/qemu-thread-posix.c                           |   12 +-
 util/qemu-thread-win32.c                           |    4 +-
 vl.c                                               |   62 +-
 xen-mapcache.c                                     |    3 +
 110 files changed, 3728 insertions(+), 468 deletions(-)
 create mode 100644 hax-stub.c
 create mode 100644 hw/acpi/acpi-stub.c
 rename stubs/ipmi.c =3D> hw/acpi/ipmi-stub.c (100%)
 create mode 100644 hw/core/reset.c
 create mode 100644 hw/smbios/smbios-stub.c
 rename stubs/smbios_type_38.c =3D> hw/smbios/smbios_type_38-stub.c (100%=
)
 rename stubs/vhost.c =3D> hw/virtio/vhost-stub.c (100%)
 create mode 100644 include/exec/ramlist.h
 create mode 100644 include/sysemu/hax.h
 create mode 100644 include/sysemu/hw_accel.h
 create mode 100644 include/sysemu/reset.h
 delete mode 100644 stubs/cpus.c
 delete mode 100644 stubs/fdset-add-fd.c
 delete mode 100644 stubs/fdset-find-fd.c
 delete mode 100644 stubs/fdset-get-fd.c
 delete mode 100644 stubs/fdset-remove-fd.c
 create mode 100644 stubs/fdset.c
 delete mode 100644 stubs/get-next-serial.c
 delete mode 100644 stubs/iohandler.c
 delete mode 100644 stubs/kvm.c
 delete mode 100644 stubs/migration-colo.c
 delete mode 100644 stubs/mon-is-qmp.c
 delete mode 100644 stubs/monitor-init.c
 rename stubs/{get-fd.c =3D> monitor.c} (75%)
 delete mode 100644 stubs/replay-user.c
 delete mode 100644 stubs/reset.c
 create mode 100644 target/i386/hax-all.c
 create mode 100644 target/i386/hax-darwin.c
 create mode 100644 target/i386/hax-darwin.h
 create mode 100644 target/i386/hax-i386.h
 create mode 100644 target/i386/hax-interface.h
 create mode 100644 target/i386/hax-mem.c
 create mode 100644 target/i386/hax-windows.c
 create mode 100644 target/i386/hax-windows.h
 create mode 100644 user-exec-stub.c
--=20
2.9.3
