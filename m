Received: from eggs.gnu.org ([2001:4830:134:3::10]:36845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3Q-0000Lx-Ml
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz3D-0000fj-8B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:16 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:46653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz3C-0000eE-Uz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:03 -0500
Received: by mail-pg0-x232.google.com with SMTP id b11so9390277pgu.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:18:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:17:32 -0800
Message-Id: <20171218171758.16964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 00/26] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Minor changes since last time.
  * Two bugs fixed pointed out by Kirill.
  * Allow for 4 and 5 operand operations.


r~


Richard Henderson (26):
  tcg: Add types and basic operations for host vectors
  tcg: Add generic vector expanders
  tcg: Allow multiple word entries into the constant pool
  target/arm: Align vector registers
  target/arm: Use vector infrastructure for aa64 add/sub/logic
  target/arm: Use vector infrastructure for aa64 mov/not/neg
  target/arm: Use vector infrastructure for aa64 dup/movi
  tcg/i386: Add vector operations
  tcg: Add tcg_expand_vec_op and tcg-target.opc.h
  tcg: Add generic vector ops for interleave
  target/arm: Use vector infrastructure for aa64 zip/uzp/trn/xtn
  tcg: Add generic vector ops for constant shifts
  target/arm: Use vector infrastructure for aa64 constant shifts
  tcg: Add generic vector ops for comparisons
  target/arm: Use vector infrastructure for aa64 compares
  tcg/i386: Add vector operations/expansions for shift/cmp/interleave
  tcg: Add generic vector ops for multiplication
  target/arm: Use vector infrastructure for aa64 multiplies
  tcg: Add generic vector ops for extension
  target/arm: Use vector infrastructure for aa64 widening shifts
  tcg/i386: Add vector operations/expansions for mul/extend
  tcg/aarch64: Add vector operations
  tcg/optimize: Handle vector opcodes during optimize
  tcg: Add support for 4 operand vector ops
  tcg: Add support for 5 operand vector ops
  tcg: Add generic helpers for saturating arithmetic

 Makefile.target              |    4 +-
 accel/tcg/tcg-runtime.h      |  122 +++
 target/arm/cpu.h             |    2 +-
 tcg/aarch64/tcg-target.h     |   30 +-
 tcg/aarch64/tcg-target.opc.h |    3 +
 tcg/i386/tcg-target.h        |   46 +-
 tcg/i386/tcg-target.opc.h    |   11 +
 tcg/tcg-gvec-desc.h          |   49 +
 tcg/tcg-op-gvec.h            |  271 +++++
 tcg/tcg-op.h                 |   51 +
 tcg/tcg-opc.h                |   59 +
 tcg/tcg.h                    |   81 ++
 accel/tcg/tcg-runtime-gvec.c |  884 +++++++++++++++
 target/arm/translate-a64.c   | 1100 +++++++++++++------
 tcg/aarch64/tcg-target.inc.c |  674 +++++++++++-
 tcg/i386/tcg-target.inc.c    | 1325 ++++++++++++++++++++++-
 tcg/optimize.c               |  141 ++-
 tcg/tcg-op-gvec.c            | 2440 ++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  566 ++++++++++
 tcg/tcg-pool.inc.c           |  115 +-
 tcg/tcg.c                    |  144 ++-
 accel/tcg/Makefile.objs      |    2 +-
 tcg/README                   |  148 +++
 23 files changed, 7734 insertions(+), 534 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target.opc.h
 create mode 100644 tcg/i386/tcg-target.opc.h
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 accel/tcg/tcg-runtime-gvec.c
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-op-vec.c

-- 
2.14.3
