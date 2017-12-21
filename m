Received: from eggs.gnu.org ([2001:4830:134:3::10]:35376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRwKI-0007wd-1C
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRwKD-00068k-Ps
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:38 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:45431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRwKD-00067L-EM
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:35:33 -0500
Received: by mail-wm0-x241.google.com with SMTP id 9so14345951wme.4
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 00:35:33 -0800 (PST)
Received: from donizetti.lan (dynamic-adsl-78-12-251-125.clienti.tiscali.it.
	[78.12.251.125]) by smtp.gmail.com with ESMTPSA id
	26sm29752439wrw.19.2017.12.21.00.35.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 21 Dec 2017 00:35:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Dec 2017 09:35:26 +0100
Message-Id: <20171221083529.6982-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/41] First batch of misc patches for QEMU
 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 200780a3a3ed067dfb2e0d2210b0ed09e748ba26:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-cmdline-2017-12-18-v2' into staging (2017-12-20 13:20:48 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 194b7f0d448361dd58d2f7f189147cf075988255:

  chardev: convert the socket server to QIONetListener (2017-12-21 09:30:32 +0100)

----------------------------------------------------------------
* NBD and chardev conversion to QIONetListener (Daniel)
* MTTCG fixes (David)
* Hyper-V fixes (Roman, Evgeny)
* share-rw option (Fam)
* Mux chardev event bugfix (Marc-André)
* Add systemd unit files in contrib/ (me)
* SCSI and block/iscsi.c bugfixes (me, Peter L.)
* unassigned_mem_ops fixes (Peter M.)
* VEX decoding fix (Peter M.)
* "info pic" and "info irq" improvements (Peter Xu)
* vmport trace events (Philippe)
* Braille chardev bugfix (Samuel)
* Compiler warnings fix (Stefan)
* initial support for TCG smoke test of more boards (Thomas)
* New CPU features (Yang)
* Reduce startup memory usage (Yang)
* QemuThread race fix (linhecheng)

----------------------------------------------------------------
Daniel P. Berrange (4):
      sockets: remove obsolete code that updated listen address
      blockdev: convert internal NBD server to QIONetListener
      blockdev: convert qemu-nbd server to QIONetListener
      chardev: convert the socket server to QIONetListener

David Hildenbrand (2):
      cpus: make pause_all_cpus() play with SMP on single threaded TCG
      cpu-exec: fix missed CPU kick during interrupt injection

Evgeny Yakovlev (1):
      hyperv: set partition-wide MSRs only on first vcpu

Fam Zheng (2):
      scsi-block: Add share-rw option
      MAITAINERS: List Fam Zheng as reviewer for SCSI patches

Marc-André Lureau (3):
      checkpatch: volatile with a comment or sig_atomic_t is okay
      chardev: fix backend events regression with mux chardev
      test: add some chardev mux event tests

Paolo Bonzini (5):
      memfd: fix configure test
      qemu-pr-helper: miscellaneous fixes
      contrib: add systemd unit files
      scsi: provide general-purpose functions to manage sense data
      scsi: replace hex constants with #defines

Peter Lieven (2):
      block/iscsi: dont leave allocmap in an invalid state on UNMAP failure
      block/iscsi: only report an iSCSI Failure if we don't handle it gracefully

Peter Maydell (3):
      target/i386: Fix handling of VEX prefixes
      exec: Don't reuse unassigned_mem_ops for io_mem_rom
      hw/mips/boston: Remove workaround for writes to ROM aborting

Peter Xu (7):
      cpu: refactor cpu_address_space_init()
      cpu: suffix cpu address spaces with cpu index
      i8259: convert DPRINTFs into trace
      i8259: use DEBUG_IRQ_COUNT always
      i8259: generalize statistics into common code
      kvm-i8259: support "info pic" and "info irq"
      i8259: move TYPE_INTERRUPT_STATS_PROVIDER upper

Philippe Mathieu-Daudé (1):
      hw/i386/vmport: replace fprintf() by trace events or LOG_UNIMP

Roman Kagan (2):
      hyperv: ensure SINTx msrs are reset properly
      hyperv: make SynIC version msr constant

Samuel Thibault (1):
      baum: Truncate braille device size to 84x1

Stefan Weil (1):
      target/i386: Fix compiler warnings

Thomas Huth (4):
      tests/boot-serial-test: Make sure that we check the timeout regularly
      tests/boot-serial-test: Add code to allow to specify our own kernel or bios
      hw/moxie/moxiesim: Add support for loading a BIOS on moxiesim
      Remove legacy -no-kvm-pit option

Yang Zhong (2):
      x86/cpu: Enable new SSE/AVX/AVX512 cpu features
      rcu: reduce more than 7MB heap memory by malloc_trim()

linzhecheng (1):
      qemu-thread: fix races on threads that exit very quickly

 MAINTAINERS                              |   2 +
 accel/tcg/cpu-exec.c                     |  12 +--
 block/iscsi.c                            |  51 +++++++---
 blockdev-nbd.c                           |  50 +++-------
 chardev/baum.c                           |   8 +-
 chardev/char-mux.c                       |  10 ++
 chardev/char-socket.c                    |  73 ++++++--------
 chardev/char.c                           |  18 ++--
 configure                                |  37 ++++++-
 contrib/systemd/qemu-guest-agent.service |  11 +++
 contrib/systemd/qemu-pr-helper.service   |  15 +++
 contrib/systemd/qemu-pr-helper.socket    |   9 ++
 cpus.c                                   |  37 +++----
 exec.c                                   |  44 ++++++++-
 hw/i386/kvm/i8259.c                      |   1 +
 hw/i386/trace-events                     |   4 +
 hw/i386/vmport.c                         |  14 +--
 hw/intc/i8259.c                          |  86 +++-------------
 hw/intc/i8259_common.c                   |  49 ++++++++++
 hw/intc/trace-events                     |   7 ++
 hw/mips/boston.c                         |  14 +--
 hw/moxie/moxiesim.c                      |  12 ++-
 hw/scsi/scsi-bus.c                       |  16 +--
 hw/scsi/scsi-disk.c                      |   1 +
 include/chardev/char.h                   |   1 +
 include/exec/exec-all.h                  |   6 +-
 include/hw/isa/i8259_internal.h          |   7 +-
 include/qemu/sockets.h                   |   2 +-
 include/scsi/utils.h                     |   9 +-
 qemu-doc.texi                            |   5 -
 qemu-nbd.c                               |  61 +++++-------
 qemu-options.hx                          |   3 -
 qga/channel-posix.c                      |   2 +-
 scripts/checkpatch.pl                    |   7 +-
 scsi/qemu-pr-helper.c                    |  30 +++++-
 scsi/utils.c                             | 163 ++++++++++++++++---------------
 target/arm/cpu.c                         |  13 +--
 target/i386/cpu.c                        |  16 +--
 target/i386/cpu.h                        |  12 ++-
 target/i386/kvm.c                        |  44 +++++----
 target/i386/translate.c                  |   9 +-
 tests/boot-serial-test.c                 |  59 ++++++++---
 tests/test-char.c                        |  17 ++++
 util/memfd.c                             |   4 +-
 util/qemu-sockets.c                      |  31 +-----
 util/qemu-thread-posix.c                 |  59 +++++++----
 util/rcu.c                               |   6 ++
 vl.c                                     |   4 -
 48 files changed, 664 insertions(+), 487 deletions(-)
 create mode 100644 contrib/systemd/qemu-guest-agent.service
 create mode 100644 contrib/systemd/qemu-pr-helper.service
 create mode 100644 contrib/systemd/qemu-pr-helper.socket
-- 
2.14.3
