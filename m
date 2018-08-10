Received: from eggs.gnu.org ([2001:4830:134:3::10]:43848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fnxhg-0005hm-Bv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fnxhf-0001up-H9
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:03:04 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Thu,  9 Aug 2018 23:01:32 -0400
Message-Id: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 0/7] Some improvements in z/Arch instructions
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

Found while attempting to run an old tool in qemu.

* BAL and BALR:    Added.
* CSST:            Qemu crashed after an accidental jump to garbage.
* IPM:             A tool produced an incorrect output.
* EX TRT/TRTR:     A tool ran quite slow.
* PACK:            A tool produced an incorrect output.
* CVB, CVBY, CVBG: Added.

Changes since v1:
* Tests.
* Call pc_to_link_info() instead of op_bas().
* Clarified CSST commit message.
* Rewrote IPM using extract/deposit.
* Clarified PACK commit message.
* Do not use LowCore for CONFIG_USER_ONLY.
* Reduce duplication in CVB code.

Pavel Zbitskiy (7):
  tests/tcg: add a simple s390x test
  target/s390x: add BAL and BALR instructions
  target/s390x: fix CSST decoding and runtime alignment check
  target/s390x: fix IPM polluting irrelevant bits
  target/s390x: add EX support for TRT and TRTR
  target/s390x: fix PACK reading 1 byte less and writing 1 byte more
  target/s390x: implement CVB, CVBY and CVBG

 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  7 ++++
 target/s390x/int_helper.c       | 50 ++++++++++++++++++++++++++
 target/s390x/mem_helper.c       | 24 ++++++++++---
 target/s390x/translate.c        | 64 ++++++++++++++++++++++++++-------
 tests/tcg/s390x/Makefile.target |  9 +++++
 tests/tcg/s390x/csst.c          | 43 ++++++++++++++++++++++
 tests/tcg/s390x/cvb.c           | 18 ++++++++++
 tests/tcg/s390x/exrl-trt.c      | 48 +++++++++++++++++++++++++
 tests/tcg/s390x/exrl-trtr.c     | 48 +++++++++++++++++++++++++
 tests/tcg/s390x/hello-s390x.c   |  7 ++++
 tests/tcg/s390x/ipm.c           | 22 ++++++++++++
 tests/tcg/s390x/pack.c          | 21 +++++++++++
 13 files changed, 346 insertions(+), 16 deletions(-)
 create mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/csst.c
 create mode 100644 tests/tcg/s390x/cvb.c
 create mode 100644 tests/tcg/s390x/exrl-trt.c
 create mode 100644 tests/tcg/s390x/exrl-trtr.c
 create mode 100644 tests/tcg/s390x/hello-s390x.c
 create mode 100644 tests/tcg/s390x/ipm.c
 create mode 100644 tests/tcg/s390x/pack.c

-- 
2.18.0
