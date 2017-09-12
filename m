Received: from eggs.gnu.org ([2001:4830:134:3::10]:37795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro02-0001d8-1f
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1drnzx-0006wz-Ui
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:22 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1drnzx-0006wT-N0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:17 -0400
Received: by mail-pf0-x231.google.com with SMTP id y29so18667988pff.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:24:57 -0700
Message-Id: <20170912162513.21694-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/16] TCG vectorization and example
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

I haven't gotten so far as the complex vector op issue that came
up in conversation with Alex this week.  But this is what I was
targeting as v2:

  * Add documentation.  Enough, or is it still lacking?
  * Fixed the bug in tcg/i386 that affected BIC.
  * Fill in the host vector ops for aarch64.


r~


Richard Henderson (16):
  tcg: Add expanders for out-of-line vector helpers
  tcg: Add types for host vectors
  tcg: Add operations for host vectors
  tcg: Add tcg_op_supported
  tcg: Add INDEX_op_invalid
  tcg: Add vector infrastructure and ops for add/sub/logic
  target/arm: Align vector registers
  target/arm: Use vector infrastructure for aa64 add/sub/logic
  tcg/i386: Add vector operations
  tcg/aarch64: Fully convert tcg_target_op_def
  tcg: Remove tcg_regset_clear
  tcg: Remove tcg_regset_set
  tcg: Remove tcg_regset_{or,and,andnot,not}
  tcg: Remove tcg_regset_set32
  tcg: Fix types in tcg_regset_{set,reset}_reg
  tcg/aarch64: Add vector operations

 Makefile.target              |   5 +-
 target/arm/cpu.h             |   2 +-
 tcg/aarch64/tcg-target.h     |  23 +-
 tcg/i386/tcg-target.h        |  46 ++-
 tcg/tcg-gvec-desc.h          |  49 +++
 tcg/tcg-op-gvec.h            | 104 +++++++
 tcg/tcg-opc.h                |  91 ++++++
 tcg/tcg-runtime.h            |  16 +
 tcg/tcg.h                    |  46 ++-
 target/arm/translate-a64.c   | 137 +++++----
 tcg/aarch64/tcg-target.inc.c | 689 +++++++++++++++++++++++++++++++------------
 tcg/arm/tcg-target.inc.c     |  25 +-
 tcg/i386/tcg-target.inc.c    | 468 +++++++++++++++++++++++++----
 tcg/mips/tcg-target.inc.c    |   2 +-
 tcg/ppc/tcg-target.inc.c     |  41 +--
 tcg/s390/tcg-target.inc.c    |  22 +-
 tcg/sparc/tcg-target.inc.c   |  52 ++--
 tcg/tcg-op-gvec.c            | 582 ++++++++++++++++++++++++++++++++++++
 tcg/tcg-runtime-gvec.c       | 192 ++++++++++++
 tcg/tcg.c                    | 334 ++++++++++++++++++++-
 tcg/tci/tcg-target.inc.c     |  13 +-
 21 files changed, 2527 insertions(+), 412 deletions(-)
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-runtime-gvec.c

-- 
2.13.5
