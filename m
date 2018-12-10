Received: from eggs.gnu.org ([2001:4830:134:3::10]:34457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWN7N-0002g6-11
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWN7J-0003i1-NC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:05:08 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWN7J-0003hh-Hg
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:05:05 -0500
Received: by mail-ot1-x344.google.com with SMTP id 81so10692900otj.2
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:05:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 10 Dec 2018 09:04:58 -0600
Message-Id: <20181210150501.7990-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 0/3] target/arm: ARMv8.1-LOR
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

Changes since v3:
  * Removed the extra VI/VF/VSE change.

Changes since v2:
  * Rebased on target-arm.next, which now includes 7 of the 10 patches.
  * Fixes based on patch review.


r~


Richard Henderson (3):
  target/arm: Introduce arm_hcr_el2_eff
  target/arm: Use arm_hcr_el2_eff more places
  target/arm: Implement the ARMv8.1-LOR extension

 target/arm/cpu.h           |  72 +++++------------
 hw/intc/arm_gicv3_cpuif.c  |  21 ++---
 target/arm/cpu64.c         |   1 +
 target/arm/helper.c        | 153 +++++++++++++++++++++++++++++++++----
 target/arm/op_helper.c     |  14 ++--
 target/arm/translate-a64.c |  12 +++
 6 files changed, 187 insertions(+), 86 deletions(-)

-- 
2.17.2
