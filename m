Received: from eggs.gnu.org ([2001:4830:134:3::10]:52615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRiTE-0001of-80
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRiFP-0001t5-AZ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:38:14 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRiFP-0001sZ-2o
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:38:11 -0500
Received: by mail-lj1-x233.google.com with SMTP id v1-v6so21070876ljd.0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 10:38:11 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id s20sm750723lfb.51.2018.11.27.10.38.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Nov 2018 10:38:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 19:38:06 +0100
Message-Id: <1543343886-816-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 00/14] Misc patches for QEMU 3.1.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 4822f1ee9efa8df56e29db0a68323b484bdb0335:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181127-pull-request' into staging (2018-11-27 11:21:38 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3fe2199833c47652a7e5dbf8b347d873820104b8:

  hostmem: no need to check for host_memory_backend_mr_inited() in alloc() (2018-11-27 19:36:22 +0100)

----------------------------------------------------------------
* lsi HBA reselection fix (George)
* Small cleanups (Li Qiang)
* bugfixes for vhost-user-bridge and hostmem (Marc-André)
* single-thread TCG fix (me)
* VMX migration blocker (me)
* target/i386 fix for LOCK (Richard)
* MAINTAINERS update (Philippe, Thomas)

----------------------------------------------------------------
George Kennedy (1):
      lsi: Reselection needed to remove pending commands from queue

Li Qiang (2):
      vl: Improve error message when we can't load fw_cfg from file
      vl.c: remove outdated comment

Marc-André Lureau (4):
      vmstate: constify VMStateField
      vhost-user-bridge: fix recvmsg iovlen
      hostmem-memfd: honour share=on/off property
      hostmem: no need to check for host_memory_backend_mr_inited() in alloc()

Paolo Bonzini (4):
      target/i386: kvm: add VMX migration blocker
      cpus: run work items for all vCPUs if single-threaded
      migration: savevm: consult migration blockers
      checkpatch: g_test_message does not need a trailing newline

Philippe Mathieu-Daudé (1):
      MAINTAINERS: Add an entry for the Firmware Configuration (fw_cfg) device

Richard Henderson (1):
      target/i386: Generate #UD when applying LOCK to a register destination

Thomas Huth (1):
      MAINTAINERS: Add some missing entries related to accelerators

 MAINTAINERS                 |  18 +++++++
 backends/hostmem-file.c     |  24 ++++-----
 backends/hostmem-memfd.c    |   8 ++-
 cpus.c                      |  12 +++--
 hw/display/virtio-gpu.c     |   4 +-
 hw/intc/s390_flic_kvm.c     |   4 +-
 hw/nvram/eeprom93xx.c       |   6 +--
 hw/nvram/fw_cfg.c           |   6 +--
 hw/pci/msix.c               |   4 +-
 hw/pci/pci.c                |   8 +--
 hw/pci/shpc.c               |   7 +--
 hw/scsi/lsi53c895a.c        |  48 +++++++++++++-----
 hw/scsi/scsi-bus.c          |   4 +-
 hw/timer/twl92230.c         |   4 +-
 hw/usb/redirect.c           |  12 ++---
 hw/virtio/virtio.c          |   8 +--
 include/migration/vmstate.h |   6 +--
 migration/savevm.c          |  11 ++--
 migration/vmstate-types.c   | 119 ++++++++++++++++++++++++--------------------
 migration/vmstate.c         |  31 ++++++------
 qemu-options.hx             |   4 +-
 scripts/checkpatch.pl       |   3 +-
 target/alpha/machine.c      |   5 +-
 target/arm/machine.c        |  12 ++---
 target/hppa/machine.c       |  10 ++--
 target/i386/kvm.c           |  15 ++++--
 target/i386/translate.c     |  35 +++++++------
 target/mips/machine.c       |  14 +++---
 target/openrisc/machine.c   |   5 +-
 target/ppc/machine.c        |  14 +++---
 target/sparc/machine.c      |   7 +--
 tests/vhost-user-bridge.c   |   2 +-
 vl.c                        |   9 ++--
 33 files changed, 285 insertions(+), 194 deletions(-)
-- 
1.8.3.1
