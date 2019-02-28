Received: from eggs.gnu.org ([209.51.188.92]:43948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzBNA-0003OJ-Bf
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzBMy-00052H-Df
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:21 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:43161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzBMy-00050R-0f
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 21:24:20 -0500
Received: by mail-pg1-x531.google.com with SMTP id l11so8892925pgq.10
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 18:24:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 18:24:12 -0800
Message-Id: <20190228022415.27878-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/3] target/arm: SB and PredInv extensions
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
  * Rebase on master, cherry-picking one required patch from
    the ARMv8.5-MemTag patch set.
  * Use the same form of TB exit for SB as for ISB.
  * Rename all the bits related to PredInv.
  * Fix registration for PredInv cache flush special regs,
    and spell out why in a comment.


r~


Richard Henderson (3):
  target/arm: Split out arm_sctlr
  target/arm: Implement ARMv8.0-SB
  target/arm: Implement ARMv8.0-PredRes

 target/arm/cpu.h           | 49 ++++++++++++++++++++++-------
 linux-user/elfload.c       |  1 +
 target/arm/cpu.c           |  2 ++
 target/arm/cpu64.c         |  4 +++
 target/arm/helper.c        | 63 ++++++++++++++++++++++++++++++++++----
 target/arm/translate-a64.c | 14 +++++++++
 target/arm/translate.c     | 22 +++++++++++++
 7 files changed, 138 insertions(+), 17 deletions(-)

-- 
2.17.2
