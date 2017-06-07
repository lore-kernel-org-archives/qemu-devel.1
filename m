Received: from eggs.gnu.org ([2001:4830:134:3::10]:57176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIdjY-0005hy-Mx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIdjU-00013V-F4
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:23:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIdjU-00013Q-6j
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:22:56 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B221C057FA7
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:22:55 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-77.ams2.redhat.com
	[10.36.118.77] (may be forged))
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v57GMrqa016525
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 12:22:54 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  7 Jun 2017 18:22:22 +0200
Message-Id: <20170607162253.14134-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v6 00/31] Misc patches for 2017-06-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 65dfad62a176f5265f801683be64149c5ad55f=
7d:

  Merge remote-tracking branch 'remotes/xtensa/tags/20170606-xtensa' into=
 staging (2017-06-06 17:00:12 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ac06724a715864942e2b5e28f92d5d5421f0a0b0:

  docs: create config/, devel/ and spin/ subdirectories (2017-06-07 18:22=
:03 +0200)

----------------------------------------------------------------
* virtio-scsi use-after-free fix (Fam)
* SMM fixes and improvements for TCG (myself, Mihail)
* irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
* Coverity fix (Stefano)
* NBD cleanups and fixes (Vladimir, Eric, myself)
* RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
* socket error reporting improvement (Daniel)
* GDB XML description for SSE registers (Abdallah)
* kvmclock update fix (Denis)
* SMM memory savings (Gonglei)
* -cpu 486 fix (myself)
* various bugfixes (Roman, Peter, myself, Thomas)
* rtc-test improvement (Guangrong)
* migration throttling fix (Felipe)
* create docs/ subdirectories (myself)

----------------------------------------------------------------

Dropped vhost-scsi temporarily.

Abdallah Bouassida (1):
      target/i386: Add GDB XML description for SSE registers

Daniel P. Berrange (1):
      sockets: improve error reporting if UNIX socket path is too long

Denis Plotnikov (1):
      kvmclock: update system_time_msr address forcibly

Eric Blake (1):
      nbd: Fully initialize client in case of failed negotiation

Fam Zheng (1):
      virtio-scsi: Unset hotplug handler when unrealize

Felipe Franciosi (1):
      cpus: reset throttle_thread_scheduled after sleep

Gonglei (1):
      kvm: don't register smram_listener when smm is off

Mihail Abakumov (1):
      i386: fix read/write cr with icount option

Paolo Bonzini (6):
      target/i386: enable A20 automatically in system management mode
      target/i386: use multiple CPU AddressSpaces
      linuxboot_dma: compile for i486
      edu: fix memory leak on msi_broken platforms
      nbd: make it thread-safe, fix qcow2 over nbd
      docs: create config/, devel/ and spin/ subdirectories

Peter Xu (4):
      kvm: irqchip: trace changes on msi add/remove
      msix: trace control bit write op
      kvm: irqchip: skip update msi when disabled
      exec: simplify phys_page_find() params

Roman Pen (1):
      i386/kvm: do not zero out segment flags if segment is unusable or n=
ot present

Stefano Stabellini (1):
      Check the return value of fcntl in qemu_set_cloexec

Tai Yunfang (1):
      mc146818rtc: precisely count the clock for periodic timer

Vladimir Sementsov-Ogievskiy (5):
      nbd: strict nbd_wr_syncv
      nbd: read_sync and friends: return 0 on success
      nbd: add errp parameter to nbd_wr_syncv()
      nbd: add errp to read_sync, write_sync and drop_sync
      nbd/client.c: use errp instead of LOG

Xiao Guangrong (5):
      mc146818rtc: update periodic timer only if it is needed
      mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on TARGET=
_I386
      mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
      mc146818rtc: embrace all x86 specific code
      qtest: add rtc periodic timer test

 block/nbd-client.c                         |  41 +++---
 configure                                  |   4 +-
 cpus.c                                     |   2 +-
 docs/{ =3D> config}/ich9-ehci-uhci.cfg       |   0
 docs/{ =3D> config}/mach-virt-graphical.cfg  |   0
 docs/{ =3D> config}/mach-virt-serial.cfg     |   0
 docs/{ =3D> config}/q35-emulated.cfg         |   0
 docs/{ =3D> config}/q35-virtio-graphical.cfg |   0
 docs/{ =3D> config}/q35-virtio-serial.cfg    |   0
 docs/{ =3D> devel}/atomics.txt               |   0
 docs/{ =3D> devel}/bitmaps.md                |   0
 docs/{ =3D> devel}/blkdebug.txt              |   0
 docs/{ =3D> devel}/blkverify.txt             |   0
 docs/{ =3D> devel}/build-system.txt          |   0
 docs/{ =3D> devel}/lockcnt.txt               |   0
 docs/{ =3D> devel}/memory.txt                |   0
 docs/{ =3D> devel}/migration.txt             |   0
 docs/{ =3D> devel}/multi-thread-tcg.txt      |   0
 docs/{ =3D> devel}/multiple-iothreads.txt    |   0
 docs/{ =3D> devel}/qapi-code-gen.txt         |   0
 docs/{ =3D> devel}/rcu.txt                   |   0
 docs/{ =3D> devel}/tracing.txt               |   0
 docs/{ =3D> devel}/virtio-migration.txt      |   0
 docs/{ =3D> devel}/writing-qmp-commands.txt  |   0
 docs/{ =3D> spin}/aio_notify.promela         |   0
 docs/{ =3D> spin}/aio_notify_accept.promela  |   0
 docs/{ =3D> spin}/aio_notify_bug.promela     |   0
 docs/{ =3D> spin}/tcg-exclusive.promela      |   0
 docs/{ =3D> spin}/win32-qemu-event.promela   |   0
 exec.c                                     |  13 +-
 gdb-xml/i386-32bit-sse.xml                 |  52 ++++++++
 gdb-xml/i386-32bit.xml                     |  14 ++
 gdb-xml/i386-64bit-sse.xml                 |  60 +++++++++
 gdb-xml/i386-64bit.xml                     |  14 ++
 hw/i386/kvm/clock.c                        |   3 +
 hw/misc/edu.c                              |  12 +-
 hw/pci/msix.c                              |  11 +-
 hw/pci/trace-events                        |   3 +
 hw/scsi/virtio-scsi.c                      |   3 +
 hw/timer/mc146818rtc.c                     | 203 +++++++++++++++++++----=
------
 include/block/nbd.h                        |   8 +-
 include/hw/timer/mc146818rtc_regs.h        |  20 +++
 kvm-all.c                                  |   8 +-
 nbd/client.c                               | 125 +++++++++---------
 nbd/common.c                               |  23 ++--
 nbd/nbd-internal.h                         |  40 +++++-
 nbd/server.c                               | 100 ++++++--------
 pc-bios/linuxboot_dma.bin                  | Bin 1536 -> 1536 bytes
 pc-bios/optionrom/Makefile                 |   1 +
 qemu-nbd.c                                 |   5 +-
 target/i386/arch_memory_mapping.c          |  18 +--
 target/i386/cpu.c                          |  23 ++--
 target/i386/cpu.h                          |  20 ++-
 target/i386/helper.c                       |  96 +++++++-------
 target/i386/kvm.c                          |  36 ++---
 target/i386/machine.c                      |   4 -
 target/i386/smm_helper.c                   |  18 ---
 target/i386/translate.c                    |  12 ++
 tests/qemu-iotests/083.out                 |   2 +
 tests/rtc-test.c                           |  49 +++++++
 trace-events                               |   3 +-
 util/oslib-posix.c                         |   4 +-
 util/qemu-sockets.c                        |  68 ++++++----
 63 files changed, 732 insertions(+), 386 deletions(-)
 rename docs/{ =3D> config}/ich9-ehci-uhci.cfg (100%)
 rename docs/{ =3D> config}/mach-virt-graphical.cfg (100%)
 rename docs/{ =3D> config}/mach-virt-serial.cfg (100%)
 rename docs/{ =3D> config}/q35-emulated.cfg (100%)
 rename docs/{ =3D> config}/q35-virtio-graphical.cfg (100%)
 rename docs/{ =3D> config}/q35-virtio-serial.cfg (100%)
 rename docs/{ =3D> devel}/atomics.txt (100%)
 rename docs/{ =3D> devel}/bitmaps.md (100%)
 rename docs/{ =3D> devel}/blkdebug.txt (100%)
 rename docs/{ =3D> devel}/blkverify.txt (100%)
 rename docs/{ =3D> devel}/build-system.txt (100%)
 rename docs/{ =3D> devel}/lockcnt.txt (100%)
 rename docs/{ =3D> devel}/memory.txt (100%)
 rename docs/{ =3D> devel}/migration.txt (100%)
 rename docs/{ =3D> devel}/multi-thread-tcg.txt (100%)
 rename docs/{ =3D> devel}/multiple-iothreads.txt (100%)
 rename docs/{ =3D> devel}/qapi-code-gen.txt (100%)
 rename docs/{ =3D> devel}/rcu.txt (100%)
 rename docs/{ =3D> devel}/tracing.txt (100%)
 rename docs/{ =3D> devel}/virtio-migration.txt (100%)
 rename docs/{ =3D> devel}/writing-qmp-commands.txt (100%)
 rename docs/{ =3D> spin}/aio_notify.promela (100%)
 rename docs/{ =3D> spin}/aio_notify_accept.promela (100%)
 rename docs/{ =3D> spin}/aio_notify_bug.promela (100%)
 rename docs/{ =3D> spin}/tcg-exclusive.promela (100%)
 rename docs/{ =3D> spin}/win32-qemu-event.promela (100%)
 create mode 100644 gdb-xml/i386-32bit-sse.xml
 create mode 100644 gdb-xml/i386-32bit.xml
 create mode 100644 gdb-xml/i386-64bit-sse.xml
 create mode 100644 gdb-xml/i386-64bit.xml
--=20
2.13.0
