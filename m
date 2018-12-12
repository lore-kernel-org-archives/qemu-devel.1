Received: from eggs.gnu.org ([2001:4830:134:3::10]:52038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MO-0000f4-Eq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MH-0008TP-3N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:38 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MG-0008Gj-K8
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:32 -0500
Received: by mail-wr1-x42b.google.com with SMTP id z5so18062478wrt.11
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:21 +0100
Message-Id: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/54] Misc patches for 2018-12-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e2a9129b491fdb3be3661baf08a9fa4c2e19a028:

  vhost-user-test: create a temporary directory per TestServer (2018-12-12 13:49:31 +0100)

This introduces a new dependency on perl's Test::Harness package.  This is
distributed in package perl-Test-Harness for Fedora, and libtest-harness-perl
for Debian.  I couldn't find anything for BSD or macOS, but at least the
Patchew BSD images already have it so it is probably bundled with Perl.

Thanks,

Paolo

----------------------------------------------------------------
* HAX support for Linux hosts (Alejandro)
* esp bugfixes (Guenter)
* Windows build cleanup (Marc-André)
* checkpatch logic improvements (Paolo)
* coalesced range bugfix (Paolo)
* switch testsuite to TAP (Paolo)
* QTAILQ rewrite (Paolo)
* enable vhost for TCG and clean up vhost-user-test (Paolo)
* block/iscsi.c cancellation fixes (Stefan)
* improve selection of the default accelerator (Thomas)
* add explicit checks for the compiler version and cleanup (Thomas)

----------------------------------------------------------------
Alexandro Sanchez Bach (1):
      hax: Support for Linux hosts

Guenter Roeck (2):
      esp-pci: Fix status register write erase control
      scsi: esp: Defer command completion until previous interrupts have been handled

Marc-André Lureau (5):
      vhost-user-bridge: fix "unknown type name" compilation error
      build-sys: don't include windows.h, osdep.h does it
      build-sys: move windows defines in osdep.h header
      build-sys: build with Vista API by default
      RFC: qga: drop < Vista compatibility

Paolo Bonzini (32):
      checkpatch: fix premature exit when no input or --mailback
      checkpatch: check Signed-off-by in --mailback mode
      checkpatch: improve handling of multiple patches or files
      checkpatch: colorize output to terminal
      pam: wrap MemoryRegion initialization in a transaction
      memory: extract flat_range_coalesced_io_{del,add}
      memory: avoid unnecessary coalesced_io_del operations
      memory: update coalesced_range on transaction_commit
      test: execute g_test_run when tests are skipped
      test: replace gtester with a TAP driver
      qemu/queue.h: do not access tqe_prev directly
      vfio: make vfio_address_spaces static
      qemu/queue.h: leave head structs anonymous unless necessary
      qemu/queue.h: typedef QTAILQ heads
      qemu/queue.h: remove Q_TAILQ_{HEAD,ENTRY}
      qemu/queue.h: reimplement QTAILQ without pointer-to-pointers
      qemu/queue.h: simplify reverse access to QTAILQ
      checkpatch: warn about qemu/queue.h head structs that are not typedef-ed
      vhost-net: move stubs to a separate file
      vhost-net-user: add stubs for when no virtio-net device is present
      vhost: restrict Linux dependency to kernel vhost
      vhost-net: compile it on all targets that have virtio-net.
      vhost-net: revamp configure logic
      vhost-user-test: use g_cond_broadcast
      vhost-user-test: signal data_cond when s->rings changes
      vhost-user: support cross-endian vnet headers
      vhost-user-test: support VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
      vhost-user-test: skip if there is no memory at address 0
      vhost-user-test: reduce usage of global_qtest
      vhost-user-test: create a main loop per TestServer
      vhost-user-test: small changes to init_hugepagefs
      vhost-user-test: create a temporary directory per TestServer

Peng Hao (1):
      hw/watchdog/wdt_i6300esb : remove a unnecessary comment

