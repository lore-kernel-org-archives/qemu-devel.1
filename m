Received: from eggs.gnu.org ([2001:4830:134:3::10]:52785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85Z5-0007rs-64
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85Z1-0004jz-CM
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:22 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:42 +0200
Message-Id: <20181004152857.14525-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] s390x updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit dafd95053611aa14dda40266857608d12ddce6=
58:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-10-02 18:27:18 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20181004

for you to fetch changes up to b576d582ea2b03f4eada186fff59308d22b40a6a:

  hw/s390x/s390-pci-bus: Convert sysbus init function to realize function=
 (2018-10-04 12:10:40 +0200)

----------------------------------------------------------------
Various s390x updates:
- fix several struct definitions so that sparc hosts do not trip over
  unaligned accesses
- fence enabling huge pages for pre-3.1 machines
- sysbus init -> realize conversion
- fixes and improvements in tcg (instruction flags and AFP registers)

----------------------------------------------------------------

David Hildenbrand (9):
  s390x: move tcg_s390_program_interrupt() into TCG code and mark it
    noreturn
  s390x/tcg: factor out and fix DATA exception injection
  s390x/tcg: store in the TB flags if AFP is enabled
  s390x/tcg: support flags for instructions
  s390x/tcg: add instruction flags for floating point instructions
  s390x/tcg: check for AFP-register, BFP and DFP data exceptions
  s390x/tcg: handle privileged instructions via flags
  s390x/tcg: fix FP register pair checks
  s390x/tcg: refactor specification checking

Janosch Frank (1):
  s390x: Fence huge pages prior to 3.1

Pavel Zbitskiy (1):
  target/s390x: exception on non-aligned LPSW(E)

Thomas Huth (4):
  hw/s390x/ipl: Fix alignment problems of S390IPLState members
  hw/s390x/css: Remove QEMU_PACKED from struct SenseId
  hw/s390x/ioinst: Fix alignment problem in struct SubchDev
  hw/s390x/s390-pci-bus: Convert sysbus init function to realize
    function

 hw/s390x/css.c                     |  38 ++--
 hw/s390x/ipl.h                     |   5 +-
 hw/s390x/s390-pci-bus.c            |  34 ++--
 hw/s390x/s390-virtio-ccw.c         |  10 +
 include/hw/s390x/css.h             |   6 +-
 include/hw/s390x/ioinst.h          |  21 +-
 include/hw/s390x/s390-virtio-ccw.h |   3 +
 target/s390x/cpu.h                 |   9 +
 target/s390x/excp_helper.c         |  36 ++++
 target/s390x/fpu_helper.c          |  13 +-
 target/s390x/helper.h              |   1 +
 target/s390x/insn-data.def         | 395 +++++++++++++++++++------------=
------
 target/s390x/interrupt.c           |  15 +-
 target/s390x/kvm.c                 |  10 +-
 target/s390x/tcg-stub.c            |  10 +
 target/s390x/tcg_s390x.h           |   4 +
 target/s390x/translate.c           | 203 ++++++++-----------
 17 files changed, 430 insertions(+), 383 deletions(-)

--=20
2.14.4
