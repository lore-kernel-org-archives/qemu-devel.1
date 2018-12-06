Received: from eggs.gnu.org ([2001:4830:134:3::10]:46133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUy11-0000hd-9a
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gUxsJ-0004CS-DB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:55:51 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:33874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gUxsJ-0004CI-73
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:55:47 -0500
Received: by mail-oi1-x234.google.com with SMTP id h25so1158494oig.1
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 09:55:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  6 Dec 2018 11:55:38 -0600
Message-Id: <20181206175541.29508-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/3] target/arm: ARMv8.1-LOR
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

Changes since v2:
  * Rebased on target-arm.next, which now includes 7 of the 10 patches.
  * Fixes based on patch review.


r~


Richard Henderson (3):
  target/arm: Introduce arm_hcr_el2_eff
  target/arm: Use arm_hcr_el2_eff more places
  target/arm: Implement the ARMv8.1-LOR extension

 target/arm/cpu.h           |  72 +++++-----------
 hw/intc/arm_gicv3_cpuif.c  |  21 ++---
 target/arm/cpu64.c         |   1 +
 target/arm/helper.c        | 163 +++++++++++++++++++++++++++++++++----
 target/arm/op_helper.c     |  14 ++--
 target/arm/translate-a64.c |  12 +++
 6 files changed, 197 insertions(+), 86 deletions(-)

-- 
2.17.2
