Received: from eggs.gnu.org ([2001:4830:134:3::10]:44141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFF-0002XR-Be
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFC-0004Xy-1W
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:29 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzFB-0004WI-QV
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:25 -0500
Received: by mail-pg0-x241.google.com with SMTP id b11so9404289pgu.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:30:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:30:13 -0800
Message-Id: <20171218173022.18418-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/9] target/arm: Prepatory work for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

This is primarily about changing the representation of env->vfp.regs
to allow for the larger vector sizes.


r~


Richard Henderson (9):
  target/arm: Mark disas_set_insn_syndrome inline
  target/arm: Use pointers in crypto helpers
  target/arm: Use pointers in neon zip/uzp helpers
  target/arm: Use pointers in neon tbl helper
  target/arm: Add aa32_vfp_dreg/aa64_vfp_qreg helpers
  vmstate: Add VMSTATE_UINT64_SUB_ARRAY
  target/arm: Expand vector registers for SVE
  target/arm: Add ZCR.LEN to tb->flags
  target/arm: Add ARM_FEATURE_SVE

 include/migration/vmstate.h |   9 ++-
 target/arm/cpu.h            | 127 ++++++++++++++++++++++--------
 target/arm/helper.h         |  46 +++++------
 target/arm/translate.h      |   3 +-
 linux-user/signal.c         |  22 +++---
 target/arm/arch_dump.c      |   8 +-
 target/arm/cpu.c            |   2 +
 target/arm/cpu64.c          |   1 +
 target/arm/crypto_helper.c  | 184 +++++++++++++++++---------------------------
 target/arm/helper-a64.c     |  13 ++--
 target/arm/helper.c         |  32 +++++---
 target/arm/kvm32.c          |   4 +-
 target/arm/kvm64.c          |  31 +++-----
 target/arm/machine.c        |  37 ++++++++-
 target/arm/neon_helper.c    | 162 ++++++++++++++++++++------------------
 target/arm/op_helper.c      |  17 ++--
 target/arm/translate-a64.c  | 106 ++++++++++++-------------
 target/arm/translate.c      | 138 ++++++++++++++++++---------------
 18 files changed, 510 insertions(+), 432 deletions(-)

-- 
2.14.3
