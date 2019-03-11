Received: from eggs.gnu.org ([209.51.188.92]:42860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GqH-0002mq-DH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GqG-00054T-E6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:29 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:49 +0100
Message-Id: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/33] final s390x patches for 4.0 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit e2a18635a400b0e68679614132e9ef6316105590:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-08' into staging (2019-03-09 20:55:44 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190311

for you to fetch changes up to 2c7590c8ea90a7fbe1efcac90cdfdb8017c1b365:

  s390x/tcg: Implement VECTOR UNPACK * (2019-03-11 09:31:01 +0100)

----------------------------------------------------------------
s390x update:
- clean up LowCore definition
- first part of vector instruction support for tcg

----------------------------------------------------------------

David Hildenbrand (32):
  s390x/tcg: Define vector instruction formats
  s390x/tcg: Check vector register instructions at central point
  s390x/tcg: Utilities for vector instruction helpers
  s390x/tcg: Implement VECTOR GATHER ELEMENT
  s390x/tcg: Implement VECTOR GENERATE BYTE MASK
  s390x/tcg: Implement VECTOR GENERATE MASK
  s390x/tcg: Implement VECTOR LOAD
  s390x/tcg: Implement VECTOR LOAD AND REPLICATE
  s390x/tcg: Implement VECTOR LOAD ELEMENT
  s390x/tcg: Implement VECTOR LOAD ELEMENT IMMEDIATE
  s390x/tcg: Implement VECTOR LOAD GR FROM VR ELEMENT
  s390x/tcg: Implement VECTOR LOAD LOGICAL ELEMENT AND ZERO
  s390x/tcg: Implement VECTOR LOAD MULTIPLE
  s390x/tcg: Implement VECTOR LOAD TO BLOCK BOUNDARY
  s390x/tcg: Implement VECTOR LOAD VR ELEMENT FROM GR
  s390x/tcg: Implement VECTOR LOAD VR FROM GRS DISJOINT
  s390x/tcg: Implement VECTOR LOAD WITH LENGTH
  s390x/tcg: Implement VECTOR MERGE (HIGH|LOW)
  s390x/tcg: Implement VECTOR PACK *
  s390x/tcg: Implement VECTOR PERMUTE
  s390x/tcg: Implement VECTOR PERMUTE DOUBLEWORD IMMEDIATE
  s390x/tcg: Implement VECTOR REPLICATE
  s390x/tcg: Implement VECTOR REPLICATE IMMEDIATE
  s390x/tcg: Implement VECTOR SCATTER ELEMENT
  s390x/tcg: Implement VECTOR SELECT
  s390x/tcg: Implement VECTOR SIGN EXTEND TO DOUBLEWORD
  s390x/tcg: Provide probe_write_access helper
  s390x/tcg: Implement VECTOR STORE
  s390x/tcg: Implement VECTOR STORE ELEMENT
  s390x/tcg: Implement VECTOR STORE MULTIPLE
  s390x/tcg: Implement VECTOR STORE WITH LENGTH
  s390x/tcg: Implement VECTOR UNPACK *

Thomas Huth (1):
  target/s390x: Remove non-architected entries from struct LowCore

 target/s390x/Makefile.objs      |   1 +
 target/s390x/cpu.h              |   7 +
 target/s390x/helper.h           |  21 +
 target/s390x/insn-data.def      |  82 +++
 target/s390x/insn-format.def    |  25 +
 target/s390x/internal.h         |  43 +-
 target/s390x/mem_helper.c       |  26 +
 target/s390x/translate.c        |  61 ++-
 target/s390x/translate_vx.inc.c | 935 ++++++++++++++++++++++++++++++++
 target/s390x/vec.h              | 101 ++++
 target/s390x/vec_helper.c       | 193 +++++++
 11 files changed, 1455 insertions(+), 40 deletions(-)
 create mode 100644 target/s390x/translate_vx.inc.c
 create mode 100644 target/s390x/vec.h
 create mode 100644 target/s390x/vec_helper.c

-- 
2.17.2
