Received: from eggs.gnu.org ([2001:4830:134:3::10]:57563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDK1m-0006Uq-Hz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDK1i-0003w8-Gq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:56:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:45988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDK1h-0003jY-Sn
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:56:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id y15-v6so15135729plr.12
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 18:56:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Oct 2018 18:56:14 -0700
Message-Id: <20181019015617.22583-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/3] target/arm: Reduce tlb_flush overhead
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

While installing AArch64 Ubuntu into a new vm,
I happened to notice that tlb_flush+memset was
consuming 25% of the total runtime.

This patch set reduces that overhead to 10%.
Full tlb flushes are down to 11k from 1.8M,
when pausing the installation at the first menu.

Changes since v1:
  * Rename the function in patch 3 to vmsa_ttbr_el1_write.


r~

Richard Henderson (3):
  target/arm: Remove writefn from TTBR0_EL3
  target/arm: Only flush tlb if ASID changes
  target/arm: Flush only the TLBs affected by TTBR*_EL1

 target/arm/helper.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

-- 
2.17.2
