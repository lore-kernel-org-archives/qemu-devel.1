Received: from eggs.gnu.org ([2001:4830:134:3::10]:60914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDPJA-0003zt-HW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 03:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDPJ6-0007rl-TP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 03:34:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDPJ6-0007do-G4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 03:34:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5-v6so36278266wrt.2
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 00:34:41 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-231-174.clienti.tiscali.it.
	[78.12.231.174]) by smtp.gmail.com with ESMTPSA id
	m143-v6sm2815401wmd.29.2018.10.19.00.34.39
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 19 Oct 2018 00:34:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 Oct 2018 09:34:37 +0200
Message-Id: <1539934478-8896-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 00/47] Miscellaneous patches for 2018-10-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-10-17' into staging (2018-10-18 13:40:19 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0f8f43be5f3c40359d5ad855d2e02facf8b3c6c0:

  replay: pass raw icount value to replay_save_clock (2018-10-19 09:32:54 +0200)

----------------------------------------------------------------
* RTC fixes (Artem)
* icount fixes (Artem)
* rr fixes (Pavel, myself)
* hotplug cleanup (Igor)
* SCSI fixes (myself)
* 4.20-rc1 KVM header update (myself)
* coalesced PIO support (Peng Hao)
* HVF fixes (Roman B.)
* Hyper-V refactoring (Roman K.)
* Support for Hyper-V IPI (Vitaly)

----------------------------------------------------------------
Artem Pisarenko (7):
      Revert some patches from recent [PATCH v6] "Fixing record/replay and adding reverse debugging"
      qemu-timer: introduce timer attributes
      qemu-timer: avoid checkpoints for virtual clock timers in external subsystems
      vl: improve/fix documentation related to RTC function
      vl: refactor -rtc option references
      Fixes RTC bug with base datetime shifts in clock=vm
      vl, qapi: offset calculation in RTC_CHANGE event reverted

Igor Mammedov (1):
      call HotplugHandler->plug() as the last step in device realization

Li Qiang (2):
      hw: edu: drop DO_UPCAST
      target/i386: kvm: just return after migrate_add_blocker failed

Paolo Bonzini (6):
      es1370: more fixes for ADC_FRAMEADR and ADC_FRAMECNT
      target-i386: kvm: do not initialize padding fields
      linux-headers: update to 4.20-rc1
      scsi-disk: fix double completion of failing passthrough requests
      scsi-disk: fix rerror/werror=ignore
      replay: pass raw icount value to replay_save_clock

Pavel Dovgalyuk (1):
      replay: don't process events at virtual clock checkpoint

Peng Hao (4):
      target-i386 : add coalesced_pio API
      target-i386: add rtc 0x70 port as coalesced_pio
      target-i386: add i440fx 0xcf8 port as coalesced_pio
      target-i386: add q35 0xcf8 port as coalesced_pio

Roman Bolshakov (2):
      i386: hvf: Fix register refs if REX is present
      i386: hvf: Remove hvf_disabled

Roman Kagan (23):
      hyperv_testdev: refactor for better maintainability
      hyperv_testdev: drop unnecessary includes
      hyperv: cosmetic: g_malloc -> g_new
      hyperv: synic: only setup ack notifier if there's a callback
      hyperv: allow passing arbitrary data to sint ack callback
      hyperv: address HvSintRoute by X86CPU pointer
      hyperv: make HvSintRoute reference-counted
      hyperv: rename kvm_hv_sint_route_set_sint
      hyperv: split hyperv-proto.h into x86 and arch-independent parts
      hyperv: make hyperv_vp_index inline
      hyperv: factor out arch-independent API into hw/hyperv
      default-configs: collect CONFIG_HYPERV* in hyperv.mak
      i386: add hyperv-stub for CONFIG_HYPERV=n
      hyperv:synic: split capability testing and setting
      hyperv: qom-ify SynIC
      hyperv: only add SynIC in compatible configurations
      hyperv: make overlay pages for SynIC
      hyperv: add synic message delivery
      hyperv: add synic event flag signaling
      hyperv: process SIGNAL_EVENT hypercall
      hyperv: add support for KVM_HYPERV_EVENTFD
      hyperv: process POST_MESSAGE hypercall
      hyperv_testdev: add SynIC message and event testmodes

