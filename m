Received: from eggs.gnu.org ([209.51.188.92]:37313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZma-0003D4-0Q
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZmZ-00077u-7J
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:49:59 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZmY-00077Y-W7
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:49:59 -0500
Received: by mail-pg1-x543.google.com with SMTP id s198so4812770pgs.2
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:49:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:49:47 +1100
Message-Id: <20190110124951.15473-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] target/arm: Implement TBI for user-only
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

Based-on: 20190110121736.23448-1-richard.henderson@linaro.org
aka the BTI patch set.

This is a prerequisite to implementing v8.5-MemTag.


r~


Richard Henderson (4):
  target/arm: Add TBFLAG_A64_TBID, split out gen_top_byte_ignore
  target/arm: Clean TBI for data operations in the translator
  target/arm: Compute TB_FLAGS for TBI for user-only
  target/arm: Enable TBI for user-only

 target/arm/cpu.h           |   1 +
 target/arm/internals.h     |  21 ---
 target/arm/translate.h     |   3 +-
 target/arm/cpu.c           |   6 +
 target/arm/helper.c        |  14 +-
 target/arm/translate-a64.c | 257 +++++++++++++++++++------------------
 6 files changed, 150 insertions(+), 152 deletions(-)

-- 
2.17.2
