Received: from eggs.gnu.org ([2001:4830:134:3::10]:55184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1g6y0s-0007St-Vy
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1g6y0r-0008Ur-5w
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:13:26 -0400
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:43376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1g6y0m-0008TJ-Eb
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:13:23 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20181001092659.19418-1-pbonzini@redhat.com>
References: <20181001092659.19418-1-pbonzini@redhat.com>
MIME-Version: 1.0
Date: Mon, 01 Oct 2018 16:13:14 +0300
Message-Id: <287411538399594@iva5-815ce03d682b.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/79] Misc patches for 2018-09-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

+ marcandre.lureau@

Hi,

I follow the "Fix socket chardev regression" series of Marc-Andr=C3=A9.
The v2 of the series has commit "test-char: fix random socket test failur=
e".

So, I don't see the commit in this pull. May be you missed it?

+ "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>

Regards,
Yury Kotov

01.10.2018, 12:27, "Paolo Bonzini" <pbonzini@redhat.com>:
> The following changes since commit 042938f46e1c477419d1931381fdadffaa49=
d45e:
>
> =C2=A0=C2=A0Merge remote-tracking branch 'remotes/dgilbert/tags/pull-mi=
gration-20180926a' into staging (2018-09-28 17:07:23 +0100)
>
> are available in the Git repository at:
>
> =C2=A0=C2=A0git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 9e909b84144c79672b0847808358e8a4d134ced0=
:
>
> =C2=A0=C2=A0hw/scsi/mptendian: Avoid taking address of fields in packed=
 structs (2018-10-01 11:25:42 +0200)
