Received: from eggs.gnu.org ([2001:4830:134:3::10]:40637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOl-00082m-HN
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOh-0007O4-LI
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:11 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOh-0007NZ-BC
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:07 -0400
Received: by mail-wr0-x241.google.com with SMTP id y25so544010wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:07 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id f21sm3258597wra.5.2017.06.15.03.53.04
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Jun 2017 03:53:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:20 +0200
Message-Id: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/41] Misc patches for 2017-06-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 49cc0340f8be18871319ffec6efc72147e73ff0b:

  vhost-user-scsi: Introduce a vhost-user-scsi sample application (2017-06-15 11:18:40 +0200)

----------------------------------------------------------------
* nbd and qemu-nbd fixes (Eric, Max)
* nbd refactoring (Vladimir)
* vhost-user-scsi, take N+1 (Felipe)
* replace memory_region_set_fd with memory_region_init_ram_from_fd (Marc-André)
* docs/ movement (Paolo)
* megasas TOCTOU fixes (Paolo)
* make async_safe_run_on_cpu work on kvm/hax accelerators (Paolo)
* Build system and poison.h improvements (Thomas)
* -accel thread=xxx fix (Thomas)
* move files to accel/ (Yang Zhong)

----------------------------------------------------------------
Eric Blake (1):
      nbd: Fix regression on resiliency to port scan

Felipe Franciosi (2):
      vhost-user-scsi: Introduce vhost-user-scsi host device
      vhost-user-scsi: Introduce a vhost-user-scsi sample application

Marc-André Lureau (6):
      exec: check kvm mmu notifiers earlier
      exec: split file_ram_alloc()
      exec: split qemu_ram_alloc_from_file()
      Add memory_region_init_ram_from_fd()
      ivshmem: use ram_from_fd()
      memory: remove memory_region_set_fd

Max Reitz (1):
      qemu-nbd: Ignore SIGPIPE

Paolo Bonzini (10):
      megasas: add qtest
      megasas: do not read sense length more than once from frame
      megasas: do not read iovec count more than once from frame
      megasas: do not read DCMD opcode more than once from frame
      megasas: do not read command more than once from frame
      megasas: do not read SCSI req parameters more than once from frame
      megasas: always store SCSIRequest* into MegasasCmd
      hax-all: make async_safe_run_on_cpu safe on HAX too
      docs: create interop/ subdirectory
      qemu-doc: include version number

Roman Kagan (1):
      kvm-all: make async_safe_run_on_cpu safe on kvm too

Thomas Huth (4):
      Makefile: Do not generate files if "configure" has not been run yet
      vl: Fix broken thread=xxx option of the --accel parameter
      include/exec/poison: Add missing TARGET defines
      include/exec/poison: Mark some CONFIG defines as poisoned, too

Vladimir Sementsov-Ogievskiy (12):
      nbd: rename read_sync and friends
      nbd: make nbd_drop public
      nbd/server: get rid of nbd_negotiate_read and friends
      nbd/server: get rid of ssize_t
      nbd/server: refactor nbd_co_send_reply
      nbd/server: get rid of EAGAIN dead code
      nbd/server: refactor nbd_co_receive_request
      nbd/server: remove NBDClientNewData
      nbd/server: nbd_negotiate: fix error path
      nbd/server: get rid of fail: return rc
      nbd/server: rename rc to ret
      nbd/server: refactor nbd_trip

