Received: from eggs.gnu.org ([2001:4830:134:3::10]:36563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9Z-0003OK-B5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9W-0006W0-3z
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:29 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9V-0006V5-TM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:26 -0400
Received: by mail-wm0-x22c.google.com with SMTP id n11so3168064wma.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:25 -0700 (PDT)
Received: from 640k.lan (94-39-132-181.adsl-ull.clienti.tiscali.it.
	[94.39.132.181])
	by smtp.gmail.com with ESMTPSA id k195sm408197wmd.7.2017.03.14.09.18.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Mar 2017 09:18:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:02 +0100
Message-Id: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/18] Misc patches for QEMU 2.9 hard freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 94b5d57d2f5a3c849cecd65e424bb6f50b998df9:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170314' into staging (2017-03-14 10:13:19 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2563c9c6b8670400c48e562034b321a7cf3d9a85:

  nbd/client: fix drop_sync [CVE-2017-2630] (2017-03-14 14:41:19 +0100)

----------------------------------------------------------------
* "x" monitor command fix for KVM (Christian)
* MemoryRegion name documentation (David)
* mem-prealloc optimization (Jitendra)
* -icount/MTTCG fixes (me)
* "info mtree" niceness (Peter)
* NBD drop_sync buffer overflow (Vladimir/Eric)
* small cleanups and bugfixes (Li, Lin, Suramya, Thomas)
* fix for "-device kvmclock" w/TCG (Eduardo)
* debug output before crashing on KVM_{GET,SET}_MSRS (Eduardo)

----------------------------------------------------------------
Christian Borntraeger (1):
      exec: add cpu_synchronize_state to cpu_memory_rw_debug

Dr. David Alan Gilbert (1):
      memory_region: Fix name comments

Eduardo Habkost (2):
      kvm: Print MSR information if KVM_{GET,SET}_MSRS failed
      kvmclock: Don't crash QEMU if KVM is disabled

Jitendra Kolhe (1):
      mem-prealloc: reduce large guest start-up and migration time.

Li Qiang (1):
      scsi: mptsas: fix the wrong reading size in fetch request

Lin Ma (1):
      configure: add the missing help output for optional features

Marc-André Lureau (1):
      scripts/dump-guest-memory.py: fix int128_get64 on recent gcc

Paolo Bonzini (6):
      target/nios2: take BQL around interrupt check
      qemu-timer: fix off-by-one
      qemu-timer: do not include sysemu/cpus.h from util/qemu-timer.h
      cpus: define QEMUTimerListNotifyCB for QEMU system emulation
      main-loop: remove now unnecessary optimization
      icount: process QEMU_CLOCK_VIRTUAL timers in vCPU thread

Peter Xu (1):
      memory: info mtree check mr range overflow

Suramya Shah (1):
      util: Removed unneeded header from path.c

Thomas Huth (1):
      docs: Add a note about mixing bootindex with "-boot order"

Vladimir Sementsov-Ogievskiy (1):
      nbd/client: fix drop_sync [CVE-2017-2630]

 backends/hostmem.c           |   4 +-
 configure                    |  12 +++++
 cpu-exec.c                   |   1 +
 cpus.c                       |  31 ++++++++++++-
 docs/bootindex.txt           |   9 ++++
 exec.c                       |   4 +-
 hw/core/ptimer.c             |   1 +
 hw/i386/kvm/clock.c          |   6 +++
 hw/ppc/pnv.c                 |   1 +
 hw/scsi/mptsas.c             |   6 +--
 include/exec/memory.h        |  18 +++++---
 include/qemu/osdep.h         |   3 +-
 include/qemu/timer.h         |  29 ++++++++++--
 include/sysemu/cpus.h        |   3 ++
 kvm-all.c                    |   1 +
 memory.c                     |  21 +++++++--
 monitor.c                    |   1 +
 nbd/client.c                 |   2 +-
 qemu-options.hx              |   5 +-
 replay/replay.c              |   1 +
 scripts/dump-guest-memory.py |  14 +++++-
 stubs/cpu-get-icount.c       |   6 +++
 target/alpha/translate.c     |   1 +
 target/i386/kvm.c            |  12 +++++
 target/nios2/op_helper.c     |   3 ++
 tests/test-aio-multithread.c |   2 +-
 tests/test-aio.c             |   2 +-
 translate-all.c              |   1 +
 util/async.c                 |   2 +-
 util/main-loop.c             |   3 +-
 util/oslib-posix.c           | 108 ++++++++++++++++++++++++++++++++++---------
 util/oslib-win32.c           |   3 +-
 util/path.c                  |   1 -
 util/qemu-timer.c            |  17 ++++---
 vl.c                         |   5 +-
 35 files changed, 274 insertions(+), 65 deletions(-)
-- 
1.8.3.1