>
> ----------------------------------------------------------------
> * configure fix for environment variables (Daniel)
> * fix memory leaks (Alex)
> * x86_64 MTTCG fixes (Emilio)
> * introduce atomic64 (Emilio)
> * Fix for virtio hang (Fam, myself)
> * SH serial port fix (Geert)
> * Deprecate rotation_rate for scsi-block (Fam)
> * Extend memory-backend-file availability to all POSIX hosts (Hikaru)
> * Memory API cleanups and fixes (Igor, Li Qiang, Peter, Philippe)
> * MSI/IOMMU fix (Jan)
> * Socket reconnection fixes (Marc-Andr=C3=A9)
> * icount fixes (Emilio, myself)
> * QSP fixes for Coverity (myself)
> * Some record/replay improovements (Pavel)
> * Packed struct fixes (Peter)
> * Windows dump fixes and elf2dmp (Viktor)
> * kvmclock fix (Yongji)
>
> ----------------------------------------------------------------
> Now without UTF-8 mojibake.
>
> Alex Benn=C3=A9e (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpus: fix TCG kick timer leak
>
> Daniel P. Berrang=C3=A9 (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0configure: preserve various environ=
ment variables in config.status
>
> Emilio G. Cota (22):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic: fix comment s/x64_64/x86_64=
/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpus: initialize timers_state.vm_cl=
ock_lock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cacheinfo: add i/d cache_linesize_l=
og
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0util: add atomic64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tests: add atomic64-bench
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qsp: use atomic64 accessors
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test-rcu-list: access n_reclaims an=
d n_nodes_removed with atomic64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpus: access .qemu_icount with atom=
ic64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpus: access .qemu_icount_bias with=
 atomic64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_cc_srcT to Di=
sasContext
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_A0 to DisasCo=
ntext
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_T0 to DisasCo=
ntext
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_T1 to DisasCo=
ntext
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_tmp0 to Disas=
Context
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_tmp4 to Disas=
Context
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_ptr0 to Disas=
Context
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_ptr1 to Disas=
Context
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_tmp2_i32 to D=
isasContext
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_tmp3_i32 to D=
isasContext
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move cpu_tmp1_i64 to D=
isasContext
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: move x86_64_hregs to D=
isasContext
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0configure: enable mttcg for i386 an=
d x86_64
>
> Fam Zheng (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0virtio: Return true from virtio_que=
ue_empty if broken
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scsi-block: Deprecate rotation_rate
>
> Geert Uytterhoeven (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/char/sh_serial: Add timeout hand=
ling to unbreak serial input
>
> Hikaru Nishida (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hostmem-file: make available memory=
-backend-file on POSIX-based hosts
>
> Igor Mammedov (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory: cleanup side effects of mem=
ory_region_init_foo() on failure
>
> Jan Kiszka (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvm: x86: Fix kvm_arch_fixup_msi_ro=
ute for remap-less case
>
> Li Qiang (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fw_cfg_mem: add read memory region =
callback
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw: debugexit: add read callback
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw: pc-testdev: add read memory reg=
ion callback
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw: hyperv_testdev: add read callba=
ck
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw: edu: replace device name with m=
acro
>
> Li Zhijian (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0change get_image_size return type t=
o int64_t
>
> Liran Alon (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i386: Compile CPUX86State xsave_buf=
 only when support KVM or HVF
>
> Marc-Andr=C3=A9 Lureau (9):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hostmem-memfd: add checks before ad=
ding hostmem-memfd & properties
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0util: add qemu_write_pidfile()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0util: use fcntl() for qemu_write_pi=
dfile() locking
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Delete PID file on exit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Revert "chardev: tcp: postpone TLS =
work until machine done"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Revert "chardev: tcp: postpone asyn=
c connection setup"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char-socket: update all ioc handler=
s when changing context
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test-char: add socket reconnect tes=
t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qom/object: add some interface asse=
rts
>
> Mark Cave-Ayland (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lsi53c895a: convert to trace-events
>
> Paolo Bonzini (9):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qsp: hide indirect function calls f=
rom Coverity
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0es1370: fix ADC_FRAMEADR and ADC_FR=
AMECNT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpus: take seqlock across qemu_icou=
nt updates
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0serial: fix DLL writes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char-pty: remove unnecessary #ifdef
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: unify masking of inter=
rupts
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: rename HF_SVMI_MASK to=
 HF_GUEST_MASK
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hvf: drop unused variable
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0virtio: do not take address of pack=
ed members
>
> Pavel Dovgalyuk (10):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ps2: prevent changing irq state on =
save and load
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0replay: wake up vCPU when replaying
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0replay: flush events when exiting
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0translator: fix breakpoint processi=
ng
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0replay: allow loading any snapshots=
 before recording
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0timer: introduce new virtual clock
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slirp: fix ipv6 timers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ui: fix virtual timers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target/i386: fix translation for ic=
ount mode
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0replay: replay BH for IDE trim oper=
ation
>
> Peter Maydell (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory: Remove old_mmio accessors
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/nvram/fw_cfg: Use memberwise cop=
y of MemoryRegionOps struct
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0docs/devel/memory.txt: Document _wi=
th_attrs accessors
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/scsi/mptendian: Avoid taking add=
ress of fields in packed structs
>
> Philippe Mathieu-Daud=C3=A9 (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory: Use MAKE_64BIT_MASK()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory: Refactor common shifting co=
de from accessors
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory: Fix access_with_adjusted_si=
ze(small size) on big-endian memory regions
>
> Thomas Huth (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0accel/tcg: Remove dead code
>
> Viktor Prutyanov (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dump: fix Windows dump memory run m=
apping
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dump: move Windows dump structures =
definitions
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0contrib: add elf2dmp tool
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MAINTAINERS: add myself as elf2dmp =
maintainer
>
> Yongji Xie (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvmclock: run KVM_KVMCLOCK_CTRL ioc=
tl in vcpu thread
>
> =C2=A0MAINTAINERS | 5 +
> =C2=A0Makefile | 5 +
> =C2=A0Makefile.objs | 1 +
> =C2=A0accel/tcg/translate-all.c | 9 -
> =C2=A0accel/tcg/translator.c | 8 +-
> =C2=A0backends/Makefile.objs | 2 +-
> =C2=A0backends/hostmem-file.c | 2 +-
> =C2=A0backends/hostmem-memfd.c | 32 +-
> =C2=A0chardev/char-pty.c | 6 -
> =C2=A0chardev/char-socket.c | 86 +-
> =C2=A0configure | 45 +
> =C2=A0contrib/elf2dmp/Makefile.objs | 1 +
> =C2=A0contrib/elf2dmp/addrspace.c | 233 ++++
> =C2=A0contrib/elf2dmp/addrspace.h | 44 +
> =C2=A0contrib/elf2dmp/download.c | 47 +
> =C2=A0contrib/elf2dmp/download.h | 13 +
> =C2=A0contrib/elf2dmp/err.h | 13 +
> =C2=A0contrib/elf2dmp/kdbg.h | 194 ++++
> =C2=A0contrib/elf2dmp/main.c | 589 ++++++++++
> =C2=A0contrib/elf2dmp/pdb.c | 322 ++++++
> =C2=A0contrib/elf2dmp/pdb.h | 241 ++++
> =C2=A0contrib/elf2dmp/pe.h | 121 ++
> =C2=A0contrib/elf2dmp/qemu_elf.c | 164 +++
> =C2=A0contrib/elf2dmp/qemu_elf.h | 51 +
> =C2=A0cpus.c | 84 +-
> =C2=A0docs/devel/memory.txt | 13 +-
> =C2=A0exec.c | 4 +-
> =C2=A0hw/alpha/dp264.c | 3 +-
> =C2=A0hw/audio/es1370.c | 10 +-
> =C2=A0hw/char/serial.c | 4 +-
> =C2=A0hw/char/sh_serial.c | 20 +
> =C2=A0hw/char/virtio-serial-bus.c | 6 +-
> =C2=A0hw/core/loader.c | 5 +-
> =C2=A0hw/hppa/machine.c | 2 +-
> =C2=A0hw/i386/kvm/clock.c | 17 +-
> =C2=A0hw/i386/pc.c | 7 +-
> =C2=A0hw/ide/core.c | 3 +-
> =C2=A0hw/input/ps2.c | 8 +-
> =C2=A0hw/mips/mips_fulong2e.c | 4 +-
> =C2=A0hw/mips/mips_malta.c | 4 +-
> =C2=A0hw/mips/mips_mipssim.c | 3 +-
> =C2=A0hw/mips/mips_r4k.c | 4 +-
> =C2=A0hw/misc/debugexit.c | 6 +
> =C2=A0hw/misc/edu.c | 5 +-
> =C2=A0hw/misc/hyperv_testdev.c | 10 +-
> =C2=A0hw/misc/pc-testdev.c | 20 +-
> =C2=A0hw/moxie/moxiesim.c | 2 +-
> =C2=A0hw/nvram/fw_cfg.c | 13 +-
> =C2=A0hw/scsi/lsi53c895a.c | 214 ++--
> =C2=A0hw/scsi/mptendian.c | 163 +--
> =C2=A0hw/scsi/scsi-disk.c | 6 +
> =C2=A0hw/scsi/trace-events | 62 ++
> =C2=A0hw/virtio/virtio.c | 8 +
> =C2=A0include/exec/memory.h | 7 +-
> =C2=A0include/hw/loader.h | 2 +-
> =C2=A0include/qemu/atomic.h | 36 +-
> =C2=A0include/qemu/memfd.h | 18 +-
> =C2=A0include/qemu/osdep.h | 5 +-
> =C2=A0include/qemu/thread.h | 17 +
> =C2=A0include/qemu/timer.h | 9 +
> =C2=A0include/qemu/win_dump_defs.h | 179 +++
> =C2=A0include/sysemu/replay.h | 3 +
> =C2=A0memory.c | 163 +--
> =C2=A0os-posix.c | 24 -
> =C2=A0os-win32.c | 25 -
> =C2=A0qga/main.c | 54 +-
> =C2=A0qom/object.c | 9 +-
> =C2=A0replay/replay-events.c | 14 +-
> =C2=A0replay/replay-internal.h | 2 -
> =C2=A0replay/replay-snapshot.c | 17 +-
> =C2=A0replay/replay.c | 12 +
> =C2=A0scsi/qemu-pr-helper.c | 40 +-
> =C2=A0slirp/ip6_icmp.c | 7 +-
> =C2=A0target/i386/cpu.c | 51 +-
> =C2=A0target/i386/cpu.h | 9 +-
> =C2=A0target/i386/excp_helper.c | 2 +-
> =C2=A0target/i386/hvf/README.md | 2 +-
> =C2=A0target/i386/hvf/hvf.c | 3 +-
> =C2=A0target/i386/hvf/x86hvf.c | 4 +-
> =C2=A0target/i386/kvm.c | 10 +-
> =C2=A0target/i386/seg_helper.c | 112 +-
> =C2=A0target/i386/svm_helper.c | 6 +-
> =C2=A0target/i386/translate.c | 2474 +++++++++++++++++++++-------------=
-------
> =C2=A0tests/Makefile.include | 3 +-
> =C2=A0tests/atomic64-bench.c | 171 +++
> =C2=A0tests/test-char.c | 18 +-
> =C2=A0tests/test-rcu-list.c | 20 +-
> =C2=A0tests/vhost-user-test.c | 6 +-
> =C2=A0ui/input.c | 8 +-
> =C2=A0util/Makefile.objs | 1 +
> =C2=A0util/atomic64.c | 83 ++
> =C2=A0util/cacheinfo.c | 11 +
> =C2=A0util/memfd.c | 35 +-
> =C2=A0util/oslib-posix.c | 73 ++
> =C2=A0util/oslib-win32.c | 27 +
> =C2=A0util/qemu-timer.c | 2 +
> =C2=A0util/qsp.c | 49 +-
> =C2=A0vl.c | 25 +-
> =C2=A0win_dump.c | 40 +-
> =C2=A0win_dump.h | 166 +--
> =C2=A0100 files changed, 4814 insertions(+), 2184 deletions(-)
> =C2=A0create mode 100644 contrib/elf2dmp/Makefile.objs
> =C2=A0create mode 100644 contrib/elf2dmp/addrspace.c
> =C2=A0create mode 100644 contrib/elf2dmp/addrspace.h
> =C2=A0create mode 100644 contrib/elf2dmp/download.c
> =C2=A0create mode 100644 contrib/elf2dmp/download.h
> =C2=A0create mode 100644 contrib/elf2dmp/err.h
> =C2=A0create mode 100644 contrib/elf2dmp/kdbg.h
> =C2=A0create mode 100644 contrib/elf2dmp/main.c
> =C2=A0create mode 100644 contrib/elf2dmp/pdb.c
> =C2=A0create mode 100644 contrib/elf2dmp/pdb.h
> =C2=A0create mode 100644 contrib/elf2dmp/pe.h
> =C2=A0create mode 100644 contrib/elf2dmp/qemu_elf.c
> =C2=A0create mode 100644 contrib/elf2dmp/qemu_elf.h
> =C2=A0create mode 100644 include/qemu/win_dump_defs.h
> =C2=A0create mode 100644 tests/atomic64-bench.c
> =C2=A0create mode 100644 util/atomic64.c
> --
> 2.17.1