Yang Zhong (4):
      accel: split the tcg accelerator from accel.c file
      tcg: move tcg related files into accel/tcg/ subdirectory
      tcg: move tcg backend files into accel/tcg/
      accel: move kvm related accelerator files into accel/

 .gitignore                                         |  17 +-
 Makefile                                           |  77 +-
 Makefile.objs                                      |   7 +-
 Makefile.target                                    |  12 +-
 accel/Makefile.objs                                |   4 +
 accel.c => accel/accel.c                           |  27 -
 accel/kvm/Makefile.objs                            |   1 +
 kvm-all.c => accel/kvm/kvm-all.c                   |   4 +-
 accel/kvm/trace-events                             |  15 +
 accel/stubs/Makefile.objs                          |   1 +
 kvm-stub.c => accel/stubs/kvm-stub.c               |   0
 accel/tcg/Makefile.objs                            |   3 +
 cpu-exec-common.c => accel/tcg/cpu-exec-common.c   |   0
 cpu-exec.c => accel/tcg/cpu-exec.c                 |   2 +-
 cputlb.c => accel/tcg/cputlb.c                     |   0
 accel/tcg/tcg-all.c                                |  61 ++
 accel/tcg/trace-events                             |  10 +
 translate-all.c => accel/tcg/translate-all.c       |   2 +-
 translate-all.h => accel/tcg/translate-all.h       |   0
 translate-common.c => accel/tcg/translate-common.c |   0
 block/nbd-client.c                                 |   8 +-
 blockdev-nbd.c                                     |   6 +-
 configure                                          |   4 +-
 contrib/libvhost-user/libvhost-user.h              |  11 +-
 contrib/vhost-user-scsi/Makefile.objs              |   1 +
 contrib/vhost-user-scsi/vhost-user-scsi.c          | 886 +++++++++++++++++++++
 default-configs/pci.mak                            |   1 +
 default-configs/s390x-softmmu.mak                  |   1 +
 docs/{specs => interop}/parallels.txt              |   0
 docs/{specs => interop}/qcow2.txt                  |   0
 docs/{specs => interop}/qed_spec.txt               |   0
 docs/{ => interop}/qemu-ga-ref.texi                |   0
 docs/{ => interop}/qemu-qmp-ref.texi               |   0
 docs/{ => interop}/qmp-intro.txt                   |   0
 docs/{ => interop}/qmp-spec.txt                    |   0
 docs/{specs => interop}/vhost-user.txt             |   0
 .../{ => interop}/vnc-ledstate-Pseudo-encoding.txt |   0
 exec.c                                             | 116 +--
 hw/misc/ivshmem.c                                  |  14 +-
 hw/scsi/Makefile.objs                              |   1 +
 hw/scsi/megasas.c                                  | 175 ++--
 hw/scsi/vhost-scsi-common.c                        |   1 -
 hw/scsi/vhost-user-scsi.c                          | 205 +++++
 hw/virtio/virtio-pci.c                             |  58 ++
 hw/virtio/virtio-pci.h                             |  11 +
 include/block/nbd.h                                |  10 +-
 include/exec/memory.h                              |  31 +-
 include/exec/poison.h                              |  31 +
 include/exec/ram_addr.h                            |   3 +
 include/hw/virtio/vhost-user-scsi.h                |  35 +
 include/hw/virtio/virtio-scsi.h                    |   2 +
 memory.c                                           |  26 +-
 nbd/client.c                                       |  64 +-
 nbd/common.c                                       |  34 +-
 nbd/nbd-internal.h                                 |  28 +-
 nbd/server.c                                       | 343 +++-----
 qemu-doc.texi                                      |   5 +-
 qemu-nbd.c                                         |   8 +-
 rules.mak                                          |   2 +-
 target/i386/hax-all.c                              |   3 +-
 tcg-runtime.c => tcg/tcg-runtime.c                 |   0
 tci.c => tcg/tci.c                                 |   0
 tests/Makefile.include                             |   3 +
 tests/megasas-test.c                               |  86 ++
 trace-events                                       |  22 -
 vl.c                                               |  13 +-
 66 files changed, 1895 insertions(+), 596 deletions(-)
 create mode 100644 accel/Makefile.objs
 rename accel.c => accel/accel.c (87%)
 create mode 100644 accel/kvm/Makefile.objs
 rename kvm-all.c => accel/kvm/kvm-all.c (99%)
 create mode 100644 accel/kvm/trace-events
 create mode 100644 accel/stubs/Makefile.objs
 rename kvm-stub.c => accel/stubs/kvm-stub.c (100%)
 create mode 100644 accel/tcg/Makefile.objs
 rename cpu-exec-common.c => accel/tcg/cpu-exec-common.c (100%)
 rename cpu-exec.c => accel/tcg/cpu-exec.c (99%)
 rename cputlb.c => accel/tcg/cputlb.c (100%)
 create mode 100644 accel/tcg/tcg-all.c
 create mode 100644 accel/tcg/trace-events
 rename translate-all.c => accel/tcg/translate-all.c (99%)
 rename translate-all.h => accel/tcg/translate-all.h (100%)
 rename translate-common.c => accel/tcg/translate-common.c (100%)
 create mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
 rename docs/{specs => interop}/parallels.txt (100%)
 rename docs/{specs => interop}/qcow2.txt (100%)
 rename docs/{specs => interop}/qed_spec.txt (100%)
 rename docs/{ => interop}/qemu-ga-ref.texi (100%)
 rename docs/{ => interop}/qemu-qmp-ref.texi (100%)
 rename docs/{ => interop}/qmp-intro.txt (100%)
 rename docs/{ => interop}/qmp-spec.txt (100%)
 rename docs/{specs => interop}/vhost-user.txt (100%)
 rename docs/{ => interop}/vnc-ledstate-Pseudo-encoding.txt (100%)
 create mode 100644 hw/scsi/vhost-user-scsi.c
 create mode 100644 include/hw/virtio/vhost-user-scsi.h
 rename tcg-runtime.c => tcg/tcg-runtime.c (100%)
 rename tci.c => tcg/tci.c (100%)
 create mode 100644 tests/megasas-test.c
-- 
1.8.3.1
