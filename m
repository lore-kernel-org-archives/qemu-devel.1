Received: from eggs.gnu.org ([2001:4830:134:3::10]:34456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfCe-0004uh-LD
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfCd-0007ua-8C
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:21:56 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 27 Feb 2018 14:21:24 +0100
Message-Id: <20180227132150.13847-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/26] s390x updates (and friends)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:

  maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180227

for you to fetch changes up to eae9f29130f3ed40ad77f40a3bae4b9ebff28907:

  Merge tag 'tags/s390-ccw-bios-2018-02-26' into s390-next (2018-02-27 13:54:37 +0100)

----------------------------------------------------------------
- add query-cpus-fast and deprecate query-cpus, while adding s390 cpu
  information
- remove s390x memory hotplug implementation, which is not useable in
  this form
- add boot menu support in the s390-ccw bios
- expose s390x guest crash information
- fixes and cleaups

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/cpu: expose the guest crash information

Collin L. Walling (13):
  s390-ccw: refactor boot map table code
  s390-ccw: refactor eckd_block_num to use CHS
  s390-ccw: refactor IPL structs
  s390-ccw: update libc
  s390-ccw: move auxiliary IPL data to separate location
  s390-ccw: parse and set boot menu options
  s390-ccw: set up interactive boot menu parameters
  s390-ccw: read stage2 boot loader data to find menu
  s390-ccw: print zipl boot menu
  s390-ccw: read user input for boot index via the SCLP console
  s390-ccw: set cp_receive mask only when needed and consume pending
    service irqs
  s390-ccw: use zipl values when no boot menu options are present
  s390-ccw: interactive boot menu for scsi

Cornelia Huck (1):
  s390x: remove s390_get_memslot_count

David Hildenbrand (3):
  s390x/tcg: fix disabling/enabling DAT
  s390x/tcg: add various alignment checks
  s390x/sclp: remove memory hotplug support

Dr. David Alan Gilbert (1):
  s390/stattrib: Make SaveVMHandlers data static

Halil Pasic (1):
  s390x/cpumodel: document S390FeatDef.bit not applicable

Luiz Capitulino (1):
  qmp: add query-cpus-fast

Thomas Huth (1):
  pc-bios/s390: Rebuild the s390x firmware images with the boot menu
    changes

Viktor Mihajlovski (4):
  qmp: expose s390-specific CPU info
  qmp: add architecture specific cpu data for query-cpus-fast
  qemu-doc: deprecate query-cpus
  hmp: change hmp_info_cpus to use query-cpus-fast

 cpus.c                      |  54 ++++++++
 hmp.c                       |  41 +-----
 hw/intc/s390_flic.c         |   4 +-
 hw/s390x/s390-stattrib.c    |  26 ++--
 hw/s390x/s390-virtio-ccw.c  |   2 +-
 hw/s390x/sclp.c             | 310 +-------------------------------------------
 include/hw/s390x/sclp.h     |  26 ----
 monitor.c                   |  13 +-
 qapi-schema.json            | 115 +++++++++++++++-
 qapi/run-state.json         |  55 +++++++-
 qemu-doc.texi               |   4 +
 target/s390x/cpu.c          |  78 ++++++++---
 target/s390x/cpu.h          |  21 ++-
 target/s390x/cpu_features.c |   8 +-
 target/s390x/helper.c       |   5 +-
 target/s390x/insn-data.def  |  16 +--
 target/s390x/kvm-stub.c     |   5 -
 target/s390x/kvm.c          |  28 ++--
 target/s390x/kvm_s390x.h    |   1 -
 target/s390x/mem_helper.c   |  25 ++++
 target/s390x/mmu_helper.c   |   2 +-
 target/s390x/sigp.c         |  38 +++---
 target/s390x/translate.c    |  53 +++++++-
 vl.c                        |  11 +-
 24 files changed, 461 insertions(+), 480 deletions(-)

-- 
2.13.6
