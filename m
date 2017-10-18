Received: from eggs.gnu.org ([2001:4830:134:3::10]:35647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxs-0003Id-2g
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxo-0001vk-SK
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:04 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:52605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxo-0001uV-IS
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:00 -0400
Received: by mail-wr0-x229.google.com with SMTP id k62so5589808wrc.9
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:12:59 -0700 (PDT)
Received: from 640k.lan (94-39-155-245.adsl-ull.clienti.tiscali.it.
	[94.39.155.245])
	by smtp.gmail.com with ESMTPSA id 69sm13436794wmm.2.2017.10.18.09.12.54
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Oct 2017 09:12:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:11:52 +0200
Message-Id: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/29] Misc patches for 2017-10-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit a0b261db8c030813e30a39eae47359ac2a37f7e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2017-10-12 10:02:09 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3da023b5827543ee4c022986ea2ad9d1274410b2:

  scsi: reject configurations with logical block size > physical block size (2017-10-18 11:56:14 +0200)

----------------------------------------------------------------
* TCG 8-byte atomic accesses bugfix (Andrew)
* Report disk rotation rate (Daniel)
* Report invalid scsi-disk block size configuration (Mark)
* KVM and memory API MemoryListener fixes (David, Maxime, Peter Xu)
* x86 CPU hotplug crash fix (Igor)
* Load/store API documentation (Peter Maydell)
* Small fixes by myself and Thomas
* qdev DEVICE_DELETED deferral (Michael)

----------------------------------------------------------------
Andrew Baumann (1):
      notdirty_mem_write: implement 8-byte accesses

Daniel P. Berrange (3):
      scsi-disk: support reporting of rotation rate
      ide: support reporting of rotation rate
      char: don't skip client cleanup if 'connected' flag is unset

David Hildenbrand (7):
      memory: call log_start after region_add
      kvm: fix alignment of ram address
      kvm: tolerate non-existing slot for log_start/log_stop/log_sync
      kvm: fix error message when failing to unregister slot
      kvm: region_add and region_del is not called on updates
      kvm: simplify kvm_align_section()
      memory: reuse section_from_flat_range()

Igor Mammedov (1):
      pc: make sure that plugged CPUs are of the same type

Mark Kanda (1):
      scsi: reject configurations with logical block size > physical block size

Maxime Coquelin (1):
      memory: fix off-by-one error in memory_region_notify_one()

Michael Roth (3):
      qdev: store DeviceState's canonical path to use when unparenting
      Revert "qdev: Free QemuOpts when the QOM path goes away"
      qdev: defer DEVICE_DEL event until instance_finalize()

Paolo Bonzini (8):
      checkpatch: refine mode selection
      build: remove CONFIG_LIBDECNUMBER
      nios2: define tcg_env
      tco: add trace events
      target/i386: introduce x86_ld*_code
      target/i386: trap on instructions longer than >15 bytes
      watch_mem_write: implement 8-byte accesses
      qemu-pr-helper: use new libmultipath API

Peter Maydell (1):
      docs/devel/loads-stores.rst: Document our various load and store APIs

Peter Xu (2):
      exec: add page_mask for flatview_do_translate
      exec: simplify address_space_get_iotlb_entry

Thomas Huth (1):
      disas: Always initialize read_memory_inner_func properly

 Makefile.target                           |   6 -
 accel/kvm/kvm-all.c                       |  39 ++-
 chardev/char-socket.c                     |  19 +-
 configure                                 |  12 +-
 default-configs/ppc-linux-user.mak        |   1 -
 default-configs/ppc-softmmu.mak           |   1 -
 default-configs/ppc64-linux-user.mak      |   1 -
 default-configs/ppc64-softmmu.mak         |   1 -
 default-configs/ppc64abi32-linux-user.mak |   1 -
 default-configs/ppc64le-linux-user.mak    |   1 -
 default-configs/ppcemb-softmmu.mak        |   1 -
 disas.c                                   |   1 -
 docs/devel/loads-stores.rst               | 396 ++++++++++++++++++++++++++++++
 exec.c                                    | 109 ++++++--
 hw/acpi/tco.c                             |  11 +-
 hw/acpi/trace-events                      |   4 +
 hw/core/qdev.c                            |  32 ++-
 hw/i386/pc.c                              |   7 +
 hw/ide/core.c                             |   1 +
 hw/ide/qdev.c                             |   1 +
 hw/scsi/scsi-disk.c                       |  28 +++
 include/disas/bfd.h                       |   1 +
 include/hw/ide/internal.h                 |   8 +
 include/hw/qdev-core.h                    |   1 +
 libdecnumber/Makefile.objs                |   5 +
 memory.c                                  |  18 +-
 scripts/checkpatch.pl                     |  19 +-
 scsi/qemu-pr-helper.c                     |  17 +-
 target/i386/translate.c                   | 257 ++++++++++---------
 target/nios2/translate.c                  |   1 +
 target/ppc/Makefile.objs                  |   1 +
 31 files changed, 777 insertions(+), 224 deletions(-)
 create mode 100644 docs/devel/loads-stores.rst
 create mode 100644 libdecnumber/Makefile.objs
-- 
1.8.3.1
