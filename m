Received: from eggs.gnu.org ([2001:4830:134:3::10]:42261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzR-0005zI-DA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzN-0005Xm-F7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:49 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:39305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuzN-0005Wn-20
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:45 -0500
Received: by mail-ot1-x335.google.com with SMTP id n8so9105770otl.6
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:29 -0600
Message-Id: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 00/10] target/arm: LOR, HPD, AA32HPD
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

Three relatively simple post-8.0 extensions.

Changes since v1:
  * Add TLOR access checks for LOR registers.
  * Clean up access to HCR_EL2.
  * Clean up setting of SCR_EL3.
  * Other changes as noted within each patch.


r~


Richard Henderson (10):
  target/arm: Move id_aa64mmfr* to ARMISARegisters
  target/arm: Add HCR_EL2 bits up to ARMv8.5
  target/arm: Add SCR_EL3 bits up to ARMv8.5
  target/arm: Fix HCR_EL2.TGE check in arm_phys_excp_target_el
  target/arm: Introduce arm_hcr_el2_eff
  target/arm: Use arm_hcr_el2_eff more places
  target/arm: Tidy scr_write
  target/arm: Implement the ARMv8.1-LOR extension
  target/arm: Implement the ARMv8.1-HPD extension
  target/arm: Implement the ARMv8.2-AA32HPD extension

 target/arm/cpu.h           | 141 ++++++++++++---------
 target/arm/internals.h     |   3 +-
 hw/intc/arm_gicv3_cpuif.c  |  21 ++--
 target/arm/cpu.c           |   4 +
 target/arm/cpu64.c         |  11 +-
 target/arm/helper.c        | 247 +++++++++++++++++++++++++++++++------
 target/arm/kvm64.c         |   4 +
 target/arm/op_helper.c     |  14 +--
 target/arm/translate-a64.c |  12 ++
 9 files changed, 342 insertions(+), 115 deletions(-)

-- 
2.17.2
