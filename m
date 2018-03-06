Received: from eggs.gnu.org ([2001:4830:134:3::10]:47945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVJ-0004kj-Dy
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVD-00068W-Aw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:41 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:43835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVD-00067z-0i
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:35 -0500
Received: by mail-wr0-x22d.google.com with SMTP id u49so20885621wrc.10
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:34 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.19.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:19:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:18:56 +0100
Message-Id: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/34] Misc patches for 2018-03-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 58e2e17dba49b43f4ac9de19468aeae1c787dcc2:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-03-06 11:20:44 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3e015d815b3f28bfd874bf8a1697308ef9af2b4c:

  use g_path_get_basename instead of basename (2018-03-06 14:01:29 +0100)

----------------------------------------------------------------
* new QMP command qom-list-properties (Alexey)
* TCG cleanups (David)
* use g_path_get_basename/g_path_get_dirname when useful (Julia)
* WHPX fixes (Justin)
* ASAN fixes (Marc-André)
* g364fb memory leak fix, address_space_to_flatview RCU fixes (me)
* chardev memory leak fix (Peter)
* checkpatch improvements (Julia, Su Hang)
* next round of deprecation patches (Thomas)

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      qmp: Merge ObjectPropertyInfo and DevicePropertyInfo
      qmp: Add qom-list-properties to list QOM object properties

David Hildenbrand (3):
      cpus: properly inititalize CPU > 1 under single-threaded TCG
      cpus: wait for CPU creation at central place
      cpus: CPU threads are always created initially for one CPU only

Julia Suvorova (2):
      checkpatch: add a warning for basename/dirname
      use g_path_get_basename instead of basename

Justin Terry (VM) via Qemu-devel (8):
      Fixing WHPX casing to match SDK
      Resolves WHPX breaking changes in SDK 17095
      Remove unnecessary WHPX __debugbreak();
      Fix WHPX additional lock acquisition
      Fix WHPX typo in 'mmio'
      Fix WHPX issue leaking tpr values
      WHXP Removes the use of WHvGetExitContextSize
      WHPX improve interrupt notification registration

Marc-André Lureau (4):
      build-sys: fix -fsanitize=address check
      lockable: workaround GCC link issue with ASAN
      ahci-test: fix opts leak of skip tests
      sdhci-test: fix leaks

Paolo Bonzini (9):
      g364fb: fix DirtyBitmapSnapshot leak
      openpic_kvm: drop address_space_to_flatview call
      memory: inline some performance-sensitive accessors
      address_space_write: address_space_to_flatview needs RCU lock
      address_space_read: address_space_to_flatview needs RCU lock
      address_space_access_valid: address_space_to_flatview needs RCU lock
      address_space_map: address_space_to_flatview needs RCU lock
      address_space_rw: address_space_to_flatview needs RCU lock
      Revert "build-sys: compile with -Og or -O1 when --enable-debug"

Peter Xu (1):
      chardev: fix leak in tcp_chr_telnet_init_io()

Su Hang (1):
      checkpatch: add check for `while` and `for`

Thomas Huth (4):
      Remove the deprecated -tdf option
      scsi: Remove automatic creation of SCSI controllers with -drive if=scsi
      Document --rtc-td-hack, --localtime and --startdate as deprecated
      balloon: Fix documentation of the --balloon parameter and deprecate it

 chardev/char-socket.c          | 10 +++--
 configure                      | 47 +++++++++-------------
 cpus.c                         | 33 +++++-----------
 exec.c                         | 90 +++++++++++++++++++++++++-----------------
 fsdev/virtfs-proxy-helper.c    | 15 ++++---
 hw/display/g364fb.c            |  1 +
 hw/i386/pc.c                   | 17 --------
 hw/i386/pc_piix.c              |  4 --
 hw/i386/pc_q35.c               |  3 --
 hw/intc/openpic_kvm.c          |  4 --
 hw/s390x/s390-ccw.c            |  2 +-
 hw/scsi/lsi53c895a.c           |  2 +-
 hw/scsi/scsi-bus.c             | 49 +----------------------
 hw/scsi/spapr_vscsi.c          |  3 +-
 hw/vfio/pci.c                  |  2 +-
 hw/vfio/platform.c             |  2 +-
 include/exec/memory-internal.h | 13 ++++--
 include/exec/memory.h          | 47 ++++++++++++++--------
 include/hw/scsi/scsi.h         |  2 +-
 include/qemu/lockable.h        |  2 +-
 include/qom/object.h           | 16 ++++++++
 memory.c                       | 30 --------------
 qapi/misc.json                 | 34 ++++++++--------
 qdev-monitor.c                 |  6 +--
 qemu-doc.texi                  | 33 ++++++++--------
 qemu-io.c                      |  2 +-
 qemu-options.hx                | 11 ++----
 qga/commands-posix.c           |  4 +-
 qmp.c                          | 69 +++++++++++++++++++++++++++-----
 qom/object.c                   |  7 ++++
 scripts/checkpatch.pl          | 10 ++++-
 target/i386/whpx-all.c         | 70 +++++++++++---------------------
 tests/ahci-test.c              |  1 +
 tests/qemu-iotests/051         |  4 --
 tests/sdhci-test.c             |  2 +
 vl.c                           | 20 ++++------
 36 files changed, 315 insertions(+), 352 deletions(-)
-- 
1.8.3.1
