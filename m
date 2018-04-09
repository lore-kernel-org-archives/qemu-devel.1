Received: from eggs.gnu.org ([2001:4830:134:3::10]:37166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f5YH0-00005L-Ve
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f5YGx-0003dp-Ry
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:59:59 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f5YGx-0003dQ-KP
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:59:55 -0400
Received: by mail-wm0-x233.google.com with SMTP id r82so17527998wme.0
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 07:59:55 -0700 (PDT)
Received: from 640k.lan (94-36-194-48.adsl-ull.clienti.tiscali.it.
	[94.36.194.48]) by smtp.gmail.com with ESMTPSA id
	134sm1195166wmt.29.2018.04.09.07.59.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Apr 2018 07:59:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  9 Apr 2018 16:59:50 +0200
Message-Id: <1523285990-37457-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/20] Miscellaneous patches for QEMU 2.12-rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:

  Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e0014d4b3a955cfd8d517674703bfa87f340290a:

  Add missing bit for SSE instr in VEX decoding (2018-04-09 16:36:40 +0200)

----------------------------------------------------------------
Miscellaneous bugfixes, including crash fixes from Alexey, Peter M. and
Thomas.

----------------------------------------------------------------
Alexandro Sanchez Bach (1):
      target/i386: Fix andn instruction

Bruce Rogers (1):
      sys_membarrier: fix up include directives

Daniel Henrique Barboza (1):
      hw/scsi: support SCSI-2 passthrough without PI

Eric Blake (2):
      dump: Fix build with newer gcc
      maint: Add .mailmap entries for patches claiming list authorship

Eugene Minibaev (1):
      Add missing bit for SSE instr in VEX decoding

Fam Zheng (1):
      scsi-disk: Don't enlarge min_io_size to max_io_size

Justin Terry (VM) (1):
      target/i386: WHPX: set CPUID_EXT_HYPERVISOR bit

Marc-André Lureau (1):
      memfd: fix vhost-user-test on non-memfd capable host

Michael Chapman (1):
      kvmclock: fix clock_is_reliable on migration from QEMU < 2.9

Michal Privoznik (2):
      qemu-pr-helper: Daemonize before dropping privileges
      qemu-pr-helper: Write pidfile more often

Paolo Bonzini (1):
      scsi-disk: allow customizing the SCSI version

Philippe Mathieu-Daudé (1):
      hw/dma/i82374: Avoid double creation of the 82374 controller

Roman Kagan (2):
      i386/hyperv: add hv-frequencies cpu property
      i386/hyperv: error out if features requested but unsupported

Su Hang (1):
      scripts/checkpatch.pl: Bug fix

Thomas Huth (2):
      configure: Add missing configure options to help text
      device-crash-test: Remove fixed isa-fdc entry

linzhecheng (1):
      virtio-serial: fix heapover-flow

 .mailmap                    | 18 ++++++++---
 configure                   |  3 ++
 dump.c                      |  4 +--
 hw/char/virtio-serial-bus.c |  7 ++--
 hw/dma/i82374.c             |  9 +++++-
 hw/i386/kvm/clock.c         | 14 ++++++++
 hw/scsi/scsi-disk.c         | 39 ++++++++++++++++------
 hw/scsi/scsi-generic.c      | 48 ++++++++++++++++++++-------
 hw/virtio/vhost.c           |  2 +-
 include/hw/scsi/scsi.h      |  2 ++
 include/qemu/memfd.h        |  1 +
 scripts/checkpatch.pl       | 15 +++++++--
 scripts/device-crash-test   |  1 -
 scsi/qemu-pr-helper.c       | 18 +++++++----
 target/i386/cpu.c           |  1 +
 target/i386/cpu.h           |  1 +
 target/i386/kvm.c           | 56 ++++++++++++++++++++++++--------
 target/i386/translate.c     |  6 ++--
 target/i386/whpx-all.c      | 79 ++++++++++++++++++++++++++++++++++++++++++++-
 util/memfd.c                | 34 ++++++++++++++++++-
 util/sys_membarrier.c       |  6 ++--
 21 files changed, 304 insertions(+), 60 deletions(-)
-- 
1.8.3.1

diff --git a/util/memfd.c b/util/memfd.c
index 277f721..b3ecbac 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -202,6 +202,7 @@ bool qemu_memfd_alloc_check(void)
  */
 bool qemu_memfd_check(void)
 {
+#ifdef CONFIG_LINUX
     static int memfd_check = MEMFD_TODO;
 
     if (memfd_check == MEMFD_TODO) {
@@ -215,4 +216,7 @@ bool qemu_memfd_check(void)
     }
 
     return memfd_check == MEMFD_OK;
+#else
+    return false;
+#endif
 }
