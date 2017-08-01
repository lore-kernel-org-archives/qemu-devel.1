Received: from eggs.gnu.org ([2001:4830:134:3::10]:59535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrT-0004J1-Ql
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrQ-00079K-KK
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:35 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrQ-00078X-Do
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:32 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 12so8900803wrb.1
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:30 -0700 (PDT)
Received: from 640k.lan (94-39-192-75.adsl-ull.clienti.tiscali.it.
	[94.39.192.75]) by smtp.gmail.com with ESMTPSA id
	u187sm1724160wmd.26.2017.08.01.09.17.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Aug 2017 09:17:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:08 +0200
Message-Id: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/17] Misc changes for QEMU 2.10-rc1 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 7d48cf8102a10e4a54333811bafb5eb566509268:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-08-01 14:33:56 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 33f21e4f044ac1c37f60edc1f1aee628be8f463b:

  mc146818rtc: implement UIP latching as intended (2017-08-01 17:27:34 +0200)

----------------------------------------------------------------
* Xen fix (Anthony)
* chardev fixes (Anton, Marc-André)
* small dead code removal (Zhongyi)
* documentation (Dan)
* bugfixes (David)
* decrease migration downtime (Jay)
* improved error output (Laurent)
* RTC tests and bugfix (me)
* Bluetooth clang analyzer fix (me)
* KVM CPU hotplug race (Peng Hao)
* Two other patches from Philippe's clang analyzer series

----------------------------------------------------------------
Anthony PERARD (1):
      exec: Add lock parameter to qemu_ram_ptr_length

Anton Nefedov (1):
      char: don't exit on hmp 'chardev-add help'

Daniel P. Berrange (2):
      docs: document deprecation policy & deprecated features in appendix
      qemu-options: document existance of versioned machine types

Dr. David Alan Gilbert (2):
      vl.c/exit: pause cpus before closing block devices
      cpu_physical_memory_sync_dirty_bitmap: Fix alignment check

Jay Zhou (1):
      migration: optimize the downtime

Laurent Vivier (1):
      accel: cleanup error output

Mao Zhongyi (2):
      hw/scsi/vmw_pvscsi: Remove the dead error handling
      hw/scsi/vmw_pvscsi: Convert to realize

Marc-André Lureau (1):
      char-fd: remove useless chr pointer

Paolo Bonzini (5):
      bt: stop the sdp memory allocation craziness
      rtc-test: cleanup register_b_set_flag test
      rtc-test: introduce more update tests
      mc146818rtc: simplify check_update_timer
      mc146818rtc: implement UIP latching as intended

Peng Hao (1):
      target-i386: kvm_get/put_vcpu_events don't handle sipi_vector

 accel/accel.c             |  20 +++---
 chardev/char-fd.c         |   1 -
 chardev/char.c            |   2 +-
 exec.c                    |  12 ++--
 hw/bt/sdp.c               |  17 +++--
 hw/scsi/vmw_pvscsi.c      |  12 +---
 hw/timer/mc146818rtc.c    |  37 +++++-----
 include/chardev/char-fd.h |   2 +-
 include/chardev/char.h    |   4 +-
 include/exec/ram_addr.h   |   7 +-
 memory.c                  |  36 +++++++++-
 qemu-doc.texi             | 175 ++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx           |  15 +++-
 target/i386/kvm.c         |  35 ++++++----
 tests/rtc-test.c          | 156 +++++++++++++++++++++++++++++++++--------
 vl.c                      |  12 ++--
 16 files changed, 437 insertions(+), 106 deletions(-)
-- 
1.8.3.1
