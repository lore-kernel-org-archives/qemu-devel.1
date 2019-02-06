Received: from eggs.gnu.org ([209.51.188.92]:50797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFbg-0007H2-Cw
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFQU-0003JY-KA
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grFQU-0003It-68
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:10 -0500
Received: by mail-wm1-x341.google.com with SMTP id g67so1209776wmd.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 21:07:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 05:06:56 +0000
Message-Id: <20190206050701.11847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/5] target/arm: tcg vector cleanups
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

Generic tcg now has support for folding of OR,
and has grown min/max primitives.


r~


Richard Henderson (5):
  target/arm: Rely on optimization within tcg_gen_gvec_or
  target/arm: Use vector minmax expanders for aarch64
  target/arm: Use vector minmax expanders for aarch32
  target/arm: Use tcg integer min/max primitives for neon
  target/arm: Remove neon min/max helpers

 target/arm/helper.h        | 12 ----------
 target/arm/neon_helper.c   | 12 ----------
 target/arm/translate-a64.c | 41 +++++++++++++---------------------
 target/arm/translate-sve.c |  6 +----
 target/arm/translate.c     | 45 ++++++++++++++++++++++----------------
 5 files changed, 42 insertions(+), 74 deletions(-)

-- 
2.17.2
