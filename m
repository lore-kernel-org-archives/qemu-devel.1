Received: from eggs.gnu.org ([2001:4830:134:3::10]:42018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejpNs-00089S-QR
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejpNp-00042K-Mr
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:16 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:43544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejpNp-00040C-Es
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:13 -0500
Received: by mail-pg0-x232.google.com with SMTP id f6so1791567pgs.10
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:49:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  8 Feb 2018 08:49:08 -0800
Message-Id: <20180208164909.8639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/20] tcg generic vectors
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

Changes since last:
  * Fix the constant pool patch for ppc64 and sparc64 hosts.
    That's a bit of a brown-bag moment.  I failed to test those
    because "clearly" they weren't affected the patches.


r~


The following changes since commit b256b89c63c12e902645dd55e7b5362f60574742:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2018-02-08 10:16:59 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20180208

for you to fetch changes up to 14e4c1e2355473ccb2939afc69ac8f25de103b92:

  tcg/aarch64: Add vector operations (2018-02-08 15:54:08 +0000)

----------------------------------------------------------------
tcg generic vectors

----------------------------------------------------------------
Richard Henderson (20):
      tcg: Allow multiple word entries into the constant pool
      tcg: Add types and basic operations for host vectors
      tcg: Standardize integral arguments to expanders
      tcg: Add generic vector expanders
      tcg: Add generic vector ops for constant shifts
      tcg: Add generic vector ops for comparisons
      tcg: Add generic vector ops for multiplication
      tcg: Add generic helpers for saturating arithmetic
      tcg: Add generic vector helpers with a scalar operand
      tcg/optimize: Handle vector opcodes during optimize
      target/arm: Align vector registers
      target/arm: Use vector infrastructure for aa64 add/sub/logic
      target/arm: Use vector infrastructure for aa64 mov/not/neg
      target/arm: Use vector infrastructure for aa64 dup/movi
      target/arm: Use vector infrastructure for aa64 constant shifts
      target/arm: Use vector infrastructure for aa64 compares
      target/arm: Use vector infrastructure for aa64 multiplies
      target/arm: Use vector infrastructure for aa64 orr/bic immediate
      tcg/i386: Add vector operations
      tcg/aarch64: Add vector operations

 Makefile.target              |    4 +-
 accel/tcg/tcg-runtime.h      |  118 +++
 target/arm/cpu.h             |    2 +-
 tcg/aarch64/tcg-target.h     |   25 +-
 tcg/aarch64/tcg-target.opc.h |    3 +
 tcg/i386/tcg-target.h        |   41 +-
 tcg/i386/tcg-target.opc.h    |   13 +
 tcg/tcg-gvec-desc.h          |   49 +
 tcg/tcg-op-gvec.h            |  306 ++++++
 tcg/tcg-op.h                 |   52 +-
 tcg/tcg-opc.h                |   46 +
 tcg/tcg.h                    |   87 ++
 accel/tcg/tcg-runtime-gvec.c |  997 +++++++++++++++++++
 target/arm/translate-a64.c   |  975 ++++++++++++++-----
 tcg/aarch64/tcg-target.inc.c |  588 ++++++++++-
 tcg/i386/tcg-target.inc.c    |  987 ++++++++++++++++++-
 tcg/optimize.c               |  150 +--
 tcg/tcg-op-gvec.c            | 2216 ++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  389 ++++++++
 tcg/tcg-op.c                 |   42 +-
 tcg/tcg-pool.inc.c           |  113 ++-
 tcg/tcg.c                    |  125 ++-
 accel/tcg/Makefile.objs      |    2 +-
 configure                    |   48 +
 tcg/README                   |   86 ++
 25 files changed, 6969 insertions(+), 495 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target.opc.h
 create mode 100644 tcg/i386/tcg-target.opc.h
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 accel/tcg/tcg-runtime-gvec.c
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-op-vec.c
