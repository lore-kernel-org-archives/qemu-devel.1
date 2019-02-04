Received: from eggs.gnu.org ([209.51.188.92]:51472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeBz-00010y-Iw
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeBx-0006UW-Vr
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqeBx-0006Oo-NE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id x10so14357880wrs.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:21:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 13:21:22 +0000
Message-Id: <20190204132126.3255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/4] target/arm: Implement TBI for user-only
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

Based-on: <20190204131228.25949-1-richard.henderson@linaro.org>
aka v3 BTI.

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
 target/arm/translate-a64.c | 289 +++++++++++++++++++------------------
 6 files changed, 168 insertions(+), 166 deletions(-)

-- 
2.17.2
