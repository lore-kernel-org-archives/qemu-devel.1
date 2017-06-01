Received: from eggs.gnu.org ([2001:4830:134:3::10]:59503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQR-0003ML-9e
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQM-0005er-J6
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:03 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQM-0005eL-9i
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:41:58 -0400
Received: by mail-wm0-x241.google.com with SMTP id g15so11027915wmc.2
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:41:56 -0700 (PDT)
Received: from 640k.lan (94-39-157-43.adsl-ull.clienti.tiscali.it.
	[94.39.157.43]) by smtp.gmail.com with ESMTPSA id
	g46sm6271438wrg.69.2017.06.01.05.41.53 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 01 Jun 2017 05:41:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:18 +0200
Message-Id: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/33] Misc patches for 2017-06-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 56821559f0ba682fe6b367815572e6f974d329ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into staging (2017-05-18 13:36:15 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 602f845bfc7579fe6b39e6b09ea90e24f5c0ef48:

  kvm: don't register smram_listener when smm is off (2017-06-01 14:07:27 +0200)

----------------------------------------------------------------
* virtio-scsi use-after-free fix (Fam)
* vhost-user-scsi support (Felipe)
* SMM fixes and improvements for TCG (myself, Mihail)
* irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
* Coverity fix (Stefano)
* NBD cleanups and fixes (Vladimir, Eric, myself)
* RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
* socket error reporting improvement (Daniel)
* GDB XML description for SSE registers (Abdallah)
* kvmclock update fix (Denis)
* SMM memory savings (Gonglei)
* -cpu 486 fix (Paolo)
* various bugfixes (Roman, Peter, myself, Thomas)
* rtc-test improvement (Guangrong)

----------------------------------------------------------------
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

Felipe Franciosi (2):
      vhost-user-scsi: Introduce vhost-user-scsi host device
      vhost-user-scsi: Introduce a vhost-user-scsi sample application

Gonglei (1):
      kvm: don't register smram_listener when smm is off

Mihail Abakumov (1):
      i386: fix read/write cr with icount option

Paolo Bonzini (5):
      target/i386: enable A20 automatically in system management mode
      target/i386: use multiple CPU AddressSpaces
      linuxboot_dma: compile for i486
      edu: fix memory leak on msi_broken platforms
      nbd: make it thread-safe, fix qcow2 over nbd

Peter Xu (5):
      kvm: irqchip: trace changes on msi add/remove
      msix: trace control bit write op
      kvm: irqchip: skip update msi when disabled
      exec: simplify phys_page_find() params
      exec: fix address_space_get_iotlb_entry page mask

Roman Pen (1):
      i386/kvm: do not zero out segment flags if segment is unusable or not present

Stefano Stabellini (1):
      Check the return value of fcntl in qemu_set_cloexec

Tai Yunfang (1):
      mc146818rtc: precisely count the clock for periodic timer

Thomas Huth (1):
      hw/core: nmi.c can be compiled as common-obj nowadays

Vladimir Sementsov-Ogievskiy (5):
      nbd: strict nbd_wr_syncv
      nbd: read_sync and friends: return 0 on success
      nbd: add errp parameter to nbd_wr_syncv()
      nbd: add errp to read_sync, write_sync and drop_sync
      nbd/client.c: use errp instead of LOG

Xiao Guangrong (5):
      mc146818rtc: update periodic timer only if it is needed
      mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on TARGET_I386
      mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
      mc146818rtc: embrace all x86 specific code
      qtest: add rtc periodic timer test

 .gitignore                                |   1 +
 Makefile                                  |   3 +
 Makefile.objs                             |   4 +
 block/nbd-client.c                        |  41 +-
 configure                                 |   4 +-
 contrib/libvhost-user/libvhost-user.h     |  11 +-
 contrib/vhost-user-scsi/Makefile.objs     |   1 +
 contrib/vhost-user-scsi/vhost-user-scsi.c | 886 ++++++++++++++++++++++++++++++
 default-configs/pci.mak                   |   1 +
 default-configs/s390x-softmmu.mak         |   1 +
 exec.c                                    |  27 +-
 gdb-xml/i386-32bit-sse.xml                |  52 ++
 gdb-xml/i386-32bit.xml                    |  14 +
 gdb-xml/i386-64bit-sse.xml                |  60 ++
 gdb-xml/i386-64bit.xml                    |  14 +
 hw/core/Makefile.objs                     |   2 +-
 hw/i386/kvm/clock.c                       |   3 +
 hw/misc/edu.c                             |  12 +-
 hw/pci/msix.c                             |  11 +-
 hw/pci/trace-events                       |   3 +
 hw/scsi/Makefile.objs                     |   1 +
 hw/scsi/vhost-scsi-common.c               |   1 -
 hw/scsi/vhost-user-scsi.c                 | 211 +++++++
 hw/scsi/virtio-scsi.c                     |   3 +
 hw/timer/mc146818rtc.c                    | 203 ++++---
 hw/virtio/virtio-pci.c                    |  54 ++
 hw/virtio/virtio-pci.h                    |  11 +
 include/block/nbd.h                       |   8 +-
 include/hw/timer/mc146818rtc.h            |  19 +
 include/hw/virtio/vhost-user-scsi.h       |  35 ++
 include/hw/virtio/virtio-scsi.h           |   2 +
 kvm-all.c                                 |   8 +-
 nbd/client.c                              | 125 ++---
 nbd/common.c                              |  23 +-
 nbd/nbd-internal.h                        |  40 +-
 nbd/server.c                              | 100 ++--
 pc-bios/linuxboot_dma.bin                 | Bin 1536 -> 1536 bytes
 pc-bios/optionrom/Makefile                |   1 +
 qemu-nbd.c                                |   5 +-
 target/i386/arch_memory_mapping.c         |  18 +-
 target/i386/cpu.c                         |  23 +-
 target/i386/cpu.h                         |  20 +-
 target/i386/helper.c                      |  96 ++--
 target/i386/kvm.c                         |  36 +-
 target/i386/machine.c                     |   4 -
 target/i386/smm_helper.c                  |  18 -
 target/i386/translate.c                   |  12 +
 tests/qemu-iotests/083.out                |   2 +
 tests/rtc-test.c                          |  49 ++
 trace-events                              |   3 +-
 util/oslib-posix.c                        |   4 +-
 util/qemu-sockets.c                       |  68 ++-
 52 files changed, 1954 insertions(+), 400 deletions(-)
 create mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
 create mode 100644 gdb-xml/i386-32bit-sse.xml
 create mode 100644 gdb-xml/i386-32bit.xml
 create mode 100644 gdb-xml/i386-64bit-sse.xml
 create mode 100644 gdb-xml/i386-64bit.xml
 create mode 100644 hw/scsi/vhost-user-scsi.c
 create mode 100644 include/hw/virtio/vhost-user-scsi.h
-- 
1.8.3.1