Vitaly Kuznetsov (1):
      i386/kvm: add support for Hyper-V IPI send

 accel/kvm/kvm-all.c              |  56 +++-
 cpus.c                           |   4 +-
 default-configs/hyperv.mak       |   2 +
 default-configs/i386-softmmu.mak |   2 +-
 hw/Makefile.objs                 |   1 +
 hw/audio/es1370.c                |  10 +-
 hw/core/hotplug.c                |  10 -
 hw/core/qdev.c                   |  16 +-
 hw/hyperv/Makefile.objs          |   2 +
 hw/hyperv/hyperv.c               | 654 +++++++++++++++++++++++++++++++++++++++
 hw/hyperv/hyperv_testdev.c       | 327 ++++++++++++++++++++
 hw/misc/Makefile.objs            |   1 -
 hw/misc/edu.c                    |   4 +-
 hw/misc/hyperv_testdev.c         | 174 -----------
 hw/pci-host/piix.c               |   4 +
 hw/pci-host/q35.c                |   4 +
 hw/scsi/scsi-disk.c              |  29 +-
 hw/scsi/virtio-scsi.c            |  11 +-
 hw/timer/mc146818rtc.c           |   9 +
 include/block/aio.h              |  59 +++-
 include/exec/memory.h            |   4 +-
 include/hw/hotplug.h             |  11 -
 include/hw/hyperv/hyperv-proto.h | 130 ++++++++
 include/hw/hyperv/hyperv.h       |  83 +++++
 include/hw/i386/pc.h             |   8 +
 include/qemu/timer.h             | 126 ++++----
 include/sysemu/hvf.h             |   4 +-
 include/sysemu/replay.h          |  10 +-
 linux-headers/asm-powerpc/kvm.h  |   1 +
 linux-headers/asm-x86/kvm.h      |   8 +-
 linux-headers/linux/kvm.h        |  16 +-
 memory.c                         |   4 +-
 qapi/misc.json                   |   3 +-
 qemu-options.hx                  |  14 +-
 replay/replay-events.c           |   1 +
 replay/replay-internal.c         |  25 +-
 replay/replay-internal.h         |   2 +
 replay/replay-time.c             |   8 +-
 replay/replay.c                  |   9 +-
 slirp/ip6_icmp.c                 |   9 +-
 stubs/cpu-get-icount.c           |   5 +
 stubs/replay.c                   |   2 +-
 target/i386/Makefile.objs        |  17 +-
 target/i386/cpu.c                |   3 +
 target/i386/cpu.h                |   2 +
 target/i386/hvf/hvf.c            |   9 +-
 target/i386/hvf/x86_decode.c     |  67 ++--
 target/i386/hvf/x86_decode.h     |   6 +-
 target/i386/hyperv-proto.h       | 116 +------
 target/i386/hyperv-stub.c        |  48 +++
 target/i386/hyperv.c             | 130 +++-----
 target/i386/hyperv.h             |  28 +-
 target/i386/kvm.c                |  68 +++-
 target/i386/machine.c            |   9 +
 tests/ptimer-test-stubs.c        |  13 +-
 ui/input.c                       |   9 +-
 util/qemu-timer.c                |  65 +++-
 vl.c                             | 112 ++++---
 58 files changed, 1876 insertions(+), 688 deletions(-)
 create mode 100644 default-configs/hyperv.mak
 create mode 100644 hw/hyperv/Makefile.objs
 create mode 100644 hw/hyperv/hyperv.c
 create mode 100644 hw/hyperv/hyperv_testdev.c
 delete mode 100644 hw/misc/hyperv_testdev.c
 create mode 100644 include/hw/hyperv/hyperv-proto.h
 create mode 100644 include/hw/hyperv/hyperv.h
 create mode 100644 target/i386/hyperv-stub.c
-- 
1.8.3.1
