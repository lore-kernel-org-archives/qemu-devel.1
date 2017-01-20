Received: from eggs.gnu.org ([2001:4830:134:3::10]:53177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUco8-0006S7-RE
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUco3-0005le-Di
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:17:00 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cUco3-0005l7-3e
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:16:55 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so8152462wmi.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 09:16:55 -0800 (PST)
Received: from [192.168.10.165] (94-39-143-196.adsl-ull.clienti.tiscali.it.
	[94.39.143.196]) by smtp.googlemail.com with ESMTPSA id
	j18sm640375wrb.33.2017.01.20.09.16.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Jan 2017 09:16:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35284413-b856-beed-e203-d1f6b22b6776@redhat.com>
Date: Fri, 20 Jan 2017 18:16:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v3 00/32] Misc patches for 2017-01-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

No cigar, conflicts with master.

Paolo

On 20/01/2017 14:31, Paolo Bonzini wrote:
> The following changes since commit 2ccede18bd24fce5db83fef3674563a1f256717b:
> 
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2017-01-16 12:41:35 +0000)
> 
> are available in the git repository at:
> 
>   git://github.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to abc62c89f3191774dbd600a2caec803cbf557160:
> 
>   pc.h: move x-mach-use-reliable-get-clock compat entry to PC_COMPAT_2_8 (2017-01-20 13:22:57 +0100)
> 
> Third time is the charm...
> 
> v2->v3 adds "KVM: PPC: eliminate unnecessary duplicate constants"
> to fix the build failure, and patches 34-35 just because they're
> small and nice.
> 
> ----------------------------------------------------------------
> * QOM interface fix (Eduardo)
> * RTC fixes (Gaohuai, Igor)
> * Memory leak fixes (Li Qiang, me)
> * Ctrl-a b regression (Marc-André)
> * Stubs cleanups and fixes (Leif, me)
> * hxtool tweak (me)
> * HAX support (Vincent)
> * QemuThread, exec.c and SCSI fixes (Roman, Xinhua, me)
> * PC_COMPAT_2_8 fix (Marcelo)
> * stronger bitmap assertions (Peter)
> 
> ----------------------------------------------------------------
> Caoxinhua (1):
>       qemu-thread: fix qemu_thread_set_name() race in qemu_thread_create()
> 
> Eduardo Habkost (1):
>       qom: Make all interface types abstract
> 
> Igor Mammedov (1):
>       pc: fix crash in rtc_set_memory() if initial cpu is marked as hotplugged
> 
> Leif Lindholm (1):
>       smbios: filter based on CONFIG_SMBIOS rather than TARGET
> 
> Li Qiang (1):
>       serial: fix memory leak in serial exit
> 
> Marc-André Lureau (2):
>       char: fix ctrl-a b not working
>       Revert "win32: don't run subprocess tests on Mingw32 platform"
> 
> Marcelo Tosatti (1):
>       pc.h: move x-mach-use-reliable-get-clock compat entry to PC_COMPAT_2_8
> 
> Paolo Bonzini (17):
>       megasas: fix guest-triggered memory leak
>       stubs: merge all monitor stubs in one file, remove monitor_cur_is_qmp stub
>       stubs: move smbios stubs to hw/smbios
>       stubs: move acpi stubs to hw/acpi
>       stubs: remove unused stub for serial_hd
>       hw: move reset handlers from vl.c to hw/core
>       stubs: group stubs for user-mode emulation
>       stubs: group all monitor_fdset_* functions in a single file
>       stubs: move vhost stubs to stubs/vhost.o
>       event_notifier: cleanups around event_notifier_set_handler
>       build: remove --enable-colo/--disable-colo
>       stubs: remove stubs/kvm.c
>       acpi: filter based on CONFIG_ACPI_X86 rather than TARGET
>       scsi-block: fix direction of BYTCHK test for VERIFY commands
>       hxtool: emit Texinfo headings as @subsection
>       ramblock-notifier: new
>       KVM: PPC: eliminate unnecessary duplicate constants
> 
> Peter Lieven (1):
>       bitmap: assert that start and nr are non negative
> 
> Peter Xu (3):
>       x86: ioapic: add traces for ioapic
>       x86: ioapic: dump version for "info ioapic"
>       x86: ioapic: fix fail migration when irqchip=split
> 
> Roman Kapl (1):
>       exec: Add missing rcu_read_unlock
> 
> Vincent Palatin (4):
>       kvm: move cpu synchronization code
>       target/i386: Add Intel HAX files
>       Plumb the HAXM-based hardware acceleration support
>       hax: add Darwin support
> 
> hangaohuai (1):
>       bugfix: vm halt when in reset looping
> 
>  MAINTAINERS                                        |    1 +
>  Makefile.target                                    |    5 +-
>  arch_init.c                                        |   21 -
>  configure                                          |   27 +-
>  cpus.c                                             |   79 +-
>  exec.c                                             |    6 +
>  gdbstub.c                                          |    1 +
>  hax-stub.c                                         |   34 +
>  hw/Makefile.objs                                   |    6 +-
>  hw/acpi/Makefile.objs                              |   17 +-
>  hw/acpi/acpi-stub.c                                |   29 +
>  stubs/ipmi.c => hw/acpi/ipmi-stub.c                |    0
>  hw/char/serial.c                                   |   10 +
>  hw/core/Makefile.objs                              |    2 +-
>  hw/core/reset.c                                    |   72 ++
>  hw/i386/kvm/apic.c                                 |    1 +
>  hw/i386/kvmvapic.c                                 |    1 +
>  hw/i386/pc.c                                       |    4 +-
>  hw/intc/apic_common.c                              |    3 +-
>  hw/intc/ioapic.c                                   |   22 +-
>  hw/intc/ioapic_common.c                            |    3 +-
>  hw/intc/trace-events                               |    7 +
>  hw/misc/vmport.c                                   |    2 +-
>  hw/ppc/pnv_xscom.c                                 |    2 +-
>  hw/ppc/ppce500_spin.c                              |    4 +-
>  hw/ppc/spapr.c                                     |    2 +-
>  hw/ppc/spapr_hcall.c                               |    2 +-
>  hw/s390x/s390-pci-inst.c                           |    1 +
>  hw/scsi/megasas.c                                  |   11 +-
>  hw/scsi/scsi-disk.c                                |    2 +-
>  hw/smbios/Makefile.objs                            |   12 +-
>  hw/smbios/smbios-stub.c                            |   31 +
>  hw/smbios/smbios.c                                 |    2 +-
>  .../smbios/smbios_type_38-stub.c                   |    0
>  hw/timer/mc146818rtc.c                             |   12 +
>  hw/usb/ccid-card-emulated.c                        |    2 +-
>  hw/virtio/Makefile.objs                            |    6 +-
>  stubs/vhost.c => hw/virtio/vhost-stub.c            |    0
>  hw/virtio/virtio.c                                 |   10 +-
>  include/exec/memory.h                              |    6 +-
>  include/exec/ram_addr.h                            |   46 +-
>  include/exec/ramlist.h                             |   72 ++
>  include/hw/hw.h                                    |    6 +-
>  include/hw/i386/pc.h                               |    7 +-
>  include/hw/smbios/smbios.h                         |    2 +-
>  include/qemu/event_notifier.h                      |    3 -
>  include/qemu/main-loop.h                           |   15 +
>  include/qom/cpu.h                                  |    5 +
>  include/sysemu/arch_init.h                         |    2 -
>  include/sysemu/hax.h                               |   56 +
>  include/sysemu/hw_accel.h                          |   48 +
>  include/sysemu/kvm.h                               |   23 -
>  include/sysemu/reset.h                             |   10 +
>  include/sysemu/sysemu.h                            |    1 -
>  iohandler.c                                        |    8 +
>  migration/Makefile.objs                            |    3 +-
>  monitor.c                                          |    2 +-
>  numa.c                                             |   29 +
>  qemu-char.c                                        |   15 +-
>  qemu-options-wrapper.h                             |    2 +-
>  qemu-options.hx                                    |   42 +-
>  qom/cpu.c                                          |    2 +-
>  qom/object.c                                       |    6 +
>  scripts/hxtool                                     |   11 +-
>  stubs/Makefile.objs                                |   19 +-
>  stubs/cpus.c                                       |   11 -
>  stubs/fdset-add-fd.c                               |    8 -
>  stubs/fdset-find-fd.c                              |    8 -
>  stubs/fdset-get-fd.c                               |    8 -
>  stubs/fdset-remove-fd.c                            |    7 -
>  stubs/fdset.c                                      |   22 +
>  stubs/get-next-serial.c                            |    4 -
>  stubs/iohandler.c                                  |    8 -
>  stubs/kvm.c                                        |    8 -
>  stubs/migration-colo.c                             |   46 -
>  stubs/mon-is-qmp.c                                 |   10 -
>  stubs/monitor-init.c                               |    7 -
>  stubs/{get-fd.c => monitor.c}                      |    6 +
>  stubs/replay-user.c                                |   33 -
>  stubs/reset.c                                      |   14 -
>  target/arm/cpu.c                                   |    2 +-
>  target/i386/Makefile.objs                          |    7 +
>  target/i386/hax-all.c                              | 1155 ++++++++++++++++++++
>  target/i386/hax-darwin.c                           |  316 ++++++
>  target/i386/hax-darwin.h                           |   63 ++
>  target/i386/hax-i386.h                             |   94 ++
>  target/i386/hax-interface.h                        |  361 ++++++
>  target/i386/hax-mem.c                              |  289 +++++
>  target/i386/hax-windows.c                          |  479 ++++++++
>  target/i386/hax-windows.h                          |   89 ++
>  target/i386/helper.c                               |    1 +
>  target/i386/hyperv.c                               |    7 +-
>  target/i386/kvm.c                                  |    1 +
>  target/mips/kvm.c                                  |    5 +
>  target/ppc/kvm.c                                   |    7 +-
>  target/ppc/kvm_ppc.h                               |   12 -
>  target/ppc/mmu-hash64.c                            |    2 +-
>  target/ppc/translate_init.c                        |    2 +-
>  target/s390x/gdbstub.c                             |    1 +
>  target/s390x/kvm.c                                 |    5 +
>  tests/Makefile.include                             |    1 +
>  tests/device-introspect-test.c                     |   60 +-
>  user-exec-stub.c                                   |   34 +
>  util/bitmap.c                                      |    8 +
>  util/event_notifier-posix.c                        |    9 -
>  util/event_notifier-win32.c                        |   12 -
>  util/qemu-thread-posix.c                           |   12 +-
>  util/qemu-thread-win32.c                           |    4 +-
>  vl.c                                               |   62 +-
>  xen-mapcache.c                                     |    3 +
>  110 files changed, 3729 insertions(+), 467 deletions(-)
>  create mode 100644 hax-stub.c
>  create mode 100644 hw/acpi/acpi-stub.c
>  rename stubs/ipmi.c => hw/acpi/ipmi-stub.c (100%)
>  create mode 100644 hw/core/reset.c
>  create mode 100644 hw/smbios/smbios-stub.c
>  rename stubs/smbios_type_38.c => hw/smbios/smbios_type_38-stub.c (100%)
>  rename stubs/vhost.c => hw/virtio/vhost-stub.c (100%)
>  create mode 100644 include/exec/ramlist.h
>  create mode 100644 include/sysemu/hax.h
>  create mode 100644 include/sysemu/hw_accel.h
>  create mode 100644 include/sysemu/reset.h
>  delete mode 100644 stubs/cpus.c
>  delete mode 100644 stubs/fdset-add-fd.c
>  delete mode 100644 stubs/fdset-find-fd.c
>  delete mode 100644 stubs/fdset-get-fd.c
>  delete mode 100644 stubs/fdset-remove-fd.c
>  create mode 100644 stubs/fdset.c
>  delete mode 100644 stubs/get-next-serial.c
>  delete mode 100644 stubs/iohandler.c
>  delete mode 100644 stubs/kvm.c
>  delete mode 100644 stubs/migration-colo.c
>  delete mode 100644 stubs/mon-is-qmp.c
>  delete mode 100644 stubs/monitor-init.c
>  rename stubs/{get-fd.c => monitor.c} (75%)
>  delete mode 100644 stubs/replay-user.c
>  delete mode 100644 stubs/reset.c
>  create mode 100644 target/i386/hax-all.c
>  create mode 100644 target/i386/hax-darwin.c
>  create mode 100644 target/i386/hax-darwin.h
>  create mode 100644 target/i386/hax-i386.h
>  create mode 100644 target/i386/hax-interface.h
>  create mode 100644 target/i386/hax-mem.c
>  create mode 100644 target/i386/hax-windows.c
>  create mode 100644 target/i386/hax-windows.h
>  create mode 100644 user-exec-stub.c
> 
