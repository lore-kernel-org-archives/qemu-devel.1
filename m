Received: from eggs.gnu.org ([2001:4830:134:3::10]:58558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhT-00023W-Hl
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhO-0008PV-OF
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:54:47 -0500
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:40321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecOhO-0008On-IN
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:54:42 -0500
Received: by mail-pg0-x22d.google.com with SMTP id g16so546999pgn.7
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 20:54:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Jan 2018 20:54:22 -0800
Message-Id: <20180119045438.28582-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/16] target/arm: Prepatory work for SVE
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

I believe that this addresses all of the comments Peter had with
respect to v1.  I did go ahead and add the system registers, so that
I could figure out how they're supposed to work.

This has been rebased to master so that it has no dependencies.


r~


Richard Henderson (16):
  target/arm: Mark disas_set_insn_syndrome inline
  target/arm: Use pointers in crypto helpers
  target/arm: Use pointers in neon zip/uzp helpers
  target/arm: Use pointers in neon tbl helper
  target/arm: Change the type of vfp.regs
  target/arm: Add aa{32,64}_vfp_{dreg,qreg} helpers
  vmstate: Add VMSTATE_UINT64_SUB_ARRAY
  target/arm: Expand vector registers for SVE
  target/arm: Add predicate registers for SVE
  target/arm: Add ARM_FEATURE_SVE
  target/arm: Add SVE to migration state
  target/arm: Add ZCR_ELx
  target/arm: Move cpu_get_tb_cpu_state out of line
  target/arm: Hoist store to flags output in cpu_get_tb_cpu_state
  target/arm: Simplify fp_exception_el for user-only
  target/arm: Add SVE state to TB->FLAGS

 include/migration/vmstate.h |   9 +-
 target/arm/cpu.h            | 227 +++++++++++++++-----------------------
 target/arm/helper.h         |  46 ++++----
 target/arm/translate.h      |   2 +-
 linux-user/signal.c         |  22 ++--
 target/arm/arch_dump.c      |   8 +-
 target/arm/crypto_helper.c  | 184 ++++++++++++-------------------
 target/arm/helper-a64.c     |   5 +-
 target/arm/helper.c         | 263 ++++++++++++++++++++++++++++++++++++++++++--
 target/arm/kvm32.c          |   4 +-
 target/arm/kvm64.c          |  31 ++----
 target/arm/machine.c        |  88 ++++++++++++++-
 target/arm/neon_helper.c    | 162 ++++++++++++++-------------
 target/arm/op_helper.c      |  17 ++-
 target/arm/translate-a64.c  | 106 +++++++++---------
 target/arm/translate.c      | 139 ++++++++++++-----------
 16 files changed, 781 insertions(+), 532 deletions(-)

-- 
2.14.3
