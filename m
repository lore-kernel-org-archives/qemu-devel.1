Received: from eggs.gnu.org ([2001:4830:134:3::10]:36090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utf-0007kM-W1
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utb-00071P-H4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:31 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:41579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utb-0006wJ-A1
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:27 -0400
Received: by mail-wr0-x22b.google.com with SMTP id s12so2402598wrc.8
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:26 -0700 (PDT)
Received: from 640k.lan (94-36-194-48.adsl-ull.clienti.tiscali.it.
	[94.36.194.48]) by smtp.gmail.com with ESMTPSA id
	24sm16286180wrt.60.2018.04.06.10.11.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Apr 2018 10:11:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:01 +0200
Message-Id: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/20] Miscellaneous patches for QEMU 2.12-rc
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

for you to fetch changes up to 0af74e1178c1f4ba495b499b2ba2a8c7c453b72a:

  Add missing bit for SSE instr in VEX decoding (2018-04-06 18:42:49 +0200)

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
 util/memfd.c                | 30 ++++++++++++++++-
 util/sys_membarrier.c       |  6 ++--
 21 files changed, 300 insertions(+), 60 deletions(-)
-- 
1.8.3.1