Stefan Hajnoczi (4):
      block/iscsi: drop unused IscsiAIOCB->buf field
      block/iscsi: take iscsilun->mutex in iscsi_timed_check_events()
      block/iscsi: fix ioctl cancel use-after-free
      block/iscsi: cancel libiscsi task when ABORT TASK TMF completes

Thomas Huth (9):
      accel: Improve selection of the default accelerator
      compiler.h: Add an explicit check for the compiler version
      configure: Add a test for the minimum compiler version
      configure: Remove obsolete check for Clang < 3.2
      configure: Remove old -fno-gcse workaround for GCC 4.6.x and 4.7.[012]
      tcg/tcg.h: Remove GCC check for tcg_debug_assert() macro
      audio/alsaaudio: Remove compiler check around pragma
      includes: Replace QEMU_GNUC_PREREQ with "__has_builtin || !defined(__clang__)"
      Remove QEMU_ARTIFICIAL macro

 Makefile.target                              |   3 -
 accel/accel.c                                |  18 +-
 accel/kvm/kvm-all.c                          |   4 +-
 accel/tcg/translate-all.c                    |   4 -
 audio/alsaaudio.c                            |   2 -
 backends/Makefile.objs                       |   5 +-
 block/gluster.c                              |   2 +-
 block/iscsi.c                                |  47 +++-
 block/mirror.c                               |   2 +-
 block/qcow2-bitmap.c                         |   4 +-
 block/qcow2.h                                |   2 +-
 block/sheepdog.c                             |   6 +-
 block/vhdx.h                                 |   2 +-
 blockdev.c                                   |   4 +-
 configure                                    | 151 ++++++-----
 contrib/ivshmem-client/ivshmem-client.h      |   4 +-
 contrib/ivshmem-server/ivshmem-server.h      |   5 +-
 cpus-common.c                                |   2 +-
 default-configs/virtio.mak                   |   4 +-
 dump.c                                       |   2 +-
 exec.c                                       |   5 +-
 fsdev/qemu-fsdev.c                           |   2 +-
 hw/block/nvme.h                              |   8 +-
 hw/block/xen_disk.c                          |   6 +-
 hw/core/qdev.c                               |   4 +-
 hw/core/reset.c                              |   2 +-
 hw/i386/xen/xen-mapcache.c                   |   2 +-
 hw/net/Makefile.objs                         |   4 +-
 hw/net/vhost_net-stub.c                      |  92 +++++++
 hw/net/vhost_net.c                           |  78 +-----
 hw/pci-host/pam.c                            |   2 +
 hw/ppc/spapr_iommu.c                         |   2 +-
 hw/scsi/esp-pci.c                            |  10 +-
 hw/scsi/esp.c                                |  33 ++-
 hw/scsi/scsi-bus.c                           |   2 +-
 hw/scsi/trace-events                         |   1 +
 hw/usb/ccid-card-emulated.c                  |   4 +-
 hw/usb/combined-packet.c                     |   2 +-
 hw/usb/dev-mtp.c                             |   4 +-
 hw/usb/dev-network.c                         |   2 +-
 hw/usb/hcd-ehci.c                            |   2 +-
 hw/usb/hcd-ehci.h                            |   2 +-
 hw/usb/hcd-uhci.c                            |   4 +-
 hw/usb/xen-usb.c                             |   6 +-
 hw/vfio/common.c                             |   4 +-
 hw/virtio/Makefile.objs                      |   5 +-
 hw/virtio/vhost-backend.c                    |  11 +-
 hw/watchdog/watchdog.c                       |   2 +-
 hw/watchdog/wdt_i6300esb.c                   |   1 -
 hw/xen/xen_pvdev.c                           |   4 +-
 include/exec/memory.h                        |   6 +-
 include/exec/poison.h                        |   1 -
 include/hw/qdev-core.h                       |   2 +-
 include/hw/scsi/esp.h                        |   2 +
 include/hw/usb.h                             |   2 +-
 include/hw/vfio/vfio-common.h                |   4 +-
 include/hw/vfio/vfio-platform.h              |   2 +-
 include/net/net.h                            |   2 +-
 include/qemu/compiler.h                      |  16 +-
 include/qemu/host-utils.h                    |   4 +-
 include/qemu/option_int.h                    |   2 +-
 include/qemu/osdep.h                         |  17 ++
 include/qemu/queue.h                         | 153 +++++------
 include/qemu/rcu_queue.h                     |  45 ++--
 include/qom/cpu.h                            |   9 +-
 include/sysemu/accel.h                       |   2 +-
 include/sysemu/kvm.h                         |   2 -
 include/sysemu/memory_mapping.h              |   2 +-
 include/sysemu/rng.h                         |   2 +-
 linux-user/elfload.c                         |   2 +-
 memory.c                                     |  97 ++++---
 memory_mapping.c                             |   2 +-
 migration/block-dirty-bitmap.c               |   2 +-
 migration/block.c                            |   4 +-
 migration/ram.c                              |   2 +-
 monitor.c                                    |   4 +-
 net/Makefile.objs                            |   4 +-
 net/filter.c                                 |   2 +-
 net/net.c                                    |   4 +-
 net/queue.c                                  |   2 +-
 net/slirp.c                                  |   2 +-
 net/vhost-user-stub.c                        |  23 ++
 net/vhost-user.c                             |  13 +
 qga/commands-posix.c                         |   2 +-
 qga/commands-win32.c                         |  70 +----
 scripts/checkpatch.pl                        |  96 +++++--
 scripts/cocci-macro-file.h                   |  25 +-
 scripts/gtester-cat                          |  26 --
 scripts/tap-driver.pl                        | 378 +++++++++++++++++++++++++++
 scripts/tap-merge.pl                         | 110 ++++++++
 slirp/slirp.c                                |   2 +-
 target/arm/kvm.c                             |   2 +-
 target/i386/Makefile.objs                    |   6 +-
 target/i386/hax-i386.h                       |   6 +-
 target/i386/hax-mem.c                        |   2 +-
 target/i386/{hax-darwin.c => hax-posix.c}    |   0
 target/i386/{hax-darwin.h => hax-posix.h}    |   0
 tcg/tcg.c                                    |   2 +-
 tcg/tcg.h                                    |  10 +-
 tests/Makefile.include                       |  59 +++--
 tests/cdrom-test.c                           |   2 +-
 tests/docker/dockerfiles/centos7.docker      |   1 +
 tests/docker/dockerfiles/debian-amd64.docker |   1 +
 tests/docker/dockerfiles/debian-ports.docker |   1 +
 tests/docker/dockerfiles/debian-sid.docker   |   1 +
 tests/docker/dockerfiles/debian8.docker      |   1 +
 tests/docker/dockerfiles/debian9.docker      |   1 +
 tests/docker/dockerfiles/fedora.docker       |   1 +
 tests/docker/dockerfiles/ubuntu.docker       |   1 +
 tests/libqos/malloc.c                        |   2 +-
 tests/migration-test.c                       |   8 +-
 tests/test-rcu-list.c                        |   2 +-
 tests/test-vmstate.c                         |   8 +-
 tests/vhost-user-bridge.c                    |   3 +-
 tests/vhost-user-test.c                      | 234 +++++++++--------
 ui/console.c                                 |   4 +-
 ui/input.c                                   |  14 +-
 util/qemu-option.c                           |   4 +-
 util/qemu-thread-win32.c                     |   4 -
 vl.c                                         |   4 +-
 120 files changed, 1373 insertions(+), 737 deletions(-)
 create mode 100644 hw/net/vhost_net-stub.c
 create mode 100644 net/vhost-user-stub.c
 delete mode 100755 scripts/gtester-cat
 create mode 100755 scripts/tap-driver.pl
 create mode 100755 scripts/tap-merge.pl
 rename target/i386/{hax-darwin.c => hax-posix.c} (100%)
 rename target/i386/{hax-darwin.h => hax-posix.h} (100%)
-- 
1.8.3.1
